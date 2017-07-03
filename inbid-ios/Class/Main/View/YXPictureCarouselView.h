//
//  YXPictureCarouselView.h
//  图片轮播器 PictureCarousel
//
//  Created by 郑键 on 16/8/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXHomeDeatilModle.h"
@interface YXPictureCarouselView : UIView

//** 数据数组 */
@property (nonatomic, strong)NSArray *picturesArray;

@property(nonatomic,strong) NSArray * pictureDesc;


@property(nonatomic,strong) YXHomeDeatilModle * deatilmodle;

@end
