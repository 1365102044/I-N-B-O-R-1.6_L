//
//  YXThirdPartyBindingModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/17.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXLoginViewController.h"
/**
 支付结果处理
 flag
 YXNotRegister = 0,                 0	该手机未注册
 YXAlearlyBindingOtherAccount,      1	该手机已绑定其他微信
 YXAccountDisble,                   2	您的账户已被禁用,请联系客服
 YXAlearlyRegisterApp,              3	该手机已注册过胤宝
 */
typedef NS_ENUM(NSUInteger ,YXBindingPhoneType){
    
    YXNotRegister = 0,
    YXAlearlyBindingOtherAccount,
    YXAccountDisble,
    YXAlearlyRegisterApp,
};

@interface YXThirdPartyBindingModle : NSObject
//** 不带*的手机号 */
@property(nonatomic,copy) NSString * phone;
//** 带*的手机号 */
@property(nonatomic,copy) NSString * phoneshow;

@property(nonatomic,copy) NSString * openid;
//** 微信 1； qq 2 */
@property(nonatomic,assign) NSInteger  type;

@property(nonatomic,assign) NSInteger  flag;

@property(nonatomic,assign) YXThridLoginType  loginType;

@property(nonatomic,assign) YXBindingPhoneType  TheAccountStatus;

@property(nonatomic,strong) UIViewController * sourViewController;

@end
