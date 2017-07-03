//
//  YXMyAccountGOPaymentConfirmAddressViewController.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/11.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXMyAccountGOPaymentConfirmAddressViewController : UIViewController
/*
 @brief 订单编号
 */
@property(nonatomic,strong) NSString * dingdannumber;

@property(nonatomic,strong) NSString * proname;

/*
 @brief 2 全额支付     1 分笔支付
 */
@property(nonatomic,assign) NSInteger  isPartPay;

@property(nonatomic,strong) NSString * cellid;

@property(nonatomic,assign) NSInteger  orderType;


@end
