//
//  YXMyWalletMainTableViewCell.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletMainTableViewCell.h"


@interface YXMyWalletMainTableViewCell ()

//@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
//
//@property (weak, nonatomic) IBOutlet UILabel *titlelable;

{
    UIImageView *letimageview ;
    UILabel *titlelable;
    UIImageView *jiantouimage ;
}
@end

@implementation YXMyWalletMainTableViewCell

-(void)setTitlename:(NSString *)titlename{
    titlelable.text = titlename;
    letimageview.image = [UIImage imageNamed:titlename];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        letimageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 50)];
        letimageview.centerY = self.centerY;
        letimageview.image = [UIImage imageNamed:@"icon_dingdan"];
        [self addSubview:letimageview];
        
        titlelable = [[UILabel alloc]initWithFrame:CGRectMake(letimageview.right+5, 10, 100, 30)];
        titlelable.text = @"test";
        titlelable.textColor = UIColorFromRGB(0x333333);
        titlelable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titlelable];
        
        jiantouimage = [[UIImageView alloc]initWithFrame:CGRectMake(YXScreenW-17, (50-12.5)/2, 7, 12.5)];
        jiantouimage.image = [UIImage imageNamed:@"icon_newsjiantou"];
        [self addSubview:jiantouimage];

        
    }
    return self;
}

@end
