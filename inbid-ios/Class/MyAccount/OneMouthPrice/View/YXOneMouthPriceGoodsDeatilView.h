//
//  YXOneMouthPriceGoodsDeatilView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXOneMouthPriceConfirmOrderModle.h"

typedef void(^deatilviewheightblock)(CGFloat height);
@interface YXOneMouthPriceGoodsDeatilView : UIView


//+ (instancetype)cellWithTableView:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath ;

@property(nonatomic,strong) YXOneMouthPriceConfirmOrderModle * OneMouthPriceConfirmModel;
@property(nonatomic,copy) deatilviewheightblock deatilheightblock;

@end
