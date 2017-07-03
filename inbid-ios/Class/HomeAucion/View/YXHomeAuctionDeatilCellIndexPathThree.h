//
//  YXHomeAuctionDeatilCellIndexPathThree.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXHomeDeatilModle.h"
typedef void(^threeviewmaxheightblock)(CGFloat height);

@interface YXHomeAuctionDeatilCellIndexPathThree : UIView

//@property(nonatomic,assign) CGFloat threeViewMaxheight;

@property(nonatomic,copy)  threeviewmaxheightblock  heightblock;
@property(nonatomic,strong)  YXHomeDeatilModle * modle;

@end
