//
//  YXMyaccountGotoPayMentTopUserInformationView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/2.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMySureMoneyNopaymentModle.h"

#import "YXMyAccoutWaitPayModle.h"


typedef void(^heightBlcok)(CGFloat Height);

@interface YXMyaccountGotoPayMentTopUserInformationView : UIView

@property(nonatomic,strong) NSDictionary * dataDict;

@property(nonatomic,copy) heightBlcok  heightBlock;

/*
 @brief 1 保证金的继续支付
 */
@property(nonatomic,assign) NSInteger  fomreVC;



/*
 @brief 1分支付   2全额支付情况下 还不知道状态 要去选择支付状态
 */
@property(nonatomic,assign) NSInteger  isPartPay;

/*
 @brief 去付款页面 的数据模型
 */
@property(nonatomic,strong) YXMyAccoutWaitPayModle * DingdanDataModle;

/*
 @brief 保证金 未付款订单 详情的数据模型
 */
@property(nonatomic,strong) YXMySureMoneyNopaymentModle * NoPayMarginPriceOrderModle;

@end
