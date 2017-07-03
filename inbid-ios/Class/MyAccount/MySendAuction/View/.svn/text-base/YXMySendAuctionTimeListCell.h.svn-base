//
//  YXMySendAuctionTimeListCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionGetIdentifuDetails;
@class YXMySendAuctionTimeList;
@class YXMySendAuctionTimeListCell;

@protocol YXMySendAuctionTimeListCellDelegate <NSObject>

/**
 点击文本跳转事件

 @param mySendAuctionTimeListCell 对应的cell
 @param text                      点击的文本
 */
- (void)mySendAuctionTimeListCell:(YXMySendAuctionTimeListCell *)mySendAuctionTimeListCell clickText:(NSString *)text andIdentifyId:(long long)identifyId;

@end

@interface YXMySendAuctionTimeListCell : UITableViewCell

/**
 数据接口
 */
@property (nonatomic, strong) YXMySendAuctionTimeList *mySendAuctionTimeListModel;

/**
 鉴定订单数据
 */
@property (nonatomic, strong) YXSendAuctionGetIdentifuDetails *identifuDetails;

/**
 是否是最后一个
 */
@property (nonatomic, assign) BOOL isLastTimeListStatus;

/**
 代理
 */
@property (nonatomic, weak) id<YXMySendAuctionTimeListCellDelegate> delegate;

@end
