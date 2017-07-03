//
//  YXMyAuctionPostBondsView.h
//  MyAuction
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAuctionPostBondsView;

@protocol YXMyAuctionPostBondsViewDelegate <NSObject>

- (void)myAuctionPostBondsDelegate:(YXMyAuctionPostBondsView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender;
@end

typedef void(^helpblock)();

/*
 @brief 点击提交
 */
typedef void(^clickcommitMoneyBtnBlock)();

@interface YXMyAuctionPostBondsView : UIView

@property (nonatomic, weak)id<YXMyAuctionPostBondsViewDelegate> delegate;

@property(nonatomic,strong) NSString * esureMoney;


@property(nonatomic,copy) clickcommitMoneyBtnBlock  commitblock;

@property(nonatomic,copy) helpblock  pushhelpblock;

@end
