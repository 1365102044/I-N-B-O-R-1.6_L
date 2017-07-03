//
//  YXInputPaymentPasswordView.m
//  Project
//
//  Created by 郑键 on 17/2/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXInputPaymentPasswordView.h"
#import "YXInputPaymentPasswordTextFieldView.h"

@interface YXInputPaymentPasswordView() <YXInputPaymentPasswordTextFieldViewDelegate>

/**
 inputPaymentPasswordView
 */
@property (nonatomic, strong) UIView *inputPaymentPasswordView;

@end

@implementation YXInputPaymentPasswordView

#pragma mark - Zero.Const

/**
 *  输入密码界面高度
 */
CGFloat inputPaymentPasswordViewHeight = 403;

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /**
     *  动画
     */
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha                                                          = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

/**
 按钮点击事件

 @param sender sender
 */
- (void)funcButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(inputPaymentPasswordView:pwd:otherButton:)]) {
        [self.delegate inputPaymentPasswordView:self pwd:nil otherButton:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark <YXInputPaymentPasswordTextFieldViewDelegate>

/**
 确定按钮点击事件

 @param inputPaymentPasswordTextFieldView       inputPaymentPasswordTextFieldView
 @param sender                                  sender
 */
- (void)inputPaymentPasswordTextFieldView:(YXInputPaymentPasswordTextFieldView *)inputPaymentPasswordTextFieldView
                              buttonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(inputPaymentPasswordView:pwd:otherButton:)]) {
        
        [self.delegate inputPaymentPasswordView:self
                                            pwd:[YXStringFilterTool getSha1String:inputPaymentPasswordTextFieldView.pwdInputTextField.text]
                                    otherButton:sender];
    }
}

#pragma mark - Fifth.视图生命周期

/**
 弹出视图

 @param extend extend       扩展参数
 */
+ (instancetype)inputPaymentPasswordViewPresentWithExtend:(id)extend
{
    __block YXInputPaymentPasswordView *view                                    = [[self alloc] init];
    [SYSTEM_KEYWINDOW addSubview:view];
    
    /**
     *  动画
     */
    [UIView animateWithDuration:0.5
                          delay:0.1
         usingSpringWithDamping:0.5
          initialSpringVelocity:15.f
                        options:0
                     animations:^{
                         view.inputPaymentPasswordView.transform                = CGAffineTransformMakeTranslation(0,
                                                                                                                   ADJUST_PERCENT_FLOAT(-inputPaymentPasswordViewHeight));
                     }
                     completion:^(BOOL finished) {}];
    return view;
}

/**
 初始化

 @param frame               frame
 @return                    view
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self customUISetup];
    }
    return self;
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)customUISetup
{
    self.backgroundColor    = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.frame              = CGRectMake(0,
                                         0,
                                         SCREEN_WIDTH,
                                         SCREEN_HEIGHT);
    
    [self addSubview:self.inputPaymentPasswordView];
}

#pragma mark - Seventh.懒加载

- (UIView *)inputPaymentPasswordView
{
    if (!_inputPaymentPasswordView) {
        
        _inputPaymentPasswordView                           = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                                       SCREEN_HEIGHT,
                                                                                                       SCREEN_WIDTH,
                                                                                                       ADJUST_PERCENT_FLOAT(inputPaymentPasswordViewHeight))];
        
        _inputPaymentPasswordView.backgroundColor           = [UIColor whiteColor];
        
        /**
         *  取消按钮
         */
        UIButton *cancelButton                              = [[UIButton alloc] init];
        cancelButton.tag                                    = 1001;
        cancelButton.backgroundColor                        = _inputPaymentPasswordView.backgroundColor;
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"ic_wallet_password_cancel"]
                                forState:UIControlStateNormal];
        [cancelButton addTarget:self
                         action:@selector(funcButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
        
        /**
         *  titleLabel
         */
        UILabel *titleLabel                                 = [[UILabel alloc] init];
        titleLabel.text                                     = @"输入支付密码";
        titleLabel.font                                     = REGULAR_FONT(16.f);
        titleLabel.textColor                                = [UIColor walletTextColor];
        titleLabel.backgroundColor                          = _inputPaymentPasswordView.backgroundColor;
        
        /**
         *  分割线
         */
        UIView *marginLineView                              = [[UIView alloc] init];
        marginLineView.backgroundColor                      = [UIColor themGrayColor];
        
        /**
         *  输入框封装控件
         */
        YXInputPaymentPasswordTextFieldView *pwdTextField   = [[YXInputPaymentPasswordTextFieldView alloc] init];
        pwdTextField.backgroundColor                        = _inputPaymentPasswordView.backgroundColor;
        pwdTextField.delegate                               = self;
        
        /**
         *  忘记密码按钮
         */
        UIButton *forgetPasswordButton                      = [[UIButton alloc] init];
        forgetPasswordButton.tag                            = 1002;
        forgetPasswordButton.backgroundColor                = _inputPaymentPasswordView.backgroundColor;
        forgetPasswordButton.titleLabel.font                = REGULAR_FONT(13.f);
        [forgetPasswordButton setTitleColor:[UIColor systemButtonTextColor]
                                   forState:UIControlStateNormal];
        [forgetPasswordButton setTitle:@"忘记支付密码？"
                              forState: UIControlStateNormal];
        [forgetPasswordButton addTarget:self
                                 action:@selector(funcButtonClick:)
                       forControlEvents:UIControlEventTouchUpInside];
        
        [_inputPaymentPasswordView addSubview:cancelButton];
        [_inputPaymentPasswordView addSubview:titleLabel];
        [_inputPaymentPasswordView addSubview:marginLineView];
        [_inputPaymentPasswordView addSubview:pwdTextField];
        [_inputPaymentPasswordView addSubview:forgetPasswordButton];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_inputPaymentPasswordView);
            make.height.with.mas_equalTo(ADJUST_PERCENT_FLOAT(50));
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_inputPaymentPasswordView);
            make.top.mas_equalTo(ADJUST_PERCENT_FLOAT(17.5));
        }];
        
        [marginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_inputPaymentPasswordView);
            make.top.mas_equalTo(cancelButton.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
        [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(marginLineView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(30));
            make.left.mas_equalTo(_inputPaymentPasswordView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.right.mas_equalTo(_inputPaymentPasswordView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
            make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(50));
        }];
        
        [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pwdTextField.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(23.5));
            make.right.mas_equalTo(_inputPaymentPasswordView).mas_offset(ADJUST_PERCENT_FLOAT(-16));
        }];
    }
    return _inputPaymentPasswordView;
}

@end
