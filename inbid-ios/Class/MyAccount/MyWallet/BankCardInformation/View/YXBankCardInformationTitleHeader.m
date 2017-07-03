//
//  YXBankCardInformationTitleHeader.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXBankCardInformationTitleHeader.h"
#import "YXBankCardInformationModel.h"

@interface YXBankCardInformationTitleHeader()

/**
 titleLabel
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 bottomMarginLine
 */
@property (nonatomic, strong) UIView *bottomMarginLineView;

@end

@implementation YXBankCardInformationTitleHeader

#pragma mark - Zero.Const

/**
 *  LeftAndRightSpacing
 */
CGFloat bankCardInformationTitleHeaderLeftAndRightSpacing = 15.f;

#pragma mark - First.通知

#pragma mark - Second.赋值

- (void)setModel:(YXBankCardInformationModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.sectionTitle;
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupCustomUI];
    }
    return self;
}

#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bottomMarginLineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(bankCardInformationTitleHeaderLeftAndRightSpacing));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.bottomMarginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(1));
    }];
}

#pragma mark - Seventh.懒加载

- (UIView *)bottomMarginLineView
{
    if (!_bottomMarginLineView) {
        _bottomMarginLineView                   = [UIView new];
        _bottomMarginLineView.backgroundColor   = [UIColor themGrayColor];
    }
    return _bottomMarginLineView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                     = [UILabel new];
        _titleLabel.font                = REGULAR_FONT(13.f);
        _titleLabel.textColor           = [UIColor walletTextLightColor];
        _titleLabel.backgroundColor     = [UIColor themLightGrayColor];
    }
    return _titleLabel;
}

@end
