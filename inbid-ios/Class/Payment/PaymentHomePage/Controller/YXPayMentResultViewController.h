//
//  YXPayMentResultViewController.h
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPaymentHomePageController.h"

@interface YXPayMentResultViewController : UIViewController

/**
 鉴定订单id 提交鉴定费失败时，传入orderid
 */
@property (nonatomic, assign) long long orderId;
/**
 支付事务类型
 */
@property (nonatomic, assign) YXPaymentHomePageControllerType transType;

/**
 是否余额不足
 */
@property (nonatomic, assign) BOOL isBalanceNotEnough;

@end
