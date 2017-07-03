//
//  YXTimeCountDownManger.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 使用单例
#define kCountDownManager [YXTimeCountDownManger manager]
/// 一口价倒计时的通知
#define kCountDownNotification @"CountDownNotification"
#define KCountDownNotiWithPictureStatus @"KCountDownNotiWithPictureStatus"



@interface YXTimeCountDownManger : NSObject

/// 时间差(单位:秒)
@property (nonatomic, assign) NSInteger timeInterval;

/// 使用单例
+ (instancetype)manager;
/// 开始倒计时
- (void)start;
/// 刷新倒计时
- (void)reload;

//**停止倒计时**/
-(void)stopTime;
@end
