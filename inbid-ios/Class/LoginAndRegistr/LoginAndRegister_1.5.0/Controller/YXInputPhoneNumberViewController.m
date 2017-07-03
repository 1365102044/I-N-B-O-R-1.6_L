//
//  YXInputPhoneNumberViewController.m
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXInputPhoneNumberViewController.h"
#import "YXActivityButton.h"
#import "YXInputVerificationCodeViewController.h"
#import "YXResginsterAgreenmentViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMessageCountDownManager.h"
#import "YXLoginRequestTool.h"
#import "YXReLoginViewController.h"
#import "YXStringFilterTool.h"
@interface YXInputPhoneNumberViewController () <UITextFieldDelegate>

/**
 控制器类型
 */
@property (nonatomic, assign) YXLoginViewControllerType type;

/**
 TitleLabel
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 InputTextField
 */
@property (nonatomic, strong) UITextField *phoneNumberTextField;

/**
 loginButton
 */
@property (nonatomic, strong) YXActivityButton *activityButton;

/**
 loginRightNowTipsLabel
 */
@property (nonatomic, strong) UILabel *loginRightNowTipsLabel;

/**
 loginRightNowButton
 */
@property (nonatomic, strong) UIButton *loginRightNowButton;

/**
 registerAgreementTipsLabel
 */
@property (nonatomic, strong) UILabel *registerAgreementTipsLabel;

/**
 registerAgreementButton
 */
@property (nonatomic, strong) UIButton *registerAgreementButton;

/**
 textField Bottom Margin Line
 */
@property (nonatomic, strong) UIView *textFieldBottomMarginLine;

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

@property(nonatomic,strong) YXThirdPartyBindingModle * bindingModel;

@end

@implementation YXInputPhoneNumberViewController

#pragma mark - Zero.Const

/**
 titlelabel距顶部距离
 */
CGFloat titleLabelTopSpacing                                    = 81.5f;

/**
 phoneNumberTextField Top Margin
 */
CGFloat phoneNumberTextFieldTopMargin                           = 70.f;

/**
 phoneNumberTextField Left&Right Spacing
 */
CGFloat phoneNumberTextFieldLeftAndRightSpacing                 = 22.5f;

/**
 phoneNumberTextField Bottom Margin Line Top Margin
 */
CGFloat phoneNumberTextFieldBottomMarginLineTopMargin           = 17.f;

/**
 activityButton Top Margin
 */
CGFloat activityButtonTopMargin                                 = 40.5f;

/**
 activityButton Left&Right Spacing
 */
CGFloat activityButtonLeftAndRightSpacing                       = 15.f;

/**
 activityButton Height
 */
CGFloat activityButtonHeight                                    = 47.f;

/**
 loginRightNowTipsLabel Top Margin
 */
CGFloat loginRightNowTipsLabelTopMargin                         = 20.f;

/**
 loginRightNowTipsLabel Left Spacing
 */
CGFloat loginRightNowTipsLabelLeftSpacing                       = 15.f;

/**
 registerAgreementTipsLabel Bottom Margin
 */
CGFloat registerAgreementTipsLabelBottomMargin                  = 7.f;

/**
 registerAgreementButton Bottom Spacing
 */
CGFloat registerAgreementButtonBottomSpacing                    = 20.5f;

/**
 animationPlaceHolder OffSet
 */
CGFloat animationPlaceHolderOffSet                              = 30.5f;


#pragma mark - First.通知

/**
 接收到输入框内容改变通知

 @param no              通知内容
 */
- (void)textFieldDidChange:(NSNotification *)no
{
    if (self.phoneNumberTextField.text.length >= 11) {
        @try {
            self.phoneNumberTextField.text                          = [self.phoneNumberTextField.text substringWithRange:NSMakeRange(0, self.phoneNumberTextField.text.length >= 11 ? 11 :self.phoneNumberTextField.text.length)];
        } @catch (NSException *exception) {
        } @finally {
        }
        [self.phoneNumberTextField resignFirstResponder];
        return;
    }
    
    if ([self.phoneNumberTextField.text isEqualToString:@""]
        || self.phoneNumberTextField.text.length == 0) {
        self.activityButton.enabled                                 = NO;
    }else{
        self.activityButton.enabled                                 = YES;
    }
}

#pragma mark - Second.赋值
-(void)formeThirdAccountWith:(YXThirdPartyBindingModle *)bindingmodle {
    self.bindingModel = bindingmodle;
    
}
#pragma mark - Third.点击事件

/**
 点击事件

 @param touches         点击的点
 @param event           事件
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumberTextField resignFirstResponder];
}

/**
 register / nextStep ButtonClick

 @param sender button
 */
- (void)activityButtonClick:(UIButton *)sender
{

    /** 校验用户输入手机号是否正确 */
    if (![YXStringFilterTool filterByPhoneNumber:self.phoneNumberTextField.text]) {
        [self showAlertWithtitle:nil message:@"您输入的手机号码不正确，请重新输入" confrimBlock:^{
            
        }];
        return;
    }
    
    //**绑定进来的，需要先对手机号判断后，在确定是否发送短信验证吗**/
    if (self.type == YXLoginViewControllerTypeBinding) {
        
        [self bindingAccountRequestwtih:YXInputVerificationCodeViewControllerTypeBinding];
        return;
    }
    
    /** 重置密码进入当前界面，获取重置密码手机验证码 */
    if (self.type == YXLoginViewControllerTypeResetPwd) {
        [self loadResetPwdVerificationCode];
        return;
    }
    
    [self RequestSMSCode];
    
}

/**
 获取重置密码的验证码
 */
- (void)loadResetPwdVerificationCode
{
    [self.activityButton show];
    [[YXMyAccountNetRequestTool sharedTool] loadResetPwdVerificationCodeWithPhoneNumber:self.phoneNumberTextField.text success:^(id objc, id respodHeader) {
        if([respodHeader[@"Status"] isEqualToString:@"1"]) {
            [self pushVerificationCodeViewController];
        }else{
            //** 展示其他状态下的服务器返回状态 */
            [self showAlertWithtitle:nil message:objc confrimBlock:^{
                
            }];
        }
        [self.activityButton dismiss];
    } failure:^(NSError *error) {
        [self.activityButton dismiss];
    }];
}

/**
 发送验证码的请求 提出来
 */
-(void)RequestSMSCode
{
    [self.activityButton show];
    /** TODO:网络请求，请求验证码，并判断是否正在倒计时开始倒计时 */
    [[YXMyAccountNetRequestTool sharedTool] loginAndRegisterSMSWithPhoneNumber:self.phoneNumberTextField.text formeVCtype:_type longintype:self.bindingModel.loginType
                                                                       success:^(id objc, id respodHeader) {
                                                                           if([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                               [self pushVerificationCodeViewController];
                                                                           }else{
                                                                               //** 展示其他状态下的服务器返回状态 */
                                                                               [self showAlertWithtitle:nil message:objc confrimBlock:^{
                                                                                   
                                                                               }];
                                                                           }
                                                                           
                                                                           [self.activityButton dismiss];
                                                                       }
                                                                       failure:^(NSError *error) {
                                                                           [self.activityButton dismiss];
                                                                           
                                                                       }];
}

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

/**
 成功获取短信验证码后，跳转短信验证码控制器
 */
- (void)pushVerificationCodeViewController
{
    [YXMessageCountDownManager shareManager].SMSDate                                 = [NSDate date];
    
    YXInputVerificationCodeViewControllerType verCodeControllerType                  = YXInputVerificationCodeViewControllerTypeNone;
    if (self.type == YXLoginViewControllerTypeRegister) {
        verCodeControllerType = YXInputVerificationCodeViewControllerTypeReigster;
    }
    
    if (self.type == YXLoginViewControllerTypeResetPwd) {
        verCodeControllerType = YXInputVerificationCodeViewControllerTypeResetPwd;
    }
    if (self.type == YXLoginViewControllerTypeBinding) {
        
        verCodeControllerType = YXInputVerificationCodeViewControllerTypeBinding;
        YXInputVerificationCodeViewController *inputVerificationCodeViewController       = [YXInputVerificationCodeViewController inputVerificationCodeViewControllerWithType:verCodeControllerType
                                                                                                                                                                  phoneNumber:self.phoneNumberTextField.text
                                                                                                                                                                    andExtend:nil];
        self.bindingModel.phone = self.phoneNumberTextField.text;
        [inputVerificationCodeViewController formeThirdbindingAccountWith:self.bindingModel];
        [self.navigationController pushViewController:inputVerificationCodeViewController animated:YES];

        return;
    }

    
    YXInputVerificationCodeViewController *inputVerificationCodeViewController       = [YXInputVerificationCodeViewController inputVerificationCodeViewControllerWithType:verCodeControllerType
                                                                                                                                                              phoneNumber:self.phoneNumberTextField.text
                                                                                                                                                                andExtend:nil];
    [self.navigationController pushViewController:inputVerificationCodeViewController animated:YES];

}
/**
 对绑定的手机号的判断。是否能绑定，
 */
-(void)bindingAccountRequestwtih:(YXInputVerificationCodeViewControllerType)verCodeControllerType{
    
        [[YXLoginRequestTool sharedTool] RequestBindingPhone:self.phoneNumberTextField.text type:self.bindingModel.loginType Success:^(id objc, id respodHeader) {
            
            YXLog(@"+++++++++++%@++++++++",objc);
            if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                
                self.bindingModel.TheAccountStatus = [objc[@"flag"] integerValue];
                
                if (self.bindingModel.TheAccountStatus == YXAlearlyBindingOtherAccount) {
                    
                    YXReLoginViewController *reloginVC =[[YXReLoginViewController alloc]init];
                    reloginVC.thirdModle = self.bindingModel;
                    [self.navigationController pushViewController:reloginVC animated:YES];
                    return ;
                }else if (self.bindingModel.TheAccountStatus == YXAccountDisble ){
                    [YXAlearMnager ShowAlearViewWith:@"该账号已禁用，请联系客服" Type:2];
                    return;
                }else{
                    //**需要调到验证码的页面，再进行发送验证码的短信**/
                    [self RequestSMSCode];
                }
            }else{
                
                [YXAlearMnager ShowAlearTopBarViewWith:objc];
            }
            
        } failure:^(NSError *error) {
        }];
}

/**
 check RegisterAgreement ButtonClick

 @param sender button
 */
- (void)registerAgreementButtonClick:(UIButton *)sender
{
    YXResginsterAgreenmentViewController *agreenmentViewController                  = [YXResginsterAgreenmentViewController new];
    [self.navigationController pushViewController:agreenmentViewController animated:YES];
}

/**
 loginRightNow ButtonClick

 @param sender button
 */
- (void)loginRightNowButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self animationPlaceholderWithOffset:animationPlaceHolderOffSet fontSize:13.f];
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
        make.top.mas_equalTo(self.phoneNumberTextField).mas_offset(-offset);
        make.left.mas_equalTo(self.phoneNumberTextField);
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
 初始化
 
 @param type                                    控制器类型
 @param extend                                  后期扩展参数（没有暂时客传nil）
 @return                                        返回对应控制器对象
 */
+ (instancetype)inputPhoneNumberViewControllerWithType:(YXLoginViewControllerType)type
                                             andExtend:(id)extend
{
    YXInputPhoneNumberViewController *controller        = [YXInputPhoneNumberViewController new];
    controller.type                                     = type;
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
    
    [self.phoneNumberTextField becomeFirstResponder];
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
    self.view.backgroundColor                           = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.phoneNumberTextField];
    [self.view addSubview:self.animationPlaceHolderLabel];
    [self.view addSubview:self.activityButton];
    [self.view addSubview:self.textFieldBottomMarginLine];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(titleLabelTopSpacing);
    }];
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(phoneNumberTextFieldLeftAndRightSpacing);
        make.right.mas_equalTo(self.view).mas_offset(-phoneNumberTextFieldLeftAndRightSpacing);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(phoneNumberTextFieldTopMargin);
    }];
    
    [self.animationPlaceHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.phoneNumberTextField);
        make.width.mas_equalTo(150);
    }];
    
    [self.activityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(activityButtonLeftAndRightSpacing);
        make.right.mas_equalTo(self.view).mas_offset(-activityButtonLeftAndRightSpacing);
        make.top.mas_equalTo(self.phoneNumberTextField.mas_bottom).mas_offset(activityButtonTopMargin);
        make.height.mas_equalTo(activityButtonHeight);
    }];
    
    [self.textFieldBottomMarginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.activityButton);
        make.top.mas_equalTo(self.phoneNumberTextField.mas_bottom).mas_offset(phoneNumberTextFieldBottomMarginLineTopMargin);
        make.height.mas_equalTo(1);
    }];
    
    //** =========================================================================================== */
    //** ============================================注册=========================================== */
    //** =========================================================================================== */
    if (self.type == YXLoginViewControllerTypeRegister) {
        
        self.titleLabel.text                                = @"手机号注册";
        [self.activityButton setTitle:@"注册" forState:UIControlStateNormal];
        
        [self.view addSubview:self.loginRightNowTipsLabel];
        [self.view addSubview:self.loginRightNowButton];
        [self.view addSubview:self.registerAgreementTipsLabel];
        [self.view addSubview:self.registerAgreementButton];
        
        [self.loginRightNowTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.activityButton.mas_bottom).mas_offset(loginRightNowTipsLabelTopMargin);
            make.left.mas_equalTo(self.view).mas_offset(loginRightNowTipsLabelLeftSpacing);
        }];
        
        [self.loginRightNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.loginRightNowTipsLabel);
            make.left.mas_equalTo(self.loginRightNowTipsLabel.mas_right);
        }];

        [self.registerAgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).mas_offset(-registerAgreementButtonBottomSpacing);
        }];
        
        [self.registerAgreementTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.registerAgreementButton.mas_top).mas_offset(-registerAgreementTipsLabelBottomMargin);
        }];
        return;
    }

    //** =========================================================================================== */
    //** ===========================================重置密码========================================== */
    //** =========================================================================================== */
    if (self.type == YXLoginViewControllerTypeResetPwd) {
        self.titleLabel.text                                = @"忘记密码了？\n通过手机可以重置密码";
        return;
    }
    
    //** =========================================================================================== */
    //** ============================================绑定=========================================== */
    //** =========================================================================================== */
    if (self.type == YXLoginViewControllerTypeBinding) {
        self.titleLabel.text                                = @"为了您的账号安全\n请绑定手机号";
        return;
    }
}

#pragma mark - Seventh.懒加载

- (UILabel *)animationPlaceHolderLabel
{
    if (!_animationPlaceHolderLabel) {
        _animationPlaceHolderLabel                  = [UILabel new];
        _animationPlaceHolderLabel.font             = [UIFont systemFontOfSize:16.f];
        _animationPlaceHolderLabel.textColor        = [UIColor lightGrayColor];
        _animationPlaceHolderLabel.text             = @"请输入手机号码";
    }
    return _animationPlaceHolderLabel;
}

- (UIView *)textFieldBottomMarginLine
{
    if (!_textFieldBottomMarginLine) {
        _textFieldBottomMarginLine                  = [UIView new];
        _textFieldBottomMarginLine.backgroundColor  = [UIColor themGrayColor];
    }
    return _textFieldBottomMarginLine;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                                 = [UILabel new];
        _titleLabel.font                            = [UIFont systemFontOfSize:23.5f];
        _titleLabel.textColor                       = [UIColor blackColor];
        _titleLabel.textAlignment                   = NSTextAlignmentCenter;
        _titleLabel.numberOfLines                   = 0;
    }
    return _titleLabel;
}

- (UITextField *)phoneNumberTextField
{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField                       = [[UITextField alloc] init];
        _phoneNumberTextField.keyboardType          = UIKeyboardTypeNumberPad;
        _phoneNumberTextField.font                  = [UIFont systemFontOfSize:16.f];
        _phoneNumberTextField.delegate              = self;
    }
    return _phoneNumberTextField;
}

- (YXActivityButton *)activityButton
{
    if (!_activityButton) {
        _activityButton                             = [[YXActivityButton alloc] init];
        _activityButton.enabled                     = NO;
        [_activityButton addTarget:self action:@selector(activityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activityButton;
}

- (UILabel *)loginRightNowTipsLabel
{
    if (!_loginRightNowTipsLabel) {
        _loginRightNowTipsLabel                     = [UILabel new];
        _loginRightNowTipsLabel.font                = [UIFont systemFontOfSize:14];
        _loginRightNowTipsLabel.text                = @"已经有胤宝账号？";
    }
    return _loginRightNowTipsLabel;
}

- (UIButton *)loginRightNowButton
{
    if (!_loginRightNowButton) {
        _loginRightNowButton                        = [UIButton new];
        _loginRightNowButton.titleLabel.font        = [UIFont systemFontOfSize:14.f];
        [_loginRightNowButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginRightNowButton setTitleColor:[UIColor themBlueColor] forState:UIControlStateNormal];
        [_loginRightNowButton addTarget:self action:@selector(loginRightNowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loginRightNowButton sizeToFit];
    }
    return _loginRightNowButton;
}

- (UILabel *)registerAgreementTipsLabel
{
    if (!_registerAgreementTipsLabel) {
        _registerAgreementTipsLabel                 = [UILabel new];
        _registerAgreementTipsLabel.font            = YXRegularfont(13.f);
        _registerAgreementTipsLabel.textColor       = [UIColor orderUnitPriceTextColor];
        _registerAgreementTipsLabel.text            = @"注册即表示您同意";
    }
    return _registerAgreementTipsLabel;
}

- (UIButton *)registerAgreementButton
{
    if (!_registerAgreementButton) {
        _registerAgreementButton                    = [UIButton new];
        _registerAgreementButton.titleLabel.font    = YXRegularfont(14.f);
        [_registerAgreementButton setTitle:@"《胤宝用户服务协议》" forState:UIControlStateNormal];
        [_registerAgreementButton addTarget:self action:@selector(registerAgreementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_registerAgreementButton setTitleColor:[UIColor themBlueColor] forState:UIControlStateNormal];
        [_registerAgreementButton sizeToFit];
    }
    return _registerAgreementButton;
}

@end
