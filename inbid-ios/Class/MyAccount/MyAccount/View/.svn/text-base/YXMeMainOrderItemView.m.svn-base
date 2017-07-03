//
//  YXMeMainOrderItemView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMeMainOrderItemView.h"
#import "UILabel+Extension.h"
static CGFloat imageW = 33;
@interface YXMeMainOrderItemView ()
{
    UILabel *numberlable;
    UIImageView *iconimageview;
    UILabel *namelable;
}
@end
@implementation YXMeMainOrderItemView


-(void)setItemTitle:(NSString *)ItemTitle{
    namelable.text = ItemTitle;
    iconimageview.image = [UIImage imageNamed:ItemTitle];
}
-(void)setOrderNumber:(NSString *)orderNumber{
    
    numberlable.text = orderNumber;
    if ([orderNumber isEqualToString:@"0"]||orderNumber.length == 0) {
        numberlable.hidden = YES;
    }else{
        numberlable.hidden = NO;
        if ([orderNumber integerValue]>99) {
            numberlable.text = @"99+";
        }
        CGFloat Width = [numberlable widthWithHeight:10];
        if (Width<=18) {
            Width = 18;
        }
        numberlable.frame = CGRectMake(iconimageview.width-Width*2/3, -Width/3, Width, 18);
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        CGFloat W = (YXScreenW-60)/4;
        iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake((W-imageW)/2, 8, imageW, imageW)];
        iconimageview.image = [UIImage imageNamed:@""];
        iconimageview.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iconimageview];
        
        namelable = [[UILabel alloc]initWithFrame:CGRectMake(0, iconimageview.bottom+5, W, 20)];
        namelable.text = @"test";
        namelable.font = YXSFont(12);
        namelable.textAlignment = NSTextAlignmentCenter;
        namelable.textColor = [UIColor blackColor];
        [self addSubview:namelable];
        
       
        numberlable = [[UILabel alloc]initWithFrame:CGRectMake(iconimageview.width-18*2/3, -18/3, 18, 18)];
        numberlable.textColor = [UIColor redColor];
        numberlable.text = @"1";
        numberlable.font = YXSFont(12);
        numberlable.layer.masksToBounds = YES;
        numberlable.layer.cornerRadius = numberlable.width/2;
        numberlable.layer.borderColor = [UIColor redColor].CGColor;
        numberlable.layer.borderWidth = 1;
        numberlable.textAlignment = NSTextAlignmentCenter;
        numberlable.backgroundColor = [UIColor whiteColor];
        [iconimageview addSubview:numberlable];
        
    }
    return self;
}

@end
