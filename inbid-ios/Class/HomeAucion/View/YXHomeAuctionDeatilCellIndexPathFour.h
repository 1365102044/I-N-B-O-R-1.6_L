//
//  YXHomeAuctionDeatilCellIndexPathFour.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXHomeDeatilModle.h"
typedef void(^indexpathFourHeightBlock) (CGFloat heght);
@interface YXHomeAuctionDeatilCellIndexPathFour : UIView

@property(nonatomic,copy)  indexpathFourHeightBlock heightblock;
@property(nonatomic,strong)  YXHomeDeatilModle * modle;
@end
