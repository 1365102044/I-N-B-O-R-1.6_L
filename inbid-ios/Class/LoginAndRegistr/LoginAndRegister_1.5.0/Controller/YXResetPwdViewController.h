//
//  YXResetPwdViewController.h
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 重置密码控制器类型

 - YXResetPwdViewControllerTypeNone:                    无类型
 - YXResetPwdViewControllerTypeResetPwd:                重置密码
 - YXResetPwdViewControllerTypeResetResult:             重置密码结果页
 */
typedef NS_ENUM(NSUInteger, YXResetPwdViewControllerType) {
    YXResetPwdViewControllerTypeNone,
    YXResetPwdViewControllerTypeResetPwd,
    YXResetPwdViewControllerTypeResetResult,
};

@interface YXResetPwdViewController : UIViewController

/**
 重置密码控制器

 @param type                                            类型
 @param phoneNumber                                     手机号码
 @param extend                                          扩展参数(可传nil) 重置密码时传入验证码正确返回的串
 @return                                                重置密码控制器实例对象
 */
+ (instancetype)resetPwdViewControllerType:(YXResetPwdViewControllerType)type
                               phoneNumber:(NSString *)phoneNumber
                                 andExtend:(id)extend;

@end
