//
//  YXPaymentSuccessViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXPaymentHomepageViewDataModel;

/**
 当前控制器类型

 - YXPaymentSuccessViewControllerAllPayment:                        全款支付
 - YXPaymentSuccessViewControllerPartPayment:                       分笔
 - YXPaymentSuccessViewControllerPartDeposit:                       定金
 - YXPaymentSuccessViewControllerPartDepositExcept:                 定金余款--全额
 - YXPaymentSuccessViewControllerPartDepositExcept_partPayment:     定金余款--分笔
 */
typedef NS_ENUM(NSUInteger, YXPaymentSuccessViewControllerType) {
    YXPaymentSuccessViewControllerAllPayment,
    YXPaymentSuccessViewControllerPartPayment,
    YXPaymentSuccessViewControllerPartDeposit,
    YXPaymentSuccessViewControllerPartDepositExcept,
    YXPaymentSuccessViewControllerPartDepositExcept_partPayment,
};

@interface YXPaymentSuccessViewController : UIViewController

/**
 类型
 */
@property (nonatomic, assign) YXPaymentSuccessViewControllerType type;

/**
 数据
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *paymentBaseDataModel;

@end
