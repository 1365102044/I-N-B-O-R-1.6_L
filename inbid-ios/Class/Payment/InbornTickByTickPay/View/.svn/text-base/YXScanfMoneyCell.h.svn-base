//
//  YXScanfMoneyCell.h
//  Payment
//
//  Created by 郑键 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXScanfMoneyCell;

@protocol YXScanfMoneyCellDelegate <NSObject>

/**
 点击键盘完成按钮代理

 @param scanfMoneyCell scanfMoneyCell       输入cell
 @param moneyText moneyText                 金额
 */
- (void)scanfMoneyCell:(YXScanfMoneyCell *)scanfMoneyCell andMoneyText:(NSString *)moneyText;

@end

@interface YXScanfMoneyCell : UITableViewCell

/**
 金额输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

/**
 代理
 */
@property (nonatomic, weak) id<YXScanfMoneyCellDelegate> delegate;

@end
