//
//  YXMyAccoutWaitpaymentViewController.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXMySureMoneyNopaymentModle.h"



@interface YXMyAccoutWaitpaymentViewController : UIViewController


/*
 @brief 扫码支付 传给后台，订单id
 */
@property(nonatomic,assign) long long   OrderID;

/*
 @brief 保证金
 */

@property(nonatomic,assign) long long   prodId;


/*
 @brief 付完保证金 后 参与竞拍 跳回 商品详情 需要的probid
 */
@property(nonatomic,strong) NSString * ProBidId;

/*
 @brief 保证金的数量
 */
@property(nonatomic,assign) long long  ensurepricecount;


/*
 @brief 订单编号
 */
@property(nonatomic,strong) NSString * orderId;

/*
 @brief 2 全额支付     1 分笔支付   3 保证金的继续支付
 */
@property(nonatomic,assign) NSInteger  isPartPay;

/*
 @brief 判读是否 是保证金  1 保证金支付   2其他的是订单支付    3鉴定订单  4一口价
 */
@property(nonatomic,assign) NSInteger  fomreVC;
/*
 @brief 保证金支付 （已付金额，保证金金额）
 */
@property(nonatomic,strong) NSMutableArray * dict;


/*
 @brief 1 保证金的继续支付 （多个剩余金额）
 */
//@property(nonatomic,assign) NSInteger  isEnsuremoneyPay;

/*
 @brief  支付保证金金额的时候，判读需要付的保证金金额是否小于2000   1 如果小于2000 只能支付全部，输入框不能自己填写   2 大于2000  可以粉笔支付，但是每笔不得低于2000；
 */
@property(nonatomic,assign) NSInteger  iscanChangeShengyuCount;


/*
 @brief  如果是保证金的话，应付金额 小于2000 直接全额支付，不能选择支付方式   1  
 */
@property(nonatomic,assign) NSInteger  shouldPaymentALLmarginpriceStatus;



/*
 @brief 保证金的 时候 需要传递过来 保证金商品名
 */
@property(nonatomic,strong) NSString * GoodsName;




/*
 @brief 保证金未付款订单 详情的数据模型
 */
@property(nonatomic,strong) YXMySureMoneyNopaymentModle * NoPayMarginPriceOrderModle;


@end
