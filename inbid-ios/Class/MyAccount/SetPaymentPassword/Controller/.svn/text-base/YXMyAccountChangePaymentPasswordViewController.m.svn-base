//
//  YXMyAccountChangePaymentPasswordViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountChangePaymentPasswordViewController.h"
#import "YXMyAccountURLMacros.h"

#import "YXAlearFormMyView.h"

@interface YXMyAccountChangePaymentPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NewPasswordTextfiled;
@property (weak, nonatomic) IBOutlet UIView *backview1;

@property (weak, nonatomic) IBOutlet UILabel *desclable;

@property (weak, nonatomic) IBOutlet UITextField *OldPasswordTextfiled;

@property(nonatomic,strong) UIButton * neweyebtn;
@property(nonatomic,strong) UIButton * oldeyebtn;

@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

@property(nonatomic,strong) YXAlearFormMyView * alearMyview;


@property (weak, nonatomic) IBOutlet UIView *SMSCodeImageBackView;
@property (weak, nonatomic) IBOutlet UIImageView *SMSImageCode;

@property (weak, nonatomic) IBOutlet UITextField *SMSCodeTextfiled;

@property (weak, nonatomic) IBOutlet UIButton *changepaymentCommitBtn;

@end

@implementation YXMyAccountChangePaymentPasswordViewController

-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.SMSCodeImageBackView.hidden = YES;
    
    self.title = @"修改支付密码";
    
    
    [self setEyeBtnUI];
    
    [self setbackviewbordUI];
    
    self.NewPasswordTextfiled.delegate = self;
    self.OldPasswordTextfiled.delegate = self;
    
    [self requestforgetimageSMSCodeISshow];
    
}


-(void)setbackviewbordUI
{
    self.backview1.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.backview1.layer.borderWidth = 0.5;
    
}
- (IBAction)tap:(id)sender {
    
    [self clicktap];
}

-(void)clicktap
{
    [self.NewPasswordTextfiled resignFirstResponder];
    [self.OldPasswordTextfiled resignFirstResponder];
}


-(void)setEyeBtnUI
{
    
    self.SMSCodeImageBackView.layer.borderColor= UIColorFromRGB(0xe5e5e5).CGColor;
    self.SMSCodeImageBackView.layer.borderWidth = 0.5;
    
    
    
    UIButton *neweyebtn = [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [neweyebtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    neweyebtn.tag = 101;
    [neweyebtn addTarget:self action:@selector(ClickchangepasswordeyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.NewPasswordTextfiled.rightViewMode = UITextFieldViewModeWhileEditing;
    self.NewPasswordTextfiled.rightView = neweyebtn;
    self.neweyebtn = neweyebtn;
    
    UIButton *oldeyebtn= [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [oldeyebtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    oldeyebtn.tag = 201;
    [oldeyebtn addTarget:self action:@selector(ClickchangepasswordeyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.OldPasswordTextfiled.rightViewMode = UITextFieldViewModeWhileEditing;
    self.OldPasswordTextfiled.rightView = oldeyebtn;
    self.oldeyebtn = oldeyebtn;
    
    
    [self.NewPasswordTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.OldPasswordTextfiled setInputAccessoryView:self.customAccessoryView];
    
    self.changepaymentCommitBtn.layer.masksToBounds = YES;
    self.changepaymentCommitBtn.layer.cornerRadius = 4;

}
//** -------密码的明文和密文的切换 -----------**/

-(void)ClickchangepasswordeyeBtn:(UIButton*)sender
{
    if (sender.tag == 101) {
        
        sender.selected = !sender.selected;
        self.NewPasswordTextfiled.secureTextEntry = !sender.selected;
        if (sender.selected) {
            [self.neweyebtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        }else{
            [self.neweyebtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        }
        NSString *text = self.NewPasswordTextfiled.text;
        self.NewPasswordTextfiled.text = @" ";
        self.NewPasswordTextfiled.text = text;
        if (self.NewPasswordTextfiled.secureTextEntry)
        {
            [self.NewPasswordTextfiled insertText:self.NewPasswordTextfiled.text];
        }
        
    }else if (sender.tag == 201)
    {
        sender.selected = !sender.selected;
        self.OldPasswordTextfiled.secureTextEntry = !sender.selected;
        if (sender.selected) {
            [self.oldeyebtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        }else{
            [self.oldeyebtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        }
        NSString *text = self.OldPasswordTextfiled.text;
        self.OldPasswordTextfiled.text = @" ";
        self.OldPasswordTextfiled.text = text;
        if (self.OldPasswordTextfiled.secureTextEntry)
        {
            [self.OldPasswordTextfiled insertText:self.OldPasswordTextfiled.text];
        }
        
    }
}

/*
 @brief 切换图片验证码
 */
- (IBAction)ChangeImageCode:(id)sender {
    
    [self requestchangePayPasswordImageCode];
}
#pragma mark  ******************* 请求图片验证码 是否显示的接口 **********************
-(void)requestforgetimageSMSCodeISshow
{
    
    
    
    [YXRequestTool requestDataWithType:POST url:PAYMENTPASSWORDHIEENDORNOT_URL params:nil success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            if ([objc isEqualToString:@"false"]) {
                
                self.SMSCodeImageBackView.hidden= YES;
                
            }else if ([objc isEqualToString:@"true"])
            {
                self.SMSCodeImageBackView.hidden= NO;
                
                [self requestchangePayPasswordImageCode];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark  ******************* 请求图片验证码接口 **********************
-(void)requestchangePayPasswordImageCode
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [YXRequestTool requestImageCoderDataWithType:POST url:SETPAYMENTPASSWORDIMAGECODE_URL params:param success:^(id objc, id respodHeader) {
        
        if(![respodHeader[@"Status"] isEqualToString:@"1"])
        {
            self.alearMyview.alearstr = objc;
            
        }else{
            
            UIImage *image = [UIImage imageWithData:objc];
            self.SMSImageCode.image = image;
            self.SMSCodeTextfiled.text = nil;
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)desclabletextchangetext:(NSString*)textstr
//{
//    self.desclable.hidden = NO;
//    self.desclable.textColor = [UIColor redColor];
//    self.desclable.text = textstr;
//    
//}
- (IBAction)ClickCommitBtn:(id)sender {
    
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(CommitChangePaymentPasswords) object:nil];
    [self performSelector:@selector(CommitChangePaymentPasswords)withObject:nil afterDelay:0.2f];
}

/*
 *  oldPayPwd  原密码
 *  newPayPwd  新密码
 */
-(void)CommitChangePaymentPasswords
{
    if (self.OldPasswordTextfiled.text.length == 0) {
        
        self.alearMyview.alearstr = @"旧密码不能为空";
        return;
    }
    
    if (self.NewPasswordTextfiled.text.length == 0)
    {
        self.alearMyview.alearstr= @"新密码不能为空";
        return;
    
    }
    if (![YXStringFilterTool CheckPaymentPassword:self.OldPasswordTextfiled.text]) {
     
        self.alearMyview.alearstr = @"密码请使用字母，数字和[!#$%^&*]两种及其以上的组合，8～20位字符";
        return;
    }
    
    if (![YXStringFilterTool CheckPaymentPassword:self.NewPasswordTextfiled.text]) {
        
        self.alearMyview.alearstr = @"密码请使用字母，数字和[!#$%^&*]两种及其以上的组合，8～20位字符";
        return;
    }
    
    if (!self.SMSCodeImageBackView.hidden) {
        if (self.SMSCodeTextfiled.text.length==0) {
            self.alearMyview.alearstr = @"图片验证码不能为空";
        }
    }
    
    [YXNetworkHUD show];
    self.changepaymentCommitBtn.enabled = NO;
    //**加密**/
    NSString *NewpasswordStr = [YXStringFilterTool getSha1String:self.NewPasswordTextfiled.text];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"newPayPwd"] = NewpasswordStr;
    param[@"oldPayPwd"] = self.OldPasswordTextfiled.text;
    param[@"verifyCode"] = self.SMSCodeTextfiled.text;
    
    [YXRequestTool requestDataWithType:POST url:CHANGEPAYMENTPASSWORDS_URL params:param success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        self.changepaymentCommitBtn.enabled = YES;
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else
        {
            [self requestforgetimageSMSCodeISshow];

            self.alearMyview.alearstr = objc;
        }
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        self.changepaymentCommitBtn.enabled = YES;
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [YXNetworkHUD dismiss];
}

@end
