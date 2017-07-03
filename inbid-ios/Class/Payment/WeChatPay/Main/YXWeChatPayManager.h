//
//  YXWeChatPayManager.h
//  Payment
//
//  Created by 郑键 on 16/12/2.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
@class YXSeverSignInformationModel;
@class YXNavigationController;

@protocol YXWeChatPayManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

- (void)managerDidRecvChooseCardResponse:(WXChooseCardResp *)response;

- (void)managerDidPayResponse:(PayResp *)response;

@end

@interface YXWeChatPayManager : NSObject

/**
 代理
 */
@property (nonatomic, assign) id<YXWeChatPayManagerDelegate> delegate;

/**
 支付回调详情界面数组
 */
@property (nonatomic, strong) NSMutableArray *navigationControllerArray;

/**
 获取单利
 
 @return 对象
 */
+ (instancetype)sharedManager;

/**
 在微信支付注册App
 */
- (void)weChatPayRegisterApp;

/**
 发起微信支付

 @param url url
 @return 返回状态
 */
- (BOOL)handleOpenURL:(NSURL *)url;

/**
 发起支付
 
 @param requestParams 支付参数
 */
- (BOOL)weChatPay:(YXSeverSignInformationModel *)requestParams;


-(void)sendAuthRequest:(UIViewController *)viewcontroller;

@end
