//
//  YXNetworkTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, RequestMethod) {
    GET,
    POST,
};

@interface YXNetworkTool : AFHTTPSessionManager

//** -------获取网络工具类 -----------**/
+(instancetype)sharedTool;
-(void)requestDataWithType:(RequestMethod)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
/**
 *  取消指定的url请求
 *
 *  @param type 该请求的请求类型
 *  @param path 该请求的完整url
 */
+(void)cancelHttpRequestWithType:(NSString *)type WithPath:(NSString *)path;

-(void)requestImageCoderDataWithType:(RequestMethod)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

#pragma mark - 取消网络请求--全部请求
+ (void)cancelAllNetworkRequest;

/*
 @brief 循环请求，
 */
-(void)LoopRequestDataWithType:(RequestMethod)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

@end
