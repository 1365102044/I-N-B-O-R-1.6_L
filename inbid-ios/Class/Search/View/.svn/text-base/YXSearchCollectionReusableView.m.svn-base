//
//  YXSearchCollectionReusableView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchCollectionReusableView.h"

@interface YXSearchCollectionReusableView ()

@end

@implementation YXSearchCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView*topgrayview = [[UIView alloc]init];
        topgrayview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        topgrayview.frame =CGRectMake(0, 0, YXScreenW, 10);
        [self addSubview:topgrayview];
        
        
        _titleBtn = [[UIButton alloc]init];
        _titleBtn.frame =CGRectMake(0,10, 120 ,40);
        _titleBtn.titleLabel.font = YXRegularfont(14);
        [_titleBtn setTitleColor:UIColorFromRGB(0x0505050) forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"ic_pinpai"] forState:UIControlStateNormal];
        _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-30 , 0, 0);
        [self addSubview:_titleBtn];
        
    }
    
    return self;
}

@end
