//
//  YXGoodsDeatilRequestTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXGoodsDeatilRequestTool : YXNetworkTool

+(instancetype)sharedTool;

//** 检查是否是自己的商品*/
-(void)CheckIsSelfGoodsWithProBidId:(NSString *)proBidId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//**商品详情的数据加载*/
-(void)LoadDeatilDataWithProBidId:(NSString *)proBidId ProId:(NSString *)ProId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 1 关注 , 2 取消关注
 */
-(void)AttenOrCancleAttentWithProId:(NSString *)ProId type:(NSInteger)type Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;



#pragma mark  *** 确认订单界面

//**确认订单界面的数据加载*/
-(void)LoadConfirmOrderDataWithProBidId:(NSString *)proBidId Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//**设置身份证号码接口*/
-(void)SetIdCardNumberWithAddressId:(NSString *)addressid Idcard:(NSString *)idcard Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 点击去支付 */
-(void)GotoPayWithprodBidId:(NSString *)prodBidId DeliverType:(NSString *)deliveryType addressId:(NSString *)addressId PickId:(NSString *)pickId  orderPayType:(NSString *)orderPayType Success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;



@end
