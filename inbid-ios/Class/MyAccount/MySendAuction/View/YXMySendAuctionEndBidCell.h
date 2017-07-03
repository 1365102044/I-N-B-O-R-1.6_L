//
//  YXMySendAuctionEndBidCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMySendAuctionEndBid;
@class YXMySendAuctionEndBidCell;

@protocol YXMySendAuctionEndBidCellDelegate <NSObject>

/**
 点击push退回界面

 @param sendAuctionEndBidCell 当前点击的Cell
 */
- (void)sendAuctionEndBidCell:(YXMySendAuctionEndBidCell *)sendAuctionEndBidCell;

@end

@interface YXMySendAuctionEndBidCell : UITableViewCell

/**
 数据接口
 */
@property (nonatomic, strong) YXMySendAuctionEndBid *mySendAuctionEndBidModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXMySendAuctionEndBidCellDelegate> delegate;

@end
