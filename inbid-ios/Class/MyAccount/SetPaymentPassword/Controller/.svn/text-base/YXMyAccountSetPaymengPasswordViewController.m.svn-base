//
//  YXMyAccountSetPaymengPasswordViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountSetPaymengPasswordViewController.h"
#import "YXMyAccountURLMacros.h"
#import "YXAlearFormMyView.h"

@interface YXMyAccountSetPaymengPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *backview1;
@property (weak, nonatomic) IBOutlet UIView *backview2;
@property (weak, nonatomic) IBOutlet UIView *backview3;
@property (weak, nonatomic) IBOutlet UITextField *fristpasswordtextfiled;
@property (weak, nonatomic) IBOutlet UITextField *secondpasswordtextfiled;

@property (weak, nonatomic) IBOutlet UITextField *SMStextfiled;
@property (weak, nonatomic) IBOutlet UIButton *SMSbtn;

@property (weak, nonatomic) IBOutlet UILabel *descLable;

@property(nonatomic,strong) UIButton * firsteyeBtn;
@property(nonatomic,strong) UIButton * secondeyeBtn;

@property(nonatomic,assign) NSInteger timeNumber;
@property (weak, nonatomic) IBOutlet UILabel *SMSCoderDesclable;

@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

@property(nonatomic,strong) YXAlearFormMyView * alearMyview;



@property (weak, nonatomic) IBOutlet UIButton *SetPaymentPasswordBtn;

@end

@implementation YXMyAccountSetPaymengPasswordViewController

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
    
    
  
    
    self.title = @"设置支付密码";
    self.descLable.hidden = YES;
//    self.SMSCoderDesclable.hidden = YES;
    
    [self setviewbordUI];
    [self seteyeBtnUI];
    self.fristpasswordtextfiled.delegate = self;
    self.secondpasswordtextfiled.delegate = self;
    
    [self.fristpasswordtextfiled setInputAccessoryView:self.customAccessoryView];
    [self.secondpasswordtextfiled setInputAccessoryView:self.customAccessoryView];
    [self.SMStextfiled setInputAccessoryView:self.customAccessoryView];
}

-(void)setviewbordUI
{
    self.backview1.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.backview1.layer.borderWidth = 0.5;
    
    self.backview2.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.backview2.layer.borderWidth = 0.5;
    
    self.backview2.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.backview2.layer.borderWidth = 0.5;
    
    self.SetPaymentPasswordBtn.layer.masksToBounds = YES;
    self.SetPaymentPasswordBtn.layer.cornerRadius = 4;
    
}

- (IBAction)clickselfview:(id)sender {
    
    [self clicktap];
}

-(void)clicktap
{
    [self.fristpasswordtextfiled  resignFirstResponder];
    [self.secondpasswordtextfiled resignFirstResponder];
    [self.SMStextfiled resignFirstResponder];
}


-(void)seteyeBtnUI
{
    UIButton *firsteyeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [firsteyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    firsteyeBtn.tag = 100;
    [firsteyeBtn addTarget:self action:@selector(ClicksetpasswordeyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.fristpasswordtextfiled.rightViewMode = UITextFieldViewModeWhileEditing;
    self.fristpasswordtextfiled.rightView = firsteyeBtn;
    self.firsteyeBtn = firsteyeBtn;
    
    UIButton *secondeyeBtn= [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [secondeyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    secondeyeBtn.tag = 200;
    [secondeyeBtn addTarget:self action:@selector(ClicksetpasswordeyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.secondpasswordtextfiled.rightViewMode = UITextFieldViewModeWhileEditing;
    self.secondpasswordtextfiled.rightView = secondeyeBtn;
    self.secondeyeBtn = secondeyeBtn;

}
//** -------密码的明文和密文的切换 -----------**/
-(void)ClicksetpasswordeyeBtn:(UIButton*)sender
{
    if (sender.tag == 100) {
        
        sender.selected = !sender.selected;
        self.fristpasswordtextfiled.secureTextEntry = !sender.selected;
        if (sender.selected) {
            [self.firsteyeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        }else{
            [self.firsteyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        }
        NSString *text = self.fristpasswordtextfiled.text;
        self.fristpasswordtextfiled.text = @" ";
        self.fristpasswordtextfiled.text = text;
        if (self.fristpasswordtextfiled.secureTextEntry)
        {
            [self.fristpasswordtextfiled insertText:self.fristpasswordtextfiled.text];
        }

    }else if (sender.tag == 200)
    {
        sender.selected = !sender.selected;
        self.secondpasswordtextfiled.secureTextEntry = !sender.selected;
        if (sender.selected) {
            [self.secondeyeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        }else{
            [self.secondeyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        }
        NSString *text = self.secondpasswordtextfiled.text;
        self.secondpasswordtextfiled.text = @" ";
        self.secondpasswordtextfiled.text = text;
        if (self.secondpasswordtextfiled.secureTextEntry)
        {
            [self.secondpasswordtextfiled insertText:self.secondpasswordtextfiled.text];
        }

    }
   }

//** -------添加定时器 -----------**/
-(void)addsetpaypasswordSMSCodeTiemer
{

    self.timeNumber = 60;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatesetpaypasswordTime:) userInfo:nil repeats:YES];
    [timer fire];
    
}



//计算定时器时间
-(void)updatesetpaypasswordTime:(NSTimer *)Timer
{
    self.timeNumber--;
    
    self.SMSbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.SMSbtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.timeNumber] forState:UIControlStateNormal];
    [self.SMSbtn setTitleColor:UIColorFromRGB(0xaaa7a7) forState:UIControlStateNormal];
    self.SMSbtn.userInteractionEnabled = NO;
    
    if (self.timeNumber <= 0)
    {
        [Timer invalidate];
        [self.SMSbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.SMSbtn setTitleColor:UIColorFromRGB(0x70ADEF) forState:UIControlStateNormal];
        self.SMSbtn.userInteractionEnabled = YES;
        [YXUserDefaults setObject:nil forKey:@"TimeCount"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)checkinformation
{
    
    if (self.fristpasswordtextfiled.text.length == 0|| self.secondpasswordtextfiled.text.length==0) {
        
        self.alearMyview.alearstr = @"支付密码不能为空";
        
        return NO;
    }
    
    
    if (![self.fristpasswordtextfiled.text isEqualToString:self.secondpasswordtextfiled.text]) {
        
        self.alearMyview.alearstr = @"2次输入的密码不一致";
        
        return NO;
    }

    if(![YXStringFilterTool CheckPaymentPassword:self.fristpasswordtextfiled.text])
    {
        self.alearMyview.alearstr = @"建议您使用6-20位字母，数字和符号的密码";
        return NO;
    }

    return YES;
}


- (IBAction)ClickSMSbtn:(id)sender {
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(ClickSMSBtnRequestSMS) object:nil];
    [self performSelector:@selector(ClickSMSBtnRequestSMS)withObject:nil afterDelay:0.2f];
}

/*
 @brief 请求验证码
 */
-(void)ClickSMSBtnRequestSMS
{
   
    
    [self clicktap];
    if (![self checkinformation]) {
        
        return;
    }
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = [YXUserDefaults  objectForKey:@"PHONE"];
    
    [YXRequestTool requestDataWithType:POST url:REQUESTSMSCODER_URL params:param success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.SMSCoderDesclable.hidden = NO;
            self.SMSCoderDesclable.text = @"已发送验证码到您手机,请输入验证码完成验证";
            [self addsetpaypasswordSMSCodeTiemer];

        }else{
            
            self.alearMyview.alearstr = objc;
        }
        
    } failure:^(NSError *error) {
        
        
    }];

}

- (IBAction)CommitSetPaymentPasswords:(id)sender {
    
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(CommitSetPaymentPasswords) object:nil];
    [self performSelector:@selector(CommitSetPaymentPasswords)withObject:nil afterDelay:0.2f];
}

/*
 payPassword  支付密码
 confirmPayPassword  确认密码
 */
-(void)CommitSetPaymentPasswords
{
    
    [self clicktap];
    
    if (![self checkinformation]) {
        
        return;
    }
    
    if (self.SMStextfiled.text.length == 0) {
        
        self.alearMyview.alearstr = @"验证码不能为空";
        return;
    }
    
    
    [YXNetworkHUD show];
    self.SetPaymentPasswordBtn.enabled = NO;
    
    
    //**加密**/
    NSString *firstpasswordStr = [YXStringFilterTool getSha1String:self.fristpasswordtextfiled.text];
    NSString *secondpasswordStr = [YXStringFilterTool getSha1String:self.secondpasswordtextfiled.text];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"payPassword"] = firstpasswordStr;
    param[@"confirmPayPassword"] = secondpasswordStr;
    param[@"phone"] = [YXUserDefaults objectForKey:@"PHONE"];
    param[@"smsCode"] = self.SMStextfiled.text;
    [YXRequestTool requestDataWithType:POST url:SETPAYMENTPASSWORDS_URL params:param success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        self.SetPaymentPasswordBtn.enabled = YES;
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            //是否设置支付密码：设置为1，默认为0没有
            NSString *str = @"1";
            [YXUserDefaults setObject:str forKey:@"isPaymentCode"];
            [YXUserDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            
            self.alearMyview.alearstr = objc;
        }
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        self.SetPaymentPasswordBtn.enabled = YES;
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [YXNetworkHUD dismiss];
}
//
//-(YXMyOrderSuccessAlerview*)RemindGoodsView
//{
//    if(!_RemindGoodsView){
//        
//        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
//    }
//    return _RemindGoodsView;
//}
//-(void)setalearview:(NSString*)str
//{
//    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
//    self.RemindGoodsView.longinVCStr = str;
//    self.RemindGoodsView.frame = self.view.bounds;
//    __weak typeof (self) wealself = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [wealself dimssview];
//    });
//    
//}
//
//
//-(void)dimssview
//{
//    [self.RemindGoodsView removeFromSuperview];
//    self.RemindGoodsView = nil;
//}

@end
