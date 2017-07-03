//
//  YXSearchResultShaixuanTableViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXSearchModle.h"

@interface YXSearchResultShaixuanTableViewCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong) NSString * textstr;

@property(nonatomic,strong) YXSearchModle * modle;

@end
