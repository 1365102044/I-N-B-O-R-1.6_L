//
//  YXBankCardInformationBootomFuncFooter.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXBankCardInformationBottomFuncFooter.h"
#import "YXBankCardInformationModel.h"

@interface YXBankCardInformationBottomFuncFooter()

/**
 按钮
 */
@property (nonatomic, strong) UIButton *funcButton;

/**
 agreement
 */
@property (nonatomic, strong) UIButton *agreementButton;

/**
 checkAgreement
 */
@property (nonatomic, strong) UIButton *checkAgreementButton;

@end

@implementation YXBankCardInformationBottomFuncFooter

#pragma mark - Zero.Const

/**
 *  LeftAndRightSpacing
 */
CGFloat bankCardInformationFuncFooterLeftAndRightSpacing = 15.f;

/**
 *  ButtonTopSpacing
 */
CGFloat bankCardInformationFuncFooterButtonTopSpacing = 50.f;

/**
 *  ButtonHeight
 */
CGFloat bankCardInformationFuncFooterButtonHeight = 50.f;

/**
 *  agreementButtonTopMargin
 */
CGFloat bankCardInformationFuncFooterAgreementButtonTopMargin = 20.f;

#pragma mark - First.通知

#pragma mark - Second.赋值

- (void)setModel:(YXBankCardInformationModel *)model
{
    _model = model;
    
    self.agreementButton.hidden         = model.isHiddenFooterAgreementButton;
    self.checkAgreementButton.hidden    = model.isHiddenFooterAgreementButton;
    self.agreementButton.selected       = model.isAgreeFooterArgeement;
}

#pragma mark - Third.点击事件

- (void)funcButtonClick:(UIButton *)sender
{
    if (sender.tag == 1002) {
        sender.selected                         = !sender.selected;
        self.model.footerArgeementStatus        = sender.selected;
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(bankCardInformationBottomFuncFooter:buttonClick:)]) {
        [self.delegate bankCardInformationBottomFuncFooter:self buttonClick:sender];
    }
}

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
    UIView *bgView =[[UIView alloc] initWithFrame:self.contentView.bounds];
    bgView.backgroundColor = [UIColor themLightGrayColor];
    self.backgroundView = bgView;
    
    [self.contentView addSubview:self.funcButton];
    [self.contentView addSubview:self.agreementButton];
    [self.contentView addSubview:self.checkAgreementButton];
    
    [self.funcButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(bankCardInformationFuncFooterButtonTopSpacing));
        make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(bankCardInformationFuncFooterLeftAndRightSpacing));
        make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-bankCardInformationFuncFooterLeftAndRightSpacing));
        make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(bankCardInformationFuncFooterButtonHeight));
    }];
    
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.funcButton);
        make.top.mas_equalTo(self.funcButton.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(bankCardInformationFuncFooterAgreementButtonTopMargin));
    }];
    
    [self.checkAgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.agreementButton.mas_right);
        make.centerY.mas_equalTo(self.agreementButton);
    }];
}

#pragma mark - Seventh.懒加载

- (UIButton *)checkAgreementButton
{
    if (!_checkAgreementButton) {
        _checkAgreementButton = [[UIButton alloc] init];
        _checkAgreementButton.tag = 1001;
        _checkAgreementButton.hidden = YES;
        _checkAgreementButton.titleLabel.font = REGULAR_FONT(15.f);
        [_checkAgreementButton setTitle:@"《支付服务协议》"
                               forState:UIControlStateNormal];
        [_checkAgreementButton setBackgroundColor:[UIColor themLightGrayColor]];
        [_checkAgreementButton addTarget:self
                                  action:@selector(funcButtonClick:)
                        forControlEvents:UIControlEventTouchUpInside];
        [_checkAgreementButton setTitleColor:[UIColor systemButtonTextColor]
                                    forState:UIControlStateNormal];
    }
    return _checkAgreementButton;
}

- (UIButton *)agreementButton
{
    if (!_agreementButton) {
        _agreementButton = [[UIButton alloc] init];
        _agreementButton.tag = 1002;
        _agreementButton.hidden = YES;
        _agreementButton.titleLabel.font = REGULAR_FONT(15.f);
        [_agreementButton setTitle:@"同意"
                          forState:UIControlStateNormal];
        [_agreementButton setBackgroundColor:[UIColor themLightGrayColor]];
        [_agreementButton addTarget:self
                             action:@selector(funcButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
        [_agreementButton setTitleColor:[UIColor walletTextColor]
                               forState:UIControlStateNormal];
        [_agreementButton setImage:[UIImage imageNamed:@"ic_sendAuction_check_no"]
                          forState:UIControlStateNormal];
        [_agreementButton setImage:[UIImage imageNamed:@"ic_sendAuction_check_sel"]
                          forState:UIControlStateSelected];
    }
    return _agreementButton;
}

- (UIButton *)funcButton
{
    if (!_funcButton) {
        _funcButton = [[UIButton alloc] init];
        _funcButton.layer.cornerRadius = 4;
        _funcButton.clipsToBounds = YES;
        _funcButton.tag = 1003;
        [_funcButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_funcButton setBackgroundImage:[UIImage imageNamed:@"background"]
                               forState:UIControlStateNormal];
        [_funcButton addTarget:self
                        action:@selector(funcButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _funcButton;
}

@end
