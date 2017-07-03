//
//  YXInputPhoneNumberViewController.h
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXThirdPartyBindingModle.h"

/**
 登录控制器

 - YXLoginViewControllerTypeNone:               无类型
 - YXLoginViewControllerTypeRegister:           手机号注册界面
 - YXLoginViewControllerTypeResetPwd:           重置密码界面
 - YXLoginViewControllerTypeBinding:            第三方登录绑定手机号界面
 */
typedef NS_ENUM(NSUInteger, YXLoginViewControllerType) {
    YXLoginViewControllerTypeNone,
    YXLoginViewControllerTypeRegister,
    YXLoginViewControllerTypeResetPwd,
    YXLoginViewControllerTypeBinding,
};


@interface YXInputPhoneNumberViewController : UIViewController

/**
 初始化

 @param type                                    控制器类型
 @param extend                                  后期扩展参数（没有暂时客传nil）
 @return                                        返回对应控制器对象
 */
+ (instancetype)inputPhoneNumberViewControllerWithType:(YXLoginViewControllerType)type
                                             andExtend:(id)extend;

-(void)formeThirdAccountWith:(YXThirdPartyBindingModle *)bindingmodle;

@end
