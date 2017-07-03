//
//  YXWithdrawalsCell.m
//  Project
//
//  Created by 郑键 on 17/2/16.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXWithdrawalsCell.h"
#import "YXWithdrawalsModel.h"
#import "YXRequestZitiInformationManager.h"
#import "YXWithdrawalsDataModel.h"
#import "YXBankCardDetailInformationModel.h"

@interface YXWithdrawalsCell()

/**
 titleLabel
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 detailLabel
 */
@property (nonatomic, strong) UILabel *detailLabel;

/**
 iconImageView
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 accessButton
 */
@property (nonatomic, strong) UIButton *accessButton;

/**
 bottomSpacingView
 */
@property (nonatomic, strong) UIView *bottomSpacingView;

/**
 backgroundView
 */
@property (nonatomic, strong) UIView *grayBackgroundView;

/**
 tipsLabel
 */
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation YXWithdrawalsCell

#pragma mark - Zero.Const

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 赋值，切换界面

 @param withdrawalsModel withdrawalsModel
 */
- (void)setWithdrawalsModel:(YXWithdrawalsModel *)withdrawalsModel
{
    _withdrawalsModel = withdrawalsModel;
    
    [self reMakeSubView];
}

#pragma mark - Third.点击事件

/**
 辅助按钮点击事件

 @param sender 点击事件
 */
- (void)accessButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(withdrawalsCell:buttonClick:)]) {
        [self.delegate withdrawalsCell:self buttonClick:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 实例化cell对象

 @param style               style
 @param reuseIdentifier     reuseIdentifier
 @return                    cell对象
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
    self.selectionStyle                 = UITableViewCellSelectionStyleNone;
    self.backgroundView                 = self.grayBackgroundView;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.accessButton];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.bottomSpacingView];
    [self.contentView addSubview:self.tipsLabel];
    
    //** =========================================================================================== */
    //** ============================================公用=========================================== */
    //** =========================================================================================== */
    [self.bottomSpacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

/**
 重新布置界面
 */
- (void)reMakeSubView
{
    self.titleLabel.hidden                      = YES;
    self.accessButton.hidden                    = YES;
    self.detailLabel.hidden                     = YES;
    self.iconImageView.hidden                   = YES;
    self.textField.hidden                       = YES;
    self.tipsLabel.hidden                       = YES;
    self.bottomSpacingView.hidden               = NO;
    self.grayBackgroundView.backgroundColor     = [UIColor whiteColor];
    self.accessButton.enabled                   = self.withdrawalsModel.funcButtonEnable;
    
    [self setLabelConfiger:self.titleLabel
                      text:self.withdrawalsModel.title
                 textColor:[UIColor walletTextColor]
                      font:REGULAR_FONT(self.withdrawalsModel.titleFontSize)];
    [self setLabelConfiger:self.detailLabel
                      text:self.withdrawalsModel.detailTitle
                 textColor:[UIColor walletTextLightColor]
                      font:REGULAR_FONT(self.withdrawalsModel.detailTitleFontSize)];
    [self.accessButton setBackgroundImage:[UIImage imageNamed:@""]
                                 forState:UIControlStateNormal];
    [self.accessButton setBackgroundImage:[UIImage imageNamed:@""]
                                 forState:UIControlStateDisabled];
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellTitleLabelAndAccessButton) {
        
        self.titleLabel.hidden                  = NO;
        self.accessButton.hidden                = NO;
        self.accessButton.titleLabel.font       = REGULAR_FONT(self.withdrawalsModel.detailTitleFontSize);
        
        if (self.withdrawalsModel.showTipsColor) {
            self.titleLabel.textColor = [UIColor themGoldColor];
        }else{
            self.titleLabel.textColor = [UIColor blackColor];
        }
        
        [self.accessButton setTitleColor:[UIColor systemButtonTextColor]
                                forState:UIControlStateNormal];
        [self.accessButton setTitle:self.withdrawalsModel.detailTitle
                           forState:UIControlStateNormal];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.accessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_equalTo(ADJUST_PERCENT_FLOAT(-15));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(ADJUST_PERCENT_FLOAT(100));
        }];
    }
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellEmptyBankCard) {
        
        self.titleLabel.hidden          = NO;
        self.accessButton.hidden        = NO;

        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.accessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellBankLogo) {
        
        self.titleLabel.hidden          = NO;
        self.iconImageView.hidden       = NO;
        self.detailLabel.hidden         = NO;
        self.accessButton.hidden        = NO;
        
        [self.accessButton setTitle:@""
                           forState:UIControlStateNormal];
        [self.accessButton setBackgroundImage:[UIImage imageNamed:@"icon_fanhui1"]
                                     forState:UIControlStateNormal];
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.withdrawalsModel.dataModel.agreeListBean.logoImageUrlString]
                              placeholderImage:[UIImage imageNamed:@"银联"]
                                       options:SDWebImageRetryFailed];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(19));
            make.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(10.5));
        }];
        
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(14));
            make.bottom.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-13.5));
            make.width.mas_equalTo(ADJUST_PERCENT_FLOAT(42.5));
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(19.5));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(8));
        }];
        
        [self.accessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
        }];
    }
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellScanfMoney) {
        
        self.titleLabel.hidden          = NO;
        self.detailLabel.hidden         = NO;
        self.textField.hidden           = NO;
        if (self.withdrawalsModel.dataModel.amt_single.integerValue >= 0) {
            self.textField.text             = self.withdrawalsModel.showTotalAmont ? [NSString stringWithFormat:@"%zd", [[self.withdrawalsModel.dataModel.amt_single componentsSeparatedByString:@"."].firstObject integerValue] - 1] : self.textField.text;
            self.withdrawalsModel.userInputText = self.textField.text;
        }
        
        [self setLabelConfiger:self.detailLabel
                          text:self.withdrawalsModel.detailTitle
                     textColor:[UIColor walletTextColor]
                          font:REGULAR_FONT(self.withdrawalsModel.detailTitleFontSize)];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(14.5));
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(25));
            make.width.mas_equalTo(ADJUST_PERCENT_FLOAT(19.5));
        }];
        
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.detailLabel);
            make.left.mas_equalTo(self.detailLabel.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(9));
            make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
        }];
    }
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellTitleLabelAndDetailLabelAndAccessView) {
        
        self.titleLabel.hidden          = NO;
        self.detailLabel.hidden         = NO;
        self.accessButton.hidden        = NO;
        
        [self.accessButton setTitle:@""
                           forState:UIControlStateNormal];
        [self.accessButton setBackgroundImage:[UIImage imageNamed:@"icon_fanhui1"]
                                     forState:UIControlStateNormal];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.accessButton.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(-8.5));
        }];
        
        [self.accessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
        }];
    }
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellFooter) {
        
        self.titleLabel.hidden                      = NO;
        self.detailLabel.hidden                     = NO;
        self.accessButton.hidden                    = NO;
        self.tipsLabel.hidden                       = NO;
        self.accessButton.userInteractionEnabled    = YES;
        self.bottomSpacingView.hidden               = YES;
        self.grayBackgroundView.backgroundColor     = [UIColor themLightGrayColor];
        self.titleLabel.backgroundColor             = [UIColor themLightGrayColor];
        self.detailLabel.backgroundColor            = [UIColor themLightGrayColor];
        self.accessButton.enabled                   = self.withdrawalsModel.funcButtonEnable;
        self.accessButton.titleLabel.font           = REGULAR_FONT(18);
        
        [self setLabelConfiger:self.titleLabel
                          text:self.withdrawalsModel.title
                     textColor:[UIColor systemButtonTextColor]
                          font:REGULAR_FONT(self.withdrawalsModel.titleFontSize)];
        [self setLabelConfiger:self.detailLabel
                          text:self.withdrawalsModel.detailTitle
                     textColor:[UIColor systemButtonTextColor]
                          font:REGULAR_FONT(self.withdrawalsModel.detailTitleFontSize)];
        
        [self.accessButton setTitleColor:[UIColor whiteColor]
                                forState:UIControlStateNormal];
        [self.accessButton setTitle:@"确认转出"
                           forState:UIControlStateNormal];
        [self.accessButton setBackgroundImage:[UIImage imageNamed:@"background"]
                                     forState:UIControlStateNormal];
        [self.accessButton setBackgroundImage:[UIImage imageNamed:@"ic_sendAuction_compose_dis"]
                                     forState:UIControlStateDisabled];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(16));
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(12.5));
        }];
        
        [self.accessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
            make.top.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(21));
            make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(50));
        }];
        
        [self.tipsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.accessButton);
            make.top.mas_equalTo(self.accessButton.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(130));
        }];
    
    }
    
    if (self.withdrawalsModel.cellType == YXWithdrawalsCellAddBankCard) {
        
        self.titleLabel.hidden                      = NO;
        self.accessButton.hidden                    = NO;
        self.accessButton.titleLabel.font           = REGULAR_FONT(self.withdrawalsModel.detailTitleFontSize);
        [self.accessButton setTitle:self.withdrawalsModel.detailTitle
                           forState:UIControlStateNormal];
        [self.accessButton setTitleColor:[UIColor systemButtonTextColor]
                                forState:UIControlStateNormal];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.accessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
    }
}

/**
 配置label

 @param label               label
 @param text                text
 @param textColor           textColor
 @param font                font
 */
- (void)setLabelConfiger:(UILabel *)label
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                    font:(UIFont *)font
{
    label.font              = font;
    label.text              = text;
    label.textColor         = textColor;
}

#pragma mark - Seventh.懒加载

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        
        _tipsLabel                                  = [UILabel new];
        _tipsLabel.numberOfLines                    = 0;
        
        NSString *tipsText                          = @"1、只能提现到您本人绑定的银行卡内！\n2、“连连支付”会收取1元/笔的提现手续费，从账户余额中扣除，请保证剩余大于手续费金额。\n3、提现申请将在2个工作日内到账。\n4、如需帮助，可联系客服";
        NSString *customerServicePhoneNumber        = [[YXRequestZitiInformationManager sharedZiti] objectZiTiWithforKey:@"customerPhone"];
        NSString *totalString                       = [NSString stringWithFormat:@"%@%@",
                                                       tipsText,
                                                       customerServicePhoneNumber];
        
        NSMutableAttributedString *attrM            = [[NSMutableAttributedString alloc] initWithString:totalString];
        NSMutableParagraphStyle *paragraphStyle     = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing                  = ADJUST_PERCENT_FLOAT(9);
        [attrM addAttribute:NSFontAttributeName
                      value:REGULAR_FONT(13.f)
                      range:NSMakeRange(0,
                                        totalString.length)];
        [attrM addAttribute:NSForegroundColorAttributeName
                      value:[UIColor walletTextLightColor]
                      range:NSMakeRange(0,
                                        totalString.length)];
        [attrM addAttribute:NSParagraphStyleAttributeName
                      value:paragraphStyle
                      range:NSMakeRange(0,
                                        totalString.length)];
        [attrM addAttribute:NSForegroundColorAttributeName
                      value:[UIColor systemButtonTextColor]
                      range:NSMakeRange(tipsText.length,
                                        customerServicePhoneNumber.length)];
        _tipsLabel.attributedText                   = attrM;
    }
    return _tipsLabel;
}

- (UIView *)grayBackgroundView
{
    if (!_grayBackgroundView) {
        _grayBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _grayBackgroundView.backgroundColor = [UIColor themLightGrayColor];
    }
    return _grayBackgroundView;
}

- (UIView *)bottomSpacingView
{
    if (!_bottomSpacingView) {
        _bottomSpacingView                      = [UIView new];
        _bottomSpacingView.backgroundColor      = [UIColor themGrayColor];
    }
    return _bottomSpacingView;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField                              = [[UITextField alloc] init];
        _textField.backgroundColor              = [UIColor whiteColor];
        _textField.keyboardType                 = UIKeyboardTypeNumberPad;
        _textField.clearButtonMode              = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIButton *)accessButton
{
    if (!_accessButton) {
        _accessButton                           = [[UIButton alloc] init];
        _accessButton.hidden                    = YES;
        _accessButton.tag                       = 1001;
        _accessButton.userInteractionEnabled    = NO;
        [_accessButton setTitle:@"确认转出" forState:UIControlStateNormal];
        [_accessButton addTarget:self
                          action:@selector(accessButtonClick:)
                forControlEvents:UIControlEventTouchUpInside];
        [_accessButton sizeToFit];
        [_accessButton setBackgroundColor:[UIColor whiteColor]];
    }
    return _accessButton;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView                          = [[UIImageView alloc] init];
        _iconImageView.backgroundColor          = [UIColor whiteColor];
    }
    return _iconImageView;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel                            = [UILabel new];
        _detailLabel.backgroundColor            = [UIColor whiteColor];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                             = [UILabel new];
        _titleLabel.backgroundColor             = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
