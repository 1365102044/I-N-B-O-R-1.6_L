//
//  YXMessageCountDownManager.h
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMessageCountDownManager : NSObject

/**
 countString
 */
@property (nonatomic, copy) NSString *countDownString;

/**
 记录短信发送时间
 */
@property (nonatomic, strong) NSDate *SMSDate;

/**
 获取单例对象
 
 @return 返回单例对象
 */
+ (instancetype)shareManager;

/**
 倒计时
 */
- (void)countDown;

@end
