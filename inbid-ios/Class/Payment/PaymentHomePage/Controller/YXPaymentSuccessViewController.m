//
//  YXPaymentSuccessViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPaymentSuccessViewController.h"
#import "YXOrderDetailViewController.h"
#import "AppDelegate.h"
#import "YXPaymentHomepageViewDataModel.h"

@interface YXPaymentSuccessViewController ()

/**
 titleButton
 */
@property (nonatomic, strong) UIButton *titleButton;

/**
 paymentTypeLabel
 */
@property (nonatomic, strong) UILabel *paymentTypeLabel;

/**
 paymentTypeContentLabel
 */
@property (nonatomic, strong) UILabel *paymentTypeContentLabel;

/**
 paymentAmountLabel
 */
@property (nonatomic, strong) UILabel *paymentAmountLabel;

/**
 paymentAmountContentLabel
 */
@property (nonatomic, strong) UILabel *paymentAmountContentLabel;

/**
 surplusAmountLabel
 */
@property (nonatomic, strong) UILabel *surplusAmountLabel;

/**
 surplusAmountContentLabel
 */
@property (nonatomic, strong) UILabel *surplusAmountContentLabel;

/**
 tipsLabel
 */
@property (nonatomic, strong) UILabel *tipsLabel;

/**
 查看详情按钮
 */
@property (nonatomic, strong) UIButton *checkDetailButton;

/**
 otherButton
 */
@property (nonatomic, strong) UIButton *otherButton;

/**
 applePayDetailImageView
 */
@property (nonatomic, strong) UIImageView *applePayDetailImageView;

@end

@implementation YXPaymentSuccessViewController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 取消按钮点击事件

 @param sender 取消按钮
 */
- (void)backButtonClick:(UIButton *)sender
{
    [self pushOrderDetailController];
}

/**
 其他功能按钮点击事件

 @param sender 点击的按钮
 */
- (void)otherButtonClick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"去首页逛逛"]) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"继续支付"]) {
        [self.navigationController
         popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3]
         animated:YES];
        return;
    }
}

/**
 查看详情按钮点击事件

 @param sender 查看详情
 */
- (void)checkDetailButtonClick:(UIButton *)sender
{
    [self pushOrderDetailController];
}

/**
 跳转订单详情页面
 */
- (void)pushOrderDetailController
{
    YXOrderDetailViewController *detailController = [YXOrderDetailViewController orderDetailViewControllerWithOrderId:self.paymentBaseDataModel.orderId.longLongValue andExtend:self];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomUI];
}

/**
 子控件布局完毕
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //** =========================================================================================== */
    //** ============================================公用=========================================== */
    //** =========================================================================================== */
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(103);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
    }];
    
    [self.paymentTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleButton.mas_bottom).mas_offset(58.5);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.paymentTypeContentLabel.mas_left);
    }];
    
    [self.paymentTypeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.paymentTypeLabel);
        make.width.mas_equalTo(self.paymentTypeLabel);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.paymentAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.paymentTypeLabel.mas_bottom).mas_offset(17);
        make.left.mas_equalTo(self.paymentTypeLabel);
        make.right.mas_equalTo(self.paymentAmountContentLabel.mas_left);
    }];
    
    [self.paymentAmountContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.paymentAmountLabel);
        make.width.mas_equalTo(self.paymentTypeLabel);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.surplusAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.paymentAmountLabel.mas_bottom).mas_offset(17);
        make.left.mas_equalTo(self.paymentAmountLabel);
        make.right.mas_equalTo(self.surplusAmountContentLabel.mas_left);
    }];
    
    [self.surplusAmountContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.surplusAmountLabel);
        make.width.mas_equalTo(self.surplusAmountLabel);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(82);
        make.right.mas_equalTo(self.view).mas_offset(-82);
        make.top.mas_equalTo(self.surplusAmountLabel.mas_bottom).mas_offset(46);
    }];
    
    [self.applePayDetailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.titleButton.mas_bottom).mas_equalTo(13);
    }];
    
    //** =========================================================================================== */
    //** ==========================================全额支付========================================== */
    //** =========================================================================================== */
    if (self.type == YXPaymentSuccessViewControllerAllPayment
        || self.type == YXPaymentSuccessViewControllerPartDepositExcept) {
        
        [self.checkDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(17);
            make.top.mas_equalTo(self.paymentAmountLabel.mas_bottom).mas_offset(46);
            make.height.mas_equalTo(44);
            make.right.mas_equalTo(self.otherButton.mas_left).mas_offset(-5);
        }];
        
        [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.top.mas_equalTo(self.checkDetailButton);
            make.right.mas_equalTo(self.view).mas_offset(-17);
        }];
        
        return;
    }
    
    //** =========================================================================================== */
    //** ==========================================分笔支付========================================== */
    //** =========================================================================================== */
    if (self.type == YXPaymentSuccessViewControllerPartPayment
        || self.type == YXPaymentSuccessViewControllerPartDepositExcept_partPayment) {
        
        if ([self checkIsLastOrderPaymentWithCurrentMoney:self.paymentBaseDataModel.userPartAmountString.longLongValue]) {
            [self.checkDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.view);
                make.height.mas_equalTo(44);
                make.top.mas_equalTo(self.tipsLabel.mas_bottom).mas_offset(46);
                make.width.mas_equalTo(120);
            }];
        }else{
            [self.checkDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.view).mas_offset(17);
                make.top.mas_equalTo(self.tipsLabel.mas_bottom).mas_offset(46);
                make.height.mas_equalTo(44);
                make.right.mas_equalTo(self.otherButton.mas_left).mas_offset(-5);
            }];
            
            [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.top.mas_equalTo(self.checkDetailButton);
                make.right.mas_equalTo(self.view).mas_offset(-17);
            }];
        }
        return;
    }
    
    //** =========================================================================================== */
    //** ===========================================定金支付========================================== */
    //** =========================================================================================== */
    if (self.type == YXPaymentSuccessViewControllerPartDeposit) {
        
        [self.checkDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(168);
            make.top.mas_equalTo(self.tipsLabel.mas_bottom).mas_offset(46);
        }];
        
        return;
    }
}

/**
 查看是否是最后一单

 @return 返回 YES是 NO否
 */
- (BOOL)checkIsLastOrderPaymentWithCurrentMoney:(long long)currentMoney
{
    //** 判断是否支付完最后一笔 */
    if (self.paymentBaseDataModel.isPayedDeposit == 0) {
        if (self.paymentBaseDataModel.totalAmount.longLongValue == self.paymentBaseDataModel.alreadyPayAmount.longLongValue + currentMoney) {
            return YES;
        }else{
            return NO;
        }
    }
    
    if (self.paymentBaseDataModel.isPayedDeposit == 1) {
        if (self.paymentBaseDataModel.totalAmount.longLongValue == self.paymentBaseDataModel.alreadyPayAmount.longLongValue + currentMoney + self.paymentBaseDataModel.depositPrice) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

/**
 配置label

 @param title title 内容
 */
- (void)setupLabelWithTitle:(NSString *)title
                   andLabel:(UILabel *)label
{
    label.text = title;
}

#pragma mark - Sixth.界面配置

/**
 配置自定义界面
 */
- (void)setupCustomUI
{
    //** =========================================================================================== */
    //** ============================================公用=========================================== */
    //** =========================================================================================== */
    [self.view addSubview:self.titleButton];
    [self.view addSubview:self.paymentTypeLabel];
    [self.view addSubview:self.paymentTypeContentLabel];
    [self.view addSubview:self.paymentAmountLabel];
    [self.view addSubview:self.paymentAmountContentLabel];
    [self.view addSubview:self.surplusAmountLabel];
    [self.view addSubview:self.surplusAmountContentLabel];
    [self.view addSubview:self.checkDetailButton];
    [self.view addSubview:self.otherButton];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.applePayDetailImageView];
    self.view.backgroundColor                       = [UIColor whiteColor];
    self.title                                      = @"订单支付结果";
    
    UIButton *leftButton                            = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"矩形-15-拷贝"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    UIBarButtonItem *leftButtonItem                 = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem           = leftButtonItem;
    
    //** =========================================================================================== */
    //** =========================================apple pay======================================== */
    //** =========================================================================================== */
    if (self.paymentBaseDataModel.paymentType == 4) {
        self.applePayDetailImageView.hidden = NO;
    }
    
    //** =========================================================================================== */
    //** ==========================================全f额支付========================================== */
    //** ========================================================================================== */
    if (self.type == YXPaymentSuccessViewControllerAllPayment
        || self.type == YXPaymentSuccessViewControllerPartDepositExcept) {
        [self.otherButton setTitle:@"去首页逛逛" forState:UIControlStateNormal];
        
        self.surplusAmountLabel.hidden              = YES;
        self.surplusAmountContentLabel.hidden       = self.surplusAmountLabel.hidden;
        self.tipsLabel.hidden                       = YES;
        
        [self setupLabelWithTitle:@"支付方式："
                         andLabel:self.paymentTypeLabel];
        [self setupLabelWithTitle:self.paymentBaseDataModel.paymentTypeString
                         andLabel:self.paymentTypeContentLabel];
        
        [self setupLabelWithTitle:@"支付金额："
                         andLabel:self.paymentAmountLabel];
        [self setupLabelWithTitle:[NSString stringWithFormat:@"¥%@",
                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                       self.paymentBaseDataModel.payAmount.longLongValue / 100]]]
                         andLabel:self.paymentAmountContentLabel];
        
        return;
    }
    
    //** =========================================================================================== */
    //** ==========================================分笔支付========================================== */
    //** =========================================================================================== */
    if (self.type == YXPaymentSuccessViewControllerPartPayment
        || self.type == YXPaymentSuccessViewControllerPartDepositExcept_partPayment) {
        
        [self setupLabelWithTitle:@"支付方式："
                         andLabel:self.paymentTypeLabel];
        [self setupLabelWithTitle:self.paymentBaseDataModel.paymentTypeString
                         andLabel:self.paymentTypeContentLabel];
        
        [self setupLabelWithTitle:@"支付金额："
                         andLabel:self.paymentAmountLabel];
        
        [self setupLabelWithTitle:[NSString stringWithFormat:@"¥%@",
                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                       self.paymentBaseDataModel.userPartAmountString.longLongValue / 100]]]
                         andLabel:self.paymentAmountContentLabel];
        
        //** 判断是否支付完毕 */
        if ([self checkIsLastOrderPaymentWithCurrentMoney:self.paymentBaseDataModel.userPartAmountString.longLongValue]) {
            
            //** 判断是否支付过定金 */
            NSString *currentAlreadyPrice;
            if (self.paymentBaseDataModel.isPayedDeposit == 0) {
                currentAlreadyPrice = [NSString stringWithFormat:@"¥%@",
                                       [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                           (self.paymentBaseDataModel.alreadyPayAmount.longLongValue + self.paymentBaseDataModel.userPartAmountString.longLongValue) / 100]]];
            }
            
            if (self.paymentBaseDataModel.isPayedDeposit == 1) {
                currentAlreadyPrice = [NSString stringWithFormat:@"¥%@",
                                       [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                           (self.paymentBaseDataModel.alreadyPayAmount.longLongValue + self.paymentBaseDataModel.depositPrice + self.paymentBaseDataModel.userPartAmountString.longLongValue) / 100]]];
            }
            
            [self setupLabelWithTitle:@"累计支付金额："
                             andLabel:self.surplusAmountLabel];
            [self setupLabelWithTitle:currentAlreadyPrice
                             andLabel:self.surplusAmountContentLabel];
            
            [self setupLabelWithTitle:@"已支付全部货款，平台将在48小时内为您安排发货\n可到“我的”-“我购买的”中查看订单状态"
                             andLabel:self.tipsLabel];
        }else{
            
            NSString *currentSurplusPrice;
            if (self.paymentBaseDataModel.isPayedDeposit == 0) {
                currentSurplusPrice = [NSString stringWithFormat:@"¥%@",
                                       [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                           (self.paymentBaseDataModel.totalAmount.longLongValue - (self.paymentBaseDataModel.alreadyPayAmount.longLongValue + self.paymentBaseDataModel.userPartAmountString.longLongValue))/100]]];
            }
            
            if (self.paymentBaseDataModel.isPayedDeposit == 1) {
                currentSurplusPrice = [NSString stringWithFormat:@"¥%@",
                                       [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                           (self.paymentBaseDataModel.totalAmount.longLongValue - (self.paymentBaseDataModel.alreadyPayAmount.longLongValue + self.paymentBaseDataModel.userPartAmountString.longLongValue) - self.paymentBaseDataModel.depositPrice)/100]]];
            }
            
            [self setupLabelWithTitle:@"剩余应付金额："
                             andLabel:self.surplusAmountLabel];
            [self setupLabelWithTitle:currentSurplusPrice
                             andLabel:self.surplusAmountContentLabel];
            
            [self setupLabelWithTitle:@"剩余应付金额需在48小时内完成支付，如未及时支付订单将关闭"
                             andLabel:self.tipsLabel];
        
        }
        
        return;
    }
   
    //** =========================================================================================== */
    //** ===========================================定金支付========================================== */
    //** =========================================================================================== */
    if (self.type == YXPaymentSuccessViewControllerPartDeposit) {
        
        [self setupLabelWithTitle:@"支付方式："
                         andLabel:self.paymentTypeLabel];
        [self setupLabelWithTitle:self.paymentBaseDataModel.paymentTypeString
                         andLabel:self.paymentTypeContentLabel];
        
        [self setupLabelWithTitle:@"支付定金："
                         andLabel:self.paymentAmountLabel];
        [self setupLabelWithTitle:[NSString stringWithFormat:@"¥%@",
                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                       self.paymentBaseDataModel.depositPrice / 100]]]
                         andLabel:self.paymentAmountContentLabel];
       
        [self setupLabelWithTitle:@"剩余尾款："
                         andLabel:self.surplusAmountLabel];
        [self setupLabelWithTitle:[NSString stringWithFormat:@"¥%@",
                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                       (self.paymentBaseDataModel.totalAmount.longLongValue - self.paymentBaseDataModel.depositPrice) / 100]]]
                         andLabel:self.surplusAmountContentLabel];
       
        [self setupLabelWithTitle:@"剩余尾款需在48小时内完成支付，如未及时支付订单将关闭，已付定金不予退还\n可在“我的”-“我购买的”中查看订单详情更换其他方式付款"
                         andLabel:self.tipsLabel];
        return;
    }
}

#pragma mark - Seventh.懒加载

- (UIImageView *)applePayDetailImageView
{
    if (!_applePayDetailImageView) {
        _applePayDetailImageView                    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_ApplePay_detailImage"]];
        _applePayDetailImageView.hidden             = YES;
    }
    return _applePayDetailImageView;
}

- (UIButton *)otherButton
{
    if (!_otherButton) {
        _otherButton                                = [UIButton new];
        _otherButton.backgroundColor                = [UIColor mainThemColor];
        _otherButton.layer.cornerRadius             = 4.f;
        _otherButton.layer.masksToBounds            = YES;
        [_otherButton setTitle:@"继续支付"
                      forState:UIControlStateNormal];
        [_otherButton addTarget:self
                         action:@selector(otherButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherButton;
}

- (UIButton *)checkDetailButton
{
    if (!_checkDetailButton) {
        _checkDetailButton                          = [UIButton new];
        _checkDetailButton.backgroundColor          = [UIColor mainThemColor];
        _checkDetailButton.layer.cornerRadius       = 4.f;
        _checkDetailButton.layer.masksToBounds      = YES;
        [_checkDetailButton setTitle:@"查看订单详情"
                            forState: UIControlStateNormal];
        [_checkDetailButton addTarget:self
                               action:@selector(checkDetailButtonClick:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkDetailButton;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel                                  = [UILabel new];
        _tipsLabel.font                             = YXRegularfont(10);
        _tipsLabel.text                             = @"测试";
        _tipsLabel.textColor                        = [UIColor surePaymentLightGrayTextColor];
        _tipsLabel.textAlignment                    = NSTextAlignmentCenter;
        _tipsLabel.numberOfLines                    = 0;
    }
    return _tipsLabel;
}

- (UILabel *)surplusAmountContentLabel
{
    if (!_surplusAmountContentLabel) {
        _surplusAmountContentLabel                  = [UILabel new];
        _surplusAmountContentLabel.font             = YXRegularfont(13);
        _surplusAmountContentLabel.text             = @"测试";
        _surplusAmountContentLabel.textColor        = [UIColor themGoldColor];
    }
    return _surplusAmountContentLabel;
}

- (UILabel *)surplusAmountLabel
{
    if (!_surplusAmountLabel) {
        _surplusAmountLabel                         = [UILabel new];
        _surplusAmountLabel.font                    = YXRegularfont(13);
        _surplusAmountLabel.text                    = @"测试";
        _surplusAmountLabel.textColor               = [UIColor orderTextColor];
        _surplusAmountLabel.textAlignment           = NSTextAlignmentRight;
    }
    return _surplusAmountLabel;
}

- (UILabel *)paymentAmountContentLabel
{
    if (!_paymentAmountContentLabel) {
        _paymentAmountContentLabel                  = [UILabel new];
        _paymentAmountContentLabel.font             = YXRegularfont(13);
        _paymentAmountContentLabel.text             = @"测试";
        _paymentAmountContentLabel.textColor        = [UIColor themGoldColor];
    }
    return _paymentAmountContentLabel;
}

- (UILabel *)paymentAmountLabel
{
    if (!_paymentAmountLabel) {
        _paymentAmountLabel                         = [UILabel new];
        _paymentAmountLabel.font                    = YXRegularfont(13);
        _paymentAmountLabel.text                    = @"测试";
        _paymentAmountLabel.textColor               = [UIColor orderTextColor];
        _paymentAmountLabel.textAlignment           = NSTextAlignmentRight;
    }
    return _paymentAmountLabel;
}

- (UILabel *)paymentTypeContentLabel
{
    if (!_paymentTypeContentLabel) {
        _paymentTypeContentLabel                    = [UILabel new];
        _paymentTypeContentLabel.font               = YXRegularfont(13);
        _paymentTypeContentLabel.text               = @"测试";
        _paymentTypeContentLabel.textColor          = [UIColor themGoldColor];
    }
    return _paymentTypeContentLabel;
}

- (UILabel *)paymentTypeLabel
{
    if (!_paymentTypeLabel) {
        _paymentTypeLabel                           = [UILabel new];
        _paymentTypeLabel.font                      = YXRegularfont(13);
        _paymentTypeLabel.text                      = @"测试";
        _paymentTypeLabel.textColor                 = [UIColor orderTextColor];
        _paymentTypeLabel.textAlignment             = NSTextAlignmentRight;
    }
    return _paymentTypeLabel;
}

- (UIButton *)titleButton
{
    if (!_titleButton) {
        _titleButton                                = [UIButton new];
        _titleButton.titleEdgeInsets                = UIEdgeInsetsMake(0, 15, 0, 0);
        _titleButton.userInteractionEnabled         = NO;
        _titleButton.titleLabel.font                = [UIFont systemFontOfSize:18.f];
        [_titleButton setImage:[UIImage imageNamed:@"ic_orderDetail_right"]
                      forState:UIControlStateNormal];
        [_titleButton setTitle:@"已成功付款"
                      forState: UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor orderTextColor]
                           forState:UIControlStateNormal];
    }
    return _titleButton;
}

@end
