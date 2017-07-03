//
//  YXNewsEnsuremoneyNotiListTableViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXNewsEnsureNotiListModle.h"

@interface YXNewsEnsuremoneyNotiListTableViewCell : UITableViewCell

+(instancetype)creatensuremoenyNotilistTableViewCell;

@property(nonatomic,strong) YXNewsEnsureNotiListModle * ensuremodle;

@end
