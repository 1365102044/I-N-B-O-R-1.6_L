//
//  YXNetworkTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNetworkTool.h"
#import "AFNetworking.h"
#import "YXNetworkHUD.h"
#import <UIKit/UIKit.h>
#import "YXMyOrderSuccessAlerview.h"
#import "YXOffLineNotificationController.h"
#import "JPush.h"
#import "AppDelegate.h"
#import "YXNavigationController.h"
#import "YXLoginViewController.h"
#import "twlt_uuid_util.h"
#import "YXHomePageURLMacros.h"
@interface YXNetworkTool()

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

/**
 下线提示
 */
@property (nonatomic, weak) YXOffLineNotificationController *offLineNotificationController;
/**
 记录URL， 参数 是否是详情进来的，被挤掉线后，登录之后再跳回去，
 */
@property(nonatomic,strong) NSString * currentURL;
@property(nonatomic,strong) NSDictionary * GoodsDict;
@end

@implementation YXNetworkTool


+(instancetype)sharedTool{
    
    static YXNetworkTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[YXNetworkTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

        tool.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//        tool.requestSerializer = [AFJSONRequestSerializer serializer];
//        tool.requestSerializer = [AFJSONRequestSerializer serializer];
       
       // [tool setSecurityPolicy:[self customSecurityPolicy]];
        
        //tool.securityPolicy.allowInvalidCertificates = YES;
        //tool.securityPolicy.validatesDomainName = NO;
        
        [tool setSecurityPolicy: [tool customSecurityPolicy]];
        
        //** 解决http请求重定向 */
//        [tool setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
//            return nil;
//        }];
    });
    return tool;
}

-(void)requestDataWithType:(RequestMethod)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    self.currentURL = url;
    self.GoodsDict = params;
    //NSString *token = [YXUserDefaults objectForKey:@"TokenID"];
    NSString *token = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
#warning TODO
    
    NSString *uuid = twlt_uuid_create();
    
    if (token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"id"];
    }else{
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"id"];
    }
    
    [self.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    
    
    
    if (type == GET) {
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [YXNetworkHUD dismiss];
            success(responseObject, [self getRespodHeaderWithTask:task]);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                YXLog(@"%@",error);
                failure(error);
            }
            [YXNetworkHUD dismiss];
        }];
        
    }else{
        
        [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id json;
                NSError *error;
                json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                if (error) {
                    json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                }
            
            [YXNetworkHUD dismiss];
            
            //** token失效状态 */
            if ([[self getRespodHeaderWithTask:task][@"Status"] isEqualToString:@"3"]) {
                
                [self ShowOutLoginView:3];
                return ;
            }
            
            //** 登录状态异常 */
            if ([[self getRespodHeaderWithTask:task][@"Status"] isEqualToString:@"6"]) {
                
                [self ShowOutLoginView:6];
                return;
            }
            
            success(json, [self getRespodHeaderWithTask:task]);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                YXLog(@"%@",error);
                
                [self showRemindGoodsViewWithType:@"网络异常"];
                
                failure(error);
                [YXNetworkHUD dismiss];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [YXNetworkHUD dismiss];

            });
        }];
    }
}


//** 获取响应头 */
- (id)getRespodHeaderWithTask:(NSURLSessionTask *)task
{
    NSHTTPURLResponse *respond = (NSHTTPURLResponse *)task.response;
    return respond.allHeaderFields;
}


#pragma mark - 取消网络请求--全部请求
+ (void)cancelAllNetworkRequest
{
    [[YXNetworkTool sharedTool].operationQueue cancelAllOperations];
}

/**
 *  取消指定的url请求
 *  @param type 该请求的请求类型
 *  @param path 该请求的完整url
 */
+(void)cancelHttpRequestWithType:(NSString *)type WithPath:(NSString *)path {
    NSError * error;
    // 根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求
    NSString * urlToPeCanced = [[[[YXNetworkTool sharedTool].requestSerializer requestWithMethod:type URLString:path parameters:nil error:&error] URL] path];
    for (NSOperation * operation in [YXNetworkTool sharedTool].operationQueue.operations) {
        // 如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            // 请求的类型匹配
            BOOL hasMatchRequestType = [type isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            // 请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            // 两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
        [operation cancel];
    }
}


-(void)requestImageCoderDataWithType:(RequestMethod)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    
    
    //NSString *token = [YXUserDefaults objectForKey:@"TokenID"];
    NSString *token = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
    
    NSString *uuid = twlt_uuid_create();
    
    if (token) {
        
        [self.requestSerializer setValue:token forHTTPHeaderField:@"id"];
    }
    [self.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    
    
    if (type == GET) {
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success(responseObject, [self getRespodHeaderWithTask:task]);
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                YXLog(@"%@",error);
                failure(error);
            }
            [SVProgressHUD dismiss];
        }];
        
    }else{
        
        [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success(responseObject, [self getRespodHeaderWithTask:task]);
            
            [SVProgressHUD dismiss];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                YXLog(@"%@",error);
                //[SVProgressHUD showErrorWithStatus:@"网络异常"];
                //** 自己的网络异常弹框 */
                [self showRemindGoodsViewWithType:@"网络异常"];
                failure(error);
                
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //[SVProgressHUD dismiss];
                //** 取消网络异常弹窗 */
            });
        }];
    }
}





/*
 @brief 循环请求 不需要进度指示器
 */

-(void)LoopRequestDataWithType:(RequestMethod)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    
    //NSString *token = [YXUserDefaults objectForKey:@"TokenID"];
    NSString *token = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
    
//    NSString *uuid = [[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *uuid = twlt_uuid_create();
    
    if (token) {
        
        [self.requestSerializer setValue:token forHTTPHeaderField:@"id"];
    }
    [self.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    
    
    
    if (type == GET) {
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success(responseObject, [self getRespodHeaderWithTask:task]);
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                YXLog(@"%@",error);
                failure(error);
            }
        }];
        
    }else{
        
        [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id json;
            
            NSError *error;
            json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
            if (error) {
                json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            }
            
            
            success(json, [self getRespodHeaderWithTask:task]);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                YXLog(@"%@",error);
                failure(error);
                
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }];
    }
}

/**
 弹窗
 
 @param type 弹窗的样式
 */
- (void)showRemindGoodsViewWithType:(NSString *)type
{
    //--弹窗
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = type;
    self.RemindGoodsView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wealself dimssview];
    });
}

//** 取消弹窗 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}


- (AFSecurityPolicy *)customSecurityPolicy {
    
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ca6.server1" ofType:@"cer"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES;
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil, nil];
    
    return securityPolicy;
}


-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    if(![challenge.protectionSpace.authenticationMethod isEqualToString:@"NSURLAuthenticationMethodServerTrust"])
    {
        return;
    }
    YXLog(@"%@",challenge.protectionSpace);
    //NSURLSessionAuthChallengeDisposition 如何处理证书
    /*
     NSURLSessionAuthChallengeUseCredential = 0, 使用该证书 安装该证书
     NSURLSessionAuthChallengePerformDefaultHandling = 1, 默认采用的方式,该证书被忽略
     NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2, 取消请求,证书忽略
     NSURLSessionAuthChallengeRejectProtectionSpace = 3,          拒绝
     */
    NSURLCredential *credential = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
    
    //NSURLCredential 授权信息
    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
}


-(void)ShowOutLoginView:(NSInteger)OutLoginStatus
{
    /**
     清除Token
     */
    //[YXUserDefaults removeObjectForKey:@"TokenID"];
    [[YXLoginStatusTool sharedLoginStatus] removeTokenId];
    
    [self.operationQueue cancelAllOperations];
    //** 添加异常登录视图 */
    [[UIApplication sharedApplication].keyWindow addSubview: self.offLineNotificationController.view];
    self.offLineNotificationController.view.hidden = NO;
    self.offLineNotificationController.LoginStatus = OutLoginStatus;
    
    if ([self checkNeedGoodsWith:self.currentURL]) {
        self.offLineNotificationController.GoodsDict = self.GoodsDict;
    }
    
    [YXUserDefaults setObject:@"6" forKey:@"FromeMianLoginSatus"];
    
    [JPush setAlias:@""];
    [YXNetworkHUD dismiss];
    
}

#pragma mark - 懒加载

- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

- (YXOffLineNotificationController *)offLineNotificationController
{
    if (!_offLineNotificationController) {
        YXOffLineNotificationController *controller = [[YXOffLineNotificationController alloc] init];
        _offLineNotificationController = controller;
        _offLineNotificationController.view.frame = [UIScreen mainScreen].bounds;
        
    }
    return _offLineNotificationController;
}

// 商品详情接口，查询是否自己商品接口，确认订单接口，去支付接口, (---待优化---)
-(BOOL)checkNeedGoodsWith:(NSString *)urlstr{
    if([self.currentURL isEqualToString:REQUESTONEPRICEGOODSDEATIL_URL]||[self.currentURL isEqualToString:CHENGCKSELFBUY_URL]||[self.currentURL isEqualToString:REQUESTCONFIRMORDERDATA_URL]|| [self.currentURL isEqualToString:GOTOPAYFROMECOFIRMORDER_URL]){
        return YES;
    }
    return NO;
}
@end
