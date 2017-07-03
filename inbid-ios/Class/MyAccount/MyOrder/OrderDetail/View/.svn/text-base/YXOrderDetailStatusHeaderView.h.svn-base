//
//  YXOrderDetailStatusHeaderView.h
//  OrderDetail
//
//  Created by 郑键 on 16/12/12.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailBaseDataModel;

/**
 样式枚举

 - YXOrderDetailHeaderViewNone:         只有顶部分割线
 - YXOrderDetailHeaderViewDetail:       详情带图片
 - YXOrderDetailHeaderViewCancel:       取消订单
 - YXOrderDetailHeaderViewSuccess:      订单交易成功
 */
typedef NS_ENUM(NSUInteger, YXOrderDetailHeaderViewStyle) {
    YXOrderDetailHeaderViewNone,
    YXOrderDetailHeaderViewDetail,
    YXOrderDetailHeaderViewOrderId,
};

@interface YXOrderDetailStatusHeaderView : UITableViewHeaderFooterView

/**
 数据模型
 */
@property (nonatomic, strong) YXOrderDetailBaseDataModel *orderDetailBaseModel;

/**
 界面样式
 */
@property (nonatomic, assign) YXOrderDetailHeaderViewStyle style;

@end
