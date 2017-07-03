//
//  YXOrederDetailBottomFuncView.h
//  OrderDetail
//
//  Created by 郑键 on 16/12/15.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailBaseDataModel;
@class YXOrederDetailBottomFuncView;

@protocol YXOrederDetailBottomFuncViewDelegate <NSObject>

/**
 功能按钮点击事件

 @param orederDetailBottomFuncView  orederDetailBottomFuncView
 @param sender                      按钮
 */
- (void)orederDetailBottomFuncView:(YXOrederDetailBottomFuncView *)orederDetailBottomFuncView
                    andClickButton:(UIButton *)sender;

@end

@interface YXOrederDetailBottomFuncView : UIView

/**
 数据入口
 */
@property (nonatomic, strong) YXOrderDetailBaseDataModel *orderDetailBaseDataModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXOrederDetailBottomFuncViewDelegate> delegate;

@end
