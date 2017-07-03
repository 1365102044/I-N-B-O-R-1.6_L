//
//  YXOrderDetailViewController.h
//  OrderDetail
//
//  Created by 郑键 on 16/12/12.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXOrderDetailViewController : UIViewController

/**
 获取订单详情控制器实例

 @param orderId orderId                 订单编号
 @param extend extend                   传入来源控制器(不需使用时可传Nil)
 @return return value                   订单详情控制器实例
 */
+ (instancetype)orderDetailViewControllerWithOrderId:(long long)orderId
                                           andExtend:(id)extend;

@end
