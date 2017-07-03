//
//  AppDelegate.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 是否通知付款方式界面
 
 - AppDelegateDidBecomeActiveNone:                  刚进入程序
 - AppDelegateDidBecomeActiveQueryGoodStatus:       查询状态
 - AppDelegateDidBecomeActiveWXCallBacked:          WX已经回调
 */
typedef NS_ENUM(NSUInteger, AppDelegateDidBecomeActiveStatus) {
    AppDelegateDidBecomeActiveNone,
    AppDelegateDidBecomeActiveQueryGoodStatus,
    AppDelegateDidBecomeActiveWXCallBacked,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/**
 当前是否发送支付回调通知(用于进入支付程序后，点击home键或状态栏返回应用)
 */
@property (nonatomic, assign) AppDelegateDidBecomeActiveStatus status;

/**
 keyWindow
 */
@property (strong, nonatomic) UIWindow *window;

/**
 项目tabBar控制器
 */
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

