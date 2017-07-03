//
//  YXInputPaymentPasswordTextFieldView.m
//  Project
//
//  Created by 郑键 on 17/2/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXInputPaymentPasswordTextFieldView.h"

@interface YXInputPaymentPasswordTextFieldView()

@end

@implementation YXInputPaymentPasswordTextFieldView

#pragma mark - Zero.Const

/**
 *  按钮左边线上下间距
 */
CGFloat suerButtonLeftLineTopAndBottomSpacing = 8.f;

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 点击事件

 @param sender sender
 */
- (void)sureButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(inputPaymentPasswordTextFieldView:buttonClick:)]) {
        [self.delegate inputPaymentPasswordTextFieldView:self buttonClick:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化

 @param frame frame
 @return 对象
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupCustomUI];
    }
    return self;
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)setupCustomUI
{
    self.layer.borderWidth                              = ADJUST_PERCENT_FLOAT(1);
    self.layer.borderColor                              = [UIColor themGrayColor].CGColor;
    self.layer.cornerRadius                             = ADJUST_PERCENT_FLOAT(4.f);
    self.layer.masksToBounds                            = YES;
    
    /**
     *  确定按钮
     */
    UIButton *sureButton                                = [[UIButton alloc] init];
    sureButton.tag                                      = 1003;
    sureButton.frame                                    = CGRectMake(0,
                                                                     0,
                                                                     ADJUST_PERCENT_FLOAT(79),
                                                                     ADJUST_PERCENT_FLOAT(50));
    sureButton.backgroundColor                          = self.backgroundColor;
    sureButton.backgroundColor                          = [UIColor whiteColor];
    sureButton.titleLabel.font                          = REGULAR_FONT(16);
    [sureButton setTitleColor:[UIColor walletTextLightColor]
                     forState:UIControlStateNormal];
    [sureButton setTitle:@"确认"
                forState:UIControlStateNormal];
    [sureButton addTarget:self
                   action:@selector(sureButtonClick:)
         forControlEvents:UIControlEventTouchUpInside];
    
    CAShapeLayer *layer                                 = [[CAShapeLayer alloc] init];
    UIBezierPath *path                                  = [UIBezierPath bezierPathWithRect:CGRectMake(0,
                                                                                                      ADJUST_PERCENT_FLOAT(suerButtonLeftLineTopAndBottomSpacing),
                                                                                                      ADJUST_PERCENT_FLOAT(1.f),
                                                                                                      sureButton.height - 2 * ADJUST_PERCENT_FLOAT(suerButtonLeftLineTopAndBottomSpacing))];
    layer.path                                          = path.CGPath;
    layer.fillColor                                     = [UIColor themGrayColor].CGColor;
    [sureButton.layer addSublayer:layer];
    
    /**
     *  密码输入框
     */
    UITextField *pwdTextField                           = [[UITextField alloc] init];
    pwdTextField.rightView                              = sureButton;
    pwdTextField.keyboardType                           = UIKeyboardTypeASCIICapable;
    pwdTextField.rightViewMode                          = UITextFieldViewModeAlways;
    pwdTextField.backgroundColor                        = self.backgroundColor;
    pwdTextField.autocorrectionType                     = UITextAutocorrectionTypeNo;
    pwdTextField.secureTextEntry                        = YES;
    _pwdInputTextField                                  = pwdTextField;
    
    [self addSubview:sureButton];
    [self addSubview:pwdTextField];
    
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Seventh.懒加载

@end
