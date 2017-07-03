//
//  YXVerificationReturnGoodViewController.h
//  inbid-ios
//
//  Created by 郑键 on 17/3/7.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXVerificationReturnGoodViewController;

@protocol YXVerificationReturnGoodViewControllerDelegate <NSObject>

/**
 验证付款界面按钮点击事件
 
 @param sender                              点击的按钮
 @param loginPassword                       登录密码
 @param idCard                              身份证后八位
 */
- (void)verificationReturnGoodViewController:(YXVerificationReturnGoodViewController *)verificationReturnGoodViewController
                                 clickButton:(UIButton *)sender
                               loginPassword:(NSString *)loginPassword
                                      idCard:(NSString *)idCard;

@end

@interface YXVerificationReturnGoodViewController : UIViewController

/**
 代理
 */
@property (nonatomic, weak) id<YXVerificationReturnGoodViewControllerDelegate> delegate;

@end
