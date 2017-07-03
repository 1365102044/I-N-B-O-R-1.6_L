//
//  ZJCamerBorderView.m
//  Project
//
//  Created by 郑键 on 17/3/2.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "ZJCamerBorderView.h"

@interface ZJCamerBorderView()

/**
 图片
 */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZJCamerBorderView

/**
 初始化

 @param frame       初始化
 @return            实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupCustomUI];
    }
    return self;
}

/**
 开始扫描动画
 */
- (void)startScannerAnimating
{
    
}

/**
 停止扫描动画
 */
- (void)stopScannerAnimating
{
    
}

/**
 设置界面
 */
- (void)setupCustomUI
{
    self.clipsToBounds = YES;
    
    /**
     *  加载图片
     */
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_wallet_idCard_camer"]];
    }
    return _imageView;
}

@end
