//
//  YXPaymentTypeCell.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPaymentTypeCell.h"
#import "YXPaymentHomepageViewDataModel.h"

@interface YXPaymentTypeCell()

/**
 是否选中按钮
 */
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

/**
 支付方式titleLabel
 */
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeTitleLabel;

/**
 支付方式说明label
 */
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeDetailLabel;

/**
 支付方式logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *paymentLogoImageView;

/**
 顶部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;

/**
 applePay赋值视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *applePayDetailImageView;

@end

@implementation YXPaymentTypeCell

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 界面赋值

 @param dataModel dataModel
 */
- (void)setDataModel:(YXPaymentHomepageViewDataModel *)dataModel
{
    _dataModel = dataModel;
    
    self.paymentTypeTitleLabel.text = dataModel.title;
    self.paymentTypeDetailLabel.text = dataModel.detaileText;
    
    if ([dataModel.title isEqualToString:@"Apple Pay"]) {
        self.applePayDetailImageView.hidden = NO;
    }else{
        self.applePayDetailImageView.hidden = YES;
    }
    
    if (dataModel.isSelected.boolValue) {
        self.selectedImage.image = [UIImage imageNamed:@"icon_PayTypeSelect_sel"];
    }else{
        self.selectedImage.image = [UIImage imageNamed:@"icon_PayTypeSelect_no"];
    }
    self.paymentLogoImageView.image = [UIImage imageNamed:dataModel.imageNamed];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

#pragma mark - Sixth.界面配置

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 界面样式 */
    self.backgroundColor = [UIColor yellowColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.topMarginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
    self.bottomMarginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
    
    self.applePayDetailImageView.hidden = YES;
}

#pragma mark - Seventh.懒加载


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
