//
//  YXSendAuctionDoneController.h
//  YXSendAuction
//
//  Created by 郑键 on 16/9/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionDoneController;

@protocol YXSendAuctionDoneControllerDelegate <NSObject>

/**
 滚动到顶部

 @param sendAuctionDoneController sendAuctionDoneController
 @param scrollToTop               scrollToTop
 */
- (void)sendAuctionDoneController:(YXSendAuctionDoneController *)sendAuctionDoneController scrollToTop:(BOOL)scrollToTop;

/**
 清空输入数据

 @param sendAuctionDoneController sendAuctionDoneController
 @param clearData                 clearData 
 */
- (void)sendAuctionDoneController:(YXSendAuctionDoneController *)sendAuctionDoneController clearData:(BOOL)clearData;

@end

@interface YXSendAuctionDoneController : UIViewController

@property (nonatomic, weak) id<YXSendAuctionDoneControllerDelegate> delegate;

@end
