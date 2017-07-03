//
//  YXPaymentHomepageViewDataBaseModel.h
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXPaymentHomepageViewDataModel.h"

@interface YXPaymentHomepageViewDataBaseModel : NSObject

/**
 组数据
 */
@property (nonatomic, strong) NSArray<YXPaymentHomepageViewDataModel *> *data;

/**
 组行高
 */
@property (nonatomic, copy) NSString *headerHeight;

@end
