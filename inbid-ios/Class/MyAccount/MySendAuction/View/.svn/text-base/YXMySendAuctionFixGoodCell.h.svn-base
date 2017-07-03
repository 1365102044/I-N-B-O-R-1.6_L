//
//  YXMySendAuctionFixGoodCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMySendAuctionHoldTest;
@class YXMySendAuctionFixGoodCell;

@protocol YXMySendAuctionFixGoodCellDelegate <NSObject>

/**
 点击列表功能按钮

 @param mySendAuctionFixGoodCell mySendAuctionFixGoodCell
 @param sender                   sender
 @param model                    选中数据模型
 */
- (void)mySendAuctionFixGoodCell:(YXMySendAuctionFixGoodCell *)mySendAuctionFixGoodCell funcButton:(UIButton *)sender andModel:(YXMySendAuctionHoldTest *)model;

@end

@interface YXMySendAuctionFixGoodCell : UITableViewCell

//** 数据接口 */
@property (nonatomic, strong) YXMySendAuctionHoldTest *sendAuctionHoldTestModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXMySendAuctionFixGoodCellDelegate> delegate;

@end
