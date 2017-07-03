//
//  YXMySureMoneyNopaymentModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMySureMoneyNopaymentModle : NSObject
/**
 * 商品id
 */
@property(nonatomic,assign) long long  prodId;
/**
 * 已支付的金额（累加）
 */
@property(nonatomic,assign) long long  alreadyPayAmount;
/**
 * 支付路径: 1 手机网银支付，2 手机微信支付，3手机支付宝支付
 */
@property(nonatomic,strong) NSArray * payType;
/**
 * 保证金编号
 */
@property(nonatomic,assign) long long   NopaymentId;
/**
 * 状态：1=未支付,2=部分支付，3=已交，4=退还，5=罚扣，6=订单抵扣
 */
@property(nonatomic,assign) NSInteger  marginStatus;
/**
 * 拍卖表id
 */
@property(nonatomic,assign) long long   prodBidId;
/**
 * 保证金
 */
@property(nonatomic,assign) NSInteger  marginPrice;

/**
 * 商品名称
 */
@property(nonatomic,strong) NSString * prodName;
/**
 * 提交时间
 */
@property(nonatomic,strong) NSString * createTime;

/**
 * 是否分笔支付
 */
@property(nonatomic,assign) NSInteger  isPartPay;


@property(nonatomic,copy)  NSString*  orderId;


@property(nonatomic,strong) NSString * imgUrl;


@property(nonatomic,strong) NSString * orderPayAmount;


@end
