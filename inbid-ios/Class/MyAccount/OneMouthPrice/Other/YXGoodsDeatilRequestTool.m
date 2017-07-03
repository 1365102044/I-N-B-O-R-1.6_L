//
//  YXGoodsDeatilRequestTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXGoodsDeatilRequestTool.h"
#import "YXHomePageURLMacros.h"

@implementation YXGoodsDeatilRequestTool

+(instancetype)sharedTool
{
    static YXGoodsDeatilRequestTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXGoodsDeatilRequestTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        tool.securityPolicy.allowInvalidCertificates = YES;
        tool.securityPolicy.validatesDomainName = NO;
        
    });
    return tool;
}

//** 检查是否是自己的商品*/
-(void)CheckIsSelfGoodsWithProBidId:(NSString *)proBidId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure{
    
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"prodBidId":proBidId};

    [self requestDataWithType:POST url:CHENGCKSELFBUY_URL params:param success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

-(void)LoadDeatilDataWithProBidId:(NSString *)proBidId ProId:(NSString *)ProId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{
              @"prodBidId":proBidId,
              @"prodId":ProId
              };
    
    [self requestDataWithType:POST url:REQUESTONEPRICEGOODSDEATIL_URL params:param success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
         [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
         [YXNetworkHUD dismiss];
        failure(error);
    }];

}

/**
 1 关注 , 2 取消关注
 */
-(void)AttenOrCancleAttentWithProId:(NSString *)ProId type:(NSInteger)type Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"prodId":ProId};
    NSString *URLSTR ;
    if (type==1) {
        URLSTR = ATTENTIONGOODS_URL;
    }else if (type == 2)
    {
        URLSTR = CANCLEATTENTIONGOODS_URL;
    }
    
    [self requestDataWithType:POST url:URLSTR params:param success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];

}
//**确认订单界面的数据加载*/
-(void)LoadConfirmOrderDataWithProBidId:(NSString *)proBidId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"prodBidId":proBidId};
    
    [self requestDataWithType:POST url:REQUESTCONFIRMORDERDATA_URL params:param success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];

}

//* @param id 收货地址编号
//* @param idCard 身份证号
-(void)SetIdCardNumberWithAddressId:(NSString *)addressid Idcard:(NSString *)idcard Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"id":addressid,
              @"idCard":idcard};
    
    [self requestDataWithType:POST url:SETIDCARDNUMBERWITHADDRESSID_URL params:param success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}
/**
 * @param prodBidId 商品拍卖编号
 * @param deliveryType 物流配送方式，0表示快递，1表示自提
 * @param addressId 收货地址编号
 * @param pickupId 自提信息编号
   @orderPayType 付款方式，1全额支付，2定金支付，3分笔支付，4转账汇款，5订金+刷卡
 */
-(void)GotoPayWithprodBidId:(NSString *)prodBidId DeliverType:(NSString *)deliveryType addressId:(NSString *)addressId PickId:(NSString *)pickId  orderPayType:(NSString *)orderPayType Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [YXNetworkHUD show];
    NSDictionary *param = [NSDictionary dictionary];
    if ([deliveryType isEqualToString:@"1"]) {
        param = @{@"prodBidId":prodBidId,
                  @"deliveryType":deliveryType,
                  @"pickupId":pickId,
                  @"orderPayType":[self orderpaytypewithbtnStr:orderPayType]};
        
    }else if ([deliveryType isEqualToString:@"0"])
    {
        param = @{@"prodBidId":prodBidId,
                  @"deliveryType":deliveryType,
                  @"addressId":addressId,
                  @"orderPayType":[self orderpaytypewithbtnStr:orderPayType]};

    }
    
    [self requestDataWithType:POST url:GOTOPAYFROMECOFIRMORDER_URL params:param success:^(id objc, id respodHeader) {
        
        success(objc, respodHeader);
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        failure(error);
    }];
}
-(NSString *)orderpaytypewithbtnStr:(NSString *)title
{
    NSString *str ;
    if ([title isEqualToString:@"全额支付"]) {
        str = @"1";
    }else  if ([title isEqualToString:@"定金支付"]) {
        str = @"2";
    }else  if ([title isEqualToString:@"分笔支付"]) {
        str = @"3";
    }else  if ([title isEqualToString:@"转账汇款"]) {
        str = @"4";
    }else  if ([title isEqualToString:@"订金+刷卡"]) {
        str = @"5";
    }
    return str;
}



@end
