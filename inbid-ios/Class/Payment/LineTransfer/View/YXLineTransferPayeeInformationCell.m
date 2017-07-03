//
//  YXLineTransferPayeeInformationCell.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXLineTransferPayeeInformationCell.h"

@interface YXLineTransferPayeeInformationCell()

/**
 顶部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;

@end

@implementation YXLineTransferPayeeInformationCell

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控件生命周期

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 配置界面 */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topMarginView.backgroundColor = [UIColor colorWithWhite:229.0/255.0 alpha:1.0];
    self.bottomMarginView.backgroundColor = [UIColor colorWithWhite:229.0/255.0 alpha:1.0];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
