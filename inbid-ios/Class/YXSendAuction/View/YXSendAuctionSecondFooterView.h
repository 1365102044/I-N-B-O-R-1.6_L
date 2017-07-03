//
//  YXSendAuctionSecondFooterView.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionSecondFooterView;

@protocol YXSendAuctionSecondFooterViewDelegate <NSObject>

/**
 查看协议点击事件

 @param sendAuctionSecondFooterView sendAuctionSecondFooterView
 @param sender                      sender
 */
- (void)sendAuctionSecondFooterView:(YXSendAuctionSecondFooterView *)sendAuctionSecondFooterView clickButton:(UIButton *)sender;

@end

@interface YXSendAuctionSecondFooterView : UICollectionReusableView

/**
 我已阅读并同意按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *isReadAndAgreeButton;

/**
 代理
 */
@property (nonatomic, weak) id<YXSendAuctionSecondFooterViewDelegate> delegate;

@end

