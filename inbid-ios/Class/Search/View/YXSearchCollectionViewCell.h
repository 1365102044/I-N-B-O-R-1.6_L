//
//  YXSearchCollectionViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSearchModle.h"

typedef void(^SelectedBlock)(BOOL selected);

@interface YXSearchCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) YXSearchModle * modle;

@property (nonatomic, copy) SelectedBlock block;



@end
