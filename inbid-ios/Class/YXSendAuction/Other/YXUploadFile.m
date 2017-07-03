//
//  YXUploadFile.m
//  YXSendAuction
//
//  Created by 郑键 on 16/10/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXUploadFile.h"
#import "YXSendAuctionURLMacros.h"
#import "YXSendAuctionImageManager.h"
#import "YXSendAuctionProgressModel.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "twlt_uuid_util.h"

//static NSString * const kYXBaseUrl = @"http://192.168.1.123:80";

@implementation YXUploadFile
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        randomIDStr = @"V2ymHFg03ehbqgZCaKO6jy";
        uploadID = @"imageFile";
    }
    return self;
}

#pragma mark - 私有方法

- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", uploadID,uploadFile];
    [strM appendFormat:@"Content-Type: %@\r\n\r\n", mimeType];
    
    YXLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString:(NSString *)key value:(NSString *)value
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
    [strM appendFormat:@"%@\r\n",value];
    
    
    YXLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件

//** 单张图片上传网络请求 */
- (NSURLSessionUploadTask *)uploadFileWithURL:(NSString *)urlString image:(UIImage *)img pramDic:(NSDictionary *)pramDic completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock progress:(void(^)(NSProgress *progress))progressBlock
{
    // 1> 数据体
    NSMutableData *dataM = [NSMutableData data];
    
    //    [dataM appendData:[boundaryStr dataUsingEncoding:NSUTF8StringEncoding]];
    for (NSString *name  in [pramDic allKeys]) {
        NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:[NSString stringWithFormat:@"%@.png", [pramDic valueForKey:name]]];
        [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData: UIImageJPEGRepresentation(img, 1.0)];
    }
    
    for (NSString *name  in [pramDic allKeys]) {
        NSString *bottomStr = [self bottomString:name value:[pramDic valueForKey:name]];
        [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [dataM appendData:[[NSString stringWithFormat:@"%@%@--\r\n", boundaryStr, randomIDStr] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kOuternet, urlString]] cachePolicy:0 timeoutInterval:20];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    //    YXLog(@"%@",dataM);
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";

    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 5> 设置id和uuid
    //NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"TokenID"];
    NSString *token = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
//    NSString *uuid = [[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *uuid = twlt_uuid_create();
    
    if (token) {
        [request setValue:token forHTTPHeaderField:@"id"];
    }
    [request setValue:uuid forHTTPHeaderField:@"uuid"];
    
    
    // 3> 连接服务器发送请求
    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:progressBlock completionHandler:completionBlock];
    
    return uploadTask;
}

/**
 批量上传图片
 */
- (void)uploadImagesWithImagesArray:(NSArray *)images andUploadImageUrlString:(NSString *)urlString
{
    // 需要上传的数据
    // 准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
    NSMutableArray* result = [NSMutableArray array];
    for (id objc in images) {
        [result addObject:[NSNull null]];
    }
    
    //调度组
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < images.count; i++) {
        
        dispatch_group_enter(group);
        
        [YXSendAuctionImageManager defaultManager].imageIndex += 1;
        YXSendAuctionProgressModel *model = images[i];
        model.imageIndex = i;
        model.successed = YES;
        
        NSURLSessionUploadTask* uploadTask = [self uploadFileWithURL:urlString image:model.compressImage pramDic:@{@"num": [NSString stringWithFormat:@"%zd", model.imageIndex]} completion:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                YXLog(@"%@", error);
                dispatch_group_leave(group);
            } else {
                @synchronized (result) {
                    
                    id json;
                    NSError *error;
                    json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                    if (error) {
                        json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    }
                    model.successImageUrlString = json;
                    result[i] = json;
                    
                    //** 等待服务器回调完成进度条 */
                    model.progress = 1.0;
                    if ([json isEqualToString:@"图片保存失败,请重新上传"]) {
                        model.successed = NO;
                    }
                    
                }
                dispatch_group_leave(group);
            }
        } progress:^(NSProgress *progress) {
            //** 回调进度 */
            CGFloat calculationProgress = (CGFloat)progress.completedUnitCount / (CGFloat)progress.totalUnitCount;
            model.progress = calculationProgress - 0.01;
            
        }];
        [uploadTask resume];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //** 完成回调 */
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YXSendAuctionProgressModel *model = (YXSendAuctionProgressModel *)obj;
            if (!model.successImageUrlString) {
                model.successed = NO;
            }
        }];
    });
}


@end
