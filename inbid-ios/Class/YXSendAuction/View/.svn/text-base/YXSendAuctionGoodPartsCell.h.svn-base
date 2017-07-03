//
//  YXSendAuctionGoodPartsCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionGoodPartsModel;
@class YXSendAuctionGoodPartsCell;

@protocol YXSendAuctionGoodPartsCellDelegate <NSObject>

/**
 按钮点击事件

 @param sendAuctionGoodPartsCell sendAuctionGoodPartsCell
 @param model                    model
 */
- (void)sendAuctionGoodPartsCell:(YXSendAuctionGoodPartsCell *)sendAuctionGoodPartsCell andClickButtonModel:(YXSendAuctionGoodPartsModel *)model;

@end

@interface YXSendAuctionGoodPartsCell : UICollectionViewCell

/**
 数据接入
 */
@property (nonatomic, strong) YXSendAuctionGoodPartsModel *model;

/**
 代理
 */
@property (nonatomic, weak) id<YXSendAuctionGoodPartsCellDelegate> delegate;

@end
