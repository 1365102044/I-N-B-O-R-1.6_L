//
//  YXOrderDetailBaseDataModel.h
//  OrderDetail
//
//  Created by 郑键 on 16/12/13.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXOrderDetailModel.h"
#import "YXPaymentHomePageController.h"

/**
 当前订单状态

 - YXOrderStatusNone:                                                               无状态
 - YXOrderStatusPendingPayment:                                                     待付款
 - YXOrderStatusPendingPayment_lineTransfer:                                        待付款--线下转账
 - YXOrderStatusPendingDelivery:                                                    待发货
 - YXOrderStatusPendingDelivery_alreadyPayBond:                                     待发货--支付订金
 - YXOrderStatusPendingDelivery_notPayBond:                                         待发货
 - YXOrderStatusPartPayment:                                                        部分付款--支付定金或保证金+部分货款
 - YXOrderStatusPartPayment_alreadyPayBond:                                         部分付款--支付定金
 - YXOrderStatusPartPayment_notPayBond:                                             部分付款--未支付定金
 - YXOrderStatusPendingRecive:                                                      待收货
 - YXOrderStatusCheckTransfer:                                                      转账审核中
 - YXOrderStatusCheckTransferFaild:                                                 转账失败
 - YXOrderStatusApplyReturn:                                                        申请退款--暂无使用
 - YXOrderStatusSuccess:                                                            已成交
 - YXOrderStatusCancelNeedRefund_partPayment:                                       已取消--需要退款--部分货款
 - YXOrderStatusCancelNeedRefund_bondAndPartPayment:                                已取消--需要退款--定金+部分货款
 - YXOrderStatusCancelNotNeedRefund_payedDeposit:                                   已取消--不需要退款--支付过定金
 - YXOrderStatusCancelNotNeedRefund_userCancel:                                     已取消--不需要退款--用户取消
 - YXOrderStatusCancelNotNeedRefund_timeOut:                                        已取消--不需要退款--超时取消
 - YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit:                     已取消--退款后--支付过定金
 - YXOrderStatusCancelNotNeedRefund_alreadyRefund:                                  已取消--退款后--未支付定金
 - YXOrderStatusPendingSure:                                                        待确认
 */
typedef NS_ENUM(NSUInteger, YXOrderStatus) {
    YXOrderStatusNone,
    YXOrderStatusPendingPayment,
    YXOrderStatusPendingPayment_lineTransfer,
    YXOrderStatusPendingDelivery,
    YXOrderStatusPendingDelivery_alreadyPayBond,
    YXOrderStatusPendingDelivery_notPayBond,
    YXOrderStatusPartPayment,
    YXOrderStatusPartPayment_alreadyPayBond,
    YXOrderStatusPartPayment_notPayBond,
    YXOrderStatusPendingRecive,
    YXOrderStatusCheckTransfer,
    YXOrderStatusCheckTransferFaild,
    YXOrderStatusApplyReturn,
    YXOrderStatusSuccess,
    YXOrderStatusCancelNeedRefund_partPayment,
    YXOrderStatusCancelNeedRefund_bondAndPartPayment,
    YXOrderStatusCancelNotNeedRefund_payedDeposit,
    YXOrderStatusCancelNotNeedRefund_userCancel,
    YXOrderStatusCancelNotNeedRefund_timeOut,
    YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit,
    YXOrderStatusCancelNotNeedRefund_alreadyRefund,
    YXOrderStatusPendingSure,
};

@interface YXOrderDetailBaseDataModel : NSObject

//** =========================================================================================== */
//** ============================================公用=========================================== */
//** =========================================================================================== */

/**
 数据
 */
@property (nonatomic, strong) YXOrderDetailModel *dataModel;

/**
 行高
 */
@property (nonatomic, strong) NSArray<NSNumber *> *heightForRow;

/**
 组头高度
 */
@property (nonatomic, assign) CGFloat heightForSectionHeader;

/**
 组尾高度
 */
@property (nonatomic, assign) CGFloat heightForSectionFooter;

/**
 当前订单状态
 */
@property (nonatomic, assign) YXOrderStatus status;

/**
 组对应行
 */
@property (nonatomic, assign) NSInteger numberForSection;

/**
 当前的section
 */
@property (nonatomic, assign) NSInteger currentSection;

/**
 当前行
 */
@property (nonatomic, assign) NSInteger currentRow;

/**
 当前支付订单支付类型
 */
@property (nonatomic, assign) YXPaymentHomePageControllerType type;

//** ================================================================================================= */
//** ==========================================数据&时间轴数据========================================== */
//** ================================================================================================= */

/**
 title
 */
@property (nonatomic, copy) NSString *title;

/**
 副title
 */
@property (nonatomic, copy) NSString *detailTitle;

/**
 时间轴数组
 */
@property (nonatomic, strong) NSMutableArray *timeListArray;

/**
 倒计时展示字符串时间
 */
@property (nonatomic, copy) NSString *countDownString;

/**
 辅助视图图片名
 */
@property (nonatomic, copy) NSString *accessImageNamed;

/**
 服务器时间
 */
@property (nonatomic, strong) NSDate *severTime;

/**
 倒计时计算时间
 */
@property (nonatomic, assign) NSTimeInterval surplusBidTime;

/**
 倒计时方法
 */
- (void)countDown;

@end
