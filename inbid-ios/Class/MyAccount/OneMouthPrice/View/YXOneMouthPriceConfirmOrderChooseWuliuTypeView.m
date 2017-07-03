//
//  YXOneMouthPriceConfirmOrderChooseWuliuTypeView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceConfirmOrderChooseWuliuTypeView.h"
#import "UILabel+Extension.h"
@interface YXOneMouthPriceConfirmOrderChooseWuliuTypeView ()

{
    UIImageView *goodsImageview;
    
    UIView*imageboomline;
    
    UIButton*wuliuBtn;
    UIButton*zitiBtn;
    
    UIView*zitideatilBackBigview;
    
    UILabel*zitiAddressLable;
    UILabel*phoneLable;
    UILabel*timeLable;
    
    
    UILabel*tishiLable;
    
    NSInteger   ChooseType;
}

@end

@implementation YXOneMouthPriceConfirmOrderChooseWuliuTypeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
            ChooseType = 2;
        
        goodsImageview = [[UIImageView alloc]init];
        goodsImageview.image  =[UIImage imageNamed:@""];
        [self addSubview:goodsImageview];
        
        
        imageboomline = [[UIView alloc]init];
        imageboomline.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:imageboomline];
        
        wuliuBtn = [[UIButton alloc]init];
        [wuliuBtn setTitle:@"快递送货" forState:UIControlStateNormal];
        [wuliuBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        [wuliuBtn addTarget:self action:@selector(clickWuliuBtn) forControlEvents:UIControlEventTouchUpInside];
        wuliuBtn.titleLabel.font = YXSFont(12);
        wuliuBtn.layer.masksToBounds = YES;
        wuliuBtn.layer.cornerRadius = 2;
        wuliuBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
        wuliuBtn.layer.borderWidth = 0.5;
        [self addSubview:wuliuBtn];
        wuliuBtn.backgroundColor = [UIColor mainThemColor];
        [wuliuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        zitiBtn = [[UIButton alloc]init];
        [zitiBtn setTitle:@"自提" forState:UIControlStateNormal];
        [zitiBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        [zitiBtn addTarget:self action:@selector(clickzitiBtn) forControlEvents:UIControlEventTouchUpInside];
        zitiBtn.titleLabel.font = YXSFont(12);
        zitiBtn.layer.masksToBounds = YES;
        zitiBtn.layer.cornerRadius = 2;
        zitiBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
        zitiBtn.layer.borderWidth = 0.5;
        [self addSubview:zitiBtn];
        
        
        zitideatilBackBigview = [[UIView alloc]init];
        zitideatilBackBigview.layer.borderWidth = 0.5;
        zitideatilBackBigview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        [self addSubview:zitideatilBackBigview];
        
        
        UIColor *textColor = UIColorFromRGB(0x251011);
        
        zitiAddressLable = [[UILabel alloc]init];
        zitiAddressLable.textColor=textColor;
        zitiAddressLable.font = YXRegularfont(11);
        zitiAddressLable.numberOfLines = 0;
        [zitideatilBackBigview addSubview:zitiAddressLable];
        
        zitiAddressLable.text = [NSString stringWithFormat:@"自提地址：%@",[YXLoadZitiData objectZiTiWithforKey:@"consigneeAddress"]] ;
        [zitiAddressLable setRowSpace:5];
        
        phoneLable = [[UILabel alloc]init];
        phoneLable.textColor=textColor;
        phoneLable.font = YXRegularfont(11);
        [zitideatilBackBigview addSubview:phoneLable];
        phoneLable.text =[NSString stringWithFormat:@"贵宾专线：%@", [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"]];
        
        timeLable = [[UILabel alloc]init];
        timeLable.textColor=textColor;
        timeLable.font = YXRegularfont(11);
        [zitideatilBackBigview addSubview:timeLable];
        timeLable .text =[NSString stringWithFormat:@"营业时间：%@",[YXLoadZitiData objectZiTiWithforKey:@"businessTime"] ];
        
        tishiLable = [[UILabel alloc]init];
        tishiLable.textColor = UIColorFromRGB(0xa90311);
        tishiLable.font = YXRegularfont(9);
        tishiLable.text = @"贵重商品提货需验证提货人身份信息，请提货人携带本人身份证到提货地址提取您购买的商品，如需其他人代提货，请携带代办人及提货人本身身份证。";
        tishiLable.numberOfLines = 0;
        [tishiLable setRowSpace:5];
        [self addSubview:tishiLable];
        
        
    }
    return self;
}


-(void)setGoodsimageURL:(NSString *)goodsimageURL
{
    _goodsimageURL = goodsimageURL;
    [goodsImageview sd_setImageWithURL:[NSURL URLWithString:goodsimageURL]];
    
}

//-(void)setZitiModle:(YXOneMouthPriceConfirmOrderModle *)zitiModle
//{
//    _zitiModle = zitiModle;
//    
//    zitiAddressLable.text = [NSString stringWithFormat:@"自提地址：%@",zitiModle.consigneeName];
//
//    phoneLable.text = [NSString stringWithFormat:@"贵宾专线：%@",zitiModle.consigneePhone];
//    
//    [self layoutSubviews];
//    
//}



-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat margin = 10;
    goodsImageview.frame = CGRectMake(margin, margin, 55, 55);
    
    imageboomline.frame = CGRectMake(0, goodsImageview.bottom+margin, YXScreenW, 0.5);
    
    wuliuBtn.frame = CGRectMake(margin, imageboomline.bottom+margin, 70, 25);
    zitiBtn.frame = CGRectMake(wuliuBtn.right+20, wuliuBtn.y, 70, 25);
    

    if (ChooseType==1) {
        
        zitideatilBackBigview.frame = CGRectMake(0, wuliuBtn.bottom+10, YXScreenW, 100);
        CGFloat addreessH = [zitiAddressLable heightWithWidth:YXScreenW-20];
        if (addreessH<=20) {
            addreessH = 20;
        }
        zitiAddressLable.frame = CGRectMake(margin, margin, YXScreenW-20, addreessH);
        phoneLable.frame = CGRectMake(margin, zitiAddressLable.bottom+10, YXScreenW-20, 20);
        timeLable.frame = CGRectMake(margin, phoneLable.bottom+10, YXScreenW-20, 20);
        tishiLable.frame = CGRectMake(margin, zitideatilBackBigview.bottom+10, YXScreenW-20, 50);
        zitideatilBackBigview.height = 100-20+addreessH;
        if (self.heightblock) {
            self.heightblock(tishiLable.bottom);
        }
    }else if (ChooseType==2)
    {
        if (self.heightblock) {
            self.heightblock(wuliuBtn.bottom+10);
        }
    
    }
    
}

-(void)clickzitiBtn
{
    ChooseType = 1;
    
    zitiBtn.backgroundColor = [UIColor mainThemColor];
    [zitiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    wuliuBtn.backgroundColor = [UIColor whiteColor];
    [wuliuBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    
    
    zitideatilBackBigview.hidden = NO;
    tishiLable.hidden = NO;
    
    if (self.chooseTypeBlcok) {
        self.chooseTypeBlcok(@"自提");
    }
    [self layoutSubviews];
    
}
-(void)clickWuliuBtn
{
    ChooseType = 2;
    
    wuliuBtn.backgroundColor = [UIColor mainThemColor];
    [wuliuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    zitiBtn.backgroundColor = [UIColor whiteColor];
    [zitiBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];

    zitideatilBackBigview.hidden = YES;
    tishiLable.hidden = YES;

    if (self.chooseTypeBlcok) {
        self.chooseTypeBlcok(@"快递送货");
    }

    [self layoutSubviews];
}

/*
 @brief 已经选择的
 */
-(void)setPeisongtypestr:(NSString *)peisongtypestr
{
    _peisongtypestr = peisongtypestr;
    
    if ([peisongtypestr isEqualToString:@"自提"]) {
        
        [self clickzitiBtn];
        
    }else if ([peisongtypestr isEqualToString:@"快递物流"])
    {
        [self clickWuliuBtn];
    }
}


@end
