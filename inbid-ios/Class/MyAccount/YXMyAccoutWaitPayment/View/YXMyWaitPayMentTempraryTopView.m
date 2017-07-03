//
//  YXMyWaitPayMentTempraryTopView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/4.
//  Copyright © 2016年 胤讯. All rights reserved.
//

/*
 *
 临时页面
 本视图 只是暂时 的使用，在没有 微信 支付 接通，只有使用 PC 支付的时候，
 
 
 
 *
 */

#import "YXMyWaitPayMentTempraryTopView.h"
@interface YXMyWaitPayMentTempraryTopView ()

{
    UIImageView * payimageview;
    UILabel *YinLianTypeTishiLable;
    
}

@end


@implementation YXMyWaitPayMentTempraryTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        payimageview = [[UIImageView alloc]init];
        [self addSubview:payimageview];
        payimageview.image = [UIImage imageNamed:@"ic_ylwxz"];
        
        
        YinLianTypeTishiLable = [[UILabel alloc]init];
        YinLianTypeTishiLable.font = YXRegularfont(12);
        NSString *str = @"电脑打开inborn.com/pay扫描二维码即可在线支付";
        NSMutableAttributedString *atter = [[NSMutableAttributedString alloc]initWithString:str];
        [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(0, atter.length)];
        [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x419bef) range:NSMakeRange(4, 14)];
        [atter addAttribute:NSFontAttributeName value:YXRegularfont(12) range:NSMakeRange(0, atter.length)];
        YinLianTypeTishiLable.attributedText = atter;
        YinLianTypeTishiLable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:YinLianTypeTishiLable];
        
        
        
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = 122;
    CGFloat H = 78;
    payimageview.frame= CGRectMake((self.width-W)/2, 0, W, H);
    
    YinLianTypeTishiLable.frame  =CGRectMake(10, payimageview.bottom+8, YXScreenW-20, 20);
    
    
    
    
    
}



@end
