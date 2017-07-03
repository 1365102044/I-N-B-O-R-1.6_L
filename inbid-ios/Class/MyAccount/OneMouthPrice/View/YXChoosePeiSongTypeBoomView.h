//
//  YXChoosePeiSongTypeBoomView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^boomviewheightblock)(CGFloat height);


@interface YXChoosePeiSongTypeBoomView : UIView

@property(nonatomic,copy) boomviewheightblock  heightblock;

@property(nonatomic,strong) NSString * peisongtype;



-(void)setUIWithorderAllprice:(NSInteger )orderallprice iscanDingjin:(NSInteger )iscandingjin;

@end
