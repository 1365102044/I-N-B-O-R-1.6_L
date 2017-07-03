//
//  YXHomePageGoodListCollectionView.h
//  YXHomePageController
//
//  Created by 郑键 on 16/9/8.
//  Copyright © 2016年 郑键. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXWaterfallFlowLayout.h"
#import "YXWaterfallFlowLayoutSmall.h"
@class YXHomePageGoodClassification;
@class YXHomePageGoodListCollectionView;
@class YXHomePageScreenViewModel;

@protocol YXHomePageGoodListCollectionViewDelegate <NSObject>

/**
 push到详情界面

 @param goodListCollectionView 当前的标签下的商品列表
 @param proId                  商品编号
 @param proBidId               拍卖编号
 */
- (void)homePageGoodListPushDeatilController:(YXHomePageGoodListCollectionView *)goodListCollectionView withProdId:(long long)proId withProBidId:(long long)proBidId;

/**
 缩放item

 @param goodListCollectionView 当前的标签下的商品列表
 @param isScale                是否是缩放状态
 */
- (void)homePageGoodListChangeLayout:(YXHomePageGoodListCollectionView *)goodListCollectionView andIsScale:(BOOL)isScale;

/**
 根据数据判断是否隐藏空视图

 @param goodListCollectionView 当前的标签下的商品列表
 @param hiddenTempView         是否隐藏空视图
 */
- (void)homePageGoodListCheckData:(YXHomePageGoodListCollectionView *)goodListCollectionView hiddenTempView:(BOOL)hiddenTempView;

/**
 监听滚动，关闭条件筛选器

 @param goodListCollectionView goodListCollectionView
 @param screenSubViewStatus    screenSubViewStatus
 */
- (void)homePageGoodListCheckData:(YXHomePageGoodListCollectionView *)goodListCollectionView checkScreenSubViewStatus:(BOOL)screenSubViewStatus;

@end

@interface YXHomePageGoodListCollectionView : UICollectionViewController

/**
 对应的labelId
 */
@property (nonatomic, strong) YXHomePageGoodClassification *catoryModel;

/**
 品牌品类模型
 */
@property (nonatomic, strong) id model;

/**
 代理
 */
@property (nonatomic, weak) id<YXHomePageGoodListCollectionViewDelegate> delegate;

/**
 刷新数据
 */
@property (nonatomic, assign) BOOL isDisappear;

/**
 切换layout
 */
@property (nonatomic, assign) BOOL changeLayout;

/**
 当前控制器的编号
 */
@property (nonatomic, assign) NSInteger controllerIndex;

/**
 是否倒计时
 */
@property (nonatomic, assign) BOOL isCountDown;

/**
 筛选条件
 */
@property (nonatomic, strong) YXHomePageScreenViewModel *screenModel;

/**
 价格筛选条件类型 0.无排序 1.升序 2.降序
 */
@property (nonatomic, assign) NSInteger selectedPriceType;

@end
