//
//  YXPickuppersonListAddNewsViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPickuppersonListAddNewsViewController.h"
#import "YXMyAccountURLMacros.h"
#import "YXAlearFormMyView.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"
@interface YXPickuppersonListAddNewsViewController ()<UITextFieldDelegate,YXKeyboardToolbarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nametextfiled;

@property (weak, nonatomic) IBOutlet UITextField *phonetextfiled;

@property (weak, nonatomic) IBOutlet UITextField *IDcardtextfiled;

@property (weak, nonatomic) IBOutlet UIButton *MorenBtn;

@property (weak, nonatomic) IBOutlet UIButton *CommitBtn;

@property(nonatomic,assign) NSInteger  isdefut;

@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

//**编辑的时候是否手机号**/
@property(nonatomic,assign) BOOL  ischangephone;

@property(nonatomic,strong) YXKeyboardToolbar * customAccessoryView;
@end

@implementation YXPickuppersonListAddNewsViewController
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
    
    
    self.title = self.texttitle;
    
  
    [self.nametextfiled setInputAccessoryView:self.customAccessoryView];
    [self.phonetextfiled setInputAccessoryView:self.customAccessoryView];
    [self.IDcardtextfiled setInputAccessoryView:self.customAccessoryView];
    
     if([self.texttitle isEqualToString:@"编辑提货人信息"])
    {
        if (![self.modle.idcard isEqualToString:@""] && self.modle.idcard != nil) {
            
            
            self.nametextfiled.text = self.modle.name;
            self.IDcardtextfiled.text  = self.modle.idcard;
            self.phonetextfiled.text = self.modle.mobile;
            self.IDcardtextfiled.enabled = NO;
            self.nametextfiled.enabled = NO;
            self.nametextfiled.textColor = UIColorFromRGB(0xaaa7a7);
            self.IDcardtextfiled.textColor = UIColorFromRGB(0xaaa7a7);
            
        }else{
            
            self.nametextfiled.text = self.modle.name;
            self.phonetextfiled.text = self.modle.mobile;
            self.nametextfiled.enabled = YES;
            self.IDcardtextfiled.enabled = YES;
            
        }
        
        if ([self.modle.isDefault isEqualToString:@"1"]) {
            self.MorenBtn.selected = YES;
            [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress_highlight"] forState:UIControlStateNormal];

        }
    }
    
    
    self.CommitBtn.layer.masksToBounds = YES;
    self.CommitBtn.layer.cornerRadius = 3;
    
    self.MorenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    
    self.nametextfiled.delegate = self;
    self.phonetextfiled.delegate = self;
    self.IDcardtextfiled.delegate = self;
    [self.nametextfiled setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.IDcardtextfiled setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.phonetextfiled setAutocorrectionType:UITextAutocorrectionTypeNo];
    
//    [self.nametextfiled addTarget:self action:@selector(TextfiledDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [self.IDcardtextfiled addTarget:self action:@selector(TextfiledDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [self.phonetextfiled addTarget:self action:@selector(TextfiledDidChange:) forControlEvents:UIControlEventEditingChanged];

    [YXNotificationTool addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];

}

/**
 *  当 text field 文本内容改变时 会调用此方法
 *
 *  @param notification
 */
-(void)textViewEditChanged:(NSNotification *)notification{
    
    // 拿到文本改变的 text field
    UITextField *textField = (UITextField *)notification.object;
    
    if (textField.tag == 10) {
        
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:20];
    }
    if (textField.tag == 11) {
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:11];
    }
    if(textField.tag == 12)
    {
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:18];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.phonetextfiled) {
        
        if ([self.texttitle isEqualToString:@"编辑提货人信息"]) {
            
            self.phonetextfiled.text = nil;
            self.ischangephone = YES;
        }
    }
    
    return YES;
}

- (IBAction)ClickMorenBtn:(id)sender {

    self.MorenBtn.selected = !self.MorenBtn.selected;
    
    if (self.MorenBtn.selected) {
        
        self.isdefut = 1;
        
        [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress_highlight"] forState:UIControlStateNormal];
        
    }else
    {
        self.isdefut = 0;
        [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress"] forState:UIControlStateNormal];
    }
    
    
}


/*
 * @param name 自提人名
 * @param mobile 自提人手机号
 * @param idCard 自提人身份证号
 * @param isDefault 是否默认
 */

- (IBAction)ClickCommitBtn:(id)sender {
    
    
    if([self.texttitle isEqualToString:@"编辑提货人信息"])
    {
        [self bianjiinformation];
        
    }else if ([self.texttitle isEqualToString:@"新增提货人信息"])
    {
        [self addnewinformation];
    }
}

//**编辑**/
-(void)bianjiinformation
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if (self.ischangephone) {
        
        if (self.phonetextfiled.text.length ==0) {
            self.alearMyview.alearstr = @"手机号不能为空";
            return;
        }else if (![YXStringFilterTool filterByPhoneNumber:self.phonetextfiled.text ])
        {
            self.alearMyview.alearstr = @"手机号格式不对";
            return;
        }
        
         param[@"mobile"] =self.phonetextfiled.text;
    }
    
    if ([self.modle.idcard isEqualToString:@""]||self.modle.idcard == nil) {
        
        if (self.IDcardtextfiled.text.length) {
            
            if (![YXStringFilterTool filterCheckIDCard:self.IDcardtextfiled.text]) {
                self.alearMyview.alearstr = @"身份证号格式不对";
                
                return;
            }
        }
        
        param[@"idCard"] =self.IDcardtextfiled.text;
        
    }
    if (self.nametextfiled.text.length < 2) {
        self.alearMyview.alearstr = @"姓名不能少于2位";
        return;
    }
    param[@"isDefault"] = [NSString stringWithFormat:@"%ld",(long)self.isdefut];
    param[@"name"] = self.nametextfiled.text;
    param[@"id"] = self.modle.myID;
    
    [YXNetworkHUD show];
    self.CommitBtn.userInteractionEnabled = NO;
    [YXRequestTool requestDataWithType:POST url:XIUGAIPICKUPPERSONINFORMATION_URL params:param success:^(id objc, id respodHeader) {
        
//        YXLog(@"+++++增加信息接口+%@+++++",objc);
        [YXNetworkHUD dismiss];
        self.CommitBtn.userInteractionEnabled = YES;
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            self.alearMyview.alearstr = objc;
        }
    } failure:^(NSError *error) {
        
        [YXNetworkHUD dismiss];
        self.CommitBtn.userInteractionEnabled = YES;
    }];

}
//**新增**/
-(void)addnewinformation
{
    if (![self checkparam]) {
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = self.nametextfiled.text;
    param[@"mobile"] =self.phonetextfiled.text;
    param[@"idCard"] =self.IDcardtextfiled.text;
    param[@"isDefault"] = @(self.isdefut);
    [YXNetworkHUD show];
    self.CommitBtn.userInteractionEnabled = NO;
    [YXRequestTool requestDataWithType:POST url:ADDPICKUPPERSONINFORMATION_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        self.CommitBtn.userInteractionEnabled = YES;
        
        
        YXLog(@"+++++增加信息接口+%@+++++",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            if ([self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
                
                [YXNotificationTool postNotificationName:@"formeAddNewPickInformationBack" object:nil userInfo:[self tranforDictKey:param cellid:(NSString* )objc]];
                [self.navigationController popToViewController:self.navigationController.childViewControllers[self.navigationController.childViewControllers.count-3] animated:YES];
                return ;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            self.alearMyview.alearstr = objc;
        }
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        self.CommitBtn.userInteractionEnabled = YES;
        
    }];
}
-(NSMutableDictionary *)tranforDictKey:(NSDictionary *)olddict cellid:(NSString *)cellid{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"idcard"] =  olddict[@"idCard"];
    dict[@"name"] = olddict[@"name"];
    dict[@"mobile"] = [YXStringFilterTool replaceStringWithAsterisk:olddict[@"mobile"] startLocation:3 lenght:4];
    dict[@"id"] = cellid;
    dict[@"isDefault"] = @"0";
    
    return dict;
}
/*
 @brief 检查参数
 */
-(BOOL)checkparam
{
    if (self.nametextfiled.text.length < 2) {
        
        self.alearMyview.alearstr = @"姓名不能为空";
        return NO;
    }
    else if(self.phonetextfiled.text.length ==0)
    {
        self.alearMyview.alearstr = @"手机号不能为空";
        return NO;
    }else if(![YXStringFilterTool filterByPhoneNumber:self.phonetextfiled.text])
    {
        self.alearMyview.alearstr = @"手机号格式不对";
        return NO;
    }
    
    else if(self.IDcardtextfiled.text.length)
    {
        if(![YXStringFilterTool filterCheckIDCard:self.IDcardtextfiled.text])
        {
            self.alearMyview.alearstr = @"身份证号格式不对";
            return NO;
        }

        
    }

    return YES;
}


#pragma mark  ******************* 添加键盘俯视图**********************
#pragma mark - 懒加载
- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class]) owner:nil options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}
#pragma mark - 代理方法

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.nametextfiled resignFirstResponder];
    [self.phonetextfiled resignFirstResponder];
    [self.IDcardtextfiled resignFirstResponder];
    
}

-(void)dealloc
{
    [YXNotificationTool removeObserver:self];
}


@end
