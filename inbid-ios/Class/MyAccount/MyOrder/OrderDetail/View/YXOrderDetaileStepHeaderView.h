//
//  YXOrderDetaileStepHeaderView.h
//  OrderDetail
//
//  Created by 郑键 on 16/12/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailBaseDataModel;

@interface YXOrderDetaileStepHeaderView : UITableViewHeaderFooterView

/**
 数据
 */
@property (nonatomic, strong) YXOrderDetailBaseDataModel *orderDetailBaseDataModel;

@end
