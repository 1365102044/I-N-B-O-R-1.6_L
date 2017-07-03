//
//  YXOrderDetailModel.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/13.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrderDetailModel.h"
#import "YXMySendAuctionTimeList.h"
#import "NSDate+YXExtension.h"
#import "YXProjectImageConfigManager.h"
@implementation YXOrderDetailModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"severAlreadyPayment" : @"alreadyPayAmount",
             @"MYId":@"id",
             };
}

/**
 待付款金额

 @return 待付款金额 单位元
 */
- (long long)calculationAmount
{
    long long tempPrice = 0;
    if (self.depositPrice) tempPrice = self.depositPrice;
    //if (self.marginPrice) tempPrice = self.marginPrice;
    
    _calculationAmount = self.orderTotalAmount + self.protectPrice + self.carriage - self.orderDiscountAmount - self.alreadyPayAmount;
    
    return _calculationAmount;
}

/**
 总金额分转元

 @param orderTotalAmount 订单总金额
 */
- (void)setOrderTotalAmount:(long long)orderTotalAmount
{
    _orderTotalAmount = orderTotalAmount / 100;
}

/**
 已支付的金额

 @param alreadyPayAmount 订单已支付金额
 */
- (void)setSeverAlreadyPayment:(long long)severAlreadyPayment
{
    _severAlreadyPayment = severAlreadyPayment / 100;
}

///**
// 已经支付的金额
//
// @return 订单已支付的金额取值
// */
- (long long)alreadyPayAmount
{
    if (self.isPayedDeposit == 1) {
        _alreadyPayAmount = self.severAlreadyPayment + self.depositPrice;
    }else{
        _alreadyPayAmount = self.severAlreadyPayment;
    }
    
    return _alreadyPayAmount;
}

/**
 保价费分转元

 @param protectPrice 保价费
 */
- (void)setProtectPrice:(long long)protectPrice
{
    _protectPrice = protectPrice / 100;
}

/**
 运费分转元

 @param carriage 运费
 */
- (void)setCarriage:(long long)carriage
{
    _carriage = carriage / 100;
}

/**
 订单优惠金额分转元

 @param orderDiscountAmount 订单优惠金额
 */
- (void)setOrderDiscountAmount:(long long)orderDiscountAmount
{
    _orderDiscountAmount = orderDiscountAmount / 100;
}

/**
 定金金额分转元

 @param depositPrice 定金金额
 */
- (void)setDepositPrice:(long long)depositPrice
{
    _depositPrice = depositPrice / 100;
}

/**
 保证金金额分转元

 @param marginPrice 保证金金额
 */
- (void)setMarginPrice:(long long)marginPrice
{
    _marginPrice = marginPrice / 100;
}

/**
 获取提货人身份证信息

 @return 返回提货人身份证信息
 */
- (NSString *)pickupIdCard
{
    if ([_pickupIdCard isEqualToString:@""]
        || _pickupIdCard.length == 0
        || [_pickupIdCard isKindOfClass:[NSNull class]]) {
        return @"";
    }else{
        return _pickupIdCard;
    }
}

-(NSString *)mainImg{
    if (_mainImg.length ==0) {
        return nil;
    }
    NSArray *imarr = [_mainImg componentsSeparatedByString:@"?"];
    NSString *imaurl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_120",imarr[0]];;
    
    return imaurl;
}
-(NSString *)imgUrl{
    if (_imgUrl.length ==0) {
        return nil;
    }
    NSArray *imarr = [_imgUrl componentsSeparatedByString:@"?"];
//    NSString *imaurl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_120",imarr[0]];
    NSString *imaurl = [YXProjectImageConfigManager projectImageConfigManagerWithImageUrlString:imarr[0] configType:YXProjectImageConfigList];
    return imaurl;
}

/**
 返回 订单编号
 */
-(NSString *)orderNumber{
    if (self.CurrentVcType == MyBuyOrderType||self.CurrentVcType == MySellOutType) return self.orderId;
    else if (self.CurrentVcType == MyReturnType) return self.refundProdId;
    else return self.MYId;
}

/**
 * 订单列表显示状态:1未付款,2已付款物流待发货,3已付款自提待配货,4待收货,5待自提,6已收货待确认收货,7已提货待确认收货,8交易完成待平台打款,9平台已打款交易完成,10超时交易取消,11超时交易取消
 */
//private Integer orderShowStatus;
-(NSString *)orderShowStatusStr{
    if (_orderShowStatus==1) return @"未付款";
    else if (_orderShowStatus ==2) return @"已付款物流待发货";
    else if (_orderShowStatus ==3) return @"已付款自提待配货";
    else if (_orderShowStatus ==4) return @"待收货";
    else if (_orderShowStatus ==5) return @"待自提";
    else if (_orderShowStatus ==6) return @"已收货待确认收货";
    else if (_orderShowStatus ==7) return @"已提货待确认收货";
    else if (_orderShowStatus ==8) return @"交易完成待平台打款";
    else if (_orderShowStatus ==9) return @"平台已打款交易完成";
    else if (_orderShowStatus ==10) return @"超时交易取消";
    else if (_orderShowStatus ==11) return @"超时交易取消";
    return nil;
}

//** =========================================================================================== */
//** ===========================================迁移模型========================================= */
//** =========================================================================================== */


- (void)setTimeList:(NSArray *)timeList
{
    _timeList = [YXMySendAuctionTimeList mj_objectArrayWithKeyValuesArray:timeList];
}

- (void)setSuggestMoney:(NSInteger)suggestMoney
{
    _maxSuggestMoney = suggestMoney + suggestMoney * 0.3;
    _minSuggestMoney = [NSString stringWithFormat:@"%zd", suggestMoney * 0.7];
    _suggestMoney = suggestMoney;
}

@end
