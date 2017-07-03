//
//  YXSearchBrandsCollectionViewCell.h
//  inbid-ios
//
//  Created by 1 on 16/9/7.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSearchBrandsModle.h"
typedef void(^SelectedIDBlock)(BOOL selected,NSString *ID);

@interface YXSearchBrandsCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) YXSearchBrandsModle *brand;


@property (nonatomic, copy) SelectedIDBlock block;


/*
 @brief 品类选择的个数 0
 */
@property(nonatomic,assign) NSInteger  selectBrandsNumber;

@end
