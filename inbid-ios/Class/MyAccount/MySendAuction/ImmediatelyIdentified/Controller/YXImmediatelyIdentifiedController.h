//
//  YXImmediatelyIdentifiedController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMySendAuctionHoldTest;
@class YXImmediatelyIdentifiedController;

@protocol YXImmediatelyIdentifiedControllerDelegate <NSObject>

/**
 监听用户点击回调

 @param immediatelyIdentifiedController 立即鉴定控制器
 @param isRestPage                      是否刷新界面
 */
- (void)immediatelyIdentifiedController:(YXImmediatelyIdentifiedController *)immediatelyIdentifiedController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXImmediatelyIdentifiedController : UITableViewController


/**
 数据
 */
@property (nonatomic, strong) YXMySendAuctionHoldTest *sendAuctionHoldTestModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXImmediatelyIdentifiedControllerDelegate> delegate;

@end
