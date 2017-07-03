//
//  YXShareSDKManager.h
//  inbid-ios
//
//  Created by 郑键 on 17/1/9.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "WXApi.h"
#import <WeiboSDK.h>

@interface YXShareSDKManager : NSObject

/**
 获取单利
 
 @return 对象
 */
+ (instancetype)sharedManager;

/**
 注册sdk
 */
- (void)registerApp;

/**
 分享
 
 @param imageURLString          商品图片
 @param goodNamed               商品名称
 @param goodDetal               商品描述
 @param prodId                  商品id
 @param prodBidId               拍品id
 */
- (void)shareGoodWithImageURLString:(NSString *)imageURLString
                       andGoodNamed:(NSString *)goodNamed
                      andGoodDetail:(NSString *)goodDetal
                          andProdId:(NSString *)prodId
                       andProdBidId:(NSString *)prodBidId
                  andViewController:(UIViewController *)viewController;

@end
