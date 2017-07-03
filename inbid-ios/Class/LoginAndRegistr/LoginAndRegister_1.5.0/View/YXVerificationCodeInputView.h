//
//  YXVerificationCodeInputView.h
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXVerificationCodeInputView;

@protocol YXVerificationCodeInputViewDelegate <NSObject>

/**
 输入完成回调

 @param verificationCodeInputView           当前输入控件
 @param verificationCodeText                输入内容
 */
- (void)verificationCodeInputView:(YXVerificationCodeInputView *)verificationCodeInputView
             verificationCodeText:(NSString *)verificationCodeText;

@end

@interface YXVerificationCodeInputView : UIView

/**
 代理
 */
@property (nonatomic, weak) id<YXVerificationCodeInputViewDelegate> delegate;

/**
 输入框
 */
@property (nonatomic, strong) UITextField *inputVerificationCodeTextField;

/**
 密码验证失败
 */
@property(assign, nonatomic) BOOL passWordFailed;

@end
