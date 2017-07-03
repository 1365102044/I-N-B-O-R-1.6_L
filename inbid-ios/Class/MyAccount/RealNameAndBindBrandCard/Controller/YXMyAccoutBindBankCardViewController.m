//
//  YXMyAccoutBindBankCardViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAccountURLMacros.h"

#import "YXAlearFormMyView.h"

@interface YXMyAccoutBindBankCardViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *topbackview;

@property (weak, nonatomic) IBOutlet UILabel *CardholderLable;
@property (weak, nonatomic) IBOutlet UITextField *bankNmubertextfiled;

@property (weak, nonatomic) IBOutlet UITextField *SMSCoderTextfiled;

@property (weak, nonatomic) IBOutlet UIButton *SMSCoderBtn;
@property(nonatomic,assign) NSInteger timeNumber;

@property (weak, nonatomic) IBOutlet UIView *boomviewline1;
@property (weak, nonatomic) IBOutlet UIView *boomviewline2;
@property (weak, nonatomic) IBOutlet UIView *boomviewline3;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *desclable;

@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXMyAccoutBindBankCardViewController

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
    

    
    self.title = @"绑定银行卡";
    self.topbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.topbackview.layer.borderWidth = 0.5;
    
    self.commitBtn.layer.masksToBounds = YES;
    self.commitBtn.layer.cornerRadius = 4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addtapbankcard)];
    [self.view addGestureRecognizer:tap];
   
//    self.desclable.hidden = YES;
    self.desclable.text = @"同一个账户只能绑定本人信息";
    
    self.bankNmubertextfiled.delegate = self;
    
  self.bankNmubertextfiled.textColor = UIColorFromRGB(0x050505);
    
    if ([self.bindbankStatus isEqualToString:@"BINDBANK"]) {
        
        [self querybindbankstatus];
        [self ReadlybindbankChangeUI];
        
        
    }else{
        [self QueryRealnamestatus];
    }
    [self.bankNmubertextfiled setInputAccessoryView:self.customAccessoryView];
    [self.SMSCoderTextfiled setInputAccessoryView:self.customAccessoryView];
    
}
/*
 @brief 查询实名认证信息  拿到姓名
 */
-(void)QueryRealnamestatus
{
    [YXRequestTool requestDataWithType:POST url:QUERYRANLNAMESTATUS_URL params:nil success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.CardholderLable.text = objc[@"name"];
            self.bankNmubertextfiled.textColor = UIColorFromRGB(0xaaa7a7);
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];

}

/*
 @brief 查询绑定银行卡信息
 */
-(void)querybindbankstatus
{
    [YXRequestTool requestDataWithType:POST url:QUERYBINDBANKSTATUS_URL params:nil success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.bankNmubertextfiled.text = objc[@"bankCardNo"];
            self.bankNmubertextfiled.textColor = UIColorFromRGB(0xaaa7a7);
            self.CardholderLable.text = objc[@"name"];
            self.bankNmubertextfiled.textColor = UIColorFromRGB(0xaaa7a7);
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];

}


/*
 @brief 绑定银行卡后
 */
-(void)ReadlybindbankChangeUI
{
    self.boomviewline1.hidden = YES;
    self.boomviewline2.hidden = YES;
    self.boomviewline3.hidden = YES;
    self.desclable.hidden = YES;
    self.SMSCoderTextfiled.hidden = YES;
    self.SMSCoderBtn.hidden = YES;
    self.commitBtn.hidden = YES;
    
    
    self.bankNmubertextfiled.enabled = NO;

    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightbtn setTitle:@"更换" forState:UIControlStateNormal];
    rightbtn.titleLabel.font = YXRegularfont(15);
    [rightbtn setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(clickRightBtnItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightitem;
}

/*
 @brief 点击更换银行卡
 */
-(void)clickRightBtnItem
{
    YXMyAccoutBindBankCardViewController *bindbankVC = [[YXMyAccoutBindBankCardViewController alloc]init];
    [self.navigationController pushViewController:bindbankVC animated:YES];
}
-(void)addtapbankcard
{
    [self.bankNmubertextfiled resignFirstResponder];
    [self.SMSCoderTextfiled resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//** -------添加定时器 -----------**/
-(void)addbinkbankcardSMSCodeTiemer
{
    
    
    self.timeNumber = 60;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(binkbankcardupdateTime:) userInfo:nil repeats:YES];
    [timer fire];
}

//-(void)addpromtdescTextstr:(NSString*)desctext
//{
//    self.desclable.hidden = YES;
//    self.desclable.text = desctext;
//    self.desclable.textColor = [UIColor redColor];
//}

//计算定时器时间
-(void)binkbankcardupdateTime:(NSTimer *)Timer
{
    self.timeNumber--;
    
    self.SMSCoderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.SMSCoderBtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.timeNumber] forState:UIControlStateNormal];
    [self.SMSCoderBtn setTitleColor:UIColorFromRGB(0xAAA7A7) forState:UIControlStateNormal];
    self.SMSCoderBtn.userInteractionEnabled = NO;
    
    if (self.timeNumber <= 0)
    {
        [Timer invalidate];
        [self.SMSCoderBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.SMSCoderBtn setTitleColor:UIColorFromRGB(0x70ADEF) forState:UIControlStateNormal];
        self.SMSCoderBtn.userInteractionEnabled = YES;
    }
}

/*
 @brief 输入每4位分隔
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.bankNmubertextfiled) {
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
-(NSString *)BankNmuberTextfiledCardStr
{
    
    NSString *str =  [self.bankNmubertextfiled.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}
- (IBAction)ClickSMSCoderBtn:(id)sender {

    [self addtapbankcard];
    
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestsmsCoder) object:nil];
    [self performSelector:@selector(requestsmsCoder)withObject:nil afterDelay:0.5f];

}

-(void)requestsmsCoder
{
    [self addtapbankcard];
    
    if ([self BankNmuberTextfiledCardStr].length == 0) {
        
        self.alearMyview.alearstr = @"银行卡号不能为空";
        return;
    }
    
    if(![YXStringFilterTool CheckBankCard:[self BankNmuberTextfiledCardStr]])
    {

        self.alearMyview.alearstr = @"银行卡号格式不对";
        return;
    }
//        self.desclable.hidden = YES;
    
    
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
 * @param bankName  银行卡类型
 * @param bankCardNo  银行卡编号
 */
- (IBAction)ClickCommitbtn:(id)sender {
    
    [self addtapbankcard];
    
    if ([self BankNmuberTextfiledCardStr].length == 0) {

        self.alearMyview.alearstr = @"银行卡号不能为空";
        
        return;
    }
    
    if(![YXStringFilterTool CheckBankCard:[self BankNmuberTextfiledCardStr]])
    {
        
        self.alearMyview.alearstr = @"银行卡号格式不对";
        return;
    }
    if(self.SMSCoderTextfiled.text.length ==0)
    {

        self.alearMyview.alearstr = @"验证码不能为空";
        return;
    }
    
    [YXNetworkHUD show];
    self.commitBtn.enabled = NO;
    
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];

    parm[@"bankCardNo"] = [self BankNmuberTextfiledCardStr];
    parm[@"phone"] = [YXUserDefaults objectForKey:@"PHONE"];
    parm[@"smsCode"] = self.SMSCoderTextfiled.text;

    [YXRequestTool requestDataWithType:POST url:BINDBANDCARD_URL params:parm success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        self.commitBtn.enabled = YES;
        
        if ([respodHeader[@"status"] isEqualToString:@"1"]) {
            
            /**
             * 绑定银行卡 0未绑定 1表示绑定
             */
            NSString *str = @"1";
            [YXUserDefaults setObject:str forKey:@"cardStatus"];
            
            [YXUserDefaults synchronize];
            
            //** 监听用户操作 */
            if ([self.delegate respondsToSelector:@selector(myAccoutBindBankCardViewController:changeRestPageON:)]) {
                [self.delegate myAccoutBindBankCardViewController:self changeRestPageON:YES];
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
            self.alearMyview.alearstr = objc;
            
        }
        
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        self.commitBtn.enabled = YES;

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
