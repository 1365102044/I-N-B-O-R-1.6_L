//
//  YXSearchListNoDataView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchListNoDataView.h"

@interface YXSearchListNoDataView ()

{
UIImageView *imageView;
    UILabel*lable1;
    UILabel *lable2;

}

@end

@implementation YXSearchListNoDataView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-shangpin"]];
        [self addSubview:imageView];
        
        lable1 = [[UILabel alloc]init];
        lable1.text = @"数据为空";
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.textColor = [UIColor blackColor];
        lable1.font = YXRegularfont(15);
        [self addSubview:lable1];
        
        lable2 = [[UILabel alloc]init];
        lable2.textAlignment = NSTextAlignmentCenter;
        lable2.text = @"暂时没有相关商品";
        lable2.textColor = UIColorFromRGB(0xaaa7a7);
        lable2.font = YXRegularfont(11);
        [self addSubview:lable2];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    imageView.frame = CGRectMake((YXScreenW-90)/2,YXScreenH*0.3, 90, 90);
    
    lable1.frame = CGRectMake((YXScreenW-100)/2, imageView.bottom+34, 100, 20);
    
    lable2.frame  = CGRectMake((YXScreenW-100)/2, lable1.bottom+10, 100, 20);
    
    
    

}

@end
