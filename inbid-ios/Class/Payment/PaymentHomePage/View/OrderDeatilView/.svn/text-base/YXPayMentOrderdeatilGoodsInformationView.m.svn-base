//
//  YXPayMentOrderdeatilGoodsInformationView.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentOrderdeatilGoodsInformationView.h"

@interface YXPayMentOrderdeatilGoodsInformationView ()
{
    UIImageView *goodsimage;
    UILabel *goodsnamelable;
    UILabel *goodspricelable;

    UIView *lineview;
    
    UILabel *goodsTotalPriceTitle;
    UILabel *goodsTotalPriceContent;
    UILabel *yunfeiTitle;
    UILabel *yunfeiContent;
    UILabel *alearlyPayTitle;
    UILabel *alearlyPayContent;
    UILabel *shengyuPriceTitle;
    UILabel *shengyuPriceContent;
}

@end

@implementation YXPayMentOrderdeatilGoodsInformationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        goodsimage = [[UIImageView alloc]init];
        goodsimage.image = [UIImage imageNamed:@""];
        goodsimage.backgroundColor = [UIColor redColor];
        [self addSubview:goodsimage];
        
        
        
        
        UIColor *color = UIColorFromRGB(0x050505);
        
        goodsnamelable = [self creatlable:@"哈哈" font:14 textcolor:color];
        goodsnamelable.numberOfLines = 0;
        goodspricelable = [self creatlable:@"￥12" font:14 textcolor: UIColorFromRGB(0xad0810)];

        
        
        lineview = [[UIView alloc]init];
        lineview.backgroundColor = UIColorFromRGB(0Xe5e5e5);
        [self addSubview:lineview];
        
        goodsTotalPriceTitle = [self creatlable:@"商品总金额" font:13 textcolor:color];
        goodsTotalPriceContent = [self creatlable:@"￥12" font:13 textcolor:color];
        yunfeiTitle = [self creatlable:@"运费" font:11 textcolor:color];
        yunfeiContent = [self creatlable:@"免运费" font:11 textcolor:color];
        alearlyPayTitle = [self creatlable:@"已支付金额" font:11 textcolor:color];
        alearlyPayContent = [self creatlable:@"￥12" font:11 textcolor:color];
        shengyuPriceTitle = [self creatlable:@"" font:12 textcolor:color];
        shengyuPriceContent = [self creatlable:@"￥12" font:12 textcolor:color];
        
        yunfeiContent.alpha = 0.6;
        alearlyPayContent.alpha = 0.6;
        goodsTotalPriceContent.textAlignment = NSTextAlignmentRight;
        yunfeiContent.textAlignment = NSTextAlignmentRight;
        alearlyPayContent.textAlignment = NSTextAlignmentRight;
        shengyuPriceContent.textAlignment = NSTextAlignmentRight;
        
        NSMutableAttributedString* shengyuPriceTitleStr = [[NSMutableAttributedString alloc] initWithString:@"剩余金额（商品总金额-已支付金额）"];
        [shengyuPriceTitleStr addAttribute:NSFontAttributeName value:YXSFont(13) range:NSMakeRange(0, 4)];
        [shengyuPriceTitleStr addAttribute:NSFontAttributeName value:YXSFont(9) range:NSMakeRange(4, shengyuPriceTitleStr.length-4)];
        shengyuPriceTitle.attributedText = shengyuPriceTitleStr;
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    goodsimage.frame = CGRectMake(15, 10, 67, 67);
    goodsnamelable.frame = CGRectMake(goodsimage.right+10, goodsimage.y, YXScreenW-goodsimage.right-20, 30);
    goodspricelable.frame =CGRectMake(goodsnamelable.x, goodsimage.bottom-20,goodsnamelable.width, 20);
    
    CGFloat LeftX = 10;
    CGFloat LeftW = 130;
    CGFloat RightX = YXScreenW-150;
    CGFloat RightW = 140;
    CGFloat textH = 20;
    CGFloat rowjiange = 5;
    goodsTotalPriceTitle.frame = CGRectMake(LeftX, goodsimage.bottom+10, LeftW, textH);
    goodsTotalPriceContent.frame = CGRectMake(RightX, goodsTotalPriceTitle.y, RightW, textH);
    yunfeiTitle.frame = CGRectMake(LeftX, goodsTotalPriceTitle.bottom+rowjiange, LeftW, textH);
    yunfeiContent.frame = CGRectMake(RightX, yunfeiTitle.y, RightW, textH);
    alearlyPayTitle.frame = CGRectMake(LeftX, yunfeiTitle.bottom+rowjiange, LeftW, textH);
    alearlyPayContent.frame = CGRectMake(RightX, alearlyPayTitle.y, RightW, textH);
    shengyuPriceTitle.frame = CGRectMake(LeftX, alearlyPayTitle.bottom+rowjiange, LeftW+60, textH);
    shengyuPriceContent.frame = CGRectMake(RightX, shengyuPriceTitle.y, RightW, textH);
    
    
    
}

-(UILabel *)creatlable:(NSString *)str font:(NSInteger)font textcolor:(UIColor*)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.font = YXSFont(font);
    lable.text = str;
    lable.textColor = color;
    [self addSubview:lable];
    return lable;
}


@end
