//
//  YXMySendAuctionHoldTestHeaderView.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMySendAuctionHoldTest;
@class YXMySendAuctionHoldTestHeaderView;

@protocol YXMySendAuctionHoldTestHeaderViewDelegate <NSObject>

/**
 是否下拉时间轴方法

 @param mySendAuctionHoldTestHeaderView 当前sectionHeader
 @param isHighlight                     下拉按钮是否高亮
 @param currentSection                  当前组
 */
- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andButtonStatus:(BOOL)isHighlight andCurrentSection:(NSInteger)currentSection;

/**
 功能按钮点击回调事件

 @param mySendAuctionHoldTestHeaderView 当前sectionHeader
 @param sender                          点击的按钮
 @param holdTestModel                   当前对应模型数据
 */
- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andButton:(UIButton *)sender andHoldTestModel:(YXMySendAuctionHoldTest *)holdTestModel;

/**
 点击sectionHeader跳转事件

 @param mySendAuctionHoldTestHeaderView 当前sectionHeader
 @param holdTestModel                   当前对应模型数据
 */
- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andHoldTestModel:(YXMySendAuctionHoldTest *)holdTestModel;

/**
 点击文本跳转事件

 @param mySendAuctionHoldTestHeaderView 当前sectionHeader
 @param text                            点击的文字
 */
- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andClickText:(NSString *)text andIdentifyId:(long long)identifyId;

@end


@interface YXMySendAuctionHoldTestHeaderView : UITableViewCell

//** 数据接口 */
@property (nonatomic, strong) YXMySendAuctionHoldTest *sendAuctionHoldTestModel;
//** 当前组 */
@property (nonatomic, assign) NSInteger currentSection;
//** 代理 */
@property (nonatomic, weak) id<YXMySendAuctionHoldTestHeaderViewDelegate> delegate;

@end
