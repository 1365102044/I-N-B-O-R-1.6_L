//
//  YXPayMentNetRequestTool.h
//  Payment
//
//  Created by 胤讯测试 on 16/12/1.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXNetworkTool.h"
#import "YXPaymentURLMacros.h"
@class YXSendAuctionProgressModel;

@interface YXPayMentNetRequestTool : YXNetworkTool


/**
 支付界面数据

 @param orderId orderId                     订单id
 @param type type                           需要支付类型
 @param success success                     成功
 @param failure failure                     失败
 */
- (void)loadPayMentHomePageDataWithOrderId:(long long)orderId
                            andPaymentType:(NSInteger)type
                                   success:(void (^)(id objc, id respodHeader))success
                                   failure:(void (^)(NSError *error))failure;

/**
 预支付接口

 @param orderId orderId                     订单编号
 @param payAmount payAmount                 订单支付金额
 @param paymentType paymentType             支付类型 2微信app支付，3支付宝app支付，4apple pay，5易支付app支付
 @param transType transType                 支付事务类型 1鉴定订单，2拍卖订单，3保证金，4一口价订单
 @param isPartPay isPartPay                 是否分笔支付 0表示全额，1表示分笔
 @param isDepositPay                        是否定金支付 0表示否，1表示是
 @param success success                     成功
 @param failure failure                     失败
 */
- (void)loadPayMentPrePayDataWithOrderId:(NSString *)orderId
                            andPayAmount:(NSString *)payAmount
                          andPaymentType:(NSInteger)paymentType
                            andTransType:(NSInteger)transType
                            andIsPartPay:(NSInteger)isPartPay
                         andIsDepositPay:(NSInteger)isDepositPay
                                 success:(void (^)(id objc, id respodHeader))success
                                 failure:(void (^)(NSError *error))failure;

/**
 上传凭证图片
 
 @param urlString                           图片上传URL
 @param imageModel                          上传的图片模型
 */
- (void)upLoadImageWithUrlString:(NSString *)urlString
                        andImage:(YXSendAuctionProgressModel *)imageModel
                   andImageNamed:(NSString *)imageNamed
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;

/**
 扫码支付接口
 orderType (1鉴定订单，2拍卖订单，3保证金 4一口价)
 */
- (void)loadPayMentZbarPayDataWithOrderId:(NSString *)orderId
                             andorderType:(NSInteger)orderType
                                andUserID:(NSString *)UserID
                              andclientID:(NSString*)clientID
                                   andUrl:(NSString*)Url
                                  success:(void (^)(id objc, id respodHeader))success
                                  failure:(void (^)(NSError *error))failure;

/**
 提交生成上传凭证

 @param orderId orderId                     订单/保证金编号
 @param prodName prodName                   商品名称
 @param orderPayAmount orderPayAmount       金额
 @param paymentUrl paymentUrl               图片地址
 @param orderType orderType                 支付类型 1.鉴定费 2.拍卖订单 3.保证金 4.一口价订单
 */
- (void)offLineAddPayWithOrderId:(NSString *)orderId
                     andProdName:(NSString *)prodName
               andOrderPayAmount:(NSString *)orderPayAmount
                   andPaymentUrl:(NSString *)paymentUrl
                    andOrderType:(NSInteger)orderType
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;

/**
 查询线下汇款信息

 @param orderId                             订单
 */
- (void)queryPayWithOrderId:(NSString *)orderId
                    success:(void (^)(id objc, id respodHeader))success
                    failure:(void (^)(NSError *error))failure;

/**
 删除图片

 @param imageURLString                      图片urlString
 @param success                             成功
 @param failure                             失败
 */
- (void)delPicWithImageURLString:(NSString *)imageURLString
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;

/**
 微信回到前台回调
 
 @param transactionId                       微信订单号
 @param paymentId                           商户订单号
 @param type                                事务类型
 */
- (void)noticePayWXQueryWithTransactionId:(NSString *)transactionId
                             andpaymentId:(NSString *)paymentId
                                  andType:(NSInteger)type
                                  success:(void (^)(id objc, id respodHeader))success
                                  failure:(void (^)(NSError *error))failure;

/**
 支付宝回到前台回调
 
 @param transactionId                       支付宝支付单号
 @param paymentId                           商户支付订单单号
 @param type                                事务类型 1.鉴定订单 2.拍卖订单 3.保证金 4.一口价订单
 */
- (void)noticePayAlipayQueryWithTradeNo:(NSString *)TradeNo
                             outTradeNo:(NSString *)outTradeNo
                                  andType:(NSInteger)type
                                  success:(void (^)(id objc, id respodHeader))success
                                  failure:(void (^)(NSError *error))failure;

@end
