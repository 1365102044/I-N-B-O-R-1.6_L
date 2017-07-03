//
//  YXApplyRefundRequestTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApplyRefundRequestTool.h"
#import "YXMyAccountURLMacros.h"

@implementation YXApplyRefundRequestTool
+(instancetype)sharedTool
{
    static YXApplyRefundRequestTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXApplyRefundRequestTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        tool.securityPolicy.allowInvalidCertificates = YES;
        tool.securityPolicy.validatesDomainName = NO;
        
    });
    return tool;
}

/**
 安全验证 获取 验证码  *****不用再传手机号了，后台自己操作
 */
-(void)GetSMSCodeWithphone:(NSString *)phone
                   Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone};
    [self requestDataWithType:POST url:REQUESTSMSCODER_URL params:nil success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
    [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
    [YXNetworkHUD dismiss];
        failure(error);
    }];

}
/**
 退款申请前的 安全验证
 */
-(void)RefundMoneyScurityPassWordsCommitWith:(NSString *)PayPassword
                                     SMSCode:(NSString *)smscode
                                     Success:(void (^)(id objc, id respodHeader))success
                                     failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    NSString *jiami = [YXStringFilterTool getSha1String:PayPassword];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"payPassword":jiami,
              @"smsCode":smscode};
    [self requestDataWithType:POST url:COMMITSUCRITYDATA_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 申请退款 界面的数据接口
 * @param orderId  订单编号
 */
-(void)RequestRefundResultDataWith:(NSString *)orderId  Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"orderId":orderId};
    [self requestDataWithType:POST url:REQUESTAPPLYREFUDMONEY_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];

}


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
                               Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"refundId":refundId,
              @"bankCardNo":bankCardNo};
    
    [self requestDataWithType:POST url:REFUNDMONEYCHANGEBANKIDCARD_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];

}


/**
 申请退款增加新的银行卡接口
 */
/**
 * @param refundId  申请退款id
 * @param name  姓名
 *@param idCard 身份证号
 *@param bankCardNo 银行卡号
 *@param isCer 1代表实名认证 0代表没有
 */
-(void)RefundMoneyAddBankIdCardWith:(NSString *)refundId
                            name:(NSString *)name
                            idCard:(NSString *)idCard
                            bankCardNo:(NSString *)bankCardNo
                              isCert:(NSString *)isCert
                               Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"refundId":refundId,
              @"name":name,
              @"idCard":idCard,
              @"bankCardNo":bankCardNo,
              @"isCert":isCert};
    
    [self requestDataWithType:POST url:REFUNDMONEYADDBANKIDCARD_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];

}


/**
 申请退款提交退款申请接口
 * @param smsCode 短信验证码
 * @param refundId  申请退款id
 * @param orderId  订单编号
 */
-(void)CommitRefundMoneyDataWith:(NSString *)refundId
                         orderId:(NSString *)orderId
                         SmsCode:(NSString *)SmsCode
                         Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"refundId":refundId,
              @"orderId":orderId,
              @"smsCode":SmsCode};
    [self requestDataWithType:POST url:COMMITREFUNDDATA_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}


/**
 支付记录列表
 * @param orderId  订单编号
 */
-(void)LoadPayHistroyListDataWith:(NSString *)orderId
                          Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"orderId":orderId};
    [self requestDataWithType:POST url:LOADHISTROYLISTDATA_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];

}


/**
 查看 退款详情
 */
-(void)LoadRefundMoneyDeatilDataWith:(NSString *)orderId
                             Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"orderId":orderId};
    [self requestDataWithType:POST url:LOADREFUNDMONEYDEATILDATA_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}


@end
