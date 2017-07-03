//
//  YXSelectedPaymentTypeCell.m
//  Payment
//
//  Created by 郑键 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSelectedPaymentTypeCell.h"
#import "YXInbornTickByTickPayViewModel.h"

@interface YXSelectedPaymentTypeCell()

/**
 提示选择支付方式提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

/**
 支付方式的logoImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *paymentLogoImageView;

/**
 支付方式
 */
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeTitleLabel;

/**
 顶部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;
@end

@implementation YXSelectedPaymentTypeCell

#pragma mark - First.通知

#pragma mark - Second.赋值

- (void)setModel:(YXInbornTickByTickPayViewModel *)model
{
    if (![model.title isEqualToString:@"2"]) {
        self.tipsLabel.hidden = YES;
        self.paymentTypeTitleLabel.hidden = NO;
        self.paymentLogoImageView.hidden = NO;
        self.paymentLogoImageView.image = [UIImage imageNamed:model.logoImageNamed];
        self.paymentTypeTitleLabel.text = model.title;
    }else{
        self.tipsLabel.hidden = NO;
        self.paymentTypeTitleLabel.hidden = YES;
        self.paymentLogoImageView.hidden = YES;
    }
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
