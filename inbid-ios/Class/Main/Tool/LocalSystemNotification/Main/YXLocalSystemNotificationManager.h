//
//  YXLocalSystemNotificationManager.h
//  inbid-ios
//
//  Created by 郑键 on 17/2/28.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXLocalSystemNotificationManager : NSObject

/**
 推送本地通知
 
 @param alerTime 几秒后展示
 */
+ (void)registerNotification:(CGFloat)alerTime
                       title:(NSString *)title
                        body:(NSString *)body;

@end
