    //
//      YXMyAucctionRealnameAndBindbankCardViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAucctionRealnameAndBindbankCardViewController.h"
#import "YXMyAccountURLMacros.h"

#import "YXAlearFormMyView.h"

@interface YXMyAucctionRealnameAndBindbankCardViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *topbackview;
@property (weak, nonatomic) IBOutlet UIView *topbackviewline;

@property (weak, nonatomic) IBOutlet UITextField *nameTextfiled;

@property (weak, nonatomic) IBOutlet UITextField *peopleIDCardTextfiled;

@property (weak, nonatomic) IBOutlet UITextField *bankNmberTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *SMSTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *requestSMSCoderBtn;
@property (weak, nonatomic) IBOutlet UIView *Bankbackview;

@property(nonatomic,assign) NSInteger  timeNumber;
@property (weak, nonatomic) IBOutlet UILabel *desclable;

@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

@property(nonatomic,strong) YXAlearFormMyView * alearMyview;
@property (weak, nonatomic) IBOutlet UIButton *CommitBtn;

@end

@implementation YXMyAucctionRealnameAndBindbankCardViewController

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
    
 
    
    self.title = @"银行卡认证";
    
    self.Bankbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.Bankbackview.layer.borderWidth = 0.5;
    self.topbackviewline.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.topbackviewline.layer.borderWidth = 0.5;
    self.topbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.topbackview.layer.borderWidth = 0.5;

    self.CommitBtn.layer.masksToBounds = YES;
    self.CommitBtn.layer.cornerRadius = 4;
    
    self.desclable.text = @"同一个账户只能绑定本人信息";

    
    self.bankNmberTextfiled.delegate = self;
    self.SMSTextfiled.delegate = self;

    
    [self.nameTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.peopleIDCardTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.bankNmberTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.SMSTextfiled setInputAccessoryView:self.customAccessoryView];
 
    

    
}
-(void)addtapbankcardALL
{
    [self.nameTextfiled resignFirstResponder];
    [self.peopleIDCardTextfiled resignFirstResponder];
    [self.bankNmberTextfiled resignFirstResponder];
    [self.SMSTextfiled resignFirstResponder];
    
}
//** -------添加定时器 -----------**/
-(void)addbinkbankcardSMSCodeTiemer
{
//    self.desclable.hidden = YES;
    
    self.timeNumber = 60;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(binkbankcardupdateTime:) userInfo:nil repeats:YES];
    [timer fire];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if (YXScreenH <=568) {
        
        if (textField == self.SMSTextfiled) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.view.y -=35;
                
            }];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (YXScreenH <=568) {
        if (textField == self.SMSTextfiled) {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.view.y +=35;
                
            }];
        }
    }
}


//计算定时器时间
-(void)binkbankcardupdateTime:(NSTimer *)Timer
{
    self.timeNumber--;
    self.requestSMSCoderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.requestSMSCoderBtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.timeNumber] forState:UIControlStateNormal];
    [self.requestSMSCoderBtn setTitleColor:UIColorFromRGB(0xAAA7A7) forState:UIControlStateNormal];
    self.requestSMSCoderBtn.userInteractionEnabled = NO;
    
    if (self.timeNumber <= 0)
    {
        [Timer invalidate];
        [self.requestSMSCoderBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.requestSMSCoderBtn setTitleColor:UIColorFromRGB(0x70ADEF) forState:UIControlStateNormal];
        self.requestSMSCoderBtn.userInteractionEnabled = YES;
    }
}
/*
 @brief 输入每4位分隔
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.bankNmberTextfiled) {
        // 4位分隔银行卡卡号
        NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if ([newString stringByReplacingOccurrencesOfString:@" " withString:@""].length >= 21) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
    }
    return YES;
}
/*
 @brief 去掉空格
 */
-(NSString *)bankTextfiledCardStr
{
    
    NSString *str =  [self.bankNmberTextfiled.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}
//-(void)addpromtdescTextstr:(NSString*)desctext
//{
//    self.desclable.hidden = NO;
//    self.desclable.text = desctext;
//    self.desclable.textColor = [UIColor redColor];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 @brief 请求前的判断
 */
-(BOOL)checkInformation
{
    NSString *bankletextfiledstr = [self bankTextfiledCardStr];
    if (bankletextfiledstr.length == 0||self.nameTextfiled.text.length == 0||self.peopleIDCardTextfiled.text.length == 0) {
    
        self.alearMyview.alearstr = @"姓名,身份证号和银行卡号都不能为空";
        return NO;
    }
    
    if(![YXStringFilterTool filterCheckChines:self.nameTextfiled.text])
    {
        self.alearMyview.alearstr = @"姓名只能为中文";
        return NO;
    }
    if(![YXStringFilterTool filterCheckIDCard:self.peopleIDCardTextfiled.text])
    {

        self.alearMyview.alearstr = @"身份证号码格式不对";
        return NO;
    }
    if(![YXStringFilterTool CheckBankCard:[self bankTextfiledCardStr]])
    {
        self.alearMyview.alearstr = @"银行卡号格式不对";
        return NO;
    }

    return YES;
    
}

- (IBAction)ClickRequestSMSCoderBtn:(id)sender {
    
    [self addtapbankcardALL];
    
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestSMSCoder) object:nil];
    [self performSelector:@selector(requestSMSCoder)withObject:nil afterDelay:0.5f];
}


-(void)requestSMSCoder
{
    
    if (![self checkInformation]) {
        
        return;
    }
    
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"phone"] = [YXUserDefaults objectForKey:@"PHONE"];
    
    [YXRequestTool requestDataWithType:POST url:BINDBANKCARDSMSCODER_URL params:parm success:^(id objc, id respodHeader) {
        if ([respodHeader[@"status"] isEqualToString:@"1"]) {
            
            [self addbinkbankcardSMSCodeTiemer];

        }else{
            
            self.alearMyview.alearstr = objc;
        }
        
    } failure:^(NSError *error) {
        
        
    }];

}


/*
 * @param phone 手机号
 * @param smsCode 短信验证码
 * @param name 姓名
 * @param idCard 身份证号
 * @param bankCardNo 卡号
 * @param bankCard 哪个银行类型
 */
- (IBAction)ClickCommitBtn:(id)sender {
    
    [self addtapbankcardALL];
    
    if (![self checkInformation]) {
        
        return;
    }
    if (self.SMSTextfiled.text.length == 0) {
        
        self.alearMyview.alearstr = @"验证码不能为空";
        return;
    }

    [YXNetworkHUD show];
    self.CommitBtn.enabled = NO;
    
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"phone"] = [YXUserDefaults objectForKey:@"PHONE"];
    parm[@"name"] = self.nameTextfiled.text;
    parm[@"idCard"] = self.peopleIDCardTextfiled.text;
    parm[@"bankCardNo"] = [self bankTextfiledCardStr];
    parm[@"smsCode"] = self.SMSTextfiled.text;
    [YXRequestTool requestDataWithType:POST url:REALNAMEANDBINDBANDCARD_URL params:parm success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        self.CommitBtn.enabled = YES;
        
        if ([respodHeader[@"status"] isEqualToString:@"1"]) {
            
            //** 监听用户请求 */
            if ([self.delegate respondsToSelector:@selector(myAucctionRealnameAndBindbankCardViewController:changeRestPageON:)]) {
                [self.delegate myAucctionRealnameAndBindbankCardViewController:self changeRestPageON:YES];
            }
            
            NSString *cardStatus = @"1";
            NSString *validateStatus = @"2";
            /**
             * 绑定银行卡 0未绑定 1表示绑定
             */
            [YXUserDefaults setObject:cardStatus forKey:@"cardStatus"];
            /**
             * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
             */
            [YXUserDefaults setObject:validateStatus forKey:@"validateStatus"];
            
            
            [YXUserDefaults synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            
            self.alearMyview.alearstr = objc;
        }
        
        
    } failure:^(NSError *error) {
        
        [YXNetworkHUD dismiss];
        self.CommitBtn.enabled = YES;
    }];
    

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [YXNetworkHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

@end
