//
//  YXInbornTickByTickPayContentTableViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXInbornTickByTickPayContentTableViewController.h"
#import "YXPaymentHomepageViewDataModel.h"
#import "YXStringFilterTool.h"
#import "YXAlearFormMyView.h"

@interface YXInbornTickByTickPayContentTableViewController () <UITextFieldDelegate>

/**
 订单号label
 */
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

/**
 订单编号内容label
 */
@property (weak, nonatomic) IBOutlet UILabel *orderIdContentLabel;

/**
 订单总金额label
 */
@property (weak, nonatomic) IBOutlet UILabel *orderTotalAmountLabel;

/**
 订单总金额金额label
 */
@property (weak, nonatomic) IBOutlet UILabel *orderTotalAmountContentLabel;

/**
 订单支付方式label
 */
@property (weak, nonatomic) IBOutlet UILabel *orderPaymentTypeLabel;

/**
 订单支付方式内容label
 */
@property (weak, nonatomic) IBOutlet UILabel *orderPaymentTypeContentLabel;

/**
 支付方式logoImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *orderPaymentTypeImageView;

/**
 本次支付金额label
 */
@property (weak, nonatomic) IBOutlet UILabel *currentPaymentMoneyLabel;

/**
 币种label
 */
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

/**
 提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

/**
 全部支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *allPaymentButton;

/**
 分割线数组
 */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *spacingViewsArray;

/**
 分组视图
 */
@property (weak, nonatomic) IBOutlet UIView *groupMarginView;

/**
 支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *payButton;

/*
 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

/**
 支付方式logo右侧约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderPaymentLogoImageViewRightCons;

/**
 applePay闪付图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *applePayDetailImageView;

@end

@implementation YXInbornTickByTickPayContentTableViewController

#pragma mark - Zero.Const

BOOL isTestOFF = NO;

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 输入框输入内容

 @param sender 输入框
 */
- (IBAction)currentMoneyTextFieldEditingChanged:(UITextField *)sender
{
    if (!sender.text
        || [sender.text isEqualToString:@""]
        || sender.text.length == 0
        || sender.text.longLongValue >= 2000) {
        self.tipsLabel.font                         = YXRegularfont(11);
        self.tipsLabel.textColor                    = [UIColor surePaymentLightGrayTextColor];
        self.tipsLabel.text                         = [NSString stringWithFormat:@"剩余待付金额¥%@",
                                                       [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                                           self.dataModel.payAmount.longLongValue / 100]]];
        
        if (sender.text.longLongValue > self.dataModel.payAmount.longLongValue / 100) {
            sender.text                                 = [NSString stringWithFormat:@"%lld",
                                                           self.dataModel.payAmount.longLongValue / 100];
            self.tipsLabel.font                         = YXRegularfont(11);
            self.tipsLabel.textColor                    = [UIColor surePaymentLightGrayTextColor];
            self.tipsLabel.text                         = [NSString stringWithFormat:@"超过剩余金额¥%@",
                                                           [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                                               self.dataModel.payAmount.longLongValue / 100]]];
            return;
        }
        
    }else{
        self.tipsLabel.text                         = @"金额低于最低分笔限额，单笔不能低于¥2,000";
        self.tipsLabel.textColor                    = [UIColor themGoldColor];
    }
}

/**
 edit end

 @param sender 用户输入分币金额
 */
- (IBAction)currentMoneyTextFieldDidEnd:(UITextField *)sender
{
    
}

/**
 全部支付按钮点击事件

 @param sender 点击的按钮
 */
- (IBAction)allPaymentButtonClick:(UIButton *)sender
{
    self.currentMoneyTextField.text = [NSString stringWithFormat:@"%lld", self.dataModel.payAmount.longLongValue / 100];
    [self.currentMoneyTextField resignFirstResponder];
}

/**
 确认支付点击事件

 @param sender 点击支付按钮
 */
- (IBAction)sureButtonClick:(UIButton *)sender
{
    if ([self.currentMoneyTextField.text isEqualToString:@""]
        || self.currentMoneyTextField.text.length == 0) {
        self.alearMyview.alearstr = @"请输入分笔金额";
        return;
    }
    
    if (!isTestOFF) {
        if (!self.currentMoneyTextField.text
            || [self.currentMoneyTextField.text isEqualToString:@""]
            || self.currentMoneyTextField.text.length == 0
            || self.currentMoneyTextField.text.longLongValue < 2000) {
            self.alearMyview.alearstr = @"金额低于最低分笔限额，单笔不能低于¥2,000";
            return;
        }
    }
    
    if ([_customDelegate respondsToSelector:@selector(inbornTickByTickPayContentTableViewController:clickButton:)]) {
        [_customDelegate inbornTickByTickPayContentTableViewController:self clickButton:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark <UITextFieldDelegate>

/**
 监听输入框

 @param textField 输入框
 @param range 范围
 @param string 输入的文字
 @return 返回是否可以输入
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    long long userScanfMoney = [NSString stringWithFormat:@"%@%@",
//                                textField.text,
//                                string].longLongValue;
//    YXLog(@"%lld",userScanfMoney);

    
    return YES;
}

#pragma mark - Fifth.控制器生命周期

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupCustomUI];
}

/**
 视图即将出现

 @param animated animated
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.currentMoneyTextField becomeFirstResponder];
}

/**
 试图即将离开

 @param animated animated
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.currentMoneyTextField resignFirstResponder];
}

#pragma mark - Sixth.界面配置

/**
 配置自定义界面
 */
- (void)setupCustomUI
{
    self.automaticallyAdjustsScrollViewInsets   = NO;
    self.tableView.keyboardDismissMode          = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.orderIdLabel.font                      = YXRegularfont(12);
    self.orderIdLabel.textColor                 = [UIColor orderTextColor];
    self.orderIdLabel.text                      = @"订单号：";
    
    self.orderIdContentLabel.font               = self.orderIdLabel.font;
    self.orderIdContentLabel.textColor          = self.orderIdLabel.textColor;
    self.orderIdContentLabel.text               = self.dataModel.orderId;
    
    self.orderTotalAmountLabel.font             = YXRegularfont(13);
    self.orderTotalAmountLabel.textColor        = [UIColor surePaymentLightGrayTextColor];
    self.orderTotalAmountLabel.text             = @"订单总金额：";
    
    self.orderTotalAmountContentLabel.font      = self.orderTotalAmountLabel.font;
    self.orderTotalAmountContentLabel.textColor = [UIColor themGoldColor];
    self.orderTotalAmountContentLabel.text      = [NSString stringWithFormat:@"¥%@",
                                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                                       self.dataModel.totalAmount.longLongValue / 100]]];
    
    self.orderPaymentTypeLabel.font             = YXRegularfont(14);
    self.orderPaymentTypeLabel.text             = @"支付方式";
    self.orderPaymentTypeLabel.textColor        = [UIColor orderTextColor];
    
    self.orderPaymentTypeContentLabel.font      = self.orderPaymentTypeLabel.font;
    self.orderPaymentTypeContentLabel.textColor = self.orderPaymentTypeLabel.textColor;
    self.orderPaymentTypeContentLabel.text      = self.dataModel.paymentTypeString;
    
    self.orderPaymentTypeImageView.image        = [UIImage imageNamed:self.dataModel.paymentLogoImageNamed];
    
    self.currentPaymentMoneyLabel.font          = YXRegularfont(10);
    self.currentPaymentMoneyLabel.textColor     = [UIColor surePaymentLightGrayTextColor];
    self.currentPaymentMoneyLabel.text          = @"本次分笔支付金额";
    
    self.currencyLabel.font                     = YXRegularfont(20);
    self.currencyLabel.textColor                = [UIColor orderTextColor];
    self.currencyLabel.text                     = @"¥";
    
    self.currentMoneyTextField.font             = [UIFont systemFontOfSize:20.f];
    
    self.tipsLabel.font                         = YXRegularfont(11);
    self.tipsLabel.textColor                    = [UIColor surePaymentLightGrayTextColor];
    self.tipsLabel.text                         = [NSString stringWithFormat:@"剩余待付金额¥%@",
                                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                                       self.dataModel.payAmount.longLongValue / 100]]];
    
    self.currentMoneyTextField.delegate         = self;
    
    [self.payButton setBackgroundColor:[UIColor mainThemColor]];
    [self.payButton setTitle:self.dataModel.paymentTypeButtonString forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payButton.titleLabel.font              = YXRegularfont(17);
    
    [self.allPaymentButton setTitle:@"全额支付" forState:UIControlStateNormal];
    self.allPaymentButton.titleLabel.font       = YXRegularfont(11);
    
    self.groupMarginView.backgroundColor        = [UIColor themLightGrayColor];
    [self.spacingViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *lineView                        = (UIView *)obj;
        lineView.backgroundColor                = [UIColor themGrayColor];
    }];
    
    //** 当应付金额小于2000以后，关闭输入框用户交互，并显示支付金额 */
    if (self.dataModel.payAmount.longLongValue <= 2000) {
        self.currentMoneyTextField.userInteractionEnabled       = NO;
        self.currentMoneyTextField.text                         = [NSString stringWithFormat:@"%lld",
                                                                   self.dataModel.payAmount.longLongValue / 100];
    }
    
    if ([self.dataModel.paymentTypeString isEqualToString:@"Apple Pay"]) {
        self.applePayDetailImageView.hidden                     = NO;
        self.orderPaymentLogoImageViewRightCons.constant        = 132.5f;
    }else{
        self.applePayDetailImageView.hidden                     = YES;
        self.orderPaymentLogoImageViewRightCons.constant        = 12.5f;
    }
}

#pragma mark - Seventh.懒加载

-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        
        _alearMyview.frame = CGRectMake(YXScreenW*0.2, CGRectGetMinY([self.currentMoneyTextField convertRect:self.currentMoneyTextField.bounds toView:self.view]) - self.currentMoneyTextField.height * 0.5, YXScreenW*0.6, 30);
        _alearMyview.alpha = 0;
        _alearMyview.time = 5.0f;
    }
    return _alearMyview;
}

@end
