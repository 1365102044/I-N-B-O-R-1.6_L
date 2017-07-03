//
//  YXApprasisalReportCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApprasisalReportCell.h"
#import "YXAppraisaReportViewDataModel.h"

@interface YXApprasisalReportCell()

/**
 背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *cellBackgroundView;

/**
 价格titleLabel
 */
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;

/**
 提示语button
 */
@property (weak, nonatomic) IBOutlet UIButton *tipsButton;

@end

@implementation YXApprasisalReportCell

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 配置视图

 @param viewDataModel viewDataModel
 */
- (void)setViewDataModel:(YXAppraisaReportViewDataModel *)viewDataModel
{
    _viewDataModel = viewDataModel;
    
    self.priceTitleLabel.text = [NSString stringWithFormat:@"%@（¥%@）", viewDataModel.title, viewDataModel.money];
    [self.tipsButton setTitle:viewDataModel.detailTitle forState:UIControlStateNormal];
    [self.tipsButton setImage:[UIImage imageNamed:viewDataModel.imageNamed] forState:UIControlStateNormal];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.生命周期
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCustomUI];
}

#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    //** 样式配置 */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.priceTitleLabel.font = [UIFont systemFontOfSize:13];
    self.tipsButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.tipsButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [self.tipsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.tipsButton.imageView.image.size.width - 2, 0, self.tipsButton.imageView.image.size.width - 2)];
    [self.tipsButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.tipsButton.titleLabel.bounds.size.width + 10, 0, -self.tipsButton.titleLabel.bounds.size.width)];
    
    //** 画边框 */
    [self.cellBackgroundView.layer setBorderWidth:1.0];;
    CGColorRef color = [UIColor mainThemColor].CGColor;
    [self.cellBackgroundView.layer setBorderColor:color];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

#pragma mark - Seventh.懒加载

@end
