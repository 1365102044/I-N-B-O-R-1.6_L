//
//  YXWithdrawalsResultCell.m
//  Project
//
//  Created by 郑键 on 17/2/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXWithdrawalsResultCell.h"
#import "YXWithdrawalsResultModel.h"
#import "NSDate+YXExtension.h"

@interface YXWithdrawalsResultCell()

/**
 topSpacingView
 */
@property (nonatomic, strong) UIView *topSpacingView;

/**
 titleLabel
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 bankNameLabel
 */
@property (nonatomic, strong) UILabel *bankNameLabel;

/**
 amontLabel
 */
@property (nonatomic, strong) UILabel *amontLabel;

/**
 tipslabel
 */
@property (nonatomic, strong) UILabel *tipsLabel;

/**
 bottomSpacingLine
 */
@property (nonatomic, strong) UIView *bottomSpacingLineView;

@end

@implementation YXWithdrawalsResultCell

#pragma mark - Zero.Const

/**
 *  withdrawalsResultCellTopSpacingLine
 */
CGFloat withdrawalsResultCellTopSpacingLineHeight                   = 10;

#pragma mark - First.通知

#pragma mark - Second.赋值

- (void)setResultModel:(YXWithdrawalsResultModel *)resultModel
{
    _resultModel = resultModel;
    
    self.titleLabel.text = @"提现申请已提交，等待银行处理";
    self.bankNameLabel.text = [NSString stringWithFormat:@"%@（%@）",
                               resultModel.bankName,
                               resultModel.cardNo];
    self.amontLabel.text = [NSString stringWithFormat:@"¥%@",
                            [YXStringFilterTool strmethodComma:resultModel.amount]];
    self.tipsLabel.text = [NSString stringWithFormat:@"预计%@24:00前到账", [self getTomorrowDay:[NSDate getCurrentDate]]];
}

/**
 获取明天日期

 @param aDate 今天的NSDate对象
 @return 明天的日期
 */
- (NSString *)getTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 实例化对象

 @param style                   样式
 @param reuseIdentifier         重用标志
 @return                        实例对象
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCustomUI];
    }
    return self;
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)setupCustomUI
{
    UIView *bgView =[[UIView alloc] initWithFrame:self.contentView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    [self.contentView addSubview:self.topSpacingView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bankNameLabel];
    [self.contentView addSubview:self.amontLabel];
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.bottomSpacingLineView];
    
    [self.topSpacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(withdrawalsResultCellTopSpacingLineHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
        make.top.mas_equalTo(self.topSpacingView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(12));
        make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
    }];
    
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(14));
        make.right.mas_equalTo(self.titleLabel);
    }];
    
    [self.amontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.bankNameLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(6));
        make.right.mas_equalTo(self.titleLabel);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.amontLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
        make.right.mas_equalTo(self.titleLabel);
    }];
    
    [self.bottomSpacingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Seventh.懒加载

- (UIView *)bottomSpacingLineView
{
    if (!_bottomSpacingLineView) {
        _bottomSpacingLineView                          = [[UIView alloc] init];
        _bottomSpacingLineView.backgroundColor          = [UIColor themGrayColor];
    }
    return _bottomSpacingLineView;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel                                      = [UILabel new];
        _tipsLabel.font                                 = REGULAR_FONT(16.f);
        _tipsLabel.text                                 = @"到账时间提示";
        _tipsLabel.textColor                            = [UIColor walletTextColor];
    }
    return _tipsLabel;
}

- (UILabel *)amontLabel
{
    if (!_amontLabel) {
        _amontLabel                                     = [UILabel new];
        _amontLabel.font                                = REGULAR_FONT(13);
        _amontLabel.text                                = @"金额";
        _amontLabel.textColor                           = [UIColor walletTextLightColor];
    }
    return _amontLabel;
}

- (UILabel *)bankNameLabel
{
    if (!_bankNameLabel) {
        _bankNameLabel                                  = [UILabel new];
        _bankNameLabel.font                             = REGULAR_FONT(13);
        _bankNameLabel.text                             = @"银行名称";
        _bankNameLabel.textColor                        = [UIColor walletTextLightColor];
    }
    return _bankNameLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                                     = [UILabel new];
        _titleLabel.font                                = REGULAR_FONT(16.f);
        _titleLabel.text                                = @"正在获取网络数据";
        _titleLabel.textColor                           = [UIColor walletTextColor];
    }
    return _titleLabel;
}

- (UIView *)topSpacingView
{
    if (!_topSpacingView) {
        
        _topSpacingView                                 = [[UIView alloc] init];
        _topSpacingView.backgroundColor                 = [UIColor themLightGrayColor];
        
        UIView *topLine                                 = [[UIView alloc] init];
        [_topSpacingView addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(_topSpacingView);
            make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(10));
        }];
        
        UIView *bottomLine                              = [[UIView alloc] init];
        bottomLine.backgroundColor                      = [UIColor themGrayColor];
        [_topSpacingView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(_topSpacingView);
            make.height.mas_equalTo(1);
        }];
    }
    return _topSpacingView;
}

@end
