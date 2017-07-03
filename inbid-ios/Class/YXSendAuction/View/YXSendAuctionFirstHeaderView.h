//
//  YXSendAuctionFirstHeaderView.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPlaceholderTextView.h"
@class YXSendAuctionFirstHeaderView;

@protocol YXSendAuctionFirstHeaderViewDelegate <NSObject>

/**
 结束编辑

 @param sendAuctionFirstHeaderView sendAuctionFirstHeaderView
 @param endEditing                 endEditing
 */
- (void)sendAuctionFirstHeaderView:(YXSendAuctionFirstHeaderView *)sendAuctionFirstHeaderView endEditing:(BOOL)endEditing;

@end

@interface YXSendAuctionFirstHeaderView : UICollectionReusableView

/**
 描述输入框
 */
@property (weak, nonatomic) IBOutlet YXPlaceholderTextView *detailTextView;

/**
 代理
 */
@property (nonatomic, weak) id<YXSendAuctionFirstHeaderViewDelegate> delegate;

@end
