//
//  YXMySendAuctionSubTableViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMySendAuctionSubTableViewController;

@protocol YXMySendAuctionSubTableViewControllerDelegate <NSObject>

- (void)mySendAuctionSubTableViewController:(YXMySendAuctionSubTableViewController *)mySendAuctionSubTableViewController hiddenTempView:(BOOL)hiddenTempView title:(NSString *)title;

/**
 是否在视图出现时刷新界面

 @param mySendAuctionSubTableViewController 寄拍子页面
 @param isRestAllCurPage                    是否刷新
 */
- (void)mySendAuctionSubTableViewController:(YXMySendAuctionSubTableViewController *)mySendAuctionSubTableViewController isRestAllCurPage:(BOOL)isRestAllCurPage;

@end



@interface YXMySendAuctionSubTableViewController : UITableViewController

//** 根据index跳转相应的模块 */
@property (nonatomic, assign) NSInteger index;
//** 是否绑定银行卡 */
@property (nonatomic, assign) NSInteger cardStatus;
/**
 刷新数据
 */
@property (nonatomic, assign) BOOL isDisappear;

@property (nonatomic, weak) id<YXMySendAuctionSubTableViewControllerDelegate> delegate;

/**
 加载新数据
 */
@property (nonatomic, assign) BOOL loadNewData;

/**
 是否刷新当前页
 */
@property (nonatomic, assign) BOOL isRestCurrentPage;

@end
