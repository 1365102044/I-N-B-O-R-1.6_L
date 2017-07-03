//
//  YXVerificationPaymentPwdController.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXVerificationPaymentPwdView;

@protocol YXVerificationPaymentPwdViewDelegate <NSObject>

/**
 验证付款界面按钮点击事件

 @param verificationPaymentPwdView 验证付款界面
 @param sender                     点击的按钮
 */
- (void)verificationPaymentPwdView:(YXVerificationPaymentPwdView *)verificationPaymentPwdView andClickButton:(UIButton *)sender andTextFieldText:(NSString *)pwdText;

@end

/*
 @brief 输入图片验证码的回调
 */

typedef void(^textfieldBlock)(NSString *text);

/*
 @brief 切换图片验证码
 */
typedef void(^ClickChangeImagecodeBlock)();

@interface YXVerificationPaymentPwdView : UIView

@property (nonatomic, weak)id<YXVerificationPaymentPwdViewDelegate> delegate;


@property(nonatomic,copy) ClickChangeImagecodeBlock  Changeimagecodeblock;
@property(nonatomic,copy) textfieldBlock  textblock;

@property(nonatomic,strong) UIImage  * imagecode;

@property(nonatomic,assign) BOOL  imagecodeshowStatus;

@property(nonatomic,strong) NSString * errorstr;


@end
