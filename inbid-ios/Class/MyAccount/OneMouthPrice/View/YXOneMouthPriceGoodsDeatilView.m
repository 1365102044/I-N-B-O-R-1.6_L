//
//  YXOneMouthPriceGoodsDeatilView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceGoodsDeatilView.h"
#import "UILabel+Extension.h"
#import "YXMyTwoLable.h"


@interface YXOneMouthPriceGoodsDeatilView ()
{

    
    UILabel *titleLable;

    
    UIView *goodsDeatilBigBackView;
    UIImageView *goodsimageview;
    UILabel*goodsNameLable;
    UILabel *goodspricelable;
    
    YXMyTwoLable *allpricelable;
    YXMyTwoLable *yunfeilable;
    YXMyTwoLable *huodonglable;
    YXMyTwoLable *alearlylable;
    YXMyTwoLable *shouldpaylable;
    
    UIView *lineview;
    
}


@end

@implementation YXOneMouthPriceGoodsDeatilView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        self.layer.borderWidth = 0.5;
        
        goodsDeatilBigBackView = [[UIView alloc]init];
        goodsDeatilBigBackView.layer.borderWidth = 0.5;
        goodsDeatilBigBackView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        
        
        titleLable = [self setMyLable:@"1件商品" textcolor:[UIColor mainThemColor]];
        titleLable.font = YXSFont(13);
        goodsimageview = [[UIImageView alloc]init];
//        goodsimageview.image = [UIImage imageNamed:@"icon_touxiang"];
        
        
        
        goodsNameLable = [self setMyLable:@"" textcolor:[UIColor mainThemColor]];
        goodsNameLable.numberOfLines = 0;
        goodsNameLable.font = YXSFont(12);
        
        goodspricelable = [self setMyLable:@"单价：￥000" textcolor:UIColorFromRGB(0x999999)];
        
        [goodsDeatilBigBackView addSubview:goodsimageview];
        [goodsDeatilBigBackView addSubview:goodsNameLable ];
        [goodsDeatilBigBackView addSubview:goodspricelable];
        
        
        allpricelable = [[YXMyTwoLable alloc]init];
        allpricelable.leftstr = @"订单总金额";
        allpricelable.myfont = YXSFont(13);

        
        yunfeilable = [[YXMyTwoLable alloc]init];
        yunfeilable.leftstr = @"+运费(含商品保价费)";
        
        huodonglable = [[YXMyTwoLable alloc]init];
        huodonglable.leftstr = @"-活动优惠(包邮)";
        
        alearlylable = [[YXMyTwoLable alloc]init];
        alearlylable.leftstr = @"-已付金额";
        
        shouldpaylable = [[YXMyTwoLable alloc]init];
        shouldpaylable.myfont = YXSFont(13);
        shouldpaylable .leftstr = @"待付款金额";
        
        lineview = [[UIView alloc]init];
        lineview.backgroundColor = UIColorFromRGB(0xe5e5e5);
        
    }
    return self;
}


-(void)setOneMouthPriceConfirmModel:(YXOneMouthPriceConfirmOrderModle *)OneMouthPriceConfirmModel
{

    _OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
    
    [self addSubview:goodsDeatilBigBackView];
    [self addSubview:titleLable];
    [self addSubview:allpricelable];
    [self addSubview:yunfeilable];
    [self addSubview:huodonglable];
    [self addSubview:alearlylable];
    [self addSubview:shouldpaylable];
    [self addSubview:lineview];
    
    titleLable.text = [NSString stringWithFormat:@"%@件商品",OneMouthPriceConfirmModel.goodsNum];

    [goodsimageview sd_setImageWithURL:[NSURL URLWithString:OneMouthPriceConfirmModel.imgUrl] placeholderImage:[UIImage imageNamed:@"newsGoodslogo"]];
    

    goodsNameLable.text = OneMouthPriceConfirmModel.prodName;
    NSString *danjiaprice = [NSString stringWithFormat:@"单价：￥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",OneMouthPriceConfirmModel.prodPrice/100]]];
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:danjiaprice];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x939393) range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(11) range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xad0810) range:NSMakeRange(3, attrStr.length-3)];
    [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(3, attrStr.length-3)];
    goodspricelable.attributedText = attrStr;
    
    
    
    NSString *allpricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)[OneMouthPriceConfirmModel.orderTotalAmount integerValue]/100]];
    allpricelable.rightstr = [NSString stringWithFormat:@"¥%@",allpricestr];
    //** 运费 + 报价费 */
    NSInteger yunfeibaojiafei = (OneMouthPriceConfirmModel.carriage +OneMouthPriceConfirmModel.protectPrice)/100;
    NSString *yunfeipricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",yunfeibaojiafei]];
    yunfeilable.rightstr = [NSString stringWithFormat:@"¥%@",yunfeipricestr];

    
    //** huodong */
    huodonglable.rightstr = [NSString stringWithFormat:@"￥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",OneMouthPriceConfirmModel.orderDiscountAmount/100]]];
    
    //** alearlyprice */
    NSInteger alearlyprice = OneMouthPriceConfirmModel.alreadyPayAmount;
    alearlylable.rightstr = [NSString stringWithFormat:@"￥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",alearlyprice/100]]];
    
    //** 总金额+运费+报价-优惠价 */
    NSInteger shouldpre = [OneMouthPriceConfirmModel.orderTotalAmount integerValue] +OneMouthPriceConfirmModel.carriage + OneMouthPriceConfirmModel.protectPrice - OneMouthPriceConfirmModel.orderDiscountAmount;
    NSString *shouldpricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",shouldpre/100]];
    shouldpaylable.rightstr = [NSString stringWithFormat:@"¥%@",shouldpricestr];
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat Kmargin = 10;

    CGFloat myLH = 20;
    
    titleLable.frame= CGRectMake(Kmargin, 5, YXScreenW-20, 30);
    
    goodsDeatilBigBackView.frame = CGRectMake(0, titleLable.bottom, YXScreenW, 95);
    goodsimageview.frame = CGRectMake(Kmargin, Kmargin, 70, 70);
    CGFloat contW = YXScreenW-goodsimageview.width-Kmargin*3;
    CGFloat nameH = [goodsNameLable heightWithWidth:contW];
    if (nameH>50) {
        nameH = 50;
    }
    goodsNameLable.frame= CGRectMake(goodsimageview.right+Kmargin, goodsimageview.y, contW , nameH);
    goodspricelable.frame = CGRectMake(goodsimageview.right+Kmargin, goodsimageview.bottom-20, contW, 20);
    
    allpricelable.frame = CGRectMake(0, goodsDeatilBigBackView.bottom+Kmargin, YXScreenW, myLH);
    yunfeilable.frame = CGRectMake(10, allpricelable.bottom+Kmargin,YXScreenW-10 , myLH);
    huodonglable.frame = CGRectMake(10, yunfeilable.bottom+Kmargin, yunfeilable.width, myLH);
    alearlylable.frame = CGRectMake(10, huodonglable.bottom+Kmargin, yunfeilable.width, myLH);
    shouldpaylable.frame = CGRectMake(0, alearlylable.bottom+Kmargin*2, allpricelable.width, myLH);
    
    lineview.frame = CGRectMake(0, alearlylable.bottom+10, YXScreenW , 0.5);

    if (self.deatilheightblock) {
        self.deatilheightblock(shouldpaylable.bottom+10);
    }
    
}

-(UILabel *)setMyLable:(NSString *)textstr  textcolor:(UIColor*)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = textstr;
    lable.font = YXSFont(11);
    lable.textColor = color;
    return lable;
    
}

@end
