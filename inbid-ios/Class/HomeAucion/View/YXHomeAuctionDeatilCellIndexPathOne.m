//
//  YXHomeAuctionDeatilCellIndexPathOne.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilCellIndexPathOne.h"

@interface YXHomeAuctionDeatilCellIndexPathOne ()
{
    UIButton *btn;
    UIView *centerview;
    
    UIImageView * rightImageview;
    
    
}

@end

@implementation YXHomeAuctionDeatilCellIndexPathOne

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  UIColorFromRGB(0xf9f9f9);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelfview)];
        
        [self addGestureRecognizer:tap];
        
        
        centerview = [[UIView alloc]init];
        centerview.backgroundColor = [UIColor whiteColor];
        [self addSubview:centerview];
        
        btn = [[UIButton alloc]init];
        NSMutableAttributedString* btnstr = [[NSMutableAttributedString alloc] initWithString:@" 竞拍规则"];
        [btnstr addAttribute:NSForegroundColorAttributeName value:YXHomeDeatilcolor range:NSMakeRange(0, btnstr.length)];
        //        [btnstr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, btnstr.length-4)];
        [btnstr addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(0, btnstr.length)];
        //        [btnstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, btnstr.length-4)];
        
        [btn setAttributedTitle:btnstr forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_jingpai"] forState:UIControlStateNormal];
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [centerview addSubview:btn];
        
        
        rightImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shangpingdeatiljaintou"]];
        [self addSubview:rightImageview];
        
    }
    return self;
}

//添加点击手势
-(void)clickSelfview
{
    if (self.myblock) {
        self.myblock();
    }
}


-(void)setModle:(YXHomeDeatilModle *)modle
{
    _modle = modle;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    centerview.frame = CGRectMake(0, 10, YXScreenW, 40);

    btn.size = CGSizeMake(120, 40);
    btn.x = 10;
    btn.y = 0;
    
    
    rightImageview.size = CGSizeMake(10, 16);
    rightImageview.centerY = centerview.centerY;
    rightImageview.x = YXScreenW-10-10;
}
@end
