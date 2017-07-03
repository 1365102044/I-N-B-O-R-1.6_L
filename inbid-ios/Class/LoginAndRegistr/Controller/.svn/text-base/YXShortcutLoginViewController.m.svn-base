//
//  YXShortcutLoginViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/10.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXShortcutLoginViewController.h"
#import "YXLoginRequestTool.h"
#import "YXInputPhoneNumberViewController.h"
#import "YXSaveLoginDataTool.h"
@interface YXShortcutLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topimageTopContance;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextfiled;

@property (weak, nonatomic) IBOutlet UITextField *SmsCodeTextfield;

@property (weak, nonatomic) IBOutlet UIButton *GetSmsCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@property (assign,nonatomic) NSInteger cutNumber;
/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;

@property (nonatomic ,assign) BOOL IsNumberCuting;
@end

@implementation YXShortcutLoginViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
    self.IsNumberCuting = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCumsUI];
    
}
-(void)setCumsUI{
    
    UIImageView *leftimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11"]];
    leftimageview.frame = CGRectMake(0, 0, 40, 50);
    self.phoneTextfiled.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextfiled.leftView = leftimageview;
    self.phoneTextfiled.layer.borderColor = LineBorderColor.CGColor;
    self.phoneTextfiled.layer.borderWidth = 0.5;
    self.phoneTextfiled.layer.cornerRadius = 4;
    self.phoneTextfiled.layer.masksToBounds = YES;
    self.phoneTextfiled.delegate = self;
    
    
    UIImageView *pwdimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证码-2"]];
    pwdimageview.frame = CGRectMake(0, 0, 40, 50);
    self.SmsCodeTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.SmsCodeTextfield.leftView = pwdimageview;
    self.SmsCodeTextfield.layer.borderColor = LineBorderColor.CGColor;
    self.SmsCodeTextfield.layer.borderWidth = 0.5;
    self.SmsCodeTextfield.layer.cornerRadius = 4;
    self.SmsCodeTextfield.layer.masksToBounds = YES;
    self.SmsCodeTextfield.delegate = self;
    
    
    self.LoginBtn.layer.cornerRadius = 4;
    self.LoginBtn.layer.masksToBounds = YES;
    
    UIButton *Rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
    [Rightbtn setTitle:@"注册" forState:UIControlStateNormal];
    [Rightbtn setTitleColor:UIColorFromRGB(0x108ee9) forState:UIControlStateNormal];
    [Rightbtn addTarget:self action:@selector(GotoReginster) forControlEvents:UIControlEventTouchUpInside];
    Rightbtn.titleLabel.font = YXRegularfont(16);
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}
-(void)GotoReginster{
    YXInputPhoneNumberViewController *inputPhoneNumbeViewController = [YXInputPhoneNumberViewController inputPhoneNumberViewControllerWithType:YXLoginViewControllerTypeRegister andExtend:nil];
    [self.navigationController pushViewController:inputPhoneNumbeViewController animated:YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextfiled) {
        
        NSString *tostring =[textField.text stringByReplacingCharactersInRange:range withString:string];
        if (tostring.length>11) {
            
            [self.phoneTextfiled resignFirstResponder];
        }
        
    }
    if (textField == self.SmsCodeTextfield) {
        
        NSString *tostring =[textField.text stringByReplacingCharactersInRange:range withString:string];
        if (tostring.length>6) {
            
            [self.SmsCodeTextfield resignFirstResponder];
        }
    }
    
    return YES;
}
//获取短信验证码
- (IBAction)ClickGetSmsCodeBtn:(id)sender {
    
    if (self.IsNumberCuting) {
        return;
    }
    if (![self checkParam]) {
        return;
    }
    
    [[YXLoginRequestTool sharedTool] RequestSMSCodeforShortcurLoginWith:self.phoneTextfiled.text Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            [self addTimer];
        }else{
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
    } failure:^(NSError *error) {
    }];
}
//提及数据
- (IBAction)ClickLoginBtn:(id)sender {
    if (![self checkParam]) {
        return;
    }
    if (self.SmsCodeTextfield.text.length==0) {
        [YXAlearMnager ShowAlearViewWith:@"验证码不能为空" Type:2];
        return;
    }
    [[YXLoginRequestTool sharedTool]RequestCommitDataforShortcurLoginWith:self.phoneTextfiled.text smscode:self.SmsCodeTextfield.text Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.phoneTextfiled.text];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [YXNotificationTool postNotificationName:@"zhucesuccess" object:nil];
            
        }else{
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

-(void)addTimer{

    self.cutNumber = 60;
    NSTimer *mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCutNumber:) userInfo:nil repeats:YES];
    [mytimer fire];
}

-(void)updateCutNumber:(NSTimer *)timer{
    
    self.cutNumber --;
    self.GetSmsCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.GetSmsCodeBtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.cutNumber] forState:UIControlStateNormal];
    [self.GetSmsCodeBtn setTitleColor:UIColorFromRGB(0xaaa7a7) forState:UIControlStateNormal];
    self.IsNumberCuting = YES;
    
    if (self.cutNumber <= 0)
    {
        [timer invalidate];
        [self.GetSmsCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.GetSmsCodeBtn setTitleColor:UIColorFromRGB(0x70ADEF) forState:UIControlStateNormal];
        self.IsNumberCuting = NO;
        
    }
}
-(BOOL)checkParam
{
    if (self.phoneTextfiled.text.length ==0) {
        
        [YXAlearMnager ShowAlearTopBarViewWith:@"手机号不能为空"];
        return NO;
    }else if (![YXStringFilterTool filterByPhoneNumber:self.phoneTextfiled.text]){
        [YXAlearMnager ShowAlearTopBarViewWith:@"手机号格式不对"];
        return NO;
    }

    
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextfiled resignFirstResponder];
    [self.SmsCodeTextfield resignFirstResponder];
}
@end
