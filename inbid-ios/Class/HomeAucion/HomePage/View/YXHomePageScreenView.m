//
//  YXHomePageScreenView.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomePageScreenView.h"

@interface YXHomePageScreenView()

/**
 视图初始化数据数组
 */
@property (nonatomic, strong) NSArray *viewsDataArray;

/**
 当前选中按钮
 */
@property (nonatomic, strong) UIButton *currentButton;

@end

@implementation YXHomePageScreenView

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 清空当前状态

 @param isRestCurrentSelected isRestCurrentSelected
 */
- (void)setIsRestCurrentSelected:(BOOL)isRestCurrentSelected
{
    _isRestCurrentSelected = isRestCurrentSelected;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *subButton = (UIButton *)view;
            if (subButton.tag == 1) {
                [subButton setTitle:@"综合" forState:UIControlStateNormal];
            }
            
            if (subButton.tag == 3) {
                [subButton setTitle:@"品类" forState:UIControlStateNormal];
            }
            [self resetLayoutSubViewWithButton:subButton];
        }
    }
}

/**
 清空选中状态

 @param isClearAllSelectedButton isClearAllSelectedButton
 */
- (void)setIsClearAllSelectedButton:(BOOL)isClearAllSelectedButton
{
    _isClearAllSelectedButton = isClearAllSelectedButton;
    
    if (isClearAllSelectedButton) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)obj;
                if (btn.selected) {
                    *stop = YES;
                    if (*stop) {
                        btn.selected = NO;
                        [self resetLayoutSubViewWithButton:btn];
                    }
                }                
            }
        }];
    }
}

/**
 选中条件名称

 @param catName catName
 */
- (void)setCatName:(NSString *)catName
{
    _catName = catName;
    UIButton *button = (UIButton *)[self viewWithTag:self.selectedButtonTag];
    if ([catName isEqualToString:@"综合排序"]) {
        [button setTitle:@"综合" forState:UIControlStateNormal];
    }else if ([catName isEqualToString:@"即将开始"]) {
        [button setTitle:@"即将开始" forState:UIControlStateNormal];
    }else if ([catName isEqualToString:@"即将结束"]) {
        [button setTitle:@"即将结束" forState:UIControlStateNormal];
    }else{
        [button setTitle:catName forState:UIControlStateNormal];
    }
    [self resetLayoutSubViewWithButton:button];
}

- (void)resetLayoutSubViewWithButton:(UIButton *)btn
{
    [btn.titleLabel sizeToFit];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.size.width, 0, btn.imageView.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
}

#pragma mark - Third.点击事件

/**
 点击事件

 @param sender sender  
 */
- (void)screenViewButtonClick:(UIButton *)sender
{
    if (self.currentButton == sender && sender.tag != 2 && sender.selected == YES) {
        self.currentButton.selected = NO;
    }else{
        self.currentButton.selected = NO;
        sender.selected = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(homePageScreenView:andClickButton:)]) {
        [self.delegate homePageScreenView:self andClickButton:sender];
    }
    self.currentButton = sender;
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图初始化

/**
 初始化视图

 @param viewsDataArray viewsDataArray
 */
+ (instancetype)initWithViewsDataArray:(NSArray *)viewsDataArray
{
    YXHomePageScreenView *screenView = [[self alloc] init];
    screenView.viewsDataArray = viewsDataArray;
    [screenView setupScreenViewUI];
    return screenView;
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)setupScreenViewUI
{
    //** 添加分割线 */
    UIView *topSplitLine = [[UIView alloc] init];
    topSplitLine.width = YXScreenW;
    topSplitLine.height = 1;
    topSplitLine.y = 0;
    topSplitLine.backgroundColor = [UIColor themGrayColor];
    [self addSubview:topSplitLine];
    
    UIView *bottomSplitLine = [[UIView alloc] init];
    bottomSplitLine.width = YXScreenW;
    bottomSplitLine.height = 1;
    bottomSplitLine.y = 39 - 1;
    bottomSplitLine.backgroundColor = [UIColor themGrayColor];
    [self addSubview:bottomSplitLine];
    
    CGFloat width = YXScreenW / self.viewsDataArray.count;
    CGFloat height = 39;
    for (NSInteger i = 0; i < self.viewsDataArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i+1;
        btn.height = height;
        btn.width = width;
        btn.x = i * width;
        btn.y = 0;
        NSDictionary *dict = self.viewsDataArray[i];
        [btn setTitle:dict[@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(screenViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image;
        if (i == 1) {
            image = [UIImage imageNamed:@"ic_homePageScreenViewPriceType_no"];
        }else{
            image = [UIImage imageNamed:@"ic_homePageScreenView_no"];
            [btn setImage:[UIImage imageNamed:@"ic_homePageScreenView_hig"] forState:UIControlStateSelected];
        }
        [btn setImage:image forState:UIControlStateNormal];
        
        [btn.titleLabel sizeToFit];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
        
        [self addSubview:btn];
    }
}

#pragma mark - Seventh.懒加载

@end
