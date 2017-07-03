//
//  YXHomeAuctionDeatilHeaderView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXHomeDeatilModle.h"

//**----------tableviewheaderview的高度--------- */
typedef void(^headerViewHeightBlock) (CGFloat height);

//**----------点击的组头--------- */
typedef void(^headerViewSeactionBlock)(NSInteger tag , NSInteger attentstatus);
/*
 @brief 点击竞拍规则
 */
typedef void(^clickOneview)();

@interface YXHomeAuctionDeatilHeaderView : UIView

@property(nonatomic,copy) headerViewHeightBlock  HeaderHeightblock;

@property (nonatomic, copy) headerViewSeactionBlock seactionBlock;

@property(nonatomic,assign) CGFloat HeaderAllHeight;



@property(nonatomic,strong) YXHomeDeatilModle * deatilmodle;


@property (nonatomic, copy) clickOneview taponeviewblock;


@property(nonatomic,strong) NSString * guanzhuSTR;



/*
 @brief 循环请求改值
 */

@property (nonatomic, strong) YXHomeDeatilModle *loopmodle;


//参与人数 
@property (nonatomic, assign) NSInteger actorNum;
@property(nonatomic,assign) NSInteger  guanzhuNum;




@end
