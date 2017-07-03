//
//  YXChatViewManger.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQChatViewManager.h"
#import  <MeiQiaSDK/MQManager.h>
@interface YXChatViewManger : MQChatViewManager

/**
 是否接收通知标识
 */
@property (nonatomic, assign) BOOL showSystemNofification;

+ (instancetype)sharedChatviewManger;

/**
 注册客服
 */
- (void)registerCustomSever;

/**
 处理消息推送的客服信息

 @param userInfo userInfo
 */
- (void)handleNotificationMessageWithUserInfo:(NSDictionary *)userInfo;

-(void)LoadChatView;

@end
