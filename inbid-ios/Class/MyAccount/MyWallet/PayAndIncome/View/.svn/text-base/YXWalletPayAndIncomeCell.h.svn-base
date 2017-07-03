//
//  YXWalletPayAndIncomeCell.h
//  inbid-ios
//
//  Created by 郑键 on 17/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXWalletPayAndIncomeDataModel;
@class YXWalletPayAndIncomeCell;

@protocol YXWalletPayAndIncomeCellDelegate <NSObject>

/**
 当为最后一个cell时添加点击事件

 @param walletPayAndIncomeCell walletPayAndIncomeCell
 @param sender
 */
- (void)walletPayAndIncomeCell:(YXWalletPayAndIncomeCell *)walletPayAndIncomeCell
                   buttonClick:(UIButton *)sender;

@end

@interface YXWalletPayAndIncomeCell : UITableViewCell

/**
 属性模型
 */
@property (nonatomic, strong) YXWalletPayAndIncomeDataModel *dataModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXWalletPayAndIncomeCellDelegate> delegate;

@end
