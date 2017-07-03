//
//  YXWebPagePCPayFooterView.m
//  Payment
//
//  Created by 郑键 on 16/12/1.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXWebPagePCPayFooterView.h"

@interface YXWebPagePCPayFooterView()

/**
 确定扫码支付按钮
 */
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation YXWebPagePCPayFooterView

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 确定按钮点击事件
 */
- (void)sureButtonClick:(UIButton *)sender
{
    if (self.clicksurebtnblock) {
        self.clicksurebtnblock();
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图器生命周期

/**
 实例化对象

 @param reuseIdentifier reuseIdentifier 重用标志
 @return 返回实例对象
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self customUI];
    }
    return self;
}

#pragma mark - Sixth.界面配置

/**
 自定义UI
 */
- (void)customUI
{
    [self.contentView addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(11.5);
        make.right.mas_equalTo(self.contentView).mas_offset(-11.5);
        make.top.mas_equalTo(self.contentView).mas_offset(20);
        make.height.mas_equalTo(44);
    }];
    
    
}

#pragma mark - Seventh.懒加载

- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.backgroundColor = [UIColor blackColor];
        [_sureButton setTitle:@"扫码支付" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

@end
