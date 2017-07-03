//
//  YXSendAuctionNetworkTool.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNetworkTool.h"

@interface YXSendAuctionNetworkTool : YXNetworkTool

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

/**
 获取商品配件

 @param success success 成功
 @param failure failure 失败
 */
- (void)getGoodPartsWithSuccess:(void (^)(id objc, id respodHeader))success
                        failure:(void (^)(NSError *error))failure;

/**
 获取商品品牌
 
 @param success success 成功
 @param failure failure 失败
 */
- (void)getGoodBranceWithSuccess:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;

/**
 删除图片

 @param imageUrlString  图片的URLString
 @param success         成功
 @param failure         失败
 */
- (void)deleteImageWithImageUrlString:(NSString *)imageUrlString
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure;
@end
