//
//  YXChoosePeiSongTypeTopView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^topviewheightblock)(CGFloat height);

@interface YXChoosePeiSongTypeTopView : UIView

@property(nonatomic,copy) topviewheightblock  heightblock;

@property(nonatomic,strong) NSString * peisongtype;
@end
