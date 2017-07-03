//
//  YXInputPaymentPasswordTextFieldView.h
//  Project
//
//  Created by 郑键 on 17/2/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXInputPaymentPasswordTextFieldView;

@protocol YXInputPaymentPasswordTextFieldViewDelegate <NSObject>

- (void)inputPaymentPasswordTextFieldView:(YXInputPaymentPasswordTextFieldView *)inputPaymentPasswordTextFieldView
                              buttonClick:(UIButton *)sender;

@end

@interface YXInputPaymentPasswordTextFieldView : UIView

/**
 密码输入框
 */
@property (nonatomic, weak) UITextField *pwdInputTextField;

/**
 代理
 */
@property (nonatomic, weak) id<YXInputPaymentPasswordTextFieldViewDelegate> delegate;

@end
