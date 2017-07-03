//
//  YXHomePageNetRequestTool.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/2.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNetworkTool.h"
#import "YXInputPhoneNumberViewController.h"
#import "YXLoginViewController.h"
#import "YXInputVerificationCodeViewController.h"
@interface YXMyAccountNetRequestTool : YXNetworkTool

//** 加载基本资料 */
-(void)loadBaseDataWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
//** 修改生日/性别/邮箱 */
-(void)editBirthdayOrSexOrEmailWithBrithday:(NSString *)birthday sex:(NSString *)sex email:(NSString *)email  nickName:(NSString *)nickName success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
//** 退出登录 */
- (void)logOutWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;


//** 关注竞拍 */
- (void)loadMyQueryMenberCollectionList:(NSInteger)currentPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 正在竞拍 */
- (void)loadMyQueryPiddingByMemberId:(NSInteger)currentPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 结束竞拍 */
- (void)loadMyQueryPidOverByMemberId:(NSInteger)currentPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 判断是否提交保证金 */
- (void)loadIsSubmitBondWithBidId:(NSString *)bidId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 提交保证金接口 */
- (void)submitBondWithBidId:(NSString *)bidId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

////** 我的订单 */
//- (void)loadMyQueryAccountInfoWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 获取地址列表 */
- (void)loadMyAddressWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 删除地址 */
- (void)deleteAddressWithAddressId:(long long)addressId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 切换默认地址 */
- (void)setDefaultAddressWithAddressId:(long long)addressId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 添加新地址 */
- (void)addNewAddressWithReceiveName:(NSString *)receiveName withPhoneNumber:(NSString *)phoneNumber withProvince:(NSString *)preovince withCity:(NSString *)city area:(NSString *)area withConsigneeAddressDetail:(NSString *)consigneeAddressDetail withIsDefault:(NSInteger)isDefault success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 编辑地址 */
- (void)editAddressWithReceiveName:(NSString *)receiveName withPhoneNumber:(NSString *)phoneNumber withProvince:(NSString *)preovince withCity:(NSString *)city area:(NSString *)area withConsigneeAddressDetail:(NSString *)consigneeAddressDetail withIsDefault:(NSInteger)isDefault withAddressId:(long long)addressId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 等待鉴定 */
- (void)loadMySendAShortWaitIdentifyWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 正在寄拍 */
- (void)loadIngBidListWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 完成寄拍 */
- (void)loadEndBidListWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 等待鉴定立即鉴定列表 */
- (void)loadImmediatelyIdentifiedListWithIdentifyId:(NSString *)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 修改登录密码 */
- (void)updataPwdWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 立即邮寄 */
- (void)mailNowWithOrderIdentifyId:(long long)orderIdentifyId withIsDelivery:(BOOL)isDelivery withDeliverNum:(NSString *)deliverNum withDeliveryMerchant:(NSString *)deliveryMerchant success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 立即邮寄获取公司地址 */
- (void)mailNowLoadMyAddressWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 平台代卖/平台回收 */
- (void)platformBidOrPlatformRecoverWithOrderIdentifyId:(long long)orderIdentifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 平台代卖之确认代卖 */
- (void)sureReplaceSellWithIdentifyId:(long long)identifyId withSuggestPrice:(NSInteger)suggestPrice withUserSetPrice:(NSString *)userSetPrice success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 平台回收之同意回收 */
- (void)confirmRecycleWithIdentifyId:(long long)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 立即鉴定 */
- (void)identifyNowWithIdentifyId:(long long)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 获取预鉴定详情
 
 @param identifyId 鉴定订单id
 @param success    成功回调
 @param failure    失败回调
 */
- (void)identifyDetailWithIdentifyId:(long long)identifyId
                             success:(void (^)(id objc, id respodHeader))success
                             failure:(void (^)(NSError *error))failure;

/**
 获取快递公司地址
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getExpressListSuccess:(void (^)(id objc, id respodHeader))success
                      failure:(void (^)(NSError *error))failure;

/**
 我要退货
 
 @param payPassword  支付密码
 @param orderId      鉴定订单编号
 @param deliveryType 配送类型：1.自提 0.物流
 @param refundType   退回类型：1.鉴定失败退货 2.流拍退货 3.鉴定成功主动退回 4.一口价流拍退回
 @param prodId       流拍时传的商品id 鉴定失败不传
 @param consigneeId  客户选取/新增地址的退货地址id
 @param buyoutId       一口价流拍的时候传的一口价编号
 */
- (void)addRefundDeliveryWithPayPassword:(NSString *)payPassword
                              andOrderId:(long long)orderId
                         andDeliveryType:(NSInteger)deliveryType
                           andRefundType:(NSInteger)refundType
                               andProdId:(long long)prodId
                          andConsigneeId:(long long)consigneeId
                               imagecode:(NSString *)imagecode
                                buyoutId:(long long)buyoutId
                                 success:(void (^)(id objc, id respodHeader))success
                                 failure:(void (^)(NSError *error))failure;

/**
 查看鉴定结果
 
 @param identifyId 鉴定订单编号
 @param success    成功回调
 @param failure    失败回调
 */
- (void)getIdentifyResultWithIdentifyId:(long long)identifyId
                                success:(void (^)(id objc, id respodHeader))success
                                failure:(void (^)(NSError *error))failure;

/**
 我的一口价列表
 
 @param bidType  bidType 1.全部 2.正在售卖 3.已完成
 @param curPage  curPage
 @param pageSize pageSize
 @param success  success
 @param failure  failure
 */
- (void)getFixPriceBidListWithBidType:(NSInteger)bidType
                              curPage:(NSInteger)curPage pageSize:(NSInteger)pageSize
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure;

/**
 设置一口价
 
 @param identifyId  identifyId 鉴定订单id
 @param saleDay     saleDay 寄卖天数
 @param buyoutPrice buyoutPrice 价格
 @param success     success 成功
 @param failure     failure 失败
 */
- (void)setBuyOutPriceWithIdentifyId:(long long)identifyId
                             saleDay:(NSString *)saleDay
                         buyoutPrice:(NSString *)buyoutPrice
                             success:(void (^)(id objc, id respodHeader))success
                             failure:(void (^)(NSError *error))failure;

/**
 一口价流拍后重选界面数据获取
 
 @param identifyId 一口价拍品编号
 @param success    成功
 @param failure    失败
 */
- (void)setBuyoutChooseWithIdentifyId:(long long)identifyId
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure;

/**
 一口价流拍后处理
 
 @param fixId       fixId 一口价编号
 @param type        type 1.平台回收 2.平台寄拍 3.一口价
 @param saleDay     saleDay 一口价出售天数
 @param buyoutPrice buyoutPrice 一口价金额
 @param success     成功
 @param failure     失败
 */
- (void)setBuyoutChooseConfirmWIthId:(long long)fixId
                                type:(NSInteger)type
                             saleDay:(NSString *)saleDay
                         buyoutPrice:(NSString *)buyoutPrice
                             success:(void (^)(id objc, id respodHeader))success
                             failure:(void (^)(NSError *error))failure;

/**
 加载订单详情数据
 
 @param orderId 订单id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadOrderDetailWithOrderId:(long long)orderId
                           success:(void (^)(id objc, id respodHeader))success
                           failure:(void (^)(NSError *error))failure;

/**
 修改支付方式
 
 @param orderId 订单id
 @param orderPaytype 订单支付类型 ，1全额支付，2定金支付，3分笔支付，4转账汇款，5订金+刷卡
 @param success 成功
 @param failure 失败
 */
- (void)changePaytypeWithOrderId:(long long)orderId
                    orderPayType:(NSInteger)orderPaytype
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;

/**
 确认收货
 
 @param orderId 订单id
 @param success 成功
 @param failure 失败
 */
- (void)makeSureConsigneeWithOrder:(long long)orderId
                           success:(void (^)(id objc, id respodHeader))success
                           failure:(void (^)(NSError *error))failure;

/**
 取消订单
 
 @param orderId 订单id
 @param reasonString 问题原因字符串，传入点击的title
 @param success 成功
 @param failure 失败
 */
- (void)cancelOrderWithOrderId:(long long)orderId
                     andReason:(NSString *)reasonString
                       success:(void (^)(id objc, id respodHeader))success
                       failure:(void (^)(NSError *error))failure;

/**
 登录&注册获取短信验证码
 
 @param phoneNumber 电话号码
 @param success 成功
 @param failure 失败
 第三方登录绑定手机，验证码
 * @param phone 手机号
 * @param type 1微信，2QQ
 */
- (void)loginAndRegisterSMSWithPhoneNumber:(NSString *)phoneNumber
                               formeVCtype:(YXInputVerificationCodeViewControllerType)formeVCtype
                                longintype:(YXThridLoginType)longintype
                                   success:(void (^)(id objc, id respodHeader))success
                                   failure:(void (^)(NSError *error))failure;

/**
 注册用户信息校验
 
 @param phoneNumber 电话号码
 @param prodBids 内部取本地足记信息
 @param message 信息
 @param success 成功
 @param failure 失败
 */
- (void)registerCheckUserInformationWithPhoneNumber:(NSString *)phoneNumber
                                            message:(NSString *)message
                                            success:(void (^)(id objc, id respodHeader))success
                                            failure:(void (^)(NSError *error))failure;

/**
 忘记密码重置密码短信验证码获取
 
 @param phoneNumber 电话号码
 @param success 成功
 @param failure 失败
 */
- (void)loadResetPwdVerificationCodeWithPhoneNumber:(NSString *)phoneNumber
                                            success:(void (^)(id objc, id respodHeader))success
                                            failure:(void (^)(NSError *error))failure;

/**
 重置密码用户验证码校验
 
 @param phoneNumber 电话号码
 @param message 信息
 @param success 成功
 @param failure 失败
 */
- (void)checkResetPwdMessageWithPhoneNumber:(NSString *)phoneNumber
                                    message:(NSString *)message
                                    success:(void (^)(id objc, id respodHeader))success
                                    failure:(void (^)(NSError *error))failure;

/**
 设置新密码
 
 @param phoneNumber 手机号
 @param newPwd 新密码
 @param verifyCode 验证密码成功的随机串
 @param success 成功
 @param failure 失败
 */
- (void)setNewPwdWithPhoneNumber:(NSString *)phoneNumber
                          newPwd:(NSString *)newPwd
                      verifyCode:(NSString *)verifyCode
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;

/**
 申请退回接口第一步
 
 @param deliveryType            配送方式（0.快递发货 1.会员自提）
 @param refundType              退货类型（1.鉴定失败退货 2.寄拍流拍退货 3.鉴定成功主动退回 4.一口价流拍退货）
 @param orderId                 鉴定成功/失败退回-鉴定订单编号 流拍不传
 @param prodId                  流拍时传的商品id 鉴定不传
 @param buyoutId                一口价流拍的时候传的一口价编号
 @param consigneeId             物流地址id
 @param success                 成功
 @param failure                 失败
 */
- (void)returnGoodWithDeliveryType:(NSString *)deliveryType
                        refundType:(NSString *)refundType
                           orderId:(NSString *)orderId
                            prodId:(NSString *)prodId
                          buyoutId:(NSString *)buyoutId
                       consigneeId:(NSString *)consigneeId
                           success:(void (^)(id objc, id respodHeader))success
                           failure:(void (^)(NSError *error))failure;

/**
 退回身份验证界面
 
 @param payPassword             登录密码
 @param deliveryType            配送方式（0.快递发货 1.会员自提）
 @param refundType              退货类型（1.鉴定失败退货 2.寄拍流拍退货 3.鉴定成功主动退回 4.一口价流拍退货）
 @param orderId                 鉴定成功/失败退回-鉴定订单编号 流拍不传
 @param prodId                  流拍时传的商品id 鉴定不传
 @param buyoutId                一口价流拍的时候传的一口价编号
 @param idCard                  身份证后8位
 @param consigneeId             物流地址id
 @param success                 成功
 @param failure                 失败
 */
- (void)returnGoodWithPayPassword:(NSString *)payPassword
                     deliveryType:(NSString *)deliveryType
                       refundType:(NSString *)refundType
                          orderId:(NSString *)orderId
                           prodId:(NSString *)prodId
                         buyoutId:(NSString *)buyoutId
                           idCard:(NSString *)idCard
                      consigneeId:(NSString *)consigneeId
                          success:(void (^)(id objc, id respodHeader))success
                          failure:(void (^)(NSError *error))failure;

@end
