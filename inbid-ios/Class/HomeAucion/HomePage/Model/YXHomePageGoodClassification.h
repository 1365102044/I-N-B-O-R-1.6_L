//
//  YXHomePageGoodClassification.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXHomePageGoodClassification : NSObject
/**
 * 标签编号
 */
//private Long labelId;
@property (nonatomic, assign)NSInteger labelId;
/**
 * 标签名称
 */
//private String name;
@property (nonatomic, copy)NSString *name;
/**
 * 标签小图标
 */
//private String icon;
@property (nonatomic, copy)NSString *icon;
/**
 * 是否选中，0表示未选中，1表示选中
 */
//private Integer isSelect;
@property (nonatomic, assign)NSInteger isSelect;

//** 分类商品数组 */
@property (nonatomic, strong)NSMutableArray *goodListArray;

//** 当前滚动的位置 */
@property (nonatomic, assign)CGFloat currentContentOffsetY;

/**
 标签图片
 */
@property (nonatomic, strong) UIImage *iconImage;

@end
