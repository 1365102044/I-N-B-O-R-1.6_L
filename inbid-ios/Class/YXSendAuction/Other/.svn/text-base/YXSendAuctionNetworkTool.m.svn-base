//
//  YXSendAuctionNetworkTool.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionNetworkTool.h"
#import "YXSendAuctionURLMacros.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXSendAuctionGoodPartsModel.h"

@interface YXSendAuctionNetworkTool()

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;



@end

@implementation YXSendAuctionNetworkTool

+(instancetype)sharedTool{
    
    static YXSendAuctionNetworkTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXSendAuctionNetworkTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        //        tool.requestSerializer = [AFJSONRequestSerializer serializer];
        tool.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        tool.securityPolicy.allowInvalidCertificates = YES;
        tool.securityPolicy.validatesDomainName = NO;
        
        //** 解决http请求重定向 */
        [tool setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
            return nil;
        }];
        
    });
    return tool;
}


/**
 生成鉴定订单
 
 @param prodName     商品名称
 @param orderContent 订单内容
 @param prodImages   图片数组
 @param brand        品牌
 @param accessoryIds 商品配件ID(多个用逗号隔开)
 */
- (void)addIdenifyOrderWithProdName:(NSString *)prodName
                       orderContent:(NSString *)orderContent
                         prodImages:(NSArray *)prodImages
                              brand:(NSString *)brand
                       accessoryIds:(NSArray *)accessoryIds
                            success:(void (^)(id objc, id respodHeader))success
                            failure:(void (^)(NSError *error))failure;
{
    NSString *prodImagesString;
    for (NSInteger i = 0; i < prodImages.count; i++) {
        NSString *tempUrlString = prodImages[i];
        if (i == 0) {
            prodImagesString = tempUrlString;
        }else{
            prodImagesString = [NSString stringWithFormat:@"%@,%@", prodImagesString, tempUrlString];
        }
        
    }
    
    NSDictionary *params;
    NSString *accessoryIdsStr;
    if (accessoryIds.count == 0 || !accessoryIds) {
        params = @{@"prodName": prodName,
                   @"orderContent": orderContent,
                   @"prodImages": prodImagesString,
                   @"brand":brand};
    }else{
        
        for (NSInteger i = 0; i < accessoryIds.count; i++) {
            YXSendAuctionGoodPartsModel *model = accessoryIds[i];
            if (i == 0) {
                accessoryIdsStr = [NSString stringWithFormat:@"%zd", model.partId];
            }else{
                accessoryIdsStr = [NSString stringWithFormat:@"%@,%zd", accessoryIdsStr, model.partId];
            }
        }
        
        params = @{@"prodName": prodName,
                   @"orderContent": orderContent,
                   @"prodImages": prodImagesString,
                   @"brand":brand,
                   @"accessoryIds":accessoryIdsStr};
    }
    
    
    [self requestDataWithType:POST url:SENDAUCTIONIDENIFYORDER_URL params:params success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            [self showRemindGoodsViewWithType:@"登录状态异常"];
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取商品配件
 
 @param success success 成功
 @param failure failure 失败
 */
- (void)getGoodPartsWithSuccess:(void (^)(id objc, id respodHeader))success
                        failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:SENDAUCTIONGETGOODPARTS_URL params:@{} success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取商品品牌
 
 @param success success 成功
 @param failure failure 失败
 */
- (void)getGoodBranceWithSuccess:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:SENDAUCTIONGETGOODBRAND_URL params:@{} success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 删除图片
 
 @param imageUrlString  图片的URLString
 @param success         成功
 @param failure         失败
 */
- (void)deleteImageWithImageUrlString:(NSString *)imageUrlString
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"filename":imageUrlString};
    [self requestDataWithType:POST
                          url:SENDAUCTIONGETDELIMAGE_URL
                       params:params
                      success:^(id objc, id respodHeader) {
                          success(objc, respodHeader);
                      } failure:^(NSError *error) {
                          failure(error);
                      }];
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


- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

@end
