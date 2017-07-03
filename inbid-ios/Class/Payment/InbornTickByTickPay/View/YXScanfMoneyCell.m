//
//  YXScanfMoneyCell.m
//  Payment
//
//  Created by 郑键 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXScanfMoneyCell.h"

@interface YXScanfMoneyCell() <UITextFieldDelegate>

@end

@implementation YXScanfMoneyCell

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 按钮完成点击事件

 @param aTextfield aTextfield
 @return 是否
 */
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    
    if ([self.delegate respondsToSelector:@selector(scanfMoneyCell:andMoneyText:)]) {
        [self.delegate scanfMoneyCell:self andMoneyText:self.moneyTextField.text];
    }
    
    return YES;
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 配置界面 */
    self.moneyTextField.keyboardType = UIKeyboardTypeDefault;
    self.moneyTextField.returnKeyType = UIReturnKeyDone;
    self.moneyTextField.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.moneyTextField becomeFirstResponder];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
