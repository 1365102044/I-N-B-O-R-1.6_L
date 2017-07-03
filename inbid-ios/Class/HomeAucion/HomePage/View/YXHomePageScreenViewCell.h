//
//  YXHomePageScreenViewCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXHomePageScreenViewModel;

@interface YXHomePageScreenViewCell : UITableViewCell

/**
 数据
 */
@property (nonatomic, strong) YXHomePageScreenViewModel *model;

@end
