//
//  YXLoginRequestManger.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/4.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXNetworkTool.h"
#import "YXMyOrderListViewController.h"
@interface YXLoginRequestTool : YXNetworkTool

+(instancetype)sharedTool;

/**
 登录 phone
 */
-(void)RequestLoginWithPhone:(NSString *)phone
                    password:(NSString *)password
                  verifyCode:(NSString *)verifyCode
                     Success:(void (^)(id objc, id respodHeader))success
                     failure:(void (^)(NSError *error))failure;

/**
 拿着code 去获取accss_token
 */
-(void)RequestWeiChatLoginAccess_tokenWithCode:(NSString *)code Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 QQ 后台交互
 */
-(void)RequestQQLoginWith:(NSString *)openId access_token:(NSString *)access_token Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
/**
 第三方登录 绑定手机号
 */
-(void)RequestBindingPhone:(NSString *)phone type:(NSInteger)type Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;


/**
 第三方登录，校验手机号
 @param phone 手机号
 @param type 1微信，2QQ
 */
-(void)RequestCheckPhoneWith:(NSString *)phone type:(NSInteger)type Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 第三方登录>已注册手机号，绑定
 @param openid
 @param phone 手机号
 @param verifyCode 验证码
 @param type 1微信，2QQ
 @param accountstatus 1已注册过； 2未注册过
 */
-(void)RequestAearlyReginsterAPPBindingAccountWith:(NSString *)openid
                                             phone:(NSString *)phone
                                        verifyCode:(NSString *)verifyCode
                                              type:(NSInteger)type
                                     accountStatus:(NSInteger)accountStatus
                                           Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;


/**
 第三方登录>设置账号密码，绑定++++++++++++++++++暂时不用了++++++++++++++++++++
 @param openid
 @param phone 手机号
 @param verifyCode 验证码
 @param password 登录密码
 @param payPassword 支付密码
 @param type 1微信，2QQ
 */
-(void)RequestAearlyReginsterAPPBindingAccountWith:(NSString *)openid
                                             phone:(NSString *)phone
                                        verifyCode:(NSString *)verifyCode
                                          password:(NSString *)password
                                       payPassword:(NSString *)payPassword
                                              type:(NSInteger)type
                                           Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;



#pragma mark  *** 第三方账号的绑定和解除账号
/**
 第三方绑定账户的查询
 */
-(void)RequestQueryBindThirdAccountWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
/**
 解绑微信
 */
-(void)RequestUnbundlingWeiChatAccountWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
/**
 解绑QQ
 */
-(void)RequestUnbundlingQQAccountWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
/**
 快捷登陆的短信验证码
 * @param phone 手机号
 */
-(void)RequestSMSCodeforShortcurLoginWith:(NSString *)phone Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 快捷登陆 提交数据
 phone 手机号
 smsCode  短信验证码
 */
-(void)RequestCommitDataforShortcurLoginWith:(NSString *)phone smscode:(NSString *)smscode Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;


#pragma mark  *** 我的主页面的 数据请求 **********
/**
 加载 我的主页面的数据 v-1.6
 */
-(void)RequestMeMainAccountInformationSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 我的商品退回列表
 */
-(void)RequestMeMainReturnGoodsWithcurPage:(NSInteger )curPage pageSize:(NSInteger )pageSize Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 足迹 数据
 */
-(void)RequestMeMainBrowsRecordHistoryWithcurPage:(NSInteger )curPage pageSize:(NSInteger )pageSize Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 MyReleaseType,      //我发布的
 MyCheckOutType,     //我的鉴定
 MyBuyOrderType,     //我买到的
 MyReturnType,       //已退回的
 MyBrowsRecord,       //足迹
 鉴定的：@param identifyType 1=全部,2=待付费,3=待送鉴,4=鉴定中,5=已通过,6=未通过
 */
-(void)RequestMeMainOrdreViewDataWithcurPage:(NSInteger )curPage
                                    pageSize:(NSInteger )pageSize
                                  SourVcType:(sourViewControllerEnum)SourVcType
                                identifyType:(NSString *)identifyType
                                     Success:(void (^)(id objc, id respodHeader))success
                                     failure:(void (^)(NSError *error))failure;
@end
