//
//  YXMeMainTableHeaderView.h
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMyAccountBaseData.h"
/**
 headerview点击的事件
 */
typedef enum : NSUInteger {
    iconSLE,                                        // 头像
    nameSLE,                                        // 名字
    colectSLE,                                      // 收藏
    recordSLE,                                      // 足迹
    setSLE,                                         // 设置
} headerviewSleEnum;

typedef void(^clickHeaderBlock)(headerviewSleEnum);

@interface YXMeMainTableHeaderView : UIView

@property(nonatomic,copy) clickHeaderBlock headerBlock;
@property (nonatomic, strong) UIButton *setBtn;

@property(nonatomic,strong) YXMyAccountBaseData * dataModle;

@end
