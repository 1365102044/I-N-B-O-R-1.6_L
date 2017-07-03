//
//  YXMyaccountGotoPayMentTopUserInformationView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/2.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyaccountGotoPayMentTopUserInformationView.h"

#import "UILabel+Extension.h"
@interface YXMyaccountGotoPayMentTopUserInformationView ()
{
    
    /*
     @brief 地址信息view
     */
    UILabel *GoodsnameLable;
    UILabel *userNameLable;
    UILabel *userPhoenLable;
    UILabel *addressLable;
    UILabel *dingdanAllCountLable;
    UILabel *shouldPriceLable;
    
    /*
     @brief 已付的金额
     */
    UILabel *alealyPriceLable;
}


@end

@implementation YXMyaccountGotoPayMentTopUserInformationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        GoodsnameLable = [[UILabel alloc]init];
        GoodsnameLable.font = YXRegularfont(13);
        GoodsnameLable.textColor = UIColorFromRGB(0x050505);
        GoodsnameLable.alpha = 0.8;
        GoodsnameLable.text = @"很快就大哭大叫哈速度";
        [self addSubview:GoodsnameLable];
        GoodsnameLable.numberOfLines = 0;
        
        userNameLable = [[UILabel alloc]init];
        userNameLable.font = YXRegularfont(10);
        userNameLable.textColor = UIColorFromRGB(0xaaa7a7);
        [self addSubview:userNameLable];
        
        userPhoenLable = [[UILabel alloc]init];
        userPhoenLable.font = YXRegularfont(10);
        userPhoenLable.textColor = UIColorFromRGB(0xaaa7a7);
        [self addSubview:userPhoenLable];
        
        addressLable = [[UILabel alloc]init];
        addressLable.font = YXRegularfont(10);
        addressLable.textColor = UIColorFromRGB(0xaaa7a7);
        addressLable.numberOfLines =0;
        [addressLable setRowSpace:5];
        [self addSubview:addressLable];
        
        
        
        dingdanAllCountLable = [[UILabel alloc]init];
        dingdanAllCountLable.font = YXRegularfont(10);
        dingdanAllCountLable.textColor = [UIColor mainThemColor];
        [self addSubview:dingdanAllCountLable];
        
        shouldPriceLable = [[UILabel alloc]init];
        shouldPriceLable.font = YXRegularfont(10);
        shouldPriceLable.textColor = [UIColor mainThemColor];
        [self addSubview:shouldPriceLable];
        
        
        
        alealyPriceLable = [[UILabel alloc]init];
        alealyPriceLable.font = YXRegularfont(10);
        alealyPriceLable.textColor = [UIColor mainThemColor];
        [self addSubview:alealyPriceLable];
        
        /*
         @brief 扫码支付完成后，如果是分笔支付后，到这个页面 刷新该页面到价钱
         */
        [YXNotificationTool addObserver:self selector:@selector(RefreshPrice:) name:@"POSTPAYDICT" object:nil];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    
    CGFloat goodsNameH =[GoodsnameLable heightWithWidth:YXScreenW-20];
    
    if (goodsNameH<=20) {
        goodsNameH=20;
    }
    GoodsnameLable.frame = CGRectMake(margin, margin, YXScreenW-20, goodsNameH);
    
    
    
    if (!_fomreVC) {
        
        CGFloat userphoneW = [userPhoenLable widthWithHeight:20];
        CGFloat usernameW = [userNameLable widthWithHeight:20];
        
        if (usernameW >= YXScreenW-margin*2-userphoneW) {
            usernameW = YXScreenW-margin*2-userphoneW;
        }
        userNameLable.frame = CGRectMake(margin, GoodsnameLable.bottom+5, usernameW, 20);
        
        userPhoenLable.frame = CGRectMake(userNameLable.right+10, userNameLable.y, userphoneW, 20);
        
        CGFloat addressH = [addressLable heightWithWidth:YXScreenW-20];
        if (addressH<20) {
            addressH = 20;
        }
        addressLable.frame = CGRectMake(margin, userNameLable.bottom+5, YXScreenW-20, addressH);
        
        dingdanAllCountLable.frame = CGRectMake(margin, addressLable.bottom+5, YXScreenW-20, 20);
        
        
    }else{
        
        dingdanAllCountLable.frame = CGRectMake(margin, GoodsnameLable.bottom+5, YXScreenW-20, 20);
        
    }
    if (self.isPartPay==1) {
        
        alealyPriceLable.frame = CGRectMake(margin, dingdanAllCountLable.bottom+5, YXScreenW-20, 20);
        
        shouldPriceLable.frame = CGRectMake(margin, alealyPriceLable.bottom+5, YXScreenW-20, 20);
        
    }else{
        
        shouldPriceLable.frame = CGRectMake(margin, dingdanAllCountLable.bottom+5, YXScreenW-20, 20);
    }
    
    
    if(self.heightBlock)
    {
        self.heightBlock(shouldPriceLable.bottom+10);
    }
    
}

/*
 @brief 刷新页面的价额 数据
 */
-(void)RefreshPrice:(NSNotification*)noti
{
    
    self.isPartPay = 1;
    
    //    NSString*shouldAmt = noti.userInfo[@"shouldAmt"];
    NSString *alreadyPay = noti.userInfo[@"alreadyPay"];
    
    
    NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[alreadyPay integerValue]/100 ]];
    alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
    
    NSString *shouldAmt = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[noti.userInfo[@"shouldAmt"] integerValue]/100 ]];
    shouldPriceLable.text = [NSString stringWithFormat:@"应付金额：¥%@",shouldAmt];
    
    [self layoutSubviews];
    
}

/*
 @brief 保证金 数据
 */
-(void)setNoPayMarginPriceOrderModle:(YXMySureMoneyNopaymentModle *)NoPayMarginPriceOrderModle
{
    _NoPayMarginPriceOrderModle = NoPayMarginPriceOrderModle;
    
    GoodsnameLable.text = [NSString stringWithFormat:@"商品名称：%@",NoPayMarginPriceOrderModle.prodName];
    
    NSString *shouldprice;
    
        
    
    NSString *allprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",NoPayMarginPriceOrderModle.marginPrice /100 ]];
    dingdanAllCountLable.text = [NSString stringWithFormat:@"保证金总金额：¥%@",allprice];
    
    
    NSInteger should = (NoPayMarginPriceOrderModle.marginPrice - NoPayMarginPriceOrderModle.alreadyPayAmount)/100;
    shouldprice= [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",should]] ;
        
    
    if (self.isPartPay==1) {
        
        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",NoPayMarginPriceOrderModle.alreadyPayAmount/100 ]];
        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
    }
    
    shouldPriceLable.text = [NSString stringWithFormat:@"应付金额：¥%@",shouldprice];
    
    [self layoutSubviews];
    
}

/*
 @brief 拍品 的数据
 */
-(void)setDingdanDataModle:(YXMyAccoutWaitPayModle *)DingdanDataModle
{
    _DingdanDataModle = DingdanDataModle;
    
    userNameLable.text = [NSString stringWithFormat:@"收货人：%@",DingdanDataModle.consigneeName];
    
    
    NSString *str1 = DingdanDataModle.consigneeProvince;
    NSString *str2 = DingdanDataModle.consigneeCity;
    
    
    if (str1.length==0||str2.length ==0) {
        /*
         @brief  自提的 电话不加密
         */
        userPhoenLable.text = [NSString stringWithFormat:@"电话：%@",DingdanDataModle.consigneeMobile];
        
        addressLable.text = [NSString stringWithFormat:@"收货地址：%@",DingdanDataModle.consigneeAddressDetail];
        
    }else{
        
        NSString *phonestr =  [YXStringFilterTool replaceStringWithAsterisk:DingdanDataModle.consigneeMobile startLocation:3 lenght:4] ;
        
        userPhoenLable.text = [NSString stringWithFormat:@"电话：%@",phonestr];

        addressLable.text = [NSString stringWithFormat:@"收货地址：%@%@%@",DingdanDataModle.consigneeProvince,DingdanDataModle.consigneeCity,DingdanDataModle.consigneeAddressDetail];
    }
    
    GoodsnameLable.text = [NSString stringWithFormat:@"商品名称：%@",DingdanDataModle.prodName];
    
    
    
    NSString *shouldprice;

    
        NSString *allprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[DingdanDataModle.orderTotalAmount integerValue]/100 ]];
        dingdanAllCountLable.text = [NSString stringWithFormat:@"订单总金额：¥%@",allprice];
    
    
        NSString * should = [NSString stringWithFormat:@"%ld",([DingdanDataModle.orderPayAmount integerValue]/100 - [DingdanDataModle.alreadyPayAmount integerValue]/100) ];
        shouldprice= [YXStringFilterTool strmethodComma: should] ;
        
    
    
    if (self.isPartPay==1) {
        
        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[DingdanDataModle.alreadyPayAmount integerValue]/100 ]];
        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
    }
    
    shouldPriceLable.text = [NSString stringWithFormat:@"应付金额：¥%@",shouldprice];
    
    
    [self layoutSubviews];

    
}



//-(void)setDataDict:(NSDictionary *)dataDict
//{
//    _dataDict = dataDict;
//    
//    if (dataDict==nil) {
//        return;
//    }
//    
//    if (!_fomreVC) {
//        
//        userNameLable.text = [NSString stringWithFormat:@"收货人：%@",dataDict[@"consigneeName"]];
//        
//        NSString *phonestr =  [YXStringFilterTool replaceStringWithAsterisk:dataDict[@"consigneeMobile"] startLocation:3 lenght:4] ;
//        
//        userPhoenLable.text = [NSString stringWithFormat:@"电话：%@",phonestr];
//        NSString *str1 = dataDict[@"consigneeProvince"];
//        NSString *str2 = dataDict[@"consigneeCity"];
//        if (str1.length==0||str2.length ==0) {
//            addressLable.text = [NSString stringWithFormat:@"收货地址：%@",dataDict[@"consigneeAddressDetail"]];
//
//        }else{
//        
//            addressLable.text = [NSString stringWithFormat:@"收货地址：%@%@%@",dataDict[@"consigneeProvince"],dataDict[@"consigneeCity"],dataDict[@"consigneeAddressDetail"]];
//        }
//    }
//    
//    
//    
//    
//    GoodsnameLable.text = [NSString stringWithFormat:@"商品名称：%@",dataDict[@"prodName"]];
//    NSString *shouldprice;
//    if (self.fomreVC) {
//        
//        
//        NSString *allprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[dataDict[@"orderPayAmount"] integerValue]/100 ]];
//        
//        dingdanAllCountLable.text = [NSString stringWithFormat:@"保证金总金额：¥%@",allprice];
//        
//        
//        NSInteger should = ([dataDict[@"orderPayAmount"] integerValue] - [dataDict[@"alreadyPayAmount"] integerValue])/100;
//        shouldprice= [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",should]] ;
//        
//    }else{
//        
//        
//        
//        NSString *allprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[dataDict[@"orderTotalAmount"] integerValue]/100 ]];
//        dingdanAllCountLable.text = [NSString stringWithFormat:@"订单总金额：¥%@",allprice];
//        
//        NSString * should = [NSString stringWithFormat:@"%ld",([dataDict[@"orderPayAmount"] integerValue]/100 - [dataDict[@"alreadyPayAmount"] integerValue]/100) ];
//        
//        shouldprice= [YXStringFilterTool strmethodComma: should] ;
//    }
//    if (self.isPartPay==1) {
//        
//        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[_dataDict[@"alreadyPayAmount"] integerValue]/100 ]];
//        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
//    }
//    
//    shouldPriceLable.text = [NSString stringWithFormat:@"应付金额：¥%@",shouldprice];
//    
//    [self layoutSubviews];
//}
-(void)setIsPartPay:(NSInteger)isPartPay
{
    _isPartPay = isPartPay;
    if(self.fomreVC ==1)
    {
        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",self.NoPayMarginPriceOrderModle.alreadyPayAmount/100 ]];
        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
        
    }else{
        
        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[self.DingdanDataModle.alreadyPayAmount  integerValue]/100 ]];
        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
    }

    [self layoutSubviews];
    
}
-(void)setFomreVC:(NSInteger)fomreVC
{
    _fomreVC = fomreVC;
    
    if(fomreVC ==1)
    {
        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",self.NoPayMarginPriceOrderModle.alreadyPayAmount/100 ]];
        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];

    }else{
        
        NSString *alealyprice = [YXStringFilterTool strmethodComma: [NSString stringWithFormat:@"%ld",[self.DingdanDataModle.alreadyPayAmount  integerValue]/100 ]];
        alealyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alealyprice];
    }
        
    
    [self layoutSubviews];
    
}

@end
