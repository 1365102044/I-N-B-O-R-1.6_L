//
//  YXWithdrawalsCell.h
//  Project
//
//  Created by 郑键 on 17/2/16.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXWithdrawalsModel;
@class YXWithdrawalsCell;

/**
 cell的类型
 
 - YXWithdrawalsCellNone:                                           无类型
 - YXWithdrawalsCellTitleLabelAndAccessButton:                      title和辅助视图
 - YXWithdrawalsCellBankLogo:                                       银行logo
 - YXWithdrawalsCellScanfMoney:                                     输入金额
 - YXWithdrawalsCellTitleLabelAndDetailLabelAndAccessView:          title、detail和辅助视图
 - YXWithdrawalsCellFooter:                                         footerView
 - YXWithdrawalsCellAddBankCard:                                    添加银行卡
 */
typedef NS_ENUM(NSUInteger, YXWithdrawalsCellType) {
    YXWithdrawalsCellNone                                           = 1001,
    YXWithdrawalsCellTitleLabelAndAccessButton                      = 1002,
    YXWithdrawalsCellBankLogo                                       = 1003,
    YXWithdrawalsCellEmptyBankCard                                  = 1004,
    YXWithdrawalsCellScanfMoney                                     = 1005,
    YXWithdrawalsCellTitleLabelAndDetailLabelAndAccessView          = 1006,
    YXWithdrawalsCellFooter                                         = 1007,
    YXWithdrawalsCellAddBankCard                                    = 1008,
};

@protocol YXWithdrawalsCellDelegate <NSObject>

/**
 cell上的按钮的点击事件

 @param withdrawalsCell                                             withdrawalsCell
 @param button                                                      button
 */
- (void)withdrawalsCell:(YXWithdrawalsCell *)withdrawalsCell
            buttonClick:(UIButton *)button;

@end


@interface YXWithdrawalsCell : UITableViewCell

/**
 数据模型
 */
@property (nonatomic, strong) YXWithdrawalsModel *withdrawalsModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXWithdrawalsCellDelegate> delegate;

/**
 textField
 */
@property (nonatomic, strong) UITextField *textField;

@end
