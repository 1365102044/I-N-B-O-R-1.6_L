//
//  YXHomePageScreenViewCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomePageScreenViewCell.h"
#import "YXHomePageScreenViewModel.h"

@interface YXHomePageScreenViewCell()

/**
 顶部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *topView;

/**
 底部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 titleButton
 */
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

/**
 选中图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end

@implementation YXHomePageScreenViewCell

/**
 赋值

 @param model model
 */
- (void)setModel:(YXHomePageScreenViewModel *)model
{
    _model = model;
    
    [self.titleButton setTitle:model.catName forState:UIControlStateNormal];
    if (model.isSelected) {
        self.selectedImage.hidden = NO;
    }else{
        self.selectedImage.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 界面样式 */
    self.topView.backgroundColor = [UIColor themGrayColor];
    self.bottomView.backgroundColor = [UIColor themGrayColor];
    
    [self.titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.titleButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateSelected];
}

@end
