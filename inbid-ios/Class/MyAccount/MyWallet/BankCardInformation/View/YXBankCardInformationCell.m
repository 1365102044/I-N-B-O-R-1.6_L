//
//  YXBankCardInformationCell.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXBankCardInformationCell.h"
#import "YXBankCardInformationSubModel.h"

@interface YXBankCardInformationCell()

/**
 label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 textField
 */
@property (nonatomic, strong) UITextField *textField;

/**
 bottom Spacing
 */
@property (nonatomic, strong) UIView *bottomSpacingLineView;

@end

@implementation YXBankCardInformationCell

#pragma mark - Zero.Const

/**
 *  LeftAndRightSpacing
 */
CGFloat bankCardInformationCellLeftAndRightSpacing = 15.f;

/**
 *  titleLabel Width
 */
CGFloat bankCardInformationCellTitleLabelWidth = 55.f;


#pragma mark - First.通知

- (void)refreshViews:(NSNotification *)no
{
    if ([self.model.title isEqualToString:@"有效期"]) {
        
        if (![self.model.placeHolder isEqualToString:@"请选择有效期"]) {
            self.textField.text = self.model.placeHolder;
        }else{
            self.textField.text = @"";
        }
    }
}

- (void)userEndEditing:(NSNotification *)no
{
    if (self.textField.text.length >= self.model.maxTextCount.integerValue) {
        @try {
            self.textField.text                          = [self.textField.text substringWithRange:NSMakeRange(0, self.textField.text.length >= self.model.maxTextCount.integerValue ? self.model.maxTextCount.integerValue :self.textField.text.length)];
        } @catch (NSException *exception) {
        } @finally {
        }
        [self.textField resignFirstResponder];
    }
    self.model.userInputText = self.textField.text;
}

#pragma mark - Second.赋值

/**
 赋值界面

 @param model model
 */
- (void)setModel:(YXBankCardInformationSubModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    self.textField.placeholder = model.placeHolder;
    self.textField.userInteractionEnabled = model.isUserInteraction;
    self.textField.keyboardType = model.keyboardType;
    
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCustomUI];
        [self registerNotification];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"kBankCardInformationSelectedTimeNotificaiton"
                                                  object:nil];
}

#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    UIView *bgView =[[UIView alloc] initWithFrame:self.contentView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.bottomSpacingLineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(bankCardInformationCellLeftAndRightSpacing));
        make.width.mas_equalTo(ADJUST_PERCENT_FLOAT(bankCardInformationCellTitleLabelWidth));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-bankCardInformationCellLeftAndRightSpacing));
    }];
    
    [self.bottomSpacingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(1));
    }];
}

- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userEndEditing:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshViews:)
                                                 name:@"kBankCardInformationSelectedTimeNotificaiton"
                                               object:nil];
}

#pragma mark - Seventh.懒加载

- (UIView *)bottomSpacingLineView
{
    if (!_bottomSpacingLineView) {
        _bottomSpacingLineView                  = [UIView new];
        _bottomSpacingLineView.backgroundColor  = [UIColor themGrayColor];
    }
    return _bottomSpacingLineView;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField                      = [[UITextField alloc] init];
        _textField.backgroundColor      = [UIColor whiteColor];
        _textField.textAlignment        = NSTextAlignmentRight;
    }
    return _textField;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel                     = [UILabel new];
        _titleLabel.font                = REGULAR_FONT(16.f);
        _titleLabel.textColor           = [UIColor walletTextColor];
        _titleLabel.backgroundColor     = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
