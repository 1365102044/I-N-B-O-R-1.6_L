//
//  YXApplyRefundSultModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXApplyRefundSultModle : NSObject

/**
 * 是否已经有退款银行卡
 */
@property(nonatomic,assign) NSInteger  hasBank;
/**
 * 退款银行卡id
 */
@property(nonatomic,copy) NSString*  refundBankId;
/**
 * 退款完成时间
 */
@property(nonatomic,copy) NSString * updateTime;
/**
 * 退款申请时间
 */
@property(nonatomic,copy) NSString * createTime;
/**
 * 备注
 */
@property(nonatomic,copy) NSString * refundInfo;
/**
 * 身份证号
 */
@property(nonatomic,copy) NSString * idCard;
/**
 * 银行类型编号
 */
@property(nonatomic,copy) NSString * bankCard;
/**
 * 卡类型
 */
@property(nonatomic,copy) NSString * bankCardType;
/**
 * 银行卡号
 */
@property(nonatomic,copy) NSString * bankCardNo;
/**
 * 姓名
 */
@property(nonatomic,copy) NSString * name;
/**
 * 退款状态：1申请退款，2平台处理中, 3退款完成，4退款驳回
 */
@property(nonatomic,assign) NSInteger  refundStatus;
/**
 * 退款费率
 */
@property(nonatomic,copy) NSString * refundRadio;
/**
 * 退款手续费
 */
@property(nonatomic,copy) NSString *  refundFee;
/**
 * 实退金额
 */
@property(nonatomic,copy) NSString *  refundAmt;
/**
 * 订单可退款金额
 */
@property(nonatomic,copy) NSString * orderPayAmt;
/**
 * 退款类型1=全额,2=部分
 */
@property(nonatomic,assign) NSInteger  refundType;
/**
 * 退款申请人编号
 */
@property(nonatomic,copy) NSString * memberId;
/**
 * 操作员编号
 */
@property(nonatomic,copy) NSString * userManageId;
/**
 * 订单编号
 */
@property(nonatomic,copy) NSString * orderId;
/**
 * 退款编号
 */
@property(nonatomic,copy) NSString * refundId;
/**
 是否已经实名认证
 */
@property(nonatomic,assign) NSInteger  hasCert;


/**
 在提交退款申请后 返回的时间处理
 */
@property(nonatomic,copy) NSString * refundDays;

@property(nonatomic,copy) NSString * refundDealDays;

@property(nonatomic,copy) NSString * refundWorkDays;


/**
 退款详情中的  退款状态字段
 */
@property(nonatomic,copy) NSString * MyRefundStatus;

@end
