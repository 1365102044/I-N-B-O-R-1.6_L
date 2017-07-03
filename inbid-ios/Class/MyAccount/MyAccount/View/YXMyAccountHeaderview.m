//
//  YXMyAccountHeaderview.m
//  MyAccountView
//
//  Created by 胤讯测试 on 16/11/19.
//  Copyright © 2016年 胤讯--LWQ. All rights reserved.
//



#import "YXMyAccountHeaderview.h"

@interface YXMyAccountHeaderview ()

{

    UIImageView *backimageview;
    
    
    UIImageView *jiantouiamge ;
    
}


@end

@implementation YXMyAccountHeaderview



-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        backimageview = [[UIImageView alloc]init];
        backimageview.image = [UIImage imageNamed:@"bj"];
        [self addSubview:backimageview];
        backimageview.userInteractionEnabled = YES;
        
        
        self.iconimageview = [[UIImageView alloc]init];
        self.iconimageview.image =[UIImage imageNamed:@"ic_default"];
        self.iconimageview.layer.masksToBounds = YES;
        self.iconimageview.layer.cornerRadius = 28;
        self.iconimageview.backgroundColor = [UIColor clearColor];
        self.iconimageview.userInteractionEnabled = YES;
        [self addSubview:self.iconimageview];
        
        
        self.namelable = [[UILabel alloc]init];
//        self.namelable.text = @"未登录";
        self.namelable.font = [UIFont systemFontOfSize:13];
        self.namelable.textColor = [UIColor whiteColor];
        self.namelable.textAlignment = NSTextAlignmentLeft;
        self.namelable.backgroundColor = [UIColor clearColor];
        [self addSubview:self.namelable];
        self.namelable.userInteractionEnabled = YES;
        
        
        self.xiangqingBtn = [[UIButton alloc]init];
//        [self.xiangqingBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.xiangqingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.xiangqingBtn addTarget:self action:@selector(clickxiangqing) forControlEvents:UIControlEventTouchUpInside];
        self.xiangqingBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.xiangqingBtn];

        
        jiantouiamge= [[UIImageView alloc]init];
        jiantouiamge.image = [UIImage imageNamed:@"icon_fanhuiWhit"];
        [self addSubview:jiantouiamge];
        jiantouiamge.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapjiantou = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickxiangqing)];
        [jiantouiamge addGestureRecognizer:tapjiantou];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicknameimageAndName)];
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicknameimageAndName)];
//        [self.iconimageview addGestureRecognizer:tap1];
//        [self.namelable addGestureRecognizer:tap];
        [backimageview addGestureRecognizer:tap];
        
    }
    return self;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    backimageview.frame = self.bounds;
    
    self.iconimageview.frame =CGRectMake(20, (self.height-56)/2, 56, 56);
    
    jiantouiamge.frame = CGRectMake(YXScreenW-16, (self.height-11)/2, 6, 11);
    self.xiangqingBtn.frame = CGRectMake(self.width-90-6, (self.height-20)/2, 80, 20);

    self.namelable.frame= CGRectMake(self.iconimageview.width+20+5, (self.height-20)/2, YXScreenW - jiantouiamge.width-self.xiangqingBtn.width-self.iconimageview.width-20-5-30, 20);
    
    
}

-(void)setNameNickStr:(NSString *)nameNickStr
{

    _nameNickStr = nameNickStr;
    _namelable.text = nameNickStr;
}

-(void)clickxiangqing
{
    if (self.clickzhuanghublock) {
        self.clickzhuanghublock();
    }
    
}

-(void)clicknameimageAndName
{
    if (self.clickiconblock) {
        self.clickiconblock();
    }
}


@end
