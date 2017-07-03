//
//  YXInbornTickByTickPaymentTypeCell.m
//  Payment
//
//  Created by 郑键 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXInbornTickByTickPaymentTypeCell.h"
#import "YXInbornTickByTickPayViewModel.h"

@interface YXInbornTickByTickPaymentTypeCell()

/**
 支付方式title
 */
@property (weak, nonatomic) IBOutlet UILabel *paymentTitleLabel;

/**
 描述label
 */
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;

/**
 logoImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

/**
 顶部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;
@end

@implementation YXInbornTickByTickPaymentTypeCell

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 界面赋值

 @param model 数据模型
 */
- (void)setModel:(YXInbornTickByTickPayViewModel *)model
{
    _model = model;
    
    self.paymentTitleLabel.text = model.title;
    self.detailTitleLabel.text = model.detailTitleText;
    self.logoImageView.image = [UIImage imageNamed:model.logoImageNamed];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 界面样式 */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topMarginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
    self.bottomMarginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
