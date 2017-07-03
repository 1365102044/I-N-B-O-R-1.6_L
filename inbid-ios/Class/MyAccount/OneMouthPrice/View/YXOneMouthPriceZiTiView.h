//
//  YXOneMouthPriceZiTiView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXOneMouthPriceConfirmOrderModle.h"

#import "YXZiTiInformationModle.h"

typedef void(^heightblock)(CGFloat height);

@interface YXOneMouthPriceZiTiView : UIView

@property(nonatomic,strong) YXOneMouthPriceConfirmOrderModle * OneMouthPriceConfirmModel;

@property(nonatomic,strong) YXZiTiInformationModle * zitiiformationModle;

@property(nonatomic,copy) heightblock  heightblock;

@end
