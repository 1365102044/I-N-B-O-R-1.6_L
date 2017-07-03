//
//  YXMyAuctionSubTableViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAuctionSubTableViewController;

@protocol YXMyAuctionSubTableViewControllerDelegate <NSObject>

- (void)myAuctionSubTableViewController:(YXMyAuctionSubTableViewController *)myAuctionSubTableViewController hiddenTempView:(BOOL)hiddenTempView title:(NSString *)title;

@end

@interface YXMyAuctionSubTableViewController : UITableViewController

@property (nonatomic, weak) id<YXMyAuctionSubTableViewControllerDelegate> delegate;
/**
 刷新数据
 */
@property (nonatomic, assign) BOOL isDisappear;

/**
 加载新数据
 */
@property (nonatomic, assign) BOOL loadNewData;

@end
