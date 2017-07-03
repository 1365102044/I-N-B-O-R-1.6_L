//
//  YXLineTransferCertificatesFooterView.m
//  inbid-ios
//
//  Created by 郑键 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXLineTransferCertificatesFooterView.h"

@interface YXLineTransferCertificatesFooterView()

/**
 顶部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *topSpacingView;

/**
 提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

/**
 跳过下一步稍后再提供汇款按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation YXLineTransferCertificatesFooterView

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 功能按钮点击事件

 @param sender 功能按钮 1001.提交 1002.下一步
 */
- (IBAction)funcButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(lineTransferCertificatesFooterView:andClickBUtton:)]) {
        [_delegate lineTransferCertificatesFooterView:self andClickBUtton:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化方法

 @param reuseIdentifier     重用标志
 @return                    返回footer实例
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                             owner:nil
                                           options:nil].lastObject;
    }
    return self;
}

/**
 从xib加载后调用
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.topSpacingView.backgroundColor = [UIColor themGrayColor];
    [self.sureButton setTitle:@"提交" forState:UIControlStateNormal];
    self.sureButton.backgroundColor = [UIColor mainThemColor];
    self.nextButton.titleLabel.font = YXRegularfont(10);
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
