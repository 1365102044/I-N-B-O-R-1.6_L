//
//  YXOneMouthPriceWuLiuNoAddressView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceWuLiuNoAddressView.h"

@interface YXOneMouthPriceWuLiuNoAddressView ()

{

    UIImageView *imageview;
    UILabel *descLable;
    UIImageView *jiantouimageview;
    
}

@end

@implementation YXOneMouthPriceWuLiuNoAddressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"onemouthpriceAddress"];
        [self addSubview:imageview];
        
        descLable = [[UILabel alloc]init];
        descLable.text = @"您还没有收获地址点击这里添加";
        descLable.textColor = UIColorFromRGB(0x939393);
        descLable.font = YXSFont(11);
        [self addSubview:descLable];
        descLable.textAlignment = NSTextAlignmentCenter;
        
        
        jiantouimageview = [[UIImageView alloc]init];
        jiantouimageview.image = [UIImage imageNamed:@"shangpingdeatiljaintou"];
        [self addSubview:jiantouimageview];
        
        
        
    }
    
    return self;
}

-(void)setDescstr:(NSString *)descstr
{
    _descstr = descstr;
    
    descLable.text = descstr;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    imageview.size = CGSizeMake(27, 27);
    imageview.centerX = self.centerX;
    imageview.y = 20;
    
    descLable.frame = CGRectMake(10, imageview.bottom+10, YXScreenW-20, 20);
    
    jiantouimageview.size = CGSizeMake(6, 11);
    jiantouimageview.y = (self.height-jiantouimageview.width)/2;
    jiantouimageview.x = YXScreenW-10-6;
    
    
    
}


@end
