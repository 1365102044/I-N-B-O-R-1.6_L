//
//  YXOneMouthPriceConfirmOrderModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXOneMouthPriceConfirmOrderModle : NSObject


@property(nonatomic,strong) NSString * deliveryType;
/**
 * 订单总金额
 */
@property(nonatomic,strong) NSString * orderTotalAmount;
@property(nonatomic,strong) NSString * imgUrl;
@property(nonatomic,strong) NSString * consigneeProvince;
@property(nonatomic,strong) NSString * goodsNum;
@property(nonatomic,strong) NSString * prodBidId;
@property(nonatomic,strong) NSString * consigneeName;
@property(nonatomic,strong) NSString * consigneeAddressDetail;
@property(nonatomic,strong) NSString * consigneeCity;

@property(nonatomic,strong) NSString * prodName;
@property(nonatomic,strong) NSString * consigneeMobile;

@property(nonatomic,strong) NSString * hasAddress;

/*
 @brief 身份正号
 */
@property(nonatomic,strong) NSString * consigneeIdcard;

/*
 @brief 地址id
 */
@property(nonatomic,strong) NSString * consigneeId;

/*
 @brief 自提地址
 */
@property(nonatomic,strong) NSString * consigneeAdress;
@property(nonatomic,strong) NSString * consigneePhone;
@property(nonatomic,strong) NSString * customerPhone;


/**
 * 商品单价
 */
@property(nonatomic,assign) NSUInteger  prodPrice;
/**
 * 订单优惠金额
 */
@property(nonatomic,assign) NSInteger  orderDiscountAmount;


/**
 * 运费
 */
@property(nonatomic,assign) NSInteger  carriage;

/**
 * 保价
 */
@property(nonatomic,assign) NSInteger  protectPrice;

/**
 定金
 */
@property(nonatomic,assign) NSInteger  depositPrice;

/**
 已付金额
 */
@property(nonatomic,assign) NSInteger  alreadyPayAmount;


@end
