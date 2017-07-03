//
//  YXBankCardInformationSubModel.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXBankCardInformationSubModel.h"

@interface YXBankCardInformationSubModel()

@end

@implementation YXBankCardInformationSubModel

- (instancetype)init
{
    if (self == [super init]) {
        self.time = CGFLOAT_MAX;
    }
    return self;
}

/**
 需要倒计时时调用
 */
- (void)countDown
{
    self.title = [NSString stringWithFormat:@"%.0f秒", self.time--];
    
    if (self.time <= 0) {
        self.title = @"获取验证码";
        return;
    }
}

- (CGFloat)time
{
    if (_time == CGFLOAT_MAX) {
        _time = 60;
    }
    return _time;
}

@end
