//
//  YXOrderDetailBaseDataModel.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/13.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrderDetailBaseDataModel.h"
#import "YXOrderDetailModel.h"
#import "NSDate+YXExtension.h"
#import "YXStringFilterTool.h"

@interface YXOrderDetailBaseDataModel()

@end

@implementation YXOrderDetailBaseDataModel

#pragma mark - Zero.Const

/**
 TitleKey
 */
static NSString * const YXOrderDetailStatusCellTitleKey                 = @"YXOrderDetailStatusCellTitleKey";

/**
 DetailTitleKey
 */
static NSString * const YXOrderDetailStatusCellDetailTitleKey           = @"YXOrderDetailStatusCellDetailTitleKey";

/**
 imageNameKey
 */
static NSString * const YXOrderDetailStatusAccessImageNamedKey          = @"YXOrderDetailStatusAccessImageNamedKey";

/**
 半小时秒数
 */
NSTimeInterval YXOrderDetailHourAndAHalfSecond                          = 1800;

/**
 48小时秒数
 */
NSTimeInterval YXOrderDetailFortyEightSecond                            = 172800;

/**
 7天秒数
 */
NSTimeInterval YXOrderDetailSevenDaySecond                              = 604800;

#pragma mark - First.赋值&取值

/**
 返回当前订单状态

 @return 当前状态枚举值
 */
- (YXOrderStatus)status
{
    if (!_status) {
        
        /**
         * 订单状态：1未付款，2部分付款，3待发货，4待确认收货，5交易完成，6交易取消, 7已汇款,8汇款审核失 9已收货
         */
        if (_dataModel.orderStatus == 1) {
            if (_dataModel.orderPayType == 4) {
                _status = YXOrderStatusPendingPayment_lineTransfer;
            }
            
            if (_dataModel.orderPayType != 4) {
                _status = YXOrderStatusPendingPayment;
            }
        }
        
        if (_dataModel.orderStatus == 2) {
            //** 未支付定金 */
            if (self.dataModel.isPayedDeposit == 0) _status = YXOrderStatusPartPayment_notPayBond;
            //** 支付过定金 */
            if (self.dataModel.isPayedDeposit == 1) {
                if (self.dataModel.severAlreadyPayment == 0) _status = YXOrderStatusPartPayment_alreadyPayBond;
                if (self.dataModel.severAlreadyPayment != 0) _status = YXOrderStatusPartPayment;
            }
        }
        
        if (_dataModel.orderStatus == 3) {
            //** 未支付定金，分笔支付部分付款 */
             _status = YXOrderStatusPendingDelivery_notPayBond;
            //** TODO：扩展订金+POS支付 */
            //if (self.dataModel.isPayedDeposit == 1) _status = YXOrderStatusPendingDelivery_alreadyPayBond;
        }
        if (_dataModel.orderStatus == 4) _status = YXOrderStatusPendingRecive;
        if (_dataModel.orderStatus == 9) _status = YXOrderStatusPendingSure;
        if (_dataModel.orderStatus == 5) _status = YXOrderStatusSuccess;
        
        if (_dataModel.orderStatus == 6) {
            if (_dataModel.orderRefundStatus == 1) {
                //** 取消订单不需退款 */
                if (_dataModel.refundAmount == 0) {
                    if (_dataModel.isPayedDeposit == 1) {
                        _status = YXOrderStatusCancelNotNeedRefund_payedDeposit;
                    }
                    
                    if (_dataModel.isPayedDeposit == 0) {
                        
                        if (_dataModel.isUserCancel == 1) {
                            _status = YXOrderStatusCancelNotNeedRefund_userCancel;
                        }
                        
                        if (_dataModel.isUserCancel == 0) {
                            _status = YXOrderStatusCancelNotNeedRefund_timeOut;
                        }
                    }
                }
                //** 取消订单需要退款 */
                if (_dataModel.refundAmount > 0) {
                    if (_dataModel.isPayedDeposit == 1) {
                        _status = YXOrderStatusCancelNeedRefund_bondAndPartPayment;
                    }
                    
                    if (_dataModel.isPayedDeposit == 0) {
                        _status = YXOrderStatusCancelNeedRefund_partPayment;
                    }
                }
            }else{
                
                if (_dataModel.isPayedDeposit == 1) {
                    _status = YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit;
                }
            
                if (_dataModel.isPayedDeposit == 0) {
                    _status = YXOrderStatusCancelNotNeedRefund_alreadyRefund;
                }
            }
        }
        
        if (_dataModel.orderStatus == 7) _status = YXOrderStatusCheckTransfer;
        if (_dataModel.orderStatus == 8) _status = YXOrderStatusCheckTransferFaild;
        
    }
    return _status;
}

/**
 组对应行

 @return 返回对应的行
 */
- (NSInteger)numberForSection
{
    if (!_numberForSection) {
        
        if (self.currentSection == 0) {
            
            //** TODO:由于无法查看物流最新接口， 暂时隐藏*/
            if ([self checkOrderStatus]) _numberForSection      = 2;
            if (![self checkOrderStatus]) _numberForSection     = 2;
        }
        
        if (self.currentSection == 1) _numberForSection         = 1;
        if (self.currentSection == 2) _numberForSection         = 2;
        if (self.currentSection == 3) _numberForSection         = self.timeListArray.count;
    }
    return _numberForSection;
}

/**
 时间轴数据

 @return 返回时间轴数据数组
 */
- (NSMutableArray *)timeListArray
{
    if (!_timeListArray) {
        _timeListArray = [NSMutableArray array];
        if ([self checkStringIsEmptyWithString:self.dataModel.createTime]) {
            [_timeListArray addObject:@{YXOrderDetailStatusCellTitleKey:@"创建时间：",
                                        YXOrderDetailStatusCellDetailTitleKey:self.dataModel.createTime}];
        }
        if ([self checkStringIsEmptyWithString:self.dataModel.payedTime]) {
            [_timeListArray addObject:@{YXOrderDetailStatusCellTitleKey:@"支付时间：",
                                        YXOrderDetailStatusCellDetailTitleKey:self.dataModel.payedTime}];
        }
        if ([self checkStringIsEmptyWithString:self.dataModel.deliveryTime]) {
            [_timeListArray addObject:@{YXOrderDetailStatusCellTitleKey:@"发货时间：",
                                        YXOrderDetailStatusCellDetailTitleKey:self.dataModel.deliveryTime}];
        }
        if ([self checkStringIsEmptyWithString:self.dataModel.consigneeTime]) {
            [_timeListArray addObject:@{YXOrderDetailStatusCellTitleKey:@"签收时间：",
                                        YXOrderDetailStatusCellDetailTitleKey:self.dataModel.consigneeTime}];
        }
        if ([self checkStringIsEmptyWithString:self.dataModel.orderDealedCancelTime]) {
            if (self.status == YXOrderStatusCancelNeedRefund_bondAndPartPayment
                || self.status == YXOrderStatusCancelNeedRefund_partPayment
                || self.status == YXOrderStatusCancelNotNeedRefund_userCancel
                || self.status == YXOrderStatusCancelNotNeedRefund_timeOut
                || self.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit
                || self.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund
                || self.status == YXOrderStatusCancelNotNeedRefund_payedDeposit) {
                [_timeListArray addObject:@{YXOrderDetailStatusCellTitleKey:@"取消时间：",
                                            YXOrderDetailStatusCellDetailTitleKey:self.dataModel.orderDealedCancelTime}];
            }else{
                [_timeListArray addObject:@{YXOrderDetailStatusCellTitleKey:@"完成时间：",
                                            YXOrderDetailStatusCellDetailTitleKey:self.dataModel.orderDealedCancelTime}];
            }
        }
    }
    return _timeListArray;
}

/**
 判断当前订单是否为展示物流信息界面
 
 @return 返回是否展示物流  YES.展示物流  NO.不展示物流
 */
- (BOOL)checkOrderStatus
{
    if (self.status == YXOrderStatusPendingRecive
        || self.status == YXOrderStatusPendingSure
        || self.status == YXOrderStatusSuccess) {
        return YES;
    }else{
        return NO;
    }
}

/**
 检查文字是否有值

 @param string string
 @return 返回是否有值 NO.没有值  YES.油值
 */
- (BOOL)checkStringIsEmptyWithString:(NSString *)string
{
    if (string.length == 0 || [string isEqualToString:@""]) {
        return NO;
    }else{
        return YES;
    }
}

/**
 组头高度

 @return 组头高，最小为0.1
 */
- (CGFloat)heightForSectionHeader
{
    if (!_heightForSectionHeader) {
        
        //** 如果取消订单，返回0 */
        if (self.currentSection == 0) {

            if (self.status == YXOrderStatusCancelNeedRefund_bondAndPartPayment
                || self.status == YXOrderStatusCancelNeedRefund_partPayment
                || self.status == YXOrderStatusCancelNotNeedRefund_userCancel
                || self.status == YXOrderStatusCancelNotNeedRefund_timeOut
                || self.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit
                || self.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund
                || self.status == YXOrderStatusCancelNotNeedRefund_payedDeposit) {
                _heightForSectionHeader = 0.1;
            }else{
                _heightForSectionHeader = 70.f;
            }
        }
        if (self.currentSection == 1) _heightForSectionHeader = 112.f;
        if (self.currentSection == 2) _heightForSectionHeader = 10.f;
        if (self.currentSection == 3) _heightForSectionHeader = 45.f;
        
    }
    return _heightForSectionHeader;
}

/**
 组尾高度

 @return 返回最小高度
 */
- (CGFloat)heightForSectionFooter
{
    if (!_heightForSectionFooter) {
        _heightForSectionFooter = 0.1;
    }
    return _heightForSectionFooter;
}

/**
 行高数组的get方法

 @return 返回行高数组
 */
- (NSArray<NSNumber *> *)heightForRow
{
    if (!_heightForRow) {
        
        if (self.currentSection == 0) {
            if (self.dataModel.deliveryType == 0) {
                if (self.status != YXOrderStatusSuccess) {
                    _heightForRow = @[@110, @110, @120];
                }else{
                    _heightForRow = @[@60, @110, @120];
                }
            }
            
            if (self.dataModel.deliveryType == 1) {
                if ([self.dataModel.pickupIdCard isEqualToString:@""]
                    || !self.dataModel.pickupIdCard) {
                    if (self.status != YXOrderStatusSuccess) {
                        _heightForRow = @[@110, @240, @120];
                    }else{
                        _heightForRow = @[@60, @240, @120];
                    }
                }else{
                    if (self.status != YXOrderStatusSuccess) {
                        _heightForRow = @[@110, @270, @120];
                    }else{
                        _heightForRow = @[@60, @270, @120];
                    }
                }
            }
        }
        if (self.currentSection == 1) _heightForRow = @[@180];
        if (self.currentSection == 2) _heightForRow = [self getHeightForRowArrayWithCurrentSectionNumber:self.numberForSection];
        if (self.currentSection == 3) _heightForRow = [self getHeightForRowArrayWithCurrentSectionNumber:self.numberForSection];
    }
    return _heightForRow;
}

/**
 获取当前的行高数组

 @param currentSectionNumber currentSectionNumber
 @return 行高数组
 */
- (NSArray<NSNumber *> *)getHeightForRowArrayWithCurrentSectionNumber:(NSInteger)currentSectionNumber
{
    NSMutableArray *tempArray = [NSMutableArray array];
    CGFloat height = 0;
    if (self.currentSection == 2) height = 44.f;
    if (self.currentSection == 3) height = 30.f;
    for (NSInteger i = 0; i < currentSectionNumber; i++) {
        [tempArray addObject:[NSNumber numberWithFloat:height]];
    }
    return tempArray.copy;
}

/**
 标题

 @return 返回标题
 */
- (NSString *)title
{
    if (self.currentSection == 0) {
        _title = [self checkCurrentStatusWithPart:YXOrderDetailStatusCellTitleKey];
    }
    
    if (self.currentSection == 2) {
        if (self.currentRow == 0) _title = @"付款方式";
        if (self.currentRow == 1) _title = @"支付记录";
    }
    
    if (self.currentSection == 3) {
        NSDictionary *dict = self.timeListArray[self.currentRow];
        _title = dict[YXOrderDetailStatusCellTitleKey];
    }
    
    return _title;
}

/**
 副标题

 @return 返回副标题
 */
- (NSString *)detailTitle
{
    if (self.currentSection == 0) {
        _detailTitle = [self checkCurrentStatusWithPart:YXOrderDetailStatusCellDetailTitleKey];
    }
    
    if (self.currentSection == 2) {
        if (self.currentRow == 0) {
            
            if (self.dataModel.orderPayType == 1) _detailTitle = @"全额支付";
            if (self.dataModel.orderPayType == 2) _detailTitle = @"定金支付";
            if (self.dataModel.orderPayType == 3) _detailTitle = @"分笔支付";
            if (self.dataModel.orderPayType == 4) _detailTitle = @"转账汇款";
            if (self.dataModel.orderPayType == 5) _detailTitle = @"订金+刷卡";
        }
        
        if (self.currentRow == 1) return _detailTitle = @"查看明细";
    }
    
    if (self.currentSection == 3) {
        NSDictionary *dict = self.timeListArray[self.currentRow];
        _detailTitle = dict[YXOrderDetailStatusCellDetailTitleKey];
    }
    
    return _detailTitle;
}

/**
 辅助视图图面名称

 @return 图片名
 */
- (NSString *)accessImageNamed
{
    return [self checkCurrentStatusWithPart:YXOrderDetailStatusAccessImageNamedKey];
}

/**
 根据传入的部分，根据当前条件返回文字信息

 @param part cell 的部分
 @return 返回文字
 */
- (NSString *)checkCurrentStatusWithPart:(NSString *)part
{
    NSString *title;
    NSString *detailTitle;
    NSString *imageNamed = @"ic_orderDetail_right";
    //** ================================判断当前状态================================ */
    //** 待付款 */
    if (self.status == YXOrderStatusPendingPayment) {
        title                   = @"等待您付款";
        detailTitle             = [NSString stringWithFormat:@"%@后，如果您未付款，订单将自动关闭",
                                   self.countDownString];
        imageNamed              = @"ic_orderDetail_pedingPayment";
    }
    
    //** 线下转账 */
    if (self.status == YXOrderStatusPendingPayment_lineTransfer) {
        title                   = @"等待您上传凭证";
        detailTitle             = [NSString stringWithFormat:@"%@内上传转账汇款凭证，如果您未提供凭证，订单将自动关闭",
                                   self.countDownString];
        imageNamed              = @"ic_orderDetail_pendingUpload";
    }
    
    //** 线下转账审核凭证 */
    if (self.status == YXOrderStatusCheckTransfer) {
        title                   = @"已提交转账汇款凭证，款项待入账";
        detailTitle             = @"待客服审核转账信息，如上传凭证有误，可重新编辑上传新的凭证";
        imageNamed              = @"ic_orderDetail_pendingUpload";
    }
    
    //** 线下转账凭证审核失败 */
    if (self.status == YXOrderStatusCheckTransferFaild) {
        title                   = @"不是有效凭证，请重新上传";
        detailTitle             = [NSString stringWithFormat:@"%@内上传转账凭证，如果您未提供凭证，订单将自动关闭。如转账遇到困难，可采用其他方式支付",
                                   self.countDownString];
        imageNamed              = @"icon_cancelCerImage";
    }
    
    //** 部分付款之未支付定金 */
    if (self.status == YXOrderStatusPartPayment_notPayBond) {
        title                   = @"已支付部分货款，等待您支付余款";
        detailTitle             = [NSString stringWithFormat:@"%@后，如果您未支付余款，订单将自动关闭",
                                   self.countDownString];
    }

    
    //** 部分付款之支付定金(不包含部分分笔支付) */
    if (self.status == YXOrderStatusPartPayment_alreadyPayBond) {
        title                   = @"已支付定金，等待您支付尾款";
        detailTitle             = [NSString stringWithFormat:@"%@后，如果您未支付尾款，订单将自动关闭\n已支付定金[¥%@]不予退还",
                                   self.countDownString,
                                   [self setMoneyStrmethodComma:self.dataModel.depositPrice]];
    }
    
    //** 部分付款之货款 */
    if (self.status == YXOrderStatusPartPayment) {
        title                   = @"已支付部分货款，等待您支付余款";
        detailTitle             = [NSString stringWithFormat:@"%@后，如果您未支付余款，订单将自动关闭\n已支付定金[¥%@]不予退还",
                                   self.countDownString,
                                    [self setMoneyStrmethodComma:self.dataModel.depositPrice]];
    }
    
    //** 待发货之未支付定金 */
    if (self.status == YXOrderStatusPendingDelivery_notPayBond) {
        title                   = @"已付款，等待平台发货";
        detailTitle             = @"平台将在48小时内为您安排发货";
    }
    
    //** 待发货之支付定金余下POS */
//    if (self.status == YXOrderStatusPendingDelivery_alreadyPayBond) {
//        title                   = @"已支付订金，等待平台配货";
//        detailTitle             = @"平台将在付款后48小时内为您安排配货，商品配置至您选择的字体地址后，胤宝会以短信形式通知您。";
//    }
    
    //** 待收货 */
    if (self.status == YXOrderStatusPendingRecive) {
        if (self.dataModel.deliveryType == 0) {
            title               = @"平台已发货";
            detailTitle         = [NSString stringWithFormat:@"已通过%@为您派送商品，请保持手机通畅",
                                   self.dataModel.deliveryMerchant];
        }
        
        if (self.dataModel.deliveryType == 1) {
            title               = @"商品已到达自提点";
            detailTitle         = @"请携带本人身份证到自提地址提取您购买的商品，如需其他人代提货，请携带代办人及您本人的身份证";
        }
    }
    
    //** 待确认 */
    if (self.status == YXOrderStatusPendingSure) {
        if (self.dataModel.deliveryType == 0) {
            title               = @"物流已签收，请确认收货";
        }
        
        if (self.dataModel.deliveryType == 1) {
            title               = @"买家已取货，请确认收货";
        }
        detailTitle             = [NSString stringWithFormat:@"系统将在%@后自动确认收",
                                   self.countDownString];
    }
    
    //** 交易完成 */
    if (self.status == YXOrderStatusSuccess) {
        title                   = @"已确认，交易成功";
    }
    
    //** 取消需要退款定金和部分货款 */
    if (self.status == YXOrderStatusCancelNeedRefund_bondAndPartPayment
        || self.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit) {
        title                   = @"订单已取消";
        detailTitle             = [NSString stringWithFormat:@"由于您未在约定时间内支付余款，订单已取消\n已支付定金[¥%@]已按约定扣除，已付金额[¥%@]可申请退款",
                                   [self setMoneyStrmethodComma:self.dataModel.depositPrice],
                                   [self setMoneyStrmethodComma:self.dataModel.severAlreadyPayment]];
    }
    
    //** 取消需要退款部分货款 */
    if (self.status == YXOrderStatusCancelNeedRefund_partPayment) {
        title                   = @"订单已取消";
        detailTitle             = [NSString stringWithFormat:@"由于您未在约定时间内支付余款，订单已取消\n已付金额[¥%@]可申请退款",
                                   [self setMoneyStrmethodComma:self.dataModel.alreadyPayAmount]];
    }
    
    //** 取消不需退款--用户主动取消 */
    if (self.status == YXOrderStatusCancelNotNeedRefund_userCancel) {
        detailTitle             = @"您取消了这笔订单";
        title                   = @"订单已取消";
        imageNamed              = @"icon_cancelCerImage";
    }
    
    //** 超时取消 */
    if (self.status == YXOrderStatusCancelNotNeedRefund_timeOut
        || self.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund) {
        detailTitle             = @"由于您未在约定时间内支付尾款，订单已取消";
        title                   = @"订单已取消";
        imageNamed              = @"icon_cancelCerImage";
    }
    
    //** 取消不需要退款--付过定金 */
    if (self.status == YXOrderStatusCancelNotNeedRefund_payedDeposit) {
        title                   = @"订单已取消";
        detailTitle             = [NSString stringWithFormat:@"由于您未在约定时间内支付余款，订单已取消\n已支付定金[¥%@]已按约定扣除",
                                   [self setMoneyStrmethodComma:self.dataModel.depositPrice]];
        imageNamed              = @"icon_cancelCerImage";
    }
    
    if ([part isEqualToString:YXOrderDetailStatusCellTitleKey])         return title;
    if ([part isEqualToString:YXOrderDetailStatusCellDetailTitleKey])   return detailTitle;
    if ([part isEqualToString:YXOrderDetailStatusAccessImageNamedKey])  return imageNamed;
    
    return @"数据错误";
}

/**
 科学计数法
 
 @param price 价格
 */
- (NSString *)setMoneyStrmethodComma:(long long)price
{
    return [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", price]];
}

/**
 服务器时间

 @return 返回服务器返回时间
 */
- (NSDate *)severTime
{
    if (!_severTime) {
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        if (self.status == YXOrderStatusPendingPayment
            || self.status == YXOrderStatusPendingPayment_lineTransfer) {
            NSDate *severTime = [dateformatter dateFromString:self.dataModel.createTime];
            _severTime = [NSDate dateWithTimeInterval:YXOrderDetailHourAndAHalfSecond sinceDate:severTime];
        }
        
        if (self.status == YXOrderStatusPartPayment
            || self.status == YXOrderStatusPartPayment_notPayBond
            || self.status == YXOrderStatusPartPayment_alreadyPayBond
            || self.status == YXOrderStatusCheckTransferFaild) {
            NSDate *severTime = [dateformatter dateFromString:self.dataModel.createTime];
            _severTime = [NSDate dateWithTimeInterval:YXOrderDetailFortyEightSecond sinceDate:severTime];
            
        }
        
        if (self.status == YXOrderStatusPendingSure) {
            NSDate *severTime = [dateformatter dateFromString:self.dataModel.consigneeTime];
            _severTime = [NSDate dateWithTimeInterval:YXOrderDetailSevenDaySecond sinceDate:severTime];
        }
    }
    return _severTime;
}

/**
 获取倒计时时间
 
 @return 返回倒计时时间
 */
- (NSTimeInterval)surplusBidTime
{
    if (_surplusBidTime == CGFLOAT_MIN) {
        _surplusBidTime = [self.severTime timeIntervalSinceDate:[self timeStringToTimeDateWithDateStr:self.dataModel.systemCurrentTime]];
        if (_surplusBidTime <= 0) {
            _surplusBidTime = 0;
            return _surplusBidTime;
        }
    }
    return _surplusBidTime;
}

/**
 倒计时时间

 @return 返回倒计时字符串
 */
- (NSString *)countDownString
{
    if (self.surplusBidTime <= 0) {
        return @"倒计时已结束";
    }
    
    NSDate *now                 = [self timeStringToTimeDateWithDateStr:self.dataModel.systemCurrentTime];
    NSCalendar *calendar        = [NSCalendar currentCalendar];
    // 比较时间
    NSCalendarUnit unit         = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour |
    NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps      = [calendar components:unit
                                              fromDate:self.severTime
                                                toDate:now
                                               options:0];
    
    //** 判断是否有天 */
    if (cmps.day != 0) {
        return [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒",
                (long)self.surplusBidTime/86400,
                (long)self.surplusBidTime%86400/3600,
                (long)self.surplusBidTime%3600/60,
                (long)self.surplusBidTime%60];
    }else{
        //** 判断是否有小时 */
        if (cmps.hour != 0) {
            return [NSString stringWithFormat:@"%ld时%ld分%ld秒",
                    (long)self.surplusBidTime%86400/3600,
                    (long)self.surplusBidTime%3600/60,
                    (long)self.surplusBidTime%60];
        }else{
            //** 判断是否有分钟 */
            if (cmps.minute != 0) {
                return [NSString stringWithFormat:@"%ld分%ld秒",
                        (long)self.surplusBidTime%3600/60,
                        (long)self.surplusBidTime%60];
            }else{
                return [NSString stringWithFormat:@"%ld秒",
                        (long)self.surplusBidTime%60];
            }
        }
    }
}

/**
 字符串时间转NSDate

 @param dateStr dateStr
 @return 返回date
 */
- (NSDate *)timeStringToTimeDateWithDateStr:(NSString *)dateStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    return inputDate;
}

/**
 当前调用支付控制器类型

 @return 返回调用支付控制器类型枚举
 */
- (YXPaymentHomePageControllerType)type
{
    //** 全额支付 */
    if (self.dataModel.orderPayType == 1
        && self.dataModel.isPartPay == 0) {
        //** TODO:判断是一口价商品还是拍品，目前写死一口价产品 */
        _type           = YXPaymentHomePageControllerFixGood;
    }
    
    //** 定金支付 */
    if (self.dataModel.orderPayType == 2) {
        
        //** 支付过定金 */
        if (self.dataModel.isPayedDeposit == 1) {
            if (self.dataModel.isPartPay == 0) {
                _type       = YXPaymentHomePageControllerDepositExcept;
            }else if (self.dataModel.isPartPay == 1) {
                _type       = YXPaymentHomePageControllerDepositExcept_partPayment;
            }
        }
        
        //** TODO：未支付过定金分笔，暂时写死一口价产品，后期扩展拍品 */
        if (self.dataModel.isPayedDeposit == 0) {
            _type       = YXPaymentHomePageControllerDeposit;
        }
    }
    
    //** 分笔支付 */
    if (self.dataModel.orderPayType == 3) {
        //** TODO:后期扩展拍品 */
        _type           = YXPaymentHomePageControllerFixGood_partPayment;
    }
    
    //** 转账汇款 */
    if (self.dataModel.orderPayType == 4) {
        _type           = YXPaymentHomePageControllerLineTransfer;
    }
    
    //** 订金+刷卡 */
    if (self.dataModel.orderPayType == 5) {
        
    }
    return _type;
}

/**
 倒计时
 */
- (void)countDown
{
    self.surplusBidTime -= 1;
}

@end
