//
//  YXMyOrderTitleMenuView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleBlock)(NSInteger index);
@interface YXMyOrderTitleMenuView : UIView


@property (nonatomic,copy) TitleBlock titleBlock;

/**
 *  是否显示滑块
 */
@property (nonatomic,assign) BOOL ShowSlider;
/**
 *  是否显示边框
 */
@property (nonatomic, assign) BOOL ShowBorder;


/**
 *  传入当前controller的偏移位置
 */
- (void)sliderMoveToOffsetX:(CGFloat)x;
/**
 *  根据传入的标题数组初始化
 */
- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr type:(NSString *)type;
@end
