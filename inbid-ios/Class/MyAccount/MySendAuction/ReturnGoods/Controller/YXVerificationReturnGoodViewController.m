//
//  YXVerificationReturnGoodViewController.m
//  inbid-ios
//
//  Created by 郑键 on 17/3/7.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXVerificationReturnGoodViewController.h"
#import "YXMyAccountURLMacros.h"
#import "YXStringFilterTool.h"
#import "YXAlertViewTool.h"

@interface YXVerificationReturnGoodViewController ()

/**
 登录密码title
 */
@property (weak, nonatomic) IBOutlet UILabel *pwdTitleLabel;

/**
 密码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

/**
 身份证后8位label
 */
@property (weak, nonatomic) IBOutlet UILabel *idCardTitleLabel;

/**
 身份证输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;

/**
 确认按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

/**
 提示Label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

/**
 客服电话Label
 */
@property (weak, nonatomic) IBOutlet UILabel *customerServiceLabel;

/**
 分割线集合
 */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *marginLineViews;

@end

@implementation YXVerificationReturnGoodViewController

#pragma mark - First.通知

/**
 接收到输入框内容改变通知
 
 @param no              通知内容
 */
- (void)textFieldDidChange:(NSNotification *)no
{
    if (self.pwdTextField.text.length == 0
        || [self.pwdTextField.text isEqualToString:@""]
        || self.idCardTextField.text.length == 0
        || [self.idCardTextField.text isEqualToString:@""]
        || self.idCardTextField.text.length < 8) {
        
        self.sureButton.enabled = NO;
    }else{
        self.sureButton.enabled = YES;
    }
}

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 确定按钮点击事件

 @param sender sender
 */
- (IBAction)sureButtonClick:(UIButton *)sender
{
    if (self.pwdTextField.text.length == 0
        || [self.pwdTextField.text isEqualToString:@""]) {
        [self showTipsWithObjc:@{@"errorMsg":@"请输入登录密码"}];
        return;
    }
    
    if (self.idCardTextField.text.length == 0
        || [self.idCardTextField.text isEqualToString:@""]) {
        [self showTipsWithObjc:@{@"errorMsg":@"请输入认证用户身份证后8位"}];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(verificationReturnGoodViewController:clickButton:loginPassword:idCard:)]) {
        [self.delegate verificationReturnGoodViewController:self
                                                clickButton:sender
                                              loginPassword:[YXStringFilterTool getSha1String:self.pwdTextField.text]
                                                     idCard:self.idCardTextField.text];
    }
}

/**
 显示提示
 
 @param objc objc
 */
- (void)showTipsWithObjc:(id)objc
{
    if ([objc[@"errorMsg"] isKindOfClass:[NSString class]]) {
        
        [YXAlertViewTool showAlertView:self title:@"提示" message:objc[@"errorMsg"] confrimBlock:^{
            
        }];
        
        return;
    }
    
    NSDictionary *errorMsg;
    NSString *ret_msg;
    @try {
        errorMsg = objc[@"errorMsg"];
        ret_msg = errorMsg[@"ret_msg"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [YXAlertViewTool showAlertView:self title:@"提示" message:ret_msg confrimBlock:^{
        
    }];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomUI];
    [self loadData];
    [self registerNotification];
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
 自定义UI界面
 */
- (void)setupCustomUI
{
    self.title                                  = @"安全验证";
    self.view.backgroundColor                   = [UIColor themLightGrayColor];
    
    self.pwdTitleLabel.font                     = REGULAR_FONT(13.f);
    self.pwdTitleLabel.backgroundColor          = [UIColor themLightGrayColor];
    self.idCardTitleLabel.font                  = self.pwdTitleLabel.font;
    self.idCardTitleLabel.backgroundColor       = self.pwdTitleLabel.backgroundColor;
    self.pwdTitleLabel.text                     = @"请输入登录密码";
    self.idCardTitleLabel.text                  = @"";
    
    [self.sureButton setTitle:@"确认"
                     forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"background"]
                               forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageNamed:@"ic_register_disBg"]
                               forState:UIControlStateDisabled];
    self.sureButton.layer.cornerRadius          = 4.f;
    self.sureButton.layer.masksToBounds         = YES;
    self.sureButton.enabled                     = NO;
    
    self.tipsLabel.font                         = REGULAR_FONT(13.f);
    self.tipsLabel.backgroundColor              = [UIColor themLightGrayColor];
    self.tipsLabel.textColor                    = [UIColor walletTextLightColor];
    self.customerServiceLabel.font              = self.tipsLabel.font;
    self.customerServiceLabel.backgroundColor   = self.tipsLabel.backgroundColor;
    self.customerServiceLabel.textColor         = self.tipsLabel.textColor;
    self.tipsLabel.text                         = @"1.为了保障您的资金、物品安全，请进行安全验证。";

    NSString *customerPhoneNumber               = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSString *secondTipsText                    = @"2.如需帮助，可联系客服";
    [self setupLabelAttrbuteStringWithText:[NSString stringWithFormat:@"%@%@",
                                            secondTipsText,
                                            customerPhoneNumber]
                              andFistColor:self.tipsLabel.textColor
                          andFirstFontSize:13.f
                            andSecondColor:[UIColor systemButtonTextColor]
                         andSecondFontSize:13.f
                          andFirstRangeLoc:0
                          andFirstRangeLen:secondTipsText.length
                         andSecondRangeLoc:secondTipsText.length
                         andSecondRangeLen:customerPhoneNumber.length
                                  andLabel:self.customerServiceLabel];
    
    self.pwdTextField.keyboardType              = UIKeyboardTypeASCIICapable;
    self.idCardTextField.keyboardType           = UIKeyboardTypeASCIICapable;
    
    UIView *leftView                            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.pwdTextField.backgroundColor           = [UIColor whiteColor];
    self.pwdTextField.leftViewMode              = UITextFieldViewModeAlways;
    self.pwdTextField.leftView                  = leftView;
    self.pwdTextField.secureTextEntry           = YES;
    self.pwdTextField.clearButtonMode           = UITextFieldViewModeWhileEditing;
    UIView *leftView2                           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.idCardTextField.backgroundColor        = [UIColor whiteColor];
    self.idCardTextField.leftViewMode           = UITextFieldViewModeAlways;
    self.idCardTextField.leftView               = leftView2;
    self.idCardTextField.clearButtonMode        = UITextFieldViewModeWhileEditing;
    self.idCardTextField.autocorrectionType     = UITextAutocorrectionTypeNo;
    
    [self.marginLineViews enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.backgroundColor = [UIColor themGrayColor];
    }];
}

/**
 设置富文本label
 
 @param text                文字
 @param firstColor          第一种颜色
 @param firstFontSize       第一种字体大小
 @param secondColor         第二种文字颜色
 @param secondFontSize      第二种文字
 @param FirstRangeLoc       第一起点
 @param FirstRangeLen       第一长度
 @param SecondRangeLoc      第二起点
 @param SecondRangeLen      第二长度
 @param label label
 */
- (void)setupLabelAttrbuteStringWithText:(NSString *)text
                            andFistColor:(UIColor *)firstColor
                        andFirstFontSize:(CGFloat)firstFontSize
                          andSecondColor:(UIColor *)secondColor
                       andSecondFontSize:(CGFloat)secondFontSize
                        andFirstRangeLoc:(NSUInteger)firstRangeLoc
                        andFirstRangeLen:(NSUInteger)firstRangeLen
                       andSecondRangeLoc:(NSUInteger)secondRangeLoc
                       andSecondRangeLen:(NSUInteger)secondRangeLen
                                andLabel:(UILabel *)label
{
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:text];
    [attrM addAttribute:NSForegroundColorAttributeName
                  value:firstColor
                  range:NSMakeRange(firstRangeLoc, firstRangeLen)];
    [attrM addAttribute:NSFontAttributeName
                  value:REGULAR_FONT(firstFontSize)
                  range:NSMakeRange(firstRangeLoc, firstRangeLen)];
    
    
    [attrM addAttribute:NSForegroundColorAttributeName
                  value:secondColor
                  range:NSMakeRange(secondRangeLoc, secondRangeLen)];
    [attrM addAttribute:NSFontAttributeName
                  value:REGULAR_FONT(secondFontSize)
                  range:NSMakeRange(secondRangeLoc, secondRangeLen)];
    
    label.attributedText = attrM;
}

#pragma mark - Seventh.懒加载

#pragma mark - Eight.LoadData

- (void)loadData
{
    [YXRequestTool requestDataWithType:POST url:QUERYRANLNAMESTATUS_URL params:nil success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            self.idCardTitleLabel.text = [NSString stringWithFormat:@"请输入认证用户%@身份证号码后8位",
                                          objc[@"name"]];
        }
        
    } failure:^(NSError *error) {
        YXLog(@"%@",error);
    }];
}

@end
