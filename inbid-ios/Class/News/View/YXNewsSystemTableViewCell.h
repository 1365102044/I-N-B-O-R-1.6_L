//
//  YXNewsSystemTableViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXNewsEnsureNotiListModle.h"

@interface YXNewsSystemTableViewCell : UITableViewCell

+(instancetype)creatsystemNotilistTableViewCell;
@property(nonatomic,strong) YXNewsEnsureNotiListModle * modle;

@end
