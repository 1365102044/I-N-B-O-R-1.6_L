//
//  YXVerificationCodeInputView.m
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXVerificationCodeInputView.h"

@interface YXVerificationCodeInputView() <UITextFieldDelegate>

/**
 展示label数组
 */
@property (nonatomic, strong) NSMutableArray *labelsArray;

@end

@implementation YXVerificationCodeInputView

#pragma mark - Zero.Const

/**
 展示输入内容Label的间距
 */
CGFloat showLabelMargin             = 10;

/**
 展示输入框的最大个数
 */
CGFloat showLabelMaxCount           = 6;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 输入验证码错误，错误动画

 @param passWordFailed 输入验证码错误
 */
- (void)setPassWordFailed:(BOOL)passWordFailed
{
    _passWordFailed = passWordFailed;
    
    if (passWordFailed) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[ @0, @15, @-15, @15, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 0.4;
        
        animation.additive = YES;
        [self.layer addAnimation:animation forKey:@"shake"];
    }
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark <UITextFieldDelegate>

/**
 textField输入

 @param textField               textField
 @param range                   range
 @param string                  string
 @return return                 value
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= showLabelMaxCount && string.length) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    
    [self setLabelWithTotalString:totalString];
    
    if (totalString.length == showLabelMaxCount) {
    
        if ([self.delegate respondsToSelector:@selector(verificationCodeInputView:verificationCodeText:)]) {
            [self.delegate verificationCodeInputView:self verificationCodeText:totalString];
        }
    }
    
    return YES;
}

/**
 显示输入内容

 @param totalString 内容
 */
- (void)setLabelWithTotalString:(NSString *)totalString
{
    [self.labelsArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj,
                                                   NSUInteger idx,
                                                   BOOL * _Nonnull stop) {
        obj.text                                                                    = @"";
        [self setLabelBroderWithStatus:NO label:obj];
    }];
    
    NSRange range;
    for (NSInteger i = 0; i < totalString.length; i++) {
        range                                                                       = [totalString rangeOfComposedCharacterSequenceAtIndex:i];
        UILabel *label                                                              = self.labelsArray[i];
        label.text                                                                  = [totalString substringWithRange:range];
    }
    
    if (totalString.length == showLabelMaxCount) {
        return;
    }
    [self setLabelBroderWithStatus:YES
                             label:self.labelsArray[totalString.length]];
}

#pragma mark - Fifth.视图生命周期

/**
 初始化

 @param frame frame
 @return 返回实例
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
    [self addSubview:self.inputVerificationCodeTextField];
    [self.labelsArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj,
                                                   NSUInteger idx,
                                                   BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
}

/**
 布局子控件
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.inputVerificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    __block UILabel *currentLabel;
    [self.labelsArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj,
                                                   NSUInteger idx,
                                                   BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            if (idx == 0) {
                make.left.top.bottom.mas_equalTo(self);
            }else{
                make.width.height.top.mas_equalTo(currentLabel);
                make.left.mas_equalTo(currentLabel.mas_right).mas_offset(showLabelMargin);
                if (idx == self.labelsArray.count - 1) {
                    make.right.bottom.mas_equalTo(self);
                }
            }
        }];
        
        currentLabel = obj;
    }];
}

/**
 配置label的边框

 @param status  状态 YES选中 NO未选中
 @param label   展示控件
 */
- (void)setLabelBroderWithStatus:(BOOL)status
                           label:(UILabel *)label
{
    label.layer.borderWidth                                                             = 1.0f;
    //label.layer.cornerRadius                                                            = 5.0f;
    
    if (status) {
        label.layer.borderColor                                                          = [UIColor blackColor].CGColor;
    }else{
        label.layer.borderColor                                                          = [UIColor lightGrayColor].CGColor;
    }
}

#pragma mark - Seventh.懒加载

- (NSMutableArray *)labelsArray
{
    if (!_labelsArray) {
        _labelsArray                                                                = [NSMutableArray arrayWithCapacity:showLabelMaxCount];
        for (NSInteger i = 0; i < showLabelMaxCount; i++) {
            UILabel *label                                                          = [UILabel new];
            //label.layer.cornerRadius                                                = 2.f;
            label.backgroundColor                                                   = [UIColor whiteColor];
            //label.clipsToBounds                                                     = YES;
            label.textAlignment                                                     = NSTextAlignmentCenter;
            label.font                                                              = [UIFont systemFontOfSize:23.5f];
            [_labelsArray addObject:label];
            BOOL isSelected                                                         = NO;
            if (i == 0) {
                isSelected                                                          = YES;
            }
            [self setLabelBroderWithStatus:isSelected label:label];
        }
    }
    return _labelsArray;
}

- (UITextField *)inputVerificationCodeTextField
{
    if (!_inputVerificationCodeTextField) {
        _inputVerificationCodeTextField                                             = [UITextField new];
        _inputVerificationCodeTextField.keyboardType                                = UIKeyboardTypeNumberPad;
        _inputVerificationCodeTextField.backgroundColor                             = [UIColor groupTableViewBackgroundColor];
        _inputVerificationCodeTextField.delegate                                    = self;
        _inputVerificationCodeTextField.hidden                                      = YES;
    }
    return _inputVerificationCodeTextField;
}

@end
