//
//  YXActivityButton.m
//  Login
//
//  Created by 郑键 on 17/1/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXActivityButton.h"

@interface YXActivityButton()

/**
 动态指示器(系统原生，废弃不用)
 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

/**
 动态指示器
 */
@property (nonatomic, strong) UIImageView *loadingImageView;

/**
 动态指示器蒙版视图
 */
@property (nonatomic, strong) UIView *activityIndicatorMaskSuperView;

@end

@implementation YXActivityButton

#pragma mark - Zero.Const

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.事件

/**
 显示等待视图
 */
- (void)show
{
    self.activityIndicatorMaskSuperView.hidden                              = NO;
    [self startAnimation];
}

/**
 关闭等待视图
 */
- (void)dismiss
{
    self.activityIndicatorMaskSuperView.hidden                              = YES;
}

/**
 开始旋转动画
 */
- (void)startAnimation
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation                                                       = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue                                               = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration                                              = 0.8;
    rotationAnimation.cumulative                                            = YES;
    rotationAnimation.repeatCount                                           = MAXFLOAT;
    [self.loadingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化avtivityButton对象

 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
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
    self.layer.cornerRadius                                                = 2.f;
    self.clipsToBounds                                                     = YES;
    
    [self setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"ic_register_disBg"] forState:UIControlStateDisabled];
    [self setTitle:@"下一步" forState:UIControlStateNormal];
    [self insertSubview:self.activityIndicatorMaskSuperView aboveSubview:self.titleLabel];
    [self.activityIndicatorView startAnimating];
}

/**
 布局子界面
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.activityIndicatorMaskSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.loadingImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.activityIndicatorMaskSuperView);
    }];
    
//    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.mas_equalTo(self.activityIndicatorMaskSuperView);
//        make.width.height.mas_equalTo(50);
//    }];
    
}

#pragma mark - Seventh.懒加载

- (UIImageView *)loadingImageView
{
    if (!_loadingImageView) {
        _loadingImageView                                   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_register_loading"]];
    }
    return _loadingImageView;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView                              = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

- (UIView *)activityIndicatorMaskSuperView
{
    if (!_activityIndicatorMaskSuperView) {
        _activityIndicatorMaskSuperView                     = [UIView new];
        _activityIndicatorMaskSuperView.backgroundColor     = [UIColor mainThemColor];
        _activityIndicatorMaskSuperView.hidden              = YES;
        //[_activityIndicatorMaskSuperView addSubview:self.activityIndicatorView];
        [_activityIndicatorMaskSuperView addSubview:self.loadingImageView];
    }
    return _activityIndicatorMaskSuperView;
}

@end
