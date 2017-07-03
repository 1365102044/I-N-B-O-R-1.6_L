//
//  YXPayHistroyModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXPayHistroyModle : NSObject
/**
 * 编号
 */
@property(nonatomic,copy) NSString * paymentResultId;
/**
 * 订单编号
 */
@property(nonatomic,copy) NSString * orderId;
/**
 * 支付渠道: 1=IOS,2=android,3=pc,4=M站
 */
@property(nonatomic,assign) NSInteger  channelType;
/**
 * 支付事务类型: 1鉴定费，2拍卖订单，4一口价订单
 */
@property(nonatomic,assign) NSInteger  payTransType;
/**
 * 支付方式： 1 PC网银支付，2 手机微信支付，3手机支付宝支付，4apple pay，5易支付银联支付   8 连连PC支付 
 */
@property(nonatomic,assign) NSInteger  payType;
/**
 * 是否定金支付：0否，1是
 */
@property(nonatomic,assign) NSInteger  isDepositPay;
/**
 * 支付状态：0=未支付，1=支付中，2=支付成功，3=支付失败
 */
@property(nonatomic,assign) NSInteger  payStatus;


/**
 * 支付金额
 */
@property(nonatomic,copy) NSString * payAmt;
/**
 * 支付手续费
 */
@property(nonatomic,copy) NSString * payFee;

/**
 * 支付成功时间
 */
@property(nonatomic,copy) NSString * payedTime;


/**
 * 创建时间
 */
@property(nonatomic,copy) NSString * createTime;


/**
 * 交易流水号
 */
@property(nonatomic,copy) NSString * transactionId;


/**
 * 是否分笔支付(1=是，0=否)
 */
@property(nonatomic,assign) NSInteger  isPartPay;


/**
 自己的返回展示的字符串 支付方式
 */
@property(nonatomic,copy) NSString *MypayType;

/**
 全额 分笔，定金
 */
@property(nonatomic,copy) NSString * MyPayMoneyType;

/**
 支付进度
 */
@property(nonatomic,copy) NSString * MyPayStatus;

@end
