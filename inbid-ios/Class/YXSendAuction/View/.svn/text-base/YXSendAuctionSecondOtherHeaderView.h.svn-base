//
//  YXSendAuctionSecondOtherHeaderView.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionSecondOtherHeaderView;

@protocol YXSendAuctionSecondOtherHeaderViewDelegate <NSObject>

/**
 点击选择品牌代理

 @param sendAuctionSecondOtherHeaderView sendAuctionSecondOtherHeaderView（必传）
 @param showSelectedBranceLabel          showSelectedBranceLabel（必传）
 */
- (void)sendAuctionSecondOtherHeaderView:(YXSendAuctionSecondOtherHeaderView *)sendAuctionSecondOtherHeaderView showSelectedBranceLabel:(UILabel *)showSelectedBranceLabel;

@end

@interface YXSendAuctionSecondOtherHeaderView : UICollectionReusableView

/**
 代理
 */
@property (nonatomic, weak) id<YXSendAuctionSecondOtherHeaderViewDelegate> delegate;

/**
 展示选中品牌label
 */
@property (weak, nonatomic) IBOutlet UILabel *showBranceLabel;

@end
