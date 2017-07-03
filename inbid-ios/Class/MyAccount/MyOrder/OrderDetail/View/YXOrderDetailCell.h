//
//  YXOrderDetailCell.h
//  OrderDetail
//
//  Created by 郑键 on 16/12/13.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailBaseDataModel;

/**
 cell样式

 - YXOrderDetailCellNone:                   默认样式
 - YXOrderDetailCellStatus:                 状态
 - YXOrderDetailCellDetail:                 订单详情
 - YXOrderDetailCellPaymentStyle:           支付方式
 - YXOrderDetailCellMailStyle:              邮寄方式
 - YXOrderDetailCellLogistics:              查看物流
 - YXOrderDetailCellMailPickUp:             自提
 - YXOrderDetailTimeDetail:                 时间详情
 */
typedef NS_ENUM(NSUInteger, YXOrderDetailCellStyle) {
    YXOrderDetailCellNone,
    YXOrderDetailCellStatus,
    YXOrderDetailCellDetail,
    YXOrderDetailCellPaymentStyle,
    YXOrderDetailCellMail,
    YXOrderDetailCellLogistics,
    YXOrderDetailCellMailPickUp,
    YXOrderDetailTimeDetail,
};

/**
 *倒计时通知名
 */
static NSString * const YXOrderDetailCellCountDownNotification = @"YXOrderDetailCellCountDownNotification";

@interface YXOrderDetailCell : UITableViewCell

/**
 当前属于那种类型
 */
@property (nonatomic, assign) YXOrderDetailCellStyle style;

/**
 基础模型
 */
@property (nonatomic, assign) YXOrderDetailBaseDataModel *orderDetailBaseDataModel;

@end
