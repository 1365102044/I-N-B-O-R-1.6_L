//
//  YXInputVerificationCodeViewController.h
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXThirdPartyBindingModle.h"
/**
 当前验证码是验证哪种情况的

 - YXInputVerificationCodeViewControllerTypeNone:               无类型
 - YXInputVerificationCodeViewControllerTypeReigster:           注册
 - YXInputVerificationCodeViewControllerTypeResetPwd:           重置密码
 - YXInputVerificationCodeViewControllerTypeBinding:            绑定
 */
typedef NS_ENUM(NSUInteger, YXInputVerificationCodeViewControllerType) {
    YXInputVerificationCodeViewControllerTypeNone,
    YXInputVerificationCodeViewControllerTypeReigster,
    YXInputVerificationCodeViewControllerTypeResetPwd,
    YXInputVerificationCodeViewControllerTypeBinding,
};

@interface YXInputVerificationCodeViewController : UIViewController

/**
 实例化对象
 
 @param type                控制器类型
 @param extend              后期扩展参数（暂时传nil） 100(字符串)为第三方绑定验证码直接进入
 @param phoneNumber         电话号码
 @return                    控制器对象
 */
+ (instancetype)inputVerificationCodeViewControllerWithType:(YXInputVerificationCodeViewControllerType)type
                                                phoneNumber:(NSString *)phoneNumber
                                                  andExtend:(id)extend;
/**
 从第三方过来 绑定，
 */
-(void)formeThirdbindingAccountWith:(YXThirdPartyBindingModle *)bindingmodle;

@end
