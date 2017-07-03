//
//  YXHomePageScreenViewModel.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHomePageScreenViewModel : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString *catName;

/**
 图片名称
 */
@property (nonatomic, copy) NSString *imageNamed;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 id
 */
@property (nonatomic, assign) long long catId;

@end
