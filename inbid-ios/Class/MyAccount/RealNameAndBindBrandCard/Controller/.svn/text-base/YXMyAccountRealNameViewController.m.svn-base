//
//  YXMyAccountRealNameViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountRealNameViewController.h"
#import "YXMyAccountURLMacros.h"
#import "YXStringFilterTool.h"

#import "YXAlearFormMyView.h"


@interface YXMyAccountRealNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *topbackbigview;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *peopleCardTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *SMSCodeTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *requestSMScodeBtn;

@property(nonatomic,assign) NSInteger timeNumber;
@property (weak, nonatomic) IBOutlet UILabel *desclable;
@property (weak, nonatomic) IBOutlet UIView *boomviewline1;
@property (weak, nonatomic) IBOutlet UIView *boomviewline2;
@property (weak, nonatomic) IBOutlet UIView *boomviewline3;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;
@end

@implementation YXMyAccountRealNameViewController
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
    
  
    
    self.title = @"实名认证";
    self.topbackbigview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.topbackbigview.layer.borderWidth = 0.5;
    
    self.commitBtn.layer.masksToBounds = YES;
    self.commitBtn.layer.cornerRadius = 4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addtap)];
    [self.view addGestureRecognizer:tap];
//    self.desclable.hidden = YES;
    self.desclable.text = @"同一个账户只能绑定本人信息";

    
    
    if ([self.realnameStatus isEqualToString:@"REALNAME"]) {
        
        [self QueryRealname];
        [self WhenReadlyRealNameChange];
        
       }
    [self.nameTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.peopleCardTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.SMSCodeTextfiled setInputAccessoryView:self.customAccessoryView];
    
}
-(void)addtap
{
    [self.nameTextfiled resignFirstResponder];
    [self.peopleCardTextfiled resignFirstResponder];
    [self.SMSCodeTextfiled resignFirstResponder];
    
}
/*
 @brief 查询实名认证信息
 */
-(void)QueryRealname
{
    
    [YXRequestTool requestDataWithType:POST url:QUERYRANLNAMESTATUS_URL params:nil success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            self.nameTextfiled.text = objc[@"name"];
            self.peopleCardTextfiled.text = objc[@"idCard"];
            self.nameTextfiled.textColor = UIColorFromRGB(0xaaa7a7);
            self.peopleCardTextfiled.textColor = UIColorFromRGB(0xaaa7a7);
        }
        
    } failure:^(NSError *error) {

    }];

}
/*
 @brief 当实名认证过了，再次进来的改变
 */
-(void)WhenReadlyRealNameChange
{
    self.boomviewline1.hidden = YES;
    self.boomviewline2.hidden = YES;
    self.boomviewline3.hidden = YES;
    self.desclable.hidden = YES;
    self.requestSMScodeBtn.hidden = YES;
    self.SMSCodeTextfiled.hidden = YES;
    self.commitBtn.hidden = YES;
    

    self.nameTextfiled.enabled = NO;
    self.peopleCardTextfiled.enabled = NO;


 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//** -------添加定时器 -----------**/
-(void)addrealnameSMSCodeTiemer
{
    
    self.timeNumber = 60;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(realnameupdateTime:) userInfo:nil repeats:YES];
    [timer fire];
    
}

//计算定时器时间
-(void)realnameupdateTime:(NSTimer *)Timer
{
    self.timeNumber--;
    
    self.requestSMScodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.requestSMScodeBtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.timeNumber] forState:UIControlStateNormal];
    [self.requestSMScodeBtn setTitleColor:UIColorFromRGB(0xAAA7A7) forState:UIControlStateNormal];
    self.requestSMScodeBtn.userInteractionEnabled = NO;
    
    if (self.timeNumber <= 0)
    {
        [Timer invalidate];
        [self.requestSMScodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.requestSMScodeBtn setTitleColor:UIColorFromRGB(0x70ADEF) forState:UIControlStateNormal];
        self.requestSMScodeBtn.userInteractionEnabled = YES;
    }
}


- (IBAction)ClickSMSCodeBtn:(id)sender {
    
    [self addtap];
    
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestsmscoder) object:nil];
    [self performSelector:@selector(requestsmscoder)withObject:nil afterDelay:0.5f];
    
}

/*
 @brief 输入每4位分隔
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.peopleCardTextfiled) {
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
 @brief 请求前的判断
 */
-(BOOL)checkInformation
{
//    NSString *peopletextfiledstr = [self PeopleTextfiledCardStr];
    if (self.peopleCardTextfiled.text == 0||self.nameTextfiled.text.length == 0) {

    
        self.alearMyview.alearstr = @"姓名和身份证号都不能为空";
        
        return NO;
    }

    if(![YXStringFilterTool filterCheckChines:self.nameTextfiled.text])
    {
        
        self.alearMyview.alearstr = @"姓名只能为中文";
        return NO;
    }
    if(![YXStringFilterTool filterCheckIDCard:self.peopleCardTextfiled.text])
    {
       
         self.alearMyview.alearstr = @"身份证号码格式不对";
        return NO;
    }
 
    return YES;
    
}

/*
 @brief 去掉空格
 */
-(NSString *)PeopleTextfiledCardStr
{

    NSString *str =  [self.peopleCardTextfiled.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

-(void)requestsmscoder
{
    
    if (![self checkInformation])
    {
        return;
    }
    
    
    
//    self.desclable.hidden = YES;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = [YXUserDefaults objectForKey:@"PHONE"];
    
    [YXRequestTool requestDataWithType:POST url:REALNAMESMSCODER_URL params:param success:^(id objc, id respodHeader) {
        if ([respodHeader[@"status"] isEqualToString:@"1"]) {
            
           [self addrealnameSMSCodeTiemer];
            
        }else{
            
            
            self.alearMyview.alearstr = objc;
        }
        
    } failure:^(NSError *error) {
        
        
    }];

}

- (IBAction)ClickCommitBtn:(id)sender {
    
    [self addtap];
    
    if (![self checkInformation])
    {
        return;
    }
    if (self.SMSCodeTextfiled.text.length == 0) {
        
        self.alearMyview.alearstr = @"验证码不能为空";
        return;
    }
    
    
    [YXNetworkHUD show];
    self.commitBtn.enabled = NO;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = [YXUserDefaults objectForKey:@"PHONE"];
    param[@"smsCode"] = self.SMSCodeTextfiled.text;
    param[@"name"] = self.nameTextfiled.text;
    param[@"idCard"] = self.peopleCardTextfiled.text;
    
    
    [YXRequestTool requestDataWithType:POST url:REALNAME_URL params:param success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        self.commitBtn.enabled = YES;
        
        NSString *str;
        
        if ([respodHeader[@"status"] isEqualToString:@"1"]) {
            
            /**
             * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
             */
            str = @"2";
            
            if (self.delegate
                && [self.delegate respondsToSelector:@selector(myAccountRealNameViewController:extend:)]) {
                [self.delegate myAccountRealNameViewController:self extend:nil];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [YXUserDefaults setObject:str forKey:@"validateStatus"];
            [YXUserDefaults synchronize];

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
