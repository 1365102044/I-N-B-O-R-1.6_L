//
//  YXGoodCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXHomePageGoodList;
@class YXGoodCell;
@class YXMyQuerProdBidListCountTime;

@protocol YXGoodCellDelegate <NSObject>

/**
 缩放手势

 @param goodCell    当前的cell
 @param isScallItem 是否为缩放状态
 */
- (void)goodCell:(YXGoodCell *)goodCell isScalItem:(BOOL)isScallItem;

@end

@interface YXGoodCell : UICollectionViewCell

//** 商品数据,数据接入口 */
@property (nonatomic, strong)YXHomePageGoodList *good;

/**
 代理
 */
@property (nonatomic, weak) id<YXGoodCellDelegate> delegate;

//** 时间模型 */
@property (nonatomic, strong) YXMyQuerProdBidListCountTime *timeModel;

@end
