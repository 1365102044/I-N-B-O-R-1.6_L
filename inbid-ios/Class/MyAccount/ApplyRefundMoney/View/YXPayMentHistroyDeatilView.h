//
//  YXPayMentHistroyDeatilView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPayHistroyModle.h"
@class YXPayAndIncomeDetailModel;

typedef void(^heightBlock)(CGFloat heigth);
@interface YXPayMentHistroyDeatilView : UIView
@property(nonatomic,copy) heightBlock Heightblock;

/**
 详情中 没有接口 数据从 列表中拿到
 */
@property(nonatomic,strong) YXPayHistroyModle * DeatilModle;

/**
 钱包明细详情获取的数据
 */
@property (nonatomic, strong) YXPayAndIncomeDetailModel *payAndIncomeDetailModel;

@end
