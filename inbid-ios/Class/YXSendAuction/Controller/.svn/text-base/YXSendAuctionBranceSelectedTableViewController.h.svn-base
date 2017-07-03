//
//  YXSendAuctionBranceSelectedTableViewController.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionBranceSelectedTableViewController;

@protocol YXSendAuctionBranceSelectedTableViewControllerDelegate <NSObject>

/**
 点击选中品牌

 @param sendAuctionBranceSelectedTableViewController sendAuctionBranceSelectedTableViewController
 @param selectedBrandText                            selectedBrandText
 */
- (void)sendAuctionBranceSelectedTableViewController:(YXSendAuctionBranceSelectedTableViewController *)sendAuctionBranceSelectedTableViewController andSelectedBrandText:(NSString *)selectedBrandText;

@end

@interface YXSendAuctionBranceSelectedTableViewController : UITableViewController

/**
 选中回调的代理
 */
@property (nonatomic, weak) id<YXSendAuctionBranceSelectedTableViewControllerDelegate> selectedDelegate;

@end
