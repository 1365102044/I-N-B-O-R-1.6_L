//
//  YXInputVerificationCodeViewController.m
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXInputVerificationCodeViewController.h"
#import "YXVerificationCodeInputView.h"
#import "YXMessageCountDownManager.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXLoginRequestTool.h"
#import "YXMyAccountThridPartyViewController.h"
#import "YXSaveLoginDataTool.h"
#import "YXAlearViewTool.h"
#import "YXResetPwdViewController.h"

/**
 验证码状态

 - YXInputVerificationCodeStatusNone:                   无状态
 - YXInputVerificationCodeStatusFaild:                  服务器验证失败
 - YXInputVerificationCodeStatusOvertime:               超时
 - YXInputVerificationCodeStatusReStart:                重新获取
 */
typedef NS_ENUM(NSUInteger, YXInputVerificationCodeStatus) {
    YXInputVerificationCodeStatusNone,
    YXInputVerificationCodeStatusFaild,
    YXInputVerificationCodeStatusOvertime,
    YXInputVerificationCodeStatusReStart,
};

@interface YXInputVerificationCodeViewController () <YXVerificationCodeInputViewDelegate>

/**
 titleLabel
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 cheackInputVerificationCodeResultTips
 */
@property (nonatomic, strong) UILabel *cheackInputVerificationCodeResultTipsLabel;

/**
 VerificationCodeStatusTips
 */
@property (nonatomic, strong) UILabel *verificationCodeStatusTipsLabel;

/**
 reLoadVerificationCode
 */
@property (nonatomic, strong) UIButton *reLoadVerificationCodeButton;

/**
 验证码输入框
 */
@property (nonatomic, strong) YXVerificationCodeInputView *verificationCodeInputView;

/**
 倒计时定时器
 */
@property (nonatomic, strong) NSTimer *countDownTimer;

/**
 控制器类型
 */
@property (nonatomic, assign) YXInputVerificationCodeViewControllerType type;

/**
 用户输入手机号码
 */
@property (nonatomic, copy) NSString *userPhoneNumber;

/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;

/**
 传入的扩展识别参数
 */
@property (nonatomic, copy) NSString *extenString;

/**
 验证码状态
 */
@property (nonatomic, assign) YXInputVerificationCodeStatus codeStatus;

@property(nonatomic,strong) YXThirdPartyBindingModle * bindingPartyModle;

//@property(nonatomic,strong) UIViewController * sourViewController;
@end

@implementation YXInputVerificationCodeViewController

#pragma mark - Zero.Const

/**
 titleLabel Top Spacing
 */
CGFloat verificationTitleLabelTopSpacing                                        = 82.f;

/**
 inputView Top Margin
 */
CGFloat inputViewTopMargin                                                      = 69.5f;

/**
 inputView Left&Right Spacing
 */
CGFloat inputViewLeftAndRightSpacing                                            = 30.f;

/**
 cheackInputVerificationCodeResultTipsLabel Top Margin
 */
CGFloat cheackInputVerificationCodeResultTipsLabelTopMargin                     = 21.f;

/**
 verificationCodeStatusTipsLabel Top Margin
 */
CGFloat verificationCodeStatusTipsLabelTopMargin                                = 24.5f;

/**
 reLoadVerificationCodeButton Top Margin
 */
CGFloat reLoadVerificationCodeButtonTopMargin                                   = 0.f;

/**
 reLoadVerificationCodeButton Height
 */
CGFloat reLoadVerificationCodeButtonHeight                                      = 12.5f;

#pragma mark - First.通知

#pragma mark - Second.赋值
-(void)formeThirdbindingAccountWith:(YXThirdPartyBindingModle *)bindingmodle{
    
    self.bindingPartyModle = bindingmodle;
    
}

#pragma mark - Third.点击事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.verificationCodeInputView.inputVerificationCodeTextField becomeFirstResponder];
}

/**
 重新获取验证码点击事件

 @param sender sender
 */
- (void)reloadVerificationCodeButtonClick:(UIButton *)sender
{
    //** TODO:网络请求，请求验证码，并判断是否正在倒计时开始倒计时 */
    [[YXMyAccountNetRequestTool sharedTool] loginAndRegisterSMSWithPhoneNumber:self.userPhoneNumber formeVCtype:self.type longintype:self.bindingPartyModle.loginType
                                                                       success:^(id objc, id respodHeader) {
                                                                           if([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                               self.codeStatus                                                  = YXInputVerificationCodeStatusReStart;
                                                                               //** 获取验证码成功 */
                                                                               [YXMessageCountDownManager shareManager].SMSDate                 = [NSDate date];
                                                                               self.reLoadVerificationCodeButton.hidden                         = YES;
                                                                               self.cheackInputVerificationCodeResultTipsLabel.hidden           = YES;
                                                                               self.verificationCodeStatusTipsLabel.hidden                      = NO;
                                                                               self.verificationCodeStatusTipsLabel.text                        = @"";
                                                                           }else{
                                                                               //** 展示其他状态下的服务器返回状态 */
                                                                               [self showAlertWithtitle:nil message:objc confrimBlock:^{
                                                                                   
                                                                               }];
                                                                           }
                                                                       }
                                                                       failure:^(NSError *error) {
                                                                           
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
 定时器触发事件， 向cell发送通知, 启动倒计时
 */
- (void)timerEvent
{
    if (self.codeStatus == YXInputVerificationCodeStatusFaild
        || self.codeStatus == YXInputVerificationCodeStatusOvertime) return;
    
    [[YXMessageCountDownManager shareManager] countDown];
    
    if ([[YXMessageCountDownManager shareManager].countDownString isEqualToString:@"验证码超时失效"]) {
        self.cheackInputVerificationCodeResultTipsLabel.hidden                  = NO;
        self.cheackInputVerificationCodeResultTipsLabel.text                    = @"验证码已失效，请重新获取";
        self.verificationCodeStatusTipsLabel.hidden                             = YES;
        self.reLoadVerificationCodeButton.hidden                                = NO;
        self.codeStatus                                                         = YXInputVerificationCodeStatusOvertime;
        return;
    }
    
    if ([[YXMessageCountDownManager shareManager].countDownString isEqualToString:@"可重新获取短信验证码"]) {
        self.verificationCodeStatusTipsLabel.text                               = @"没有收到验证码短信？";
        self.reLoadVerificationCodeButton.hidden                                = NO;
        return;
    }
    
    self.verificationCodeStatusTipsLabel.text                                   = [NSString stringWithFormat:@"%@后，可重新获取验证码",
                                                                                   [YXMessageCountDownManager shareManager].countDownString];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXVerificationCodeInputViewDelegate>

/**
 输入验证码完毕回调

 @param verificationCodeInputView           verificationCodeInputView
 @param verificationCodeText                verificationCodeText 验证码内容
 */
- (void)verificationCodeInputView:(YXVerificationCodeInputView *)verificationCodeInputView
             verificationCodeText:(NSString *)verificationCodeText
{
    //** 判断当前来源控制器种类，根据不同的控制器发送不同的网络请求 */
    self.cheackInputVerificationCodeResultTipsLabel.hidden = YES;
    [YXNetworkHUD show];
    if (self.type == YXInputVerificationCodeViewControllerTypeReigster) {
        [[YXMyAccountNetRequestTool sharedTool] registerCheckUserInformationWithPhoneNumber:self.userPhoneNumber
                                                                                    message:verificationCodeText
                                                                                    success:^(id objc, id respodHeader) {
                                                                                        [YXNetworkHUD dismiss];
                                                                                        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                                            //** 验证码验证成功 */
                                                                                           [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.userPhoneNumber];

                                                                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                                
                                                                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                                [YXNotificationTool postNotificationName:@"zhucesuccess" object:nil];
                                                                                            });
                                                                                        }else{
                                                                                            if (!self.reLoadVerificationCodeButton.hidden) {
                                                                                                self.codeStatus                                             = YXInputVerificationCodeStatusFaild;
                                                                                            }
                                                                                            //** 验证码验证失败 */
                                                                                            self.cheackInputVerificationCodeResultTipsLabel.text            = (NSString *)objc;
                                                                                            self.cheackInputVerificationCodeResultTipsLabel.hidden          = NO;
                                                                                            self.verificationCodeInputView.passWordFailed                   = YES;
                                                                                        }
                                                                                    }
                                                                                    failure:^(NSError *error) {
                                                                                        [YXNetworkHUD dismiss];
                                                                                    }];
        return;
    }
    
    if (self.type == YXInputVerificationCodeViewControllerTypeResetPwd) {
        [self verificationCodeResetPwdWithVerificationCode:verificationCodeText];
        return;
    }
    
    if (self.type == YXInputVerificationCodeViewControllerTypeBinding) {
        
        if (self.bindingPartyModle.TheAccountStatus == YXAlearlyRegisterApp) {
            
            [self AccountRequestWith:1 smscode:verificationCodeText];
            
        }else if (self.bindingPartyModle.TheAccountStatus == YXNotRegister){
            
            [self AccountRequestWith:2 smscode:verificationCodeText];
        }
    }
}

/**
 验证重置密码的验证码

 @param verificationCode 验证码
 */
- (void)verificationCodeResetPwdWithVerificationCode:(NSString *)verificationCode
{
    [[YXMyAccountNetRequestTool sharedTool] checkResetPwdMessageWithPhoneNumber:self.userPhoneNumber
                                                                        message:verificationCode
                                                                        success:^(id objc, id respodHeader) {
                                                                            [YXNetworkHUD dismiss];
                                                                            if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                                //** 验证码验证成功 */
                                                                                
                                                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                    YXResetPwdViewController *resetPwdController            = [YXResetPwdViewController resetPwdViewControllerType:YXResetPwdViewControllerTypeResetPwd
                                                                                                                                                                                       phoneNumber:self.userPhoneNumber
                                                                                                                                                                                         andExtend:objc];
                                                                                    [self.navigationController pushViewController:resetPwdController animated:YES];
                                                                                });
                                                                            }else{
                                                                                if (!self.reLoadVerificationCodeButton.hidden) {
                                                                                    self.codeStatus                                             = YXInputVerificationCodeStatusFaild;
                                                                                }
                                                                                //** 验证码验证失败 */
                                                                                self.cheackInputVerificationCodeResultTipsLabel.text            = (NSString *)objc;
                                                                                self.cheackInputVerificationCodeResultTipsLabel.hidden          = NO;
                                                                                self.verificationCodeInputView.passWordFailed                   = YES;
                                                                            }
                                                                        }
                                                                        failure:^(NSError *error) {
                                                                            [YXNetworkHUD dismiss];
                                                                            YXLog(@"%@", error);
                                                                        }];
}

-(void)AccountRequestWith:(NSInteger)accountStatus smscode:(NSString *)code{
    
    [[YXLoginRequestTool sharedTool] RequestAearlyReginsterAPPBindingAccountWith:self.bindingPartyModle.openid phone:self.bindingPartyModle.phone verifyCode:code type:self.bindingPartyModle.loginType accountStatus:accountStatus  Success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            //** 绑定过来的 */
            if (self.bindingPartyModle.TheAccountStatus == YXAlearlyRegisterApp && [self.bindingPartyModle.sourViewController isKindOfClass:[YXMyAccountThridPartyViewController class]]) {
                
                [[YXAlearViewTool sharedAlearview] ShowAlearViewWith:objc Type:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popVC];
                    
                });
                
                return ;
            }
            //** 第三方注册 */
            [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.bindingPartyModle.phone];
            [YXAlearMnager ShowAlearViewWith:@"登录成功" Type:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popVC];
                
            });
        }else{
            
            //** 验证码验证失败 */
            self.cheackInputVerificationCodeResultTipsLabel.text            = @"验证码输入错误，请重新输入";
            self.cheackInputVerificationCodeResultTipsLabel.hidden          = NO;
            self.verificationCodeInputView.passWordFailed                   = YES;
            
        }
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        
    }];
    
}
-(void)popVC
{
    /**
     第三方绑定模块
     */
    if ([self.bindingPartyModle.sourViewController isKindOfClass:[YXMyAccountThridPartyViewController class]]) {
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [YXNotificationTool postNotificationName:@"FormeMycountThirdParyViewController" object:nil];
        return;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [YXNotificationTool postNotificationName:@"fromethridloginpoptorootvc" object:nil];
    
    
}
#pragma mark - Fifth.控制器生命周期

/**
 实例化对象

 @param type                控制器类型
 @param extend              后期扩展参数（暂时传nil） 100为第三方绑定验证码直接进入
 @return                    控制器对象
 */
+ (instancetype)inputVerificationCodeViewControllerWithType:(YXInputVerificationCodeViewControllerType)type
                                                phoneNumber:(NSString *)phoneNumber
                                                  andExtend:(id)extend
{
    YXInputVerificationCodeViewController *controller                           = [YXInputVerificationCodeViewController new];
    controller.type                                                             = type;
    controller.userPhoneNumber                                                  = phoneNumber;
    if ([extend isKindOfClass:[NSString class]]) {
        controller.extenString                                                  = (NSString *)extend;
    }
    return controller;
}

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomUI];
    [self creatTimer];
    [self loadData];
}

/**
 视图即将出现

 @param animated 是否展示出现动画
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.verificationCodeInputView.inputVerificationCodeTextField becomeFirstResponder];
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/**
 视图即将离开

 @param animated 是否展示离开动画
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.verificationCodeInputView.inputVerificationCodeTextField resignFirstResponder];
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
    [self cleanTimer];
}

/**
 释放定时器
 */
- (void)cleanTimer
{
    [self.countDownTimer invalidate];
    self.countDownTimer                                                     = nil;
}

#pragma mark - Sixth.界面配置

/**
 创建定时器
 */
- (void)creatTimer
{
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}

/**
 配置自定义UI界面
 */
- (void)setupCustomUI
{
    self.view.backgroundColor                                               = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.cheackInputVerificationCodeResultTipsLabel];
    [self.view addSubview:self.verificationCodeStatusTipsLabel];
    [self.view addSubview:self.reLoadVerificationCodeButton];
    [self.view addSubview:self.verificationCodeInputView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(verificationTitleLabelTopSpacing);
    }];
    
    [self.verificationCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(inputViewLeftAndRightSpacing);
        make.right.mas_equalTo(self.view).mas_offset(-inputViewLeftAndRightSpacing);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(inputViewTopMargin);
        make.height.mas_equalTo(49.5);
    }];
    
    [self.cheackInputVerificationCodeResultTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.verificationCodeInputView.mas_bottom).mas_offset(cheackInputVerificationCodeResultTipsLabelTopMargin);
    }];
    
    [self.verificationCodeStatusTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.cheackInputVerificationCodeResultTipsLabel.mas_bottom).mas_offset(verificationCodeStatusTipsLabelTopMargin);
    }];
    
    [self.reLoadVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.verificationCodeStatusTipsLabel.mas_bottom).mas_offset(reLoadVerificationCodeButtonTopMargin);
        make.height.mas_equalTo(reLoadVerificationCodeButtonHeight);
    }];
}

#pragma mark - Seventh.懒加载

- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        _countDownTimer                                                     = [NSTimer timerWithTimeInterval:1.0
                                                                                                      target:self
                                                                                                    selector:@selector(timerEvent)
                                                                                                    userInfo:nil
                                                                                                     repeats:YES];
    }
    return _countDownTimer;
}

- (YXVerificationCodeInputView *)verificationCodeInputView
{
    if (!_verificationCodeInputView) {
        _verificationCodeInputView                                          = [[YXVerificationCodeInputView alloc] init];
        _verificationCodeInputView.backgroundColor                          = [UIColor whiteColor];
        _verificationCodeInputView.delegate                                 = self;
    }
    return _verificationCodeInputView;
}

- (UIButton *)reLoadVerificationCodeButton
{
    if (!_reLoadVerificationCodeButton) {
        _reLoadVerificationCodeButton                                       = [UIButton new];
        _reLoadVerificationCodeButton.hidden                                = YES;
        _reLoadVerificationCodeButton.titleLabel.font                       = YXRegularfont(13.f);
        [_reLoadVerificationCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_reLoadVerificationCodeButton setTitleColor:[UIColor themBlueColor] forState:UIControlStateNormal];
        [_reLoadVerificationCodeButton addTarget:self
                                          action:@selector(reloadVerificationCodeButtonClick:)
                                forControlEvents:UIControlEventTouchUpInside];
    }
    return _reLoadVerificationCodeButton;
}

- (UILabel *)verificationCodeStatusTipsLabel
{
    if (!_verificationCodeStatusTipsLabel) {
        _verificationCodeStatusTipsLabel                                    = [UILabel new];
        _verificationCodeStatusTipsLabel.font                               = YXRegularfont(13.f);
        _verificationCodeStatusTipsLabel.textColor                          = [UIColor orderUnitPriceTextColor];
    }
    return _verificationCodeStatusTipsLabel;
}

- (UILabel *)cheackInputVerificationCodeResultTipsLabel
{
    if (!_cheackInputVerificationCodeResultTipsLabel) {
        _cheackInputVerificationCodeResultTipsLabel                         = [UILabel new];
        _cheackInputVerificationCodeResultTipsLabel.font                    = [UIFont systemFontOfSize:14];
        _cheackInputVerificationCodeResultTipsLabel.textColor               = [UIColor themGoldColor];
        _cheackInputVerificationCodeResultTipsLabel.hidden                  = YES;
    }
    return _cheackInputVerificationCodeResultTipsLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                                                         = [UILabel new];
        _titleLabel.font                                                    = [UIFont systemFontOfSize:23.5f];
        _titleLabel.textColor                                               = [UIColor blackColor];
        _titleLabel.textAlignment                                           = NSTextAlignmentCenter;
        _titleLabel.text                                                    = @"短信验证码已发送\n请填写验证码";
        _titleLabel.numberOfLines                                           = 0;
    }
    return _titleLabel;
}

#pragma mark - Eighth.LoadData

/**
 加载网络数据(第三方登录，直接在本界面获取网络数据)
 */
- (void)loadData
{
    if ([self.extenString isEqualToString:@"100"]) {
        [YXNetworkHUD show];
        [[YXLoginRequestTool sharedTool] RequestCheckPhoneWith:self.bindingPartyModle.phone
                                                          type:self.bindingPartyModle.loginType
                                                       Success:^(id objc, id respodHeader) {
                                                           [YXNetworkHUD dismiss];
                                                           if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                               //** 获取验证码成功 */
                                                               [YXMessageCountDownManager shareManager].SMSDate                 = [NSDate date];
                                                               self.reLoadVerificationCodeButton.hidden                         = YES;
                                                               self.cheackInputVerificationCodeResultTipsLabel.hidden           = YES;
                                                           }else{
                                                               self.cheackInputVerificationCodeResultTipsLabel.hidden           = NO;
                                                               self.cheackInputVerificationCodeResultTipsLabel.text             = (NSString *)objc;
                                                               [self failedAnimationWithView:self.cheackInputVerificationCodeResultTipsLabel];
                                                           }
                                                           
                                                       }failure:^(NSError *error) {
                                                           [YXNetworkHUD dismiss];
                                                       }];
    }
}

#pragma mark - .animation

/**
 失败抖动动画

 @param view        控件
 */
- (void)failedAnimationWithView:(UIView *)view
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @15, @-15, @15, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    [view.layer addAnimation:animation forKey:@"shake"];
}

@end
