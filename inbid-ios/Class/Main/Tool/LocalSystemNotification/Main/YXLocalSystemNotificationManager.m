//
//  YXLocalSystemNotificationManager.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/28.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXLocalSystemNotificationManager.h"
#import "EBForeNotification.h"
#import "NSDate+YXExtension.h"

@interface YXLocalSystemNotificationManager()

@end

@implementation YXLocalSystemNotificationManager

+ (instancetype)shareManager
{
    static YXLocalSystemNotificationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXLocalSystemNotificationManager alloc] init];
    });
    return manager;
}

/**
 推送本地通知
 
 @param alerTime 展示alerTime
 */
+ (void)registerNotification:(CGFloat)alerTime
                       title:(NSString *)title
                        body:(NSString *)body
{
    SYSTEM_VERSION_LESS_THAN(@"10") ? [self systemVersionLessThaniOS10WithAlerTime:alerTime title:title body:body] : [self systemVersionMoreThaniOS10WithAlerTime:alerTime title:title body:body];
}

+ (void)systemVersionLessThaniOS10WithAlerTime:(CGFloat)alerTime
                                         title:(NSString *)title
                                          body:(NSString *)body
{
    [EBForeNotification handleRemoteNotification:@{@"aps":@{@"alert":body}} soundID:1312 isIos10:NO];
}

+ (void)systemVersionMoreThaniOS10WithAlerTime:(CGFloat)alerTime
                                         title:(NSString *)title
                                          body:(NSString *)body
{
    [EBForeNotification handleRemoteNotification:@{@"aps":@{@"alert":body}} soundID:1312 isIos10:YES];
}

@end
