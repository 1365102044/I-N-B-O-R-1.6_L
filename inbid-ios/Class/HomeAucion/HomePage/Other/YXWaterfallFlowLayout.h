//
//  YXWaterfallFlowLayout.h
//  inbid-ios
//
//  Created by 郑键 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXWaterfallFlowLayout;

@protocol YXWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout;

@end

@interface YXWaterfallFlowLayout : UICollectionViewFlowLayout
/** 代理 */
@property (nonatomic, weak) id<YXWaterflowLayoutDelegate> delegate;

/**
 列数
 */
@property (nonatomic, assign) NSInteger colCount;



@end
