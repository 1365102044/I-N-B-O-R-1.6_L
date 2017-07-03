//
//  YXHomePageNetRequestTool.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/2.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountNetRequestTool.h"
#import "YXMyAccountURLMacros.h"
#import "YXStringFilterTool.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXSaveLoginDataTool.h"

@interface YXMyAccountNetRequestTool()

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

@end

@implementation YXMyAccountNetRequestTool

+(instancetype)sharedTool{
    static YXMyAccountNetRequestTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXMyAccountNetRequestTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
//        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        tool.responseSerializer = [[AFHTTPResponseSerializer alloc] init];

//        [tool.requestSerializer setValue:@"DDA12A3CFBA7463E900FFDC8383010B912345678901234567890123456789012345956751384719067" forHTTPHeaderField:@"id"];
        
        tool.securityPolicy.allowInvalidCertificates = YES;
        tool.securityPolicy.validatesDomainName = NO;
        
        //** 解决http请求重定向 */
//        [tool setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
//            return request;
//        }];
        
    });
    return tool;
}

//** 获取基本资料 */
-(void)loadBaseDataWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    [YXNetworkHUD show];
    [self requestDataWithType:POST url:MYACCOUNTBASEDATA_URL params:nil success:^(id objc, id respodHeader) {
//        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
//            [self showRemindGoodsViewWithType:@"登录状态异常"];
//            return;
//        }
        [YXNetworkHUD dismiss];
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

//** 修改生日/性别/邮箱 */
-(void)editBirthdayOrSexOrEmailWithBrithday:(NSString *)birthday sex:(NSString *)sex email:(NSString *)email  nickName:(NSString *)nickName success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params;
    
    if (sex) {
        params = @{@"sex":sex};
    }else if (birthday){
        params = @{@"birthday":birthday};
    }else if (email){
        params = @{@"email":email};
    }else if (nickName)
    {
        params = @{@"nickName":nickName};
    }
    
    [self requestDataWithType:POST url:MYEDITBIRTHDAYORSEXOREMAIL_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 退出登录 */
- (void)logOutWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    [self requestDataWithType:POST url:MYLOGOUT_URL params:nil success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
//            KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"UserToken"accessGroup:nil];
//            [wrapper resetKeychainItem];
            [YXUserDefaults setObject:@"3" forKey:@"FromeMianLoginSatus"];
            
        }
        
        
   
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 关注竞拍 */
- (void)loadMyQueryMenberCollectionList:(NSInteger)currentPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                           @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYQUERYMEMBERCOLLECTIONLIST_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 正在竞拍 */
- (void)loadMyQueryPiddingByMemberId:(NSInteger)currentPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYQUERYPIDDINGBYMEMBERID_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

//** 结束竞拍 */
- (void)loadMyQueryPidOverByMemberId:(NSInteger)currentPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYQUERYPIDOVERBYMEMBERID_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 判断是否提交保证金 */
- (void)loadIsSubmitBondWithBidId:(NSString *)bidId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"bidId":bidId};
    
    [self requestDataWithType:POST url:CHECKENSUREMONEY_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 提交保证金接口 */
- (void)submitBondWithBidId:(NSString *)bidId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"bidId":bidId};
    
    [self requestDataWithType:POST url:COMMITESUREMONEY_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

////** 我的订单 */
//- (void)loadMyQueryAccountInfoWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
//{
//    [self requestDataWithType:POST url:MYQUERYACCOUNTINFO_URL params:nil success:^(id objc, id respodHeader) {
//        //** 未登录 */
//        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
//            
//            //** 通知我的视图弹起登录界面 */
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
//            
//            return;
//        }
//        success(objc, respodHeader);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

//** 获取地址列表 */
- (void)loadMyAddressWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    //[YXNetworkHUD show];
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYADDRESSGETADDRESS_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 删除地址 */
- (void)deleteAddressWithAddressId:(long long)addressId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"id":[NSString stringWithFormat:@"%lld", addressId]};
    
    [self requestDataWithType:POST url:MYADDRESSDELADDRESS_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 切换默认地址 */
- (void)setDefaultAddressWithAddressId:(long long)addressId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"id":[NSString stringWithFormat:@"%lld", addressId]};
    
    [self requestDataWithType:POST url:MYUPDATEACQUIESCEADDRESS_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 添加新地址 */
- (void)addNewAddressWithReceiveName:(NSString *)receiveName withPhoneNumber:(NSString *)phoneNumber withProvince:(NSString *)preovince withCity:(NSString *)city area:(NSString *)area withConsigneeAddressDetail:(NSString *)consigneeAddressDetail withIsDefault:(NSInteger)isDefault success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"province":preovince,
                             @"city":city,
                             @"area":area,
                             @"phone":phoneNumber,
                             @"name":receiveName,
                             @"consigneeAddressDetail":consigneeAddressDetail,
                             @"isDefault":[NSString stringWithFormat:@"%zd", isDefault]};
    
    [self requestDataWithType:POST url:MYADDRESSADDADDRESS_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 编辑地址 */
- (void)editAddressWithReceiveName:(NSString *)receiveName withPhoneNumber:(NSString *)phoneNumber withProvince:(NSString *)preovince withCity:(NSString *)city area:(NSString *)area withConsigneeAddressDetail:(NSString *)consigneeAddressDetail withIsDefault:(NSInteger)isDefault withAddressId:(long long)addressId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    //** 判断是否是暗文手机号 */
    NSDictionary *params;
    if ([phoneNumber containsString:@"*"]) {
        params = @{@"province":preovince,
                   @"city":city,
                   @"area":area,
                   @"name":receiveName,
                   @"consigneeAddressDetail":consigneeAddressDetail,
                   @"isDefault":[NSString stringWithFormat:@"%zd", isDefault],
                   @"id":[NSString stringWithFormat:@"%lld", addressId]};
    }else{
        params = @{@"province":preovince,
                   @"city":city,
                   @"phone":phoneNumber,
                   @"name":receiveName,
                   @"consigneeAddressDetail":consigneeAddressDetail,
                   @"isDefault":[NSString stringWithFormat:@"%zd", isDefault],
                   @"id":[NSString stringWithFormat:@"%lld", addressId]};
    }
    
    
    [self requestDataWithType:POST url:MYADDRESSEDITADDRESS_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

//** 等待鉴定 */
- (void)loadMySendAShortWaitIdentifyWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYSENDASHOT_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 正在寄拍 */
- (void)loadIngBidListWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYINBID_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 完成寄拍 */
- (void)loadEndBidListWithCurPage:(NSInteger)currentPage andPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage":[NSString stringWithFormat:@"%zd", currentPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYCOMPLETEBID_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 等待鉴定立即鉴定列表 */
- (void)loadImmediatelyIdentifiedListWithIdentifyId:(NSString *)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"identifyId":identifyId};
    
    [self requestDataWithType:POST url:MYHOLDIDENTIFYNOW_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 修改登录密码 */
- (void)updataPwdWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"oldPwd":oldPwd,
                             @"newPwd":[YXStringFilterTool getSha1String:newPwd]};
    
    [self requestDataWithType:POST url:UPDATEPWD_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 立即邮寄 */
- (void)mailNowWithOrderIdentifyId:(long long)orderIdentifyId withIsDelivery:(BOOL)isDelivery withDeliverNum:(NSString *)deliverNum withDeliveryMerchant:(NSString *)deliveryMerchant success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%lld", orderIdentifyId] forKey:@"identifyId"];
    [params setObject:[NSString stringWithFormat:@"%zd", isDelivery] forKey:@"deliveryType"];
    [params setObject:deliverNum forKey:@"deliveryNum"];
    [params setObject:deliveryMerchant forKey:@"deliveryMerchant"];
    
    [self requestDataWithType:POST url:MYHOLDMAILNOW_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//** 立即邮寄获取公司地址 */
- (void)mailNowLoadMyAddressWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    [self requestDataWithType:POST url:MYSENDAUCTIONNOWMAILMYADDRESS_URL params:nil success:^(id objc, id respodHeader) {
        //** 未登录 */
        //if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            //return;
        //}
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 平台代卖/平台回收 */
- (void)platformBidOrPlatformRecoverWithOrderIdentifyId:(long long )orderIdentifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"IdentifyId":[NSString stringWithFormat:@"%lld", orderIdentifyId]};
    
    [self requestDataWithType:POST url:MYHOLDPLATFORMBID_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 平台代卖之确认代卖

 @param identifyId identifyId description
 @param suggestPrice suggestPrice description
 @param userSetPrice userSetPrice description
 @param success success description
 @param failure failure description
 */
- (void)sureReplaceSellWithIdentifyId:(long long)identifyId
                     withSuggestPrice:(NSInteger)suggestPrice
                     withUserSetPrice:(NSString *)userSetPrice
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"identifyId": [NSString stringWithFormat:@"%lld", identifyId],
                             @"suggestPrice": [NSString stringWithFormat:@"%zd", suggestPrice],
                             @"setPrice": userSetPrice};
    
    [self requestDataWithType:POST url:MYHOLDREPLACESELL_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 平台回收之同意回收 */
- (void)confirmRecycleWithIdentifyId:(long long)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"identifyId":[NSString stringWithFormat:@"%lld", identifyId]};
    
    [self requestDataWithType:POST url:MYCONFIRMRECYCLE_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 立即鉴定 */
- (void)identifyNowWithIdentifyId:(long long)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"IdentifyId":[NSString stringWithFormat:@"%lld", identifyId]};
    
    [self requestDataWithType:POST url:MYHOLDIDENTIFYNOW_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取预鉴定详情

 @param identifyId 鉴定订单id
 @param success    成功回调
 @param failure    失败回调
 */
- (void)identifyDetailWithIdentifyId:(long long)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"identifyId":[NSString stringWithFormat:@"%lld", identifyId]};
    
    [self requestDataWithType:POST url:MYHOLDIDENTIFYGETIDENTIFYDETAILS_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取快递公司地址
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getExpressListSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:MYSENDAUCTIONEXPRESSCOMPANYLIST_URL params:nil success:^(id objc, id respodHeader) {
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                                 failure:(void (^)(NSError *error))failure
{
    NSDictionary *temDict = @{@"payPassword": [YXStringFilterTool getSha1String:payPassword],
                             @"orderId": [NSString stringWithFormat:@"%lld", orderId],
                             @"deliveryType": [NSString stringWithFormat:@"%zd", deliveryType],
                             @"refundType": [NSString stringWithFormat:@"%zd", refundType],
                             @"prodId": [NSString stringWithFormat:@"%lld", prodId],
                             @"verifyCode" : imagecode};
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:temDict];
    
    if (deliveryType != 1) {
        [params setValue:[NSString stringWithFormat:@"%lld", consigneeId] forKey:@"consigneeId"];
    }
    
    if (buyoutId != 0) {
        [params setValue:[NSString stringWithFormat:@"%lld", buyoutId] forKey:@"buyoutId"];
    }
    
    [self requestDataWithType:POST url:MYSENDAUCTIONADDREFUNDDELIVERY_URL params:params success:^(id objc, id respodHeader) {
        //** 未登录 */
        if ([respodHeader[@"Status"] isEqualToString:@"3"]) {
            
            //** 通知我的视图弹起登录界面 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modalLoginController" object:nil userInfo:nil];
            
            return;
        }
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 查看鉴定结果

 @param identifyId 鉴定订单编号
 @param success    成功回调
 @param failure    失败回调
 */
- (void)getIdentifyResultWithIdentifyId:(long long)identifyId success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"identifyId":[NSString stringWithFormat:@"%lld", identifyId]};
    
    [self requestDataWithType:POST url:MYSENDAUCTIONIDENTIFYREPORT_URL params:params success:^(id objc, id respodHeader) {
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 我的一口价列表
 
 @param bidType  bidType 1.全部 2.正在售卖 3.已完成
 @param curPage  curPage
 @param pageSize pageSize
 @param success  success
 @param failure  failure
 */
- (void)getFixPriceBidListWithBidType:(NSInteger)bidType
                              curPage:(NSInteger)curPage
                             pageSize:(NSInteger)pageSize
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"bidType":[NSString stringWithFormat:@"%zd", bidType],
                             @"curPage":[NSString stringWithFormat:@"%zd", curPage],
                             @"pageSize":[NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:MYSENDFIXPRICEBID_URL params:params success:^(id objc, id respodHeader) {
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"identifyId":[NSString stringWithFormat:@"%lld", identifyId],
                             @"saleDay":saleDay,
                             @"buyoutPrice":buyoutPrice};
    
    [self requestDataWithType:POST url:MYSENDAUCTIONBUYOUTSETPRICE_URL params:params success:^(id objc, id respodHeader) {
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 一口价流拍后重选
 
 @param identifyId 一口价拍品编号
 @param success    成功
 @param failure    失败
 */
- (void)setBuyoutChooseWithIdentifyId:(long long)identifyId
                              success:(void (^)(id objc, id respodHeader))success
                              failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"id":[NSString stringWithFormat:@"%lld", identifyId]};
    
    [self requestDataWithType:POST url:MYSENDAUCTIONBUYOUTCHOOSE_URL params:params success:^(id objc, id respodHeader) {
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *params;
    if (type == 2) {
        params = @{@"id":[NSString stringWithFormat:@"%lld", fixId],
                   @"saleDay":saleDay,
                   @"buyoutPrice":buyoutPrice,
                   @"type":[NSString stringWithFormat:@"%zd", type]};
    }else{
        params = @{@"id":[NSString stringWithFormat:@"%lld", fixId],
                   @"type":[NSString stringWithFormat:@"%zd", type]};
    }
    
    
    [self requestDataWithType:POST url:MYSENDAUCTIONBUYOUTCHOOSECONFIRM_URL params:params success:^(id objc, id respodHeader) {
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 加载订单详情数据
 
 @param orderId 订单id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadOrderDetailWithOrderId:(long long)orderId
                           success:(void (^)(id objc, id respodHeader))success
                           failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *params = @{@"orderId":[NSString stringWithFormat:@"%lld", orderId]};
    
    [self requestDataWithType:POST url:MYORDERDETAIL_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                         failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD showWithOverlay];
    NSDictionary *params = @{@"orderId":[NSString stringWithFormat:@"%lld", orderId],
                             @"orderPayType":[NSString stringWithFormat:@"%zd",orderPaytype]};
    
    [self requestDataWithType:POST url:MYORDERDETAILCHANGEPAYTYPE_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 确认收货
 
 @param orderId 订单id
 @param success 成功
 @param failure 失败
 */
- (void)makeSureConsigneeWithOrder:(long long)orderId
                           success:(void (^)(id objc, id respodHeader))success
                           failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD showWithOverlay];
    NSDictionary *params = @{@"orderId":[NSString stringWithFormat:@"%lld", orderId]};
    
    [self requestDataWithType:POST url:MYORDERDETAILCONFIRMCONSIGNEE_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                       failure:(void (^)(NSError *error))failure
{
    
    [YXNetworkHUD showWithOverlay];
    NSDictionary *params = @{@"orderId":[NSString stringWithFormat:@"%lld", orderId],
                             @"reason":reasonString};
    
    [self requestDataWithType:POST url:MYORDERDETAILCANCELORDER_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                                   failure:(void (^)(NSError *error))failure
{
    NSDictionary *params ;
    NSString *url;
    if (formeVCtype == YXInputVerificationCodeViewControllerTypeBinding) {
        params = @{@"phone": phoneNumber,
                   @"type":[NSString stringWithFormat:@"%lu",(unsigned long)longintype]};
        
        url = THRIDLOGINSMSCODE_URL;
        
    }else{
        params = @{@"phone": phoneNumber};
        url = REIGSTERVERPHONENUMBER_URL;
    }
    
    [self requestDataWithType:POST url:url params:params success:^(id objc, id respodHeader) {

        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 注册用户信息校验
 
 @param phoneNumber 电话号码
 @param message 信息
 @param success 成功
 @param failure 失败
 */
- (void)registerCheckUserInformationWithPhoneNumber:(NSString *)phoneNumber
                                            message:(NSString *)message
                                            success:(void (^)(id objc, id respodHeader))success
                                            failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"phone": phoneNumber,
                             @"smsCode": message,
                             @"prodBids":[[YXSaveLoginDataTool shared] ReadMyBrowsRecord]
                             };
    
    [self requestDataWithType:POST url:REGISTERCHECKUSER_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

/**
 忘记密码重置密码短信验证码获取
 
 @param message 信息
 @param success 成功
 @param failure 失败
 */
- (void)loadResetPwdVerificationCodeWithPhoneNumber:(NSString *)phoneNumber
                                            success:(void (^)(id objc, id respodHeader))success
                                            failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"phone": phoneNumber};
    
    [self requestDataWithType:POST url:RESETPWDVERIFICATIONCODE_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                                    failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"phone": phoneNumber,
                             @"smsCode": message};
    
    [self requestDataWithType:POST url:RESETPWDCHECKVERIFICATIONCODE_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                         failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"phone": phoneNumber,
                             @"newPassWord": [YXStringFilterTool getSha1String:newPwd],
                             @"verifyCode": verifyCode};
    
    [self requestDataWithType:POST url:RESETPWDSETNEWPWD_URL params:params success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        success(objc,respodHeader);
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}

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
                           failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:deliveryType forKey:@"deliveryType"];
    [params setObject:refundType forKey:@"refundType"];
    
    if ([refundType isEqualToString:@"1"]
        || [refundType isEqualToString:@"3"]) {
        [params setObject:orderId forKey:@"orderId"];
    }
    
    if ([refundType isEqualToString:@"2"]) {
        [params setObject:prodId forKey:@"prodId"];
    }
    
    if ([refundType isEqualToString:@"4"]) {
        [params setObject:buyoutId forKey:@"buyoutId"];
        [params setObject:prodId forKey:@"prodId"];
        [params setObject:orderId forKey:@"orderId"];
    }
    
    if ([deliveryType isEqualToString:@"1"]) {
        
    }else if ([deliveryType isEqualToString:@"0"]) {
        [params setObject:consigneeId forKey:@"consigneeId"];
    }
    
    [self requestDataWithType:POST url:CHECKADDREFUNDDELIVERY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                          failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:payPassword forKey:@"payPassword"];
    [params setObject:deliveryType forKey:@"deliveryType"];
    [params setObject:refundType forKey:@"refundType"];
    [params setObject:idCard forKey:@"idCard"];
    
    if ([refundType isEqualToString:@"1"]
        || [refundType isEqualToString:@"3"]) {
        [params setObject:orderId forKey:@"orderId"];
    }
    
    if ([refundType isEqualToString:@"2"]) {
        [params setObject:prodId forKey:@"prodId"];
    }
    
    if ([refundType isEqualToString:@"4"]) {
        [params setObject:buyoutId forKey:@"buyoutId"];
    }
    
    if ([deliveryType isEqualToString:@"1"]) {
        
    }else if ([deliveryType isEqualToString:@"0"]) {
        [params setObject:consigneeId forKey:@"consigneeId"];
    }
    
    [self requestDataWithType:POST url:ADDREFUNDDELIVERY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 弹窗
 
 @param type 弹窗的样式
 */
- (void)showRemindGoodsViewWithType:(NSString *)type
{
    //--弹窗
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = type;
    self.RemindGoodsView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wealself dimssview];
    });
}


//** 取消弹窗 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}


- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

@end
