//
//  YXMyAuctionBaseCell.h
//  MyAuction
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAuctionBaseCell;
@class YXMyAccountFollowAuctionList;

@protocol YXMyAuctionBaseCellDelegate <NSObject>

- (void)myAuctionBaseCell:(YXMyAuctionBaseCell *)myAuctionBaseCell partInAuction:(UIButton *)button withProBidId:(long long)proBidId withProId:(long long)proId;

@end

@interface YXMyAuctionBaseCell : UITableViewCell

//** 正在关注数据接入 */
@property (nonatomic, strong) id model;

@property (nonatomic, weak)id<YXMyAuctionBaseCellDelegate> delegate;

@end
