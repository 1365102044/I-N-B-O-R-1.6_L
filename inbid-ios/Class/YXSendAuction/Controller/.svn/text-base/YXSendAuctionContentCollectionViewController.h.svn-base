//
//  YXSendAuctionContentCollectionViewController.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionFirstHeaderView;
@class YXSendAuctionSecondOtherHeaderView;
@class YXSendAuctionSecondFooterView;

@interface YXSendAuctionContentCollectionViewController : UICollectionViewController

/**
 选中图片带进度模型数组
 */
@property (nonatomic, strong) NSMutableArray *selectedImageModelArray;

/**
 选中的配件数组
 */
@property (nonatomic, strong) NSMutableArray *selectedGoodPartArray;

/**
 第一组组头, 获取品牌
 */
@property (nonatomic, weak, readonly) YXSendAuctionFirstHeaderView *firstHeaderView;

/**
 第二组组头, 获取品牌
 */
@property (nonatomic, weak, readonly) YXSendAuctionSecondOtherHeaderView *secondHeaderView;

/**
 第二组组尾, 获取选取协议状态
 */
@property (nonatomic, weak, readonly) YXSendAuctionSecondFooterView *secondFooterView;

/**
 清空数据
 */
@property (nonatomic, assign) BOOL clearData;

@end
