//
//  YXPaymentHomepageViewDataModel.h
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPaymentHomePageController.h"

@interface YXPaymentHomepageViewDataModel : NSObject

//** =========================================================================================== */
//** =========================================订单基本信息======================================== */
//** =========================================================================================== */

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 图片名称
 */
@property (nonatomic, copy) NSString *imageNamed;

/**
 描述文字
 */
@property (nonatomic, copy) NSString *detaileText;

/**
 是否选中 1.选中 0.未选中
 */
@property (nonatomic, copy) NSString *isSelected;

/**
 行高
 */
@property (nonatomic, copy) NSString *rowHeight;

/*
 @brief 订单号
 */
@property(nonatomic,copy) NSString * orderId;
/*
 @brief 商品名称
 */
@property(nonatomic,copy) NSString * prodName;

/**
 已付金额
 */
@property(nonatomic,copy) NSString * alreadyPayAmount;

/*
 @brief 订单总金额
 */
@property(nonatomic,copy) NSString * totalAmount;
/*
 @brief 应付金额
 */
@property(nonatomic,copy) NSString * payAmount;

/**
 预支付 返回的支付订单号
 */
@property(nonatomic,copy) NSString * PayOrderNumber;

/**
 0 为预授权  1 为消费交易
 */
@property (copy, nonatomic) NSString *ApplePayType;

/**
 凭证上传成功url
 */
@property (nonatomic, copy) NSString *upLoadCertificatesImageUrlString;

/**
 线下凭证图片urlString
 */
@property (nonatomic, copy) NSString *offlineCertificatesImageUrlString;

/**
 支付宝 支付的 秘钥 后台得到
 */
@property(nonatomic,strong) NSString * privateKey;

/**
 服务器签名订单参数
 */
@property (nonatomic, copy) NSString *severSignOrderInfo;

//** =========================================================================================== */
//** =========================================判断支付状态======================================== */
//** =========================================================================================== */

/**
 当前订单支付类型
 */
@property (nonatomic, assign) YXPaymentHomePageControllerType paymentControllerType;

/**
 支付方式 1.PC扫码 2.微信 3.支付宝 4.apple pay 5.银联支付 6.网银转账汇款
 */
@property (nonatomic, assign) NSInteger paymentType;

/**
 支付方式文字
 */
@property (nonatomic, copy) NSString *paymentTypeString;

/**
 支付方式按钮文字
 */
@property (nonatomic, copy) NSString *paymentTypeButtonString;

/**
 支付方式对应按钮名称
 */
@property (nonatomic, copy) NSString *paymentLogoImageNamed;

/**
 事务类型  支付类型  1.鉴定费 2.拍卖订单 3.保证金 4.一口价 100.初始化参数错误
 */
@property (nonatomic, assign) NSInteger transType;

/**
 是否为全额支付 0.全额 1.分笔 100.错误
 */
@property (nonatomic, assign) NSInteger isPartPay;

/**
 是否是定金支付 0.否 1.是
 */
@property (nonatomic, assign) NSInteger isCurrentDepositPay;

/**
 倒计时时间
 */
@property (nonatomic, copy) NSString *countDownTimeString;

//** =========================================================================================== */
//** =========================================新加定金支付字段===================================== */
//** =========================================================================================== */

/**
 定金金额
 */
@property (nonatomic, assign) long long depositPrice;

/**
 是否支付定金 1.是 0否
 */
@property (nonatomic, assign) NSInteger isPayedDeposit;

/**
 分笔输入金额
 */
@property (nonatomic, copy) NSString *userPartAmountString;

@end
