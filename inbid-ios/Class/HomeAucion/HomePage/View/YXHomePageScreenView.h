//
//  YXHomePageScreenView.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXHomePageScreenView;

@protocol YXHomePageScreenViewDelegate <NSObject>

/**
 条件筛选按钮点击事件代理方法

 @param homePageScreenView homePageScreenView
 @param sender             sender（必传）
 */
- (void)homePageScreenView:(YXHomePageScreenView *)homePageScreenView andClickButton:(UIButton *)sender;

@end

@interface YXHomePageScreenView : UIView

/**
 初始化视图
 
 @param viewsDataArray viewsDataArray(必传 expl:@[@{@"title":@"",@"imageNamed":@""}])
 */
+ (instancetype)initWithViewsDataArray:(NSArray *)viewsDataArray;

/**
 代理
 */
@property (nonatomic, weak) id<YXHomePageScreenViewDelegate> delegate;

/**
 选中条件名称
 */
@property (nonatomic, copy) NSString *catName;

/**
 选中的条件按钮的ButtonTag(在选中条件名称前传递，tag从1开始)
 */
@property (nonatomic, assign) NSInteger selectedButtonTag;

/**
 清空所有按钮选中状态
 */
@property (nonatomic, assign) BOOL isClearAllSelectedButton;

/**
 清空当前选中
 */
@property (nonatomic, assign) BOOL isRestCurrentSelected;

@end
