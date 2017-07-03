//
//  YXLonginVCAleartView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXLonginVCAleartView.h"

@interface YXLonginVCAleartView ()

{
    UIView *bigview;
    UIView*backcontentview;
    UIImageView*alearimage;
    UILabel*alearlable;

}

@end
@implementation YXLonginVCAleartView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        bigview = [[UIView alloc]init];
        bigview.backgroundColor = [UIColor grayColor];
        bigview.alpha = 0.0;
        
        
        
        
        backcontentview= [[UIView alloc]init];
        backcontentview.backgroundColor = [UIColor whiteColor];
        
        
        alearimage = [[UIImageView alloc]init];
        alearimage.image =[UIImage imageNamed:@"取消图标"];
        
        
        alearlable = [[UILabel alloc]init];
        alearlable.text = self.alearStr;
        alearlable.textAlignment = NSTextAlignmentCenter;
        alearlable.textColor = UIColorFromRGB(0x050505);
        alearlable.font = YXRegularfont(15);
        
        
        [self addSubview:bigview];
        [bigview addSubview:backcontentview];
        [bigview addSubview:alearlable];
        [bigview addSubview:alearimage];
        

        
        
    }
    return self;
}




-(void)setAlearStr:(NSString *)alearStr
{
    _alearStr = alearStr;
    alearlable.text = alearStr;

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    bigview.frame = self.bounds;
    
    CGFloat wi = YXScreenW*0.6;
    CGFloat he = 50;
    backcontentview.y = (YXScreenH-he)/2;
    backcontentview.width = wi;
    backcontentview.height = he;
    backcontentview.centerX = self.centerX;

    alearimage.frame = CGRectMake((backcontentview.width-25)/2, 5, 25, 25);
    alearlable.frame = CGRectMake(0, alearimage.bottom+5, backcontentview.width, 25);
    
    
}

@end
