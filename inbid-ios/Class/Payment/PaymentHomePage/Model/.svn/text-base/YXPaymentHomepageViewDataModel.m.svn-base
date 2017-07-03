//
//  YXPaymentHomepageViewDataModel.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPaymentHomepageViewDataModel.h"

@implementation YXPaymentHomepageViewDataModel

/**
 是否是定金支付

 @return 返回是否是定金支付
 */
- (NSInteger)isCurrentDepositPay
{
    if (!_isCurrentDepositPay) {
        if (self.paymentControllerType == YXPaymentHomePageControllerDeposit) _isCurrentDepositPay = 1;
        if (self.paymentControllerType != YXPaymentHomePageControllerDeposit) _isCurrentDepositPay = 0;
    }
    return _isCurrentDepositPay;
}

/**
 是否是分笔支付

 @return 返回是否是分笔支付
 */
- (NSInteger)isPartPay
{
    if (!_isPartPay) {
        
        //** 分笔支付 */
        if (self.paymentControllerType == YXPaymentHomePageControllerBidGood_partPayment
            || self.paymentControllerType == YXPaymentHomePageControllerFixGood_partPayment
            || self.paymentControllerType == YXPaymentHomePageControllerDepositExcept_partPayment) _isPartPay = 1;
        
        //** 全额支付 */
        if (self.paymentControllerType == YXPaymentHomePageControllerIdentifyCost
            || self.paymentControllerType == YXPaymentHomePageControllerBidGood
            || self.paymentControllerType == YXPaymentHomePageControllerBond
            || self.paymentControllerType == YXPaymentHomePageControllerFixGood
            || self.paymentControllerType == YXPaymentHomePageControllerDeposit
            || self.paymentControllerType == YXPaymentHomePageControllerDepositExcept) {
            _isPartPay = 0;
        }
        
    }
    return _isPartPay;
}

/**
 事务类型

 @return 返回事务类型
 */
- (NSInteger)transType
{
    if (self.paymentControllerType == YXPaymentHomePageControllerIdentifyCost) {
        //** 鉴定费 */
        _transType = 1;
    }
    
    if (self.paymentControllerType == YXPaymentHomePageControllerBidGood
        || self.paymentControllerType == YXPaymentHomePageControllerBidGood_partPayment) {
        //** 拍卖订单 */
        _transType = 2;
    }
    
    if (self.paymentControllerType == YXPaymentHomePageControllerBond) {
        //** 保证金 */
        _transType = 3;
    }
    
    if (self.paymentControllerType == YXPaymentHomePageControllerFixGood
        || self.paymentControllerType == YXPaymentHomePageControllerFixGood_partPayment
        || self.paymentControllerType == YXPaymentHomePageControllerDeposit
        || self.paymentControllerType == YXPaymentHomePageControllerDepositExcept
        || self.paymentControllerType == YXPaymentHomePageControllerDepositExcept_partPayment) {
        //** 一口价&定金支付 */
        _transType = 4;
    }
    return _transType;
}

/**
 支付方式文字

 @return 返回支付方式文字
 */
- (NSString *)paymentTypeString
{
    if (self.paymentType == 1) _paymentTypeString = @"PC扫码支付";
    if (self.paymentType == 2) _paymentTypeString = @"微信支付";
    if (self.paymentType == 3) _paymentTypeString = @"支付宝支付";
    if (self.paymentType == 4) _paymentTypeString = @"Apple Pay";
    if (self.paymentType == 5) _paymentTypeString = @"银联支付";
    if (self.paymentType == 6) _paymentTypeString = @"网银转账";
    
    return _paymentTypeString;
}

/**
 支付方式logo图片

 @return 返回图片名称
 */
- (NSString *)paymentLogoImageNamed
{
    if (!_paymentLogoImageNamed) {
        if (self.paymentType == 1) _paymentLogoImageNamed = @"icon_payment_PCPay";
        if (self.paymentType == 2) _paymentLogoImageNamed = @"icon_WeiXinPay";
        if (self.paymentType == 3) _paymentLogoImageNamed = @"icon_Alipay";
        if (self.paymentType == 4) _paymentLogoImageNamed = @"icon_ApplePay";
        if (self.paymentType == 5) _paymentLogoImageNamed = @"icon_UnionPay";
        //if (self.paymentType == 6) _paymentLogoImageNamed = @"网银转账";
    }
    return _paymentLogoImageNamed;
}

- (NSString *)paymentTypeButtonString
{
    if (self.paymentType == 1) _paymentTypeButtonString = @"打开PC扫码付款";
    if (self.paymentType == 2) _paymentTypeButtonString = @"打开微信付款";
    if (self.paymentType == 3) _paymentTypeButtonString = @"打开支付宝付款";
    if (self.paymentType == 4) _paymentTypeButtonString = @"打开Apple Pay付款";
    if (self.paymentType == 5) _paymentTypeButtonString = @"打开银联付款";
    if (self.paymentType == 6) _paymentTypeButtonString = @"网银转账";
    
    return _paymentTypeButtonString;
}

/**
 用户输入的金额

 @param userPartAmountString 金额
 */
- (void)setUserPartAmountString:(NSString *)userPartAmountString
{
    _userPartAmountString = [NSString stringWithFormat:@"%lld", userPartAmountString.longLongValue * 100];
}

@end
