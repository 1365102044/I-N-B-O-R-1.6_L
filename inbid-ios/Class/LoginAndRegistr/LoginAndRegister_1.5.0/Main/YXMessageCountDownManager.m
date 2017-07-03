//
//  YXMessageCountDownManager.m
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXMessageCountDownManager.h"

@interface YXMessageCountDownManager()

/**
 重新获取验证码的倒计时时间
 */
@property (nonatomic, assign) NSTimeInterval reLoadSMSTime;

/**
 验证码失效倒计时时间
 */
@property (nonatomic, assign) NSTimeInterval expiredSMSTime;

@end

@implementation YXMessageCountDownManager

/**
 重新获取短信验证码倒计时时间
 */
CGFloat reLoadSMSTimeInterval                           = 60.f;

/**
 短信验证码失效倒计时时间
 */
CGFloat expiredSMSTimeInterval                          = 300.f;

/**
 重置当前倒计时数据

 @param SMSDate 倒计时时间
 */
- (void)setSMSDate:(NSDate *)SMSDate
{
    _SMSDate = SMSDate;
    
    self.reLoadSMSTime                                   = CGFLOAT_MIN;
    self.expiredSMSTime                                  = CGFLOAT_MIN;
}

/**
 获取重新获取短信验证码倒计时时间

 @return 秒数
 */
- (NSTimeInterval)reLoadSMSTime
{
    if (_reLoadSMSTime == CGFLOAT_MIN) {
        NSDate *date                                        = [NSDate dateWithTimeInterval:reLoadSMSTimeInterval sinceDate:self.SMSDate];
        _reLoadSMSTime                                      = [date timeIntervalSinceDate:self.SMSDate];
    }
    return _reLoadSMSTime;
}

/**
 短信验证码失效倒计时时间

 @return 秒数
 */
- (NSTimeInterval)expiredSMSTime
{
    if (_expiredSMSTime == CGFLOAT_MIN) {
        NSDate *date                                        = [NSDate dateWithTimeInterval:expiredSMSTimeInterval sinceDate:self.SMSDate];
        _expiredSMSTime                                     = [date timeIntervalSinceDate:self.SMSDate];
    }
    return _expiredSMSTime;
}

/**
 倒计时字符串

 @return 倒计时字符串
 */
- (NSString *)countDownString
{
    if (self.reLoadSMSTime >= 0) {
        _countDownString                                    = [NSString stringWithFormat:@"%lld秒",
                                                               (long long)self.reLoadSMSTime % 60];
    }else{
        if (self.expiredSMSTime < 0) {
            _countDownString                                = @"验证码超时失效";
        }else{
            _countDownString                                = @"可重新获取短信验证码";
        }
    }
    YXLog(@"%@\n%f\n%f", _countDownString, self.reLoadSMSTime, self.expiredSMSTime);
    return _countDownString;
}

/**
 获取单例对象

 @return 返回单例对象
 */
+ (instancetype)shareManager {
    static YXMessageCountDownManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager                                             = [[YXMessageCountDownManager alloc] init];
    });
    return manager;
}

/**
 倒计时
 */
- (void)countDown
{
    self.reLoadSMSTime                                      -= 1;
    self.expiredSMSTime                                     -= 1;
}

@end
