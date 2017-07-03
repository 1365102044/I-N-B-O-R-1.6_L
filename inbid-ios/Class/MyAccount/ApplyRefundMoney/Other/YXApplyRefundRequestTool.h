//
//  YXApplyRefundRequestTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YXApplyRefundRequestTool : YXNetworkTool

+(instancetype)sharedTool;

/**
 安全验证 获取 验证码
 */
-(void)GetSMSCodeWithphone:(NSString *)phone Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 退款申请前的 安全验证
 */
-(void)RefundMoneyScurityPassWordsCommitWith:(NSString *)PayPassword SMSCode:(NSString *)smscode Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 申请退款 界面的数据接口
 * @param orderId  订单编号
 */
-(void)RequestRefundResultDataWith:(NSString *)orderId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;



/**
 申请更换，修改银行卡接口
 */
/**
 * @param refundId  申请退款id
 *@param refundBankId  修改银行退款编号id
 *@param bankCardNo 银行卡号
 */
-(void)RefundMoneyChangeBankIdCardWith:(NSString *)refundId
                          refundBankId:(NSString *)refundBankId
                            bankCardNo:(NSString *)bankCardNo
                               Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;



/**
 申请退款增加新的银行卡接口
 */
/**
 * @param refundId  申请退款id
 * @param name  姓名
 *@param idCard 身份证号
 *@param bankCardNo 银行卡号
 */
-(void)RefundMoneyAddBankIdCardWith:(NSString *)refundId
                                  name:(NSString *)name
                                idCard:(NSString *)idCard
                            bankCardNo:(NSString *)bankCardNo
                              isCert:(NSString *)isCert
                               Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 申请退款提交退款申请接口
 * @param smsCode 短信验证码
 * @param refundId  申请退款id
 * @param orderId  订单编号
 */
-(void)CommitRefundMoneyDataWith:(NSString *)refundId
                         orderId:(NSString *)orderId
                         SmsCode:(NSString *)SmsCode
                         Success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;


/**
 支付记录列表
 * @param orderId  订单编号
 */
-(void)LoadPayHistroyListDataWith:(NSString *)orderId
                          Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 查看 退款详情
 */
/**
 查看 退款详情
 */
-(void)LoadRefundMoneyDeatilDataWith:(NSString *)orderId
                             Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
@end
