//
//  YXHomeAuctionDeatilCellIndexPathThree.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilCellIndexPathThree.h"
#import "YXHomeDeatilShuxingModle.h"
#import "UILabel+Extension.h"

/*

 商品风格       商品主质
 商品颜色       品牌属地
 送货区域
 发货时间



**/

/*********************此页面 已经不用了**********************/

#define MaxCols 2
#define  kMagin 15
@interface YXHomeAuctionDeatilCellIndexPathThree ()
{
    UIButton *btn;
    UILabel *brandLable;
    UILabel *categroyLable;
    UILabel *materialLable;
    UILabel *colorLable;
    UILabel *whereLable;
    UILabel *toWhereLable;
    UILabel *styleLable;
    UILabel *timeLable;
    
    UIView *collecview;
    CGFloat collectviewMaxHeight;
    
    
    NSMutableArray *keyArr ;
    NSMutableArray *valueArr ;
    UIView*viewline;
}
@end
@implementation YXHomeAuctionDeatilCellIndexPathThree

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        btn = [[UIButton alloc]init];
        [btn setTitle:@"商品属性及发货" forState:UIControlStateNormal];
        [btn setTitleColor:YXHomeDeatilcolor forState:UIControlStateNormal];
        btn.titleLabel.font = YXRegularfont(13);
        [btn setImage:[UIImage imageNamed:@"icon_shangpin"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [self addSubview:btn];

        
        viewline = [[UIView alloc]init];
        viewline.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:viewline];
        
        
        toWhereLable = [self addLable:@"送货区域: 全国（港澳台除外）"];
        timeLable = [self addLable:@"发货时间: 付款后72小时内"];

        collecview =[[UIView alloc]init];
        [self addSubview:collecview];
        

    }
    
    return self;
}

-(void)setModle:(YXHomeDeatilModle *)modle
{
    _modle = modle;
    
    keyArr = [NSMutableArray array];
    valueArr = [NSMutableArray array];
    
    for ( YXHomeDeatilShuxingModle *shuxingmodle  in modle.prodProps) {
    
        [keyArr addObject:[NSString stringWithFormat:@"· %@",shuxingmodle.propName]];
        [valueArr addObject:shuxingmodle.propValue];
    }
    
    
//    keyArr = nil;
    
    if (keyArr.count) {
        
        for(UIView *view in [collecview subviews])
        {
            [view removeFromSuperview];
        }
        
        [self addshuxinglable];
    }
    [self layoutSubviews];

}

-(void)addshuxinglable
{
    CGFloat LABLEH = 0.0 ;
    
    for (int i=0; i<keyArr.count; i++)
    {
        UILabel *shuxinglable = [[UILabel alloc] init];
        shuxinglable.numberOfLines = 0;
        [shuxinglable setRowSpace:5];
        shuxinglable.backgroundColor = [UIColor clearColor];
        shuxinglable.text = [NSString stringWithFormat:@"%@: %@",keyArr[i],valueArr[i]];
        shuxinglable.width = YXScreenW - kMagin*2;
        CGFloat LableH = [shuxinglable heightWithWidth:YXScreenW-kMagin*2];
        shuxinglable.height = 30;
        shuxinglable.x = 0;
        shuxinglable.y =  LABLEH + 5;
        if (LableH >30) {
            
            shuxinglable.height = LableH;
        }
        LABLEH = LABLEH + shuxinglable.height;
        shuxinglable.tag = i;
        shuxinglable.font = YXRegularfont(13);
        shuxinglable.textColor = YXHomeDeatilcolor;
        [collecview addSubview:shuxinglable];
        
        collectviewMaxHeight = shuxinglable.bottom;
        
    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemHeight = 30;
    
    btn.frame = CGRectMake(15, 5, 120, 30);
    viewline.frame = CGRectMake(0, btn.bottom+5, YXScreenW, 1);
    collecview.frame =CGRectMake(kMagin, viewline.bottom, YXScreenW-kMagin*2, collectviewMaxHeight);
    toWhereLable.frame = CGRectMake(kMagin, collecview.bottom+2, YXScreenW-kMagin*2, itemHeight);
    timeLable.frame = CGRectMake(kMagin, toWhereLable.bottom+4, YXScreenW-kMagin*2, itemHeight);
    
    if (self.heightblock) {
        self.heightblock(timeLable.bottom+10);
    }
    
   
}

//** -------创建Lable -----------**/
-(UILabel *)addLable:(NSString *)textstr
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = [NSString stringWithFormat:@"· %@",textstr];
    lable.textColor = YXHomeDeatilcolor;
    lable.font = YXRegularfont(13);
    [self addSubview:lable];
    return lable;
}
@end
