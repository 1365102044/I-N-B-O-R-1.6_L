//
//  YXPaymentHomePageController.h
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 控制器支付类型

 - YXPaymentHomePageControllerNone:                             无状态
 - YXPaymentHomePageControllerIdentifyCost:                     鉴定费
 - YXPaymentHomePageControllerBidGood:                          拍卖订单-全款
 - YXPaymentHomePageControllerBidGood_partPayment:              拍卖订单-分笔
 - YXPaymentHomePageControllerBond:                             保证金
 - YXPaymentHomePageControllerFixGood:                          一口价-全款
 - YXPaymentHomePageControllerFixGood_partPayment:              一口价-分笔
 - YXPaymentHomePageControllerDeposit:                          定金
 - YXPaymentHomePageControllerDepositExcept:                    定金以外余款-全款
 - YXPaymentHomePageControllerDepositExcept_partPayment:        定金以外余款-分笔
 - YXPaymentHomePageControllerLineTransfer:                     线下转账对账
 */
typedef NS_ENUM(NSUInteger, YXPaymentHomePageControllerType) {
    YXPaymentHomePageControllerNone,
    YXPaymentHomePageControllerIdentifyCost,
    YXPaymentHomePageControllerBidGood,
    YXPaymentHomePageControllerBidGood_partPayment,
    YXPaymentHomePageControllerBond,
    YXPaymentHomePageControllerFixGood,
    YXPaymentHomePageControllerFixGood_partPayment,
    YXPaymentHomePageControllerDeposit,
    YXPaymentHomePageControllerDepositExcept,
    YXPaymentHomePageControllerDepositExcept_partPayment,
    YXPaymentHomePageControllerLineTransfer,
};

@interface YXPaymentHomePageController : UIViewController


/**
 返回当前控制器实例

 @param prodId      商品的id（必传）
 @param type        类型
 @return            返回支付方式控制器
 */
+ (instancetype)loadPaymentControllerWithProdId:(long long)prodId
                                        andType:(YXPaymentHomePageControllerType)type;


@end
