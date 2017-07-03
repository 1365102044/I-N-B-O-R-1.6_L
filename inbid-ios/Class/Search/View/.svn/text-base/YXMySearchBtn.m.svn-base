//
//  YXMySearchBtn.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySearchBtn.h"

@implementation YXMySearchBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        
        self.titleLabel.font = YXRegularfont(13);
        [self setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        self.frame = frame;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleY = contentRect.size.height *0.5;
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect

{
    CGFloat imageW = contentRect.size.width*0.6;
    
    CGFloat imageH = contentRect.size.height * 0.6-10;
    CGFloat imagex = (contentRect.size.width-imageW)/2;
    
    return CGRectMake(imagex, 8, imageW, imageH);
    
}

@end
