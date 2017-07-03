//
//  YXSeverSignInformationModel.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXSeverSignBizContentModel.h"

@interface YXSeverSignInformationModel : NSObject

//** ============================================================================= */
//** =====================================公用===================================== */
//** ============================================================================= */

/**
 加密参数
 */
@property (nonatomic, copy) NSString *sign;

/**
 商户订单编号
 */
@property (nonatomic, copy) NSString *paymentId;

//** ============================================================================= */
//** ====================================支付宝==================================== */
//** ============================================================================= */

/**
 支付参数
 */
@property (nonatomic, copy) NSString *content;


//** ============================================================================= */
//** ==================================易支付-废弃================================== */
//** ============================================================================= */

/**
 商户号
 */
@property (nonatomic, copy) NSString *v_mid;

/**
 订单生成日期
 */
@property (nonatomic, copy) NSString *v_ymd;

/**
 订单编号
 */
@property (nonatomic, copy) NSString *v_oid;

/**
 订单总金额 元为单位
 */
@property (nonatomic, copy) NSString *v_amount;

/**
 币种
 */
@property (nonatomic, copy) NSString *v_moneytype;

/**
 客户证件类型 非必传
 */
@property (nonatomic, copy) NSString *v_idtype;

/**
 客户证件号码 非必传
 */
@property (nonatomic, copy) NSString *v_idnumber;

/**
 终端编号
 */
@property (nonatomic, copy) NSString *v_rcvname;

/**
 收货地址
 */
@property (nonatomic, copy) NSString *v_rcvaddr;

/**
 收货人电话
 */
@property (nonatomic, copy) NSString *v_rcvtel;

/**
 收货人邮编
 */
@property (nonatomic, copy) NSString *v_rcvpost;

/**
 订货人邮箱
 */
@property (nonatomic, copy) NSString *v_ordmail;

/**
 下单终端类型  0client 1：wap
 */
@property (nonatomic, copy) NSString *v_orderstatus;

/**
 订货人姓名,总长不超过64个字符 掌中付用于客户验证码，统一采用:0000
 */
@property (nonatomic, copy) NSString *v_ordername;

/**
 返回商户页面地址
 */
@property (nonatomic, copy) NSString *v_url;

/**
 商户自定义参数，传操作员编号
 */
@property (nonatomic, copy) NSString *v_merdata;

/**
 服务器签名加密数据
 */
@property (nonatomic, copy) NSString *v_md5info;


//** ============================================================================= */
//** =====================================微信===================================== */
//** ============================================================================= */

/**
 商家向财付通申请的商家id
 */
@property (nonatomic, copy) NSString *partnerId;

/**
 预支付订单
 */
@property (nonatomic, copy) NSString *prepayId;

/**
 随机串，防重发
 */
@property (nonatomic, copy) NSString *nonceStr;

/**
 时间戳，防重发
 */
@property (nonatomic, copy) NSString *timeStamp;

/**
 商家根据财付通文档填写的数据和签名
 */
@property (nonatomic, copy) NSString *packageStr;

//** =========================================================================================== */
//** ==========================================applePay========================================= */
//** =========================================================================================== */

@end
