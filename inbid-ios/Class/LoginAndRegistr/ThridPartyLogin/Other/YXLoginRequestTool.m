//
//  YXLoginRequestManger.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/4.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXLoginRequestTool.h"
#import "YXNetworkTool.h"
#import "YXSaveLoginDataTool.h"
#import "twlt_uuid_util.h"

static NSString *LOGINWITHPHONENUMBER_URL = @"/api/1.6/login";
static NSString *WXLogin_URL = @"api/wx/1.6/login";
static NSString *WXBINDING_URL = @"/api/thirdLogin/checkPhone";
static NSString *QQLOGIN_URL = @"/api/qq/1.6/login";
static NSString *SENDSMSCODETOBINDINGPHONE_URL = @"/api/sms/sendThirdLogin";
//**输入的账号已经注册过胤宝APP， 绑定该手机号 */ v-1.6
//static NSString *ALEARLYREFINSTERAPPBINDINGACCOUNT_URL =@"/api/thirdLogin/bindPhone";
static NSString *ALEARLYREFINSTERAPPBINDINGACCOUNT_URL =@"/api/thirdLogin/1.6/bindPhone";
//**输入的账号未注册过胤宝APP， 绑定该手机号 */
//static NSString *THEPHOENNOTRESEGISTERBINDINGACCOUNT_URL = @"/api/1.5/thirdLogin/setPwd";
static NSString *THEPHOENNOTRESEGISTERBINDINGACCOUNT_URL = @"/api/thirdLogin/1.6/setPwd";
//** 设置账号密码 支付密码的接口，暂时不用了 */
static NSString *SETNEWACCOUNTPASSWORDANDPAYPASSWORD_URL =@"/api/thirdLogin/setPaw";
//** 第三方绑定查询接口 */
static NSString *QUERYTHIRDACCOUNT_URL = @"/api/thirdLogin/bindStatus";
//** 解绑微信 */
static NSString *UNBUNDLINGWEICHATACCOUNT_URL = @"/api/wx/unbindWx";
//** 解绑QQ */
static NSString *UNBUNDLINGQQACCOUNT_URL = @"/api/qq/unbindQQ";
//** 快捷登陆的获取验证码接口 */
static NSString *FORSHORTCURLOGINGETSMSCODE_URL = @"/api/sms/shortcutLogin";
//** 快捷登陆的提交数据接口 */
static NSString *FORSHORTCURLOGINCOMMITDATA_URL = @"/api/1.6/shortcut/login";
//** 我的账户接口 1.6版本 */
static NSString *MEMAINACCOUNTDATA_URL = @"/api/1.6/queryAccountInfo";
//** 足迹 */
static NSString *MEMAINBROWSCORDHISTORY_URL = @"/api/memberHistoryRecord";
//** 我的商品退回列表 */
static NSString *MEMAINRETURNGOODS_URL =  @"/api/1.6/myProdRefundList";
//** 我的鉴定 */
static NSString *MEMAINCHECKOUGOODS_URL =  @"/api/1.6/myIdentifyList";
//** 我发布的 */
static NSString *MEMAINMYRELEASE_URL = @"/api/1.6/myPublishList";
//** 我买到的 */
static NSString *MEMAINMYBUYDOODS_URL = @"/api/order/list";
//** 我发布的 ——> 出售中，已下架*/
static NSString *MEMAINMYRELEASEINGANDSUCCESS_URL = @"/api/1.6/querySellProdList";
//** 我的卖出的 */
static NSString *MYSELLOUTGOODSLIST_URL =@"/api/order/mySaleList";
//** 平台回收 */
static NSString *PLAFORMRETURNLIST_URL = @"/api/1.7/MyRecoveryList";
@implementation YXLoginRequestTool

+(instancetype)sharedTool
{
    static YXLoginRequestTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXLoginRequestTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        tool.securityPolicy.allowInvalidCertificates = YES;
        tool.securityPolicy.validatesDomainName = NO;
    });
    return tool;
}


/**
 登录 phone
 */
-(void)RequestLoginWithPhone:(NSString *)phone
                    password:(NSString *)password
                  verifyCode:(NSString *)verifyCode
                     Success:(void (^)(id objc, id respodHeader))success
                     failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone,
              @"password":password,
              @"uuid":twlt_uuid_create(),
              @"verifyCode":verifyCode,
              @"prodBids":[[YXSaveLoginDataTool shared] ReadMyBrowsRecord]
              };
    
    [self requestDataWithType:POST url:LOGINWITHPHONENUMBER_URL params:param success:^(id objc, id respodHeader){
        
        success(objc, respodHeader);
        [YXNetworkHUD dismiss];
        
    } failure:^(NSError *error) {
        failure(error);
        [YXNetworkHUD dismiss];
    }];
}


/**
 微信第三方登录
 @param code
 */
-(void)RequestWeiChatLoginAccess_tokenWithCode:(NSString *)code Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"code":code,
              @"prodBids":[[YXSaveLoginDataTool shared] ReadMyBrowsRecord]};
    
    [self requestDataWithType:POST url:WXLogin_URL params:param success:^(id objc, id respodHeader){
    
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 QQ 后台交互 QQ第三方登录
 * @param openId  openId
 * @param token  access token
 */
-(void)RequestQQLoginWith:(NSString *)openId access_token:(NSString *)access_token Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{

    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"openId":openId,
              @"token":access_token,
              @"prodBids":[[YXSaveLoginDataTool shared] ReadMyBrowsRecord]};
    
    [self requestDataWithType:POST url:QQLOGIN_URL params:param success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}


/**
 第三方登录 绑定手机号  
 status
	2 失败提示
	1
 flag
 0	该手机未注册 ->设置账号密码
 1	该手机已绑定其他微信  ->重新登录
 2	您的账户已被禁用,请联系客服
 3	该手机已注册过胤宝  ->验证手机号
 */
-(void)RequestBindingPhone:(NSString *)phone type:(NSInteger)type Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
//    [YXNetworkHUD show];
    
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone,
              @"type":[NSString stringWithFormat:@"%ld",(long)type]};
    
    [self requestDataWithType:POST url:WXBINDING_URL params:param success:^(id objc, id respodHeader){
//        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
//        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 第三方登录，校验手机号
 @param phone 手机号
 @param type 1微信，2QQ
 */
-(void)RequestCheckPhoneWith:(NSString *)phone type:(NSInteger)type Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone,
              @"type":[NSString stringWithFormat:@"%ld",(long)type]};
    
    [self requestDataWithType:POST url:SENDSMSCODETOBINDINGPHONE_URL params:param success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                                           Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
//    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone,
              @"openid":openid,
              @"verifyCode":verifyCode,
              @"type":[NSString stringWithFormat:@"%ld",(long)type],
              @"prodBids":[[YXSaveLoginDataTool shared] ReadMyBrowsRecord]};
    
    NSString *url;
    if (accountStatus == 1) {
        
        url = ALEARLYREFINSTERAPPBINDINGACCOUNT_URL;
        
    }else if (accountStatus == 2)
    {
        url = THEPHOENNOTRESEGISTERBINDINGACCOUNT_URL;
    }
    [self requestDataWithType:POST url:url params:param success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}


/**
 第三方登录>设置账号密码，绑定++++++++++++++++++暂时不用了++++++++++++++++++++
 @param openid
 @param phone 手机号
 @param verifyCode 验证码
--- @param password 登录密码
--- @param payPassword 支付密码
 @param type 1微信，2QQ
 */
-(void)RequestAearlyReginsterAPPBindingAccountWith:(NSString *)openid
                                             phone:(NSString *)phone
                                        verifyCode:(NSString *)verifyCode
                                          password:(NSString *)password
                                        payPassword:(NSString *)payPassword
                                              type:(NSInteger)type
                                           Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone,
              @"openid":openid,
              @"verifyCode":verifyCode,
              @"type":[NSString stringWithFormat:@"%ld",(long)type],
              @"password":password,
              @"payPassword":payPassword
              };
    
    [self requestDataWithType:POST url:SETNEWACCOUNTPASSWORDANDPAYPASSWORD_URL params:param success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}


#pragma mark  *** 第三方账号的绑定和解除账号
/**
 第三方绑定账户的查询
 */
-(void)RequestQueryBindThirdAccountWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    [self requestDataWithType:POST url:QUERYTHIRDACCOUNT_URL params:nil success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 解绑微信
 */
-(void)RequestUnbundlingWeiChatAccountWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    [self requestDataWithType:POST url:UNBUNDLINGWEICHATACCOUNT_URL params:nil success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 解绑QQ
 */
-(void)RequestUnbundlingQQAccountWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    [YXNetworkHUD show];
    [self requestDataWithType:POST url:UNBUNDLINGQQACCOUNT_URL params:nil success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}
/**
 快捷登陆的短信验证码
 * @param phone 手机号
 */
-(void)RequestSMSCodeforShortcurLoginWith:(NSString *)phone Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone};
    [self requestDataWithType:POST url:FORSHORTCURLOGINGETSMSCODE_URL params:param success:^(id objc, id respodHeader){
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}
/**
 快捷登陆 提交数据
 phone 手机号
 smsCode  短信验证码
 prodBids 会员浏览足迹的所有拍卖商品id
 */
-(void)RequestCommitDataforShortcurLoginWith:(NSString *)phone smscode:(NSString *)smscode Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"phone":phone,
              @"smsCode":smscode,
              @"prodBids":[[YXSaveLoginDataTool shared] ReadMyBrowsRecord]
              };
    [self requestDataWithType:POST url:FORSHORTCURLOGINCOMMITDATA_URL params:param success:^(id objc, id respodHeader){
      
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}




#pragma mark  *** 我的主页面的 数据请求 **********
/**
 加载 我的主页面的数据 v-1.6
 */
-(void)RequestMeMainAccountInformationSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{

//    [YXNetworkHUD show];
    [self requestDataWithType:POST url:MEMAINACCOUNTDATA_URL params:nil success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 足迹 数据
 */
-(void)RequestMeMainBrowsRecordHistoryWithcurPage:(NSInteger )curPage pageSize:(NSInteger )pageSize Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{

    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"curPage":@(curPage),
              @"pageSize":@(pageSize),
              };

    [self requestDataWithType:POST url:MEMAINBROWSCORDHISTORY_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}
/**
 我的商品退回列表
 */
-(void)RequestMeMainReturnGoodsWithcurPage:(NSInteger )curPage pageSize:(NSInteger )pageSize Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"curPage":@(curPage),
             @"pageSize":@(pageSize),
             };

    [self requestDataWithType:POST url:MEMAINRETURNGOODS_URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}
/**
 MyReleaseType,      //我发布的
 MyCheckOutType,     //我的鉴定
 MyBuyOrderType,     //我买到的
 MyReturnType,       //已退回的
 MyBrowsRecord,       //足迹
 MySellOutType ，    //我出售的
 鉴定的：@param identifyType 1=全部,2=待付费,3=待送鉴,4=鉴定中,5=已通过,6=未通过
  发布的：@param bidType  bidType 1.全部 2.正在售卖 3.已完成
 */
-(void)RequestMeMainOrdreViewDataWithcurPage:(NSInteger )curPage
                                    pageSize:(NSInteger )pageSize
                                  SourVcType:(sourViewControllerEnum)SourVcType
                                identifyType:(NSString* )identifyType
                                     Success:(void (^)(id objc, id respodHeader))success
                                     failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"curPage":@(curPage),
                                                                                 @"pageSize":@(pageSize),
                                                                                 }];
    NSString *URL;
    switch (SourVcType) {
        case MyBrowsRecord:                     //足迹
            URL = MEMAINBROWSCORDHISTORY_URL;
            break;
        case MyReturnType:                      //已退回的
            URL = MEMAINRETURNGOODS_URL;
            break;
        case MyBuyOrderType:                    //我买到的
            URL = MEMAINMYBUYDOODS_URL;
            param[@"listType"] = identifyType;
            break;
        case MyCheckOutType:                    //我鉴定的
            URL = MEMAINCHECKOUGOODS_URL;
            param[@"identifyType"] = @([identifyType integerValue]+1);
            break;
        case MyReleaseType:                     //我发布的
        {
            if ([identifyType isEqualToString:@"0"]) {
                URL = MEMAINMYRELEASE_URL;
            }else {
                param[@"bidType"] = @([identifyType integerValue] + 1);
                URL =  MEMAINMYRELEASEINGANDSUCCESS_URL;
            }
        }
            break;
        case MySellOutType:                         //我卖出的
            URL = MYSELLOUTGOODSLIST_URL;
            param[@"listType"] = identifyType;
            break;
        case MyPlaformReturnType:                   //平台回收
            URL = PLAFORMRETURNLIST_URL;
            break;
        default:
            break;
    }
    [self requestDataWithType:POST url:URL params:param success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}


@end
