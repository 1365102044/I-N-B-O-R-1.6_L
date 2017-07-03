//
//  YXResetPwdViewController.m
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXResetPwdViewController.h"
#import "YXActivityButton.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXStringFilterTool.h"

@interface YXResetPwdViewController () <UITextFieldDelegate>

/**
 titleLabel
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 pwdTextField
 */
@property (nonatomic, strong) UITextField *inputPwdTextField;

/**
 pwdBottomMarginLineView
 */
@property (nonatomic, strong) UIView *pwdTextFieldBottomMarginLineView;

/**
 statusButton
 */
@property (nonatomic, strong) UIButton *pwdStatusButton;

/**
 tipsLabel
 */
@property (nonatomic, strong) UILabel *tipsLabel;

/**
 activityButton
 */
@property (nonatomic, strong) YXActivityButton *activityButton;

/**
 secure switch Button
 */
@property (nonatomic, strong) UIButton *secureSwitchButton;

/**
 当前控制器类型
 */
@property (nonatomic, assign) YXResetPwdViewControllerType type;

/**
 倒计时定时器
 */
@property (nonatomic, strong) NSTimer *countDownTimer;

/**
 anmationPlaceHolder
 */
@property (nonatomic, strong) UILabel *animationPlaceHolderLabel;

/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;

/**
 用户电话号码
 */
@property (nonatomic, strong) NSString *userPhoneNumber;

/**
 验证验证码服务器返回串
 */
@property (nonatomic, copy) NSString *verificationCode;

/**
 结果页面
 */
@property (nonatomic, strong) YXResetPwdViewController *resetPwdResultViewController;

@end

@implementation YXResetPwdViewController

#pragma mark - Zero.Const

/**
 titleLabel Top Spacing
 */
CGFloat resetPwdTitleLabelTopSpacing                            = 81.5;

/**
 titleLabel Font Size
 */
CGFloat resetPwdTitleLabelFontSize                              = 23.5;

/**
 pwdTextField Top Margin
 */
CGFloat pwdNumberTextFieldTopMargin                             = 70.f;

/**
 pwdTextField Left&Right Spacing
 */
CGFloat pwdTextFieldLeftAndRightSpacing                         = 22.5f;

/**
 pwdTextField Bottom Margin Line Top Margin
 */
CGFloat pwdTextFieldBottomMarginLineTopMargin                   = 17.f;

/**
 tipsLabel Top Margin
 */
CGFloat resetPwdTipsLabelTopMargin                              = 14.f;

/**
 tipsLabel Font Size
 */
CGFloat resetTipsLabelFontSize                                  = 12.f;

/**
 animationPlaceHolder OffSet
 */
CGFloat resetPwdNnimationPlaceHolderOffSet                      = 30.5f;

/**
 activityButton Top Margin
 */
CGFloat resetPwdActivityButtonTopMargin                         = 37.5f;

/**
 activityButton Height
 */
CGFloat resetPwdActivityButtonHeight                            = 47.f;

#pragma mark - First.通知

/**
 接收到输入框内容改变通知
 
 @param no              通知内容
 */
- (void)textFieldDidChange:(NSNotification *)no
{
    if (self.inputPwdTextField.text.length >= 20) {
        @try {
            self.inputPwdTextField.text                             = [self.inputPwdTextField.text substringWithRange:NSMakeRange(0, self.inputPwdTextField.text.length >= 20 ? 20 :self.inputPwdTextField.text.length)];
        } @catch (NSException *exception) {
        } @finally {
        }
        [self.inputPwdTextField resignFirstResponder];
        return;
    }
    
    if ([self.inputPwdTextField.text isEqualToString:@""]
        || self.inputPwdTextField.text.length == 0) {
        self.activityButton.enabled                                 = NO;
    }else{
        self.activityButton.enabled                                 = YES;
    }
    
    if (!self.pwdStatusButton.hidden) {
        
        [self.tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.pwdTextFieldBottomMarginLineView);
            make.top.mas_equalTo(self.pwdTextFieldBottomMarginLineView.mas_bottom).mas_offset(resetPwdTipsLabelTopMargin);
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.tipsLabel.superview layoutIfNeeded];
            self.pwdStatusButton.alpha                              = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.pwdStatusButton.hidden                         = YES;
            }
        }];
    }
}

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 返回按钮点击事件

 @param sender          sender
 */
- (void)leftButtonClick:(UIButton *)sender
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

/**
 点击事件
 
 @param touches         点击的点
 @param event           事件
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputPwdTextField resignFirstResponder];
}

/**
 明文暗文切换按钮

 @param sender 按钮
 */
- (void)secureSwitchButtonClick:(UIButton *)sender
{
    sender.selected                                 = !sender.selected;
    self.inputPwdTextField.secureTextEntry          = !sender.selected;
    NSString *text                                  = self.inputPwdTextField.text;
    self.inputPwdTextField.text                     = @" ";
    self.inputPwdTextField.text                     = text;
    if (self.inputPwdTextField.secureTextEntry) {
        [self.inputPwdTextField insertText:self.inputPwdTextField.text];
    }
}

/**
 重置登录密码按钮点击事件

 @param sender sender
 */
- (void)activityButtonClick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"设置密码"]) {
        
        /**
         *  验证密码
         */
        if ([YXStringFilterTool checkResetPwd:self.inputPwdTextField.text]) {
            [self setNewPwd];
        }else{
            [self showPwdStatusLabelWithStatusText:@"密码格式不正确，请重新输入"];
        }
    }else if ([sender.titleLabel.text isEqualToString:@"返回登录"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

/**
 设置新密码
 */
- (void)setNewPwd
{
    [self.activityButton show];
    [[YXMyAccountNetRequestTool sharedTool] setNewPwdWithPhoneNumber:self.userPhoneNumber
                                                              newPwd:self.inputPwdTextField.text
                                                          verifyCode:self.verificationCode
                                                             success:^(id objc, id respodHeader) {
                                                                 [self.activityButton dismiss];
                                                                 if([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                     [self.navigationController pushViewController:self.resetPwdResultViewController animated:YES];
                                                                 }else{
                                                                     [self showPwdStatusLabelWithStatusText:(NSString *)objc];
                                                                 }
                                                                 
                                                             }
                                                             failure:^(NSError *error) {
                                                                 [self.activityButton dismiss];
                                                             }];
}

/**
 展示密码输入状态提示框

 @param statusText 提示文字
 */
- (void)showPwdStatusLabelWithStatusText:(NSString *)statusText
{
    self.pwdStatusButton.alpha                          = 0;
    self.pwdStatusButton.hidden                         = NO;
    [self.pwdStatusButton setTitle:statusText forState:UIControlStateNormal];
    
    [self.tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.pwdTextFieldBottomMarginLineView);
        make.top.mas_equalTo(self.pwdTextFieldBottomMarginLineView.mas_bottom).mas_offset(41);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.tipsLabel.superview layoutIfNeeded];
        self.pwdStatusButton.alpha                      = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Fourth.代理方法

#pragma mark <UITextFieldDelegate>

/**
 结束第一响应代理监听事件
 
 @param textField textField
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]
        || textField.text.length == 0) {
        [self animationPlaceholderWithOffset:0 fontSize:16.f];
    }
}

/**
 开始点击选中代理监听事件
 
 @param textField           textField
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animationPlaceholderWithOffset:resetPwdNnimationPlaceHolderOffSet fontSize:13.f];
}

/**
 输入框输入内容代理监听事件
 
 @param textField           textField
 @param range               range
 @param string              string
 @return                    是否可以编辑
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

/**
 占位标志动画
 
 @param offset              向上偏移量
 @param fontSize            字体大小
 */
- (void)animationPlaceholderWithOffset:(CGFloat)offset
                              fontSize:(CGFloat)fontSize
{
    [self.animationPlaceHolderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputPwdTextField).mas_offset(-offset);
        make.left.mas_equalTo(self.inputPwdTextField);
        make.width.mas_equalTo(150);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.animationPlaceHolderLabel.font             = [UIFont systemFontOfSize:fontSize];
        [self.animationPlaceHolderLabel.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Fifth.控制器生命周期

/**
 重置密码控制器

 @param type 类型
 @param extend 扩展参数（可为nil）
 @return 重置密码控制器实例对象
 */
+ (instancetype)resetPwdViewControllerType:(YXResetPwdViewControllerType)type
                               phoneNumber:(NSString *)phoneNumber
                                 andExtend:(id)extend
{
    YXResetPwdViewController *controller                                = [YXResetPwdViewController new];
    controller.type                                                     = type;
    if (type == YXResetPwdViewControllerTypeResetPwd) {
        controller.userPhoneNumber                                      = phoneNumber;
        controller.verificationCode                                     = (NSString *)extend;
    }
    return controller;
}

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomUI];
    [self registerNotification];
}

/**
 视图即将出现
 
 @param animated                                animated
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/**
 视图出现完毕
 
 @param animated                                animated
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.inputPwdTextField becomeFirstResponder];
}

/**
 视图即将离开界面
 
 @param animated                                animated
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
}

/**
 释放内存
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
}

#pragma mark - Sixth.界面配置

/**
 注册通知
 */
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}


/**
 配置自定义UI界面
 */
- (void)setupCustomUI
{
    //** =========================================================================================== */
    //** ============================================公用=========================================== */
    //** =========================================================================================== */
    [self setupNaviBar];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.activityButton];
    
    self.view.backgroundColor                           = [UIColor whiteColor];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(resetPwdTitleLabelTopSpacing);
        make.centerX.mas_equalTo(self.view);
    }];
    
    //** =========================================================================================== */
    //** ===========================================重置密码========================================= */
    //** =========================================================================================== */
    if (self.type == YXResetPwdViewControllerTypeResetPwd) {
        
        self.titleLabel.text                            = @"重置您的密码";
        
        [self.view addSubview:self.inputPwdTextField];
        [self.view addSubview:self.pwdStatusButton];
        [self.view addSubview:self.tipsLabel];
        [self.view addSubview:self.pwdTextFieldBottomMarginLineView];
        [self.view addSubview:self.animationPlaceHolderLabel];
        [self.view addSubview:self.secureSwitchButton];
        
        [self.inputPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(pwdTextFieldLeftAndRightSpacing);
            make.right.mas_equalTo(self.view).mas_offset(-pwdTextFieldLeftAndRightSpacing);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(pwdNumberTextFieldTopMargin);
        }];
        
        [self.pwdTextFieldBottomMarginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.inputPwdTextField);
            make.top.mas_equalTo(self.inputPwdTextField.mas_bottom).mas_offset(pwdTextFieldBottomMarginLineTopMargin);
            make.height.mas_equalTo(1);
           
        }];
        
        [self.pwdStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.pwdTextFieldBottomMarginLineView);
            make.top.mas_equalTo(self.pwdTextFieldBottomMarginLineView.mas_bottom).mas_offset(resetPwdTipsLabelTopMargin);
            make.height.mas_equalTo(14.f);
        }];
        
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.pwdTextFieldBottomMarginLineView);
            make.top.mas_equalTo(self.pwdTextFieldBottomMarginLineView.mas_bottom).mas_offset(resetPwdTipsLabelTopMargin);
        }];
        
        [self.activityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.pwdTextFieldBottomMarginLineView);
            make.top.mas_equalTo(self.tipsLabel.mas_bottom).mas_offset(resetPwdActivityButtonTopMargin);
            make.height.mas_equalTo(resetPwdActivityButtonHeight);
        }];
        
        [self.animationPlaceHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.inputPwdTextField);
            make.width.mas_equalTo(150);
        }];
        
        [self.secureSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.mas_equalTo(self.inputPwdTextField);
            make.height.width.mas_equalTo(44.f);
        }];
        
        return;
    }
    
    //** =========================================================================================== */
    //** ===========================================重置结果========================================= */
    //** =========================================================================================== */
    if (self.type == YXResetPwdViewControllerTypeResetResult) {
        
        self.titleLabel.text                        = @"密码已重置\n可通过新密码登录";
        self.activityButton.enabled                 = YES;
        [self.activityButton setTitle:@"返回登录" forState:UIControlStateNormal];
        
        [self.activityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(141.5);
            make.left.mas_equalTo(self.view).mas_offset(pwdTextFieldLeftAndRightSpacing);
            make.right.mas_equalTo(self.view).mas_offset(-pwdTextFieldLeftAndRightSpacing);
            make.height.mas_equalTo(resetPwdActivityButtonHeight);
        }];
        
        return;
    }
}

/**
 设置NaviBar
 */
- (void)setupNaviBar
{
    UIButton *leftButton                                                = [UIButton new];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem          = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

#pragma mark - Seventh.懒加载

- (YXResetPwdViewController *)resetPwdResultViewController
{
    if (!_resetPwdResultViewController) {
        
        _resetPwdResultViewController               = [YXResetPwdViewController resetPwdViewControllerType:YXResetPwdViewControllerTypeResetResult
                                                                                               phoneNumber:nil
                                                                                                 andExtend:nil];
    }
    return _resetPwdResultViewController;
}

- (UILabel *)animationPlaceHolderLabel
{
    if (!_animationPlaceHolderLabel) {
        _animationPlaceHolderLabel                  = [UILabel new];
        _animationPlaceHolderLabel.font             = [UIFont systemFontOfSize:16.f];
        _animationPlaceHolderLabel.textColor        = [UIColor lightGrayColor];
        _animationPlaceHolderLabel.text             = @"请输入新密码";
    }
    return _animationPlaceHolderLabel;
}

- (UIButton *)secureSwitchButton
{
    if (!_secureSwitchButton) {
        _secureSwitchButton                         = [UIButton new];
        [_secureSwitchButton setBackgroundImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        [_secureSwitchButton setBackgroundImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateSelected];
        [_secureSwitchButton addTarget:self action:@selector(secureSwitchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secureSwitchButton;
}

- (YXActivityButton *)activityButton
{
    if (!_activityButton) {
        _activityButton                                                 = [[YXActivityButton alloc] init];
        _activityButton.enabled                                         = NO;
        [_activityButton setTitle:@"设置密码" forState:UIControlStateNormal];
        [_activityButton addTarget:self action:@selector(activityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activityButton;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel                                                      = [UILabel new];
        _tipsLabel.font                                                 = YXRegularfont(resetTipsLabelFontSize);
        _tipsLabel.textColor                                            = [UIColor orderUnitPriceTextColor];
        _tipsLabel.text                                                 = @"密码支持8-20个字符，至少包含字母、数字和符号(!#$%^&*)中的两种及以上组合，要牢记密码哦。";
        _tipsLabel.numberOfLines                                        = 0;
        _tipsLabel.backgroundColor                                      = [UIColor whiteColor];
    }
    return _tipsLabel;
}

- (UIButton *)pwdStatusButton
{
    if (!_pwdStatusButton) {
        _pwdStatusButton                                                 = [UIButton new];
        _pwdStatusButton.titleLabel.font                                 = [UIFont systemFontOfSize:14];
        _pwdStatusButton.hidden                                          = YES;
        _pwdStatusButton.userInteractionEnabled                          = NO;
        _pwdStatusButton.titleLabel.font                                 = YXRegularfont(13.f);
        _pwdStatusButton.contentHorizontalAlignment                      = UIControlContentHorizontalAlignmentLeft;
        _pwdStatusButton.titleEdgeInsets                                 = UIEdgeInsetsMake(0, 5, 0, 0);
        [_pwdStatusButton setTitleColor:[UIColor themGoldColor] forState:UIControlStateNormal];
        [_pwdStatusButton setImage:[UIImage imageNamed:@"ic_register_redError"] forState:UIControlStateNormal];
    }
    return _pwdStatusButton;
}

- (UITextField *)inputPwdTextField
{
    if (!_inputPwdTextField) {
        _inputPwdTextField                                              = [UITextField new];
        _inputPwdTextField.delegate                                     = self;
        _inputPwdTextField.secureTextEntry                              = YES;
        _inputPwdTextField.keyboardType                                 = UIKeyboardTypeASCIICapable;
        _inputPwdTextField.clearsOnBeginEditing                         = NO;
    }
    return _inputPwdTextField;
}

- (UIView *)pwdTextFieldBottomMarginLineView
{
    if (!_pwdTextFieldBottomMarginLineView) {
        _pwdTextFieldBottomMarginLineView                               = [UIView new];
        _pwdTextFieldBottomMarginLineView.backgroundColor               = [UIColor themGrayColor];
        
    }
    return _pwdTextFieldBottomMarginLineView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                                                     = [UILabel new];
        _titleLabel.font                                                = [UIFont systemFontOfSize:resetPwdTitleLabelFontSize];
        _titleLabel.textColor                                           = [UIColor blackColor];
        _titleLabel.textAlignment                                       = NSTextAlignmentCenter;
        _titleLabel.numberOfLines                                       = 0;
        _titleLabel.backgroundColor                                     = [UIColor whiteColor];
    }
    return _titleLabel;
}

#pragma mark - Eighth.Other

/**
 提示框
 */
- (void)showAlertWithtitle:(NSString*)title
                   message:(NSString *)message
              confrimBlock:(void(^)())comfirm;
{
    if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        
        UIAlertView *TitleAlert                                 = [[UIAlertView alloc] initWithTitle:title
                                                                                             message:message
                                                                                            delegate:self
                                                                                   cancelButtonTitle:@""
                                                                                   otherButtonTitles:@"确定",nil];
        
        [TitleAlert show];
        
    }else{
        
        UIAlertController *alertController                      = [UIAlertController alertControllerWithTitle:title
                                                                                                      message:message
                                                                                               preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.tintColor                          = [UIColor mainThemColor];
        UIAlertAction *otherAction                              = [UIAlertAction actionWithTitle:@"确定"
                                                                                           style:UIAlertActionStyleDefault
                                                                                         handler:^(UIAlertAction *action) {
                                                                                             
                                                                                             comfirm();
                                                                                         }];
        
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    
}

@end
