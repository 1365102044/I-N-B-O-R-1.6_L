//
//  YXMyLabelCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyLabelCell.h"
#import "YXSearchModle.h"
#import "YXSearchBrandsModle.h"

@interface YXMyLabelCell()

/**
 标签按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *labelButton;

@end

@implementation YXMyLabelCell

#pragma mark - 赋值

/**
 品类赋值

 @param searchModel 品类模型
 */
- (void)setSearchModel:(YXSearchModle *)searchModel
{
    _searchModel = searchModel;
    self.labelButton.selected = searchModel.isSelected;
    [self.labelButton setTitle:searchModel.catName forState:UIControlStateNormal];
}

/**
 品牌赋值

 @param searchBrandModel 品牌模型
 */
- (void)setSearchBrandModel:(YXSearchBrandsModle *)searchBrandModel
{
    _searchBrandModel = searchBrandModel;
    self.labelButton.selected = searchBrandModel.isSelected;
    [self.labelButton setTitle:searchBrandModel.prodBrandName forState:UIControlStateNormal];
}


#pragma mark - 初始化

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.labelButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateSelected];
    [self.labelButton setBackgroundImage:[UIImage imageNamed:@"ic_myLabel_nor"] forState:UIControlStateNormal];
    [self.labelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

@end
