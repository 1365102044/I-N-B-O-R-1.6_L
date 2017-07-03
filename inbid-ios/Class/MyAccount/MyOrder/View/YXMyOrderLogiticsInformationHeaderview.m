//
//  YXMyOrderLogiticsInformationHeaderview.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyOrderLogiticsInformationHeaderview.h"
#import "YXStringFilterTool.h"
#import "UILabel+Extension.h"
@interface YXMyOrderLogiticsInformationHeaderview ()
{
    UIView *topview;
    UILabel *nameLable;
    UILabel *statusLable;


}

@end

@implementation YXMyOrderLogiticsInformationHeaderview

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
        topview = [[UIView alloc]init];
        topview.backgroundColor = [UIColor whiteColor];
        [self addSubview:topview];
        
        nameLable = [self addLable:@"" font:13 textcolor:[UIColor mainThemColor]];
        [topview addSubview:nameLable];
        
        statusLable = [self addLable:@"等待收货" font:13 textcolor:[UIColor mainThemColor]];
        [topview addSubview:statusLable];
        
        topview.layer.borderWidth = 0.5;
        topview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        
        
        
        
        
    }
    return self;
}

-(void)setTopviewDataArrModle:(YXMyOrderLoginticsInformationListModle *)topviewDataArrModle
{
    _topviewDataArrModle = topviewDataArrModle;
    nameLable.text = topviewDataArrModle.deliveryMerchant;
    statusLable.text = [NSString stringWithFormat:@"运单号：%@",topviewDataArrModle.deliveryNum];
    

    
}





-(void)layoutSubviews{

    [super layoutSubviews];

    topview.frame = CGRectMake(0, 0, YXScreenW, 74);
    nameLable.frame = CGRectMake(10, 10, YXScreenW-20, 20);
    statusLable.frame  = CGRectMake(10, nameLable.bottom+10, YXScreenW-20, 20);
    
 }

-(UILabel *)addLable:(NSString *)str font:(NSInteger)font textcolor:(UIColor*)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor whiteColor];
    lable.text = str;
    lable.font = YXRegularfont(font);
    lable.textColor = color;
    return lable;
}

@end
