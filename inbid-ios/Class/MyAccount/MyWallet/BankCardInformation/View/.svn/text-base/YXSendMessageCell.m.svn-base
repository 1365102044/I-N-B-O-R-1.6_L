//
//  YXSendMessageCell.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXSendMessageCell.h"
#import "YXBankCardInformationSubModel.h"

@interface YXSendMessageCell()

/**
 textField
 */
@property (nonatomic, strong) UITextField *textField;

/**
 load MessageButton
 */
@property (nonatomic, strong) UIButton *loadMessageButton;

/**
 bottom Spacing
 */
@property (nonatomic, strong) UIView *bottomSpacingLineView;

@end

@implementation YXSendMessageCell

#pragma mark - Zero.Const

/**
 *  LeftAndRightSpacing
 */
CGFloat bankCardInformationSendMessageCellLeftAndRightSpacing = 15.f;

/**
 *  loadMessageButton Width
 */
CGFloat bankCardInformationSendMessageCellLoadMessageButtonWidth = 120.f;

#pragma mark - First.通知

- (void)refreshView:(NSNotification *)no
{
    [self.loadMessageButton setTitle:self.model.title
                            forState:UIControlStateNormal];
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

- (void)setModel:(YXBankCardInformationSubModel *)model
{
    _model = model;
    
    self.textField.placeholder              = model.placeHolder;
    self.textField.userInteractionEnabled   = model.isUserInteraction;
    [self.loadMessageButton setTitle:model.title
                            forState:UIControlStateNormal];
}

#pragma mark - Third.点击事件

- (void)buttonClick:(UIButton *)sender
{
    if (![sender.titleLabel.text isEqualToString:@"获取验证码"]) return;
    
    if ([self.delegate respondsToSelector:@selector(sendMessageCell:buttonClick:)]) {
        [self.delegate sendMessageCell:self buttonClick:sender];
    }
}

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
                                                    name:@"walletBankMessageCountDown"
                                                  object:nil];
}

#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.loadMessageButton];
    [self.contentView addSubview:self.bottomSpacingLineView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(bankCardInformationSendMessageCellLeftAndRightSpacing));
        make.right.mas_equalTo(self.loadMessageButton.mas_left);
    }];
    
    [self.loadMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ADJUST_PERCENT_FLOAT(bankCardInformationSendMessageCellLoadMessageButtonWidth));
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
                                             selector:@selector(refreshView:)
                                                 name:@"walletBankMessageCountDown"
                                               object:nil];
}

#pragma mark - Seventh.懒加载

- (UIView *)bottomSpacingLineView
{
    if (!_bottomSpacingLineView) {
        _bottomSpacingLineView = [UIView new];
        _bottomSpacingLineView.backgroundColor = [UIColor themGrayColor];
    }
    return _bottomSpacingLineView;
}

- (UIButton *)loadMessageButton
{
    if (!_loadMessageButton) {
        _loadMessageButton = [[UIButton alloc] init];
        _loadMessageButton.titleLabel.font = REGULAR_FONT(16.f);
        [_loadMessageButton setTitle:@"获取验证码"
                            forState:UIControlStateNormal];
        [_loadMessageButton setBackgroundColor:[UIColor whiteColor]];
        [_loadMessageButton setTitleColor:[UIColor systemButtonTextColor]
                                 forState:UIControlStateNormal];
        [_loadMessageButton addTarget:self
                               action:@selector(buttonClick:)
                     forControlEvents:UIControlEventTouchUpInside];
        
        CAShapeLayer *layer                                 = [[CAShapeLayer alloc] init];
        UIBezierPath *path                                  = [UIBezierPath bezierPathWithRect:CGRectMake(0,
                                                                                                          0,
                                                                                                          ADJUST_PERCENT_FLOAT(1.f),
                                                                                                          ADJUST_PERCENT_FLOAT(50))];
        layer.path                                          = path.CGPath;
        layer.fillColor                                     = [UIColor themGrayColor].CGColor;
        [_loadMessageButton.layer addSublayer:layer];
    }
    return _loadMessageButton;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}

@end
