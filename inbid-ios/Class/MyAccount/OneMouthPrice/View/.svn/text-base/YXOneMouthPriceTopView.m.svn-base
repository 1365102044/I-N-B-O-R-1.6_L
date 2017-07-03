//
//  YXOneMouthPriceTopView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceTopView.h"

#import "YXOneMouthPriceWuLiuNoAddressView.h"
#import "YXOneMouthPriceWuLiuAddressView.h"
#import "YXOneMouthPriceGoodsDeatilView.h"


@interface YXOneMouthPriceTopView ()
{

    UILabel *peisongtypeTitleLable;
    UILabel *peisongtypeContentLable;
    UIImageView *peisongtypejiantouimageview;
    
    
    CGFloat wuliuheigth;
    NSInteger IsClickIDCardview;
    CGFloat deatilHeight;

}

@property(nonatomic,strong) YXOneMouthPriceWuLiuNoAddressView * WuliuNoAddressView;

@property(nonatomic,strong) YXOneMouthPriceWuLiuAddressView * WuliuAddressView;
@property(nonatomic,strong) YXOneMouthPriceGoodsDeatilView * goodsdeatilView;

@end

@implementation YXOneMouthPriceTopView


-(void)setChooseaddressmodle:(YXMyAddressList *)chooseaddressmodle
{
    _chooseaddressmodle  = chooseaddressmodle;
    self.WuliuAddressView.chooseaddressmodle = chooseaddressmodle;
    [self addSubview:self.WuliuAddressView];
    self.WuliuNoAddressView.hidden = YES;
    self.WuliuAddressView.hidden = NO;
    self.haveaddress = @"1";
    if (!chooseaddressmodle.IsHaveData) {
        self.WuliuAddressView.hidden = YES;
        self.WuliuNoAddressView.hidden = NO;
        self.haveaddress = @"0";
    }
    
    [self layoutSubviews];
}

#pragma mark  ******************* 赋值**********************
-(void)setOneMouthPriceConfirmModel:(YXOneMouthPriceConfirmOrderModle *)OneMouthPriceConfirmModel
{
    _OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
    
    [self addSubview:self.topbarview];
    [self addSubview:self.goodsdeatilView];
 
    
    
    self.goodsdeatilView.OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
    
    NSString *str = [_peisongtypestr componentsSeparatedByString:@"\n"][1];
    
    if ([str isEqualToString:@"快递送货"]) {
        
         peisongtypeContentLable.text  = _peisongtypestr;
        
        if ([OneMouthPriceConfirmModel.hasAddress integerValue]) {
            
            //**地址的view**/
//            [self addSubview:self.WuliuAddressView];
            self.WuliuAddressView.hidden = NO;
            self.WuliuAddressView.OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
            
            self.WuliuNoAddressView.hidden = YES;
            
        }else{
            
            //**没有默认地址的view**/
//            [self addSubview:self.WuliuNoAddressView];
            self.WuliuNoAddressView.hidden = NO;
            self.WuliuNoAddressView.descstr = @"您还没有收获地址点击这里添加";
            
            self.WuliuAddressView.hidden = YES;
            
        }

        
    }else if([str isEqualToString:@"来店自提"])
    {
        peisongtypeContentLable.text  = _peisongtypestr;
        
//        [self addSubview:self.ZiTiaddressView];
        self.ZiTiaddressView.hidden = NO;
        self.ZiTiaddressView.OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
    }
    
    
    [self layoutSubviews];
}

-(void)setMorenpaytype:(NSInteger)morenpaytype
{
    _morenpaytype =morenpaytype;
    if (morenpaytype ==1) {
        
        _peisongtypestr = @"定金支付\n快递送货";
    }else
    {
        _peisongtypestr = @"全额支付\n快递送货";
    }
    peisongtypeContentLable.text = _peisongtypestr;
}

-(void)IStapIDCardview:(NSNotification*)noti
{
    NSString *idcardstr = noti.userInfo[@"consigneeIdcard"];
    if (idcardstr) {
        IsClickIDCardview = 1;
    }else{
        IsClickIDCardview = 0;
    }
    
}

/*
 @brief 填写身份证号码
 */
-(void)clickIdCardview
{
//    if (IsClickIDCardview) {
//        return;
//    }

    if([self.WuliuAddressView.idcardContentLable.text isEqualToString:@"请填写收货人证件号码"]){
        if (self.IDCardblock) {
            self.IDCardblock();
        }
    }
}
/*
 @brief 切换地址
 */
-(void)clickAddressview
{
    if (self.changeAddressBlock) {
        self.changeAddressBlock();
    }
}
/*
 @brief 去选择地址
 */
-(void)clickgotochooseaddress
{
    if (self.changeAddressBlock) {
        self.changeAddressBlock();
    }
    
}

-(void)setPeisongtypestr:(NSString *)peisongtypestr
{
    _peisongtypestr = peisongtypestr;
    
    peisongtypeContentLable.text = peisongtypestr;
    NSString *str = [peisongtypestr componentsSeparatedByString:@"\n"][1];
    
    if ([str isEqualToString:@"快递送货"]) {
        
//        [self.ZiTiaddressView removeFromSuperview];
        self.ZiTiaddressView.hidden = YES;
        
        if ([self.haveaddress isEqualToString:@"1"]) {
            
            //**地址的view**/
//            [self addSubview:self.WuliuAddressView];
            self.WuliuAddressView.hidden = NO;
        }else{
//            [self addSubview:self.WuliuNoAddressView];
            self.WuliuNoAddressView.hidden = NO;
        }
        self.OneMouthPriceConfirmModel.hasAddress = self.haveaddress;
        
    }else if ([str isEqualToString:@"来店自提"])
    {
//        [self.WuliuNoAddressView removeFromSuperview];
//        [self.WuliuAddressView removeFromSuperview];
        self.WuliuAddressView.hidden = YES;
        self.WuliuNoAddressView.hidden=  YES;
        self.ZiTiaddressView.hidden= NO;
//         [self addSubview:self.ZiTiaddressView];
    }
    
    [self layoutSubviews];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.topbarview = [[UIView alloc]init];
        self.topbarview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        self.topbarview.layer.borderWidth = 0.5;
        self.topbarview.backgroundColor = [UIColor whiteColor];
        
        peisongtypeTitleLable = [self setMyLable:@"配送方式" textfont:13];
        peisongtypeTitleLable.font = YXSFont(13);
        
        
        peisongtypeContentLable = [self setMyLable:@"全额支付\n快递送货" textfont:10];
        peisongtypeContentLable.textColor = UIColorFromRGB(0x939393);
        peisongtypeContentLable.numberOfLines = 0;
        peisongtypeContentLable.textAlignment= NSTextAlignmentRight;
        peisongtypeContentLable.userInteractionEnabled = YES;
        
        
        peisongtypejiantouimageview = [[UIImageView alloc]init];
        peisongtypejiantouimageview.image = [UIImage imageNamed:@"shangpingdeatiljaintou"];
        peisongtypejiantouimageview.userInteractionEnabled = YES;
        
        
        
        [self.topbarview addSubview:peisongtypeTitleLable];
        [self.topbarview addSubview:peisongtypejiantouimageview];
        [self.topbarview addSubview:peisongtypeContentLable];
        
        
        __weak typeof(self) weakself = self;
        self.WuliuAddressView.heightblcok = ^(CGFloat heigth){
            
            wuliuheigth = heigth;
            
            [weakself layoutSubviews];
        };
        
        self.goodsdeatilView.deatilheightblock = ^(CGFloat height){
            deatilHeight = height;
            [weakself layoutSubviews];
        };
        
        //**地址的view**/
        [self addSubview:self.WuliuAddressView];
        [self addSubview:self.ZiTiaddressView];
        [self addSubview:self.WuliuNoAddressView];
        self.ZiTiaddressView.hidden = YES;
        self.WuliuNoAddressView.hidden = YES;
        self.WuliuAddressView.hidden = YES;
        
        /*
         @brief 控制身份证view是否能够点击
         */
        [YXNotificationTool addObserver:self selector:@selector(IStapIDCardview:) name:@"ISCLICKIDCARDVIEW" object:nil];
        
    }
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *typestr = [self.peisongtypestr componentsSeparatedByString:@"\n"][1];
    
    CGFloat makgin = 10;
    
    self.topbarview.frame =CGRectMake(0, 0, YXScreenW, 44);
    
    peisongtypeTitleLable.frame = CGRectMake(makgin, 0, 80, self.topbarview.height);
    peisongtypejiantouimageview.frame = CGRectMake(YXScreenW -6-makgin, 0, 6, 11);
    peisongtypejiantouimageview.centerY = self.topbarview.centerY;
    peisongtypeContentLable.frame = CGRectMake(YXScreenW-makgin*2-peisongtypejiantouimageview.width-120, 0, 120, 40);
    peisongtypeContentLable.centerY = self.topbarview.centerY;
    
    
    if ([typestr isEqualToString:@"快递送货"]||typestr == nil) {
        
        if ([self.haveaddress isEqualToString:@"1"]) {
        //**物流有地址**/
            if (!wuliuheigth) {
                wuliuheigth = 205;
            }
            self.WuliuAddressView.frame = CGRectMake(0, self.topbarview.bottom, YXScreenW, wuliuheigth);
            
            self.goodsdeatilView.frame = CGRectMake(0, self.WuliuAddressView.bottom+10, YXScreenW, deatilHeight);
            
            if (self.heightblock) {
                self.heightblock(self.goodsdeatilView.bottom);
            }
            
            
        }else{
            
            //**物流没有地址**/
            self.WuliuNoAddressView.frame = CGRectMake(0, self.topbarview.bottom, YXScreenW, 100);
            
            self.goodsdeatilView.frame = CGRectMake(0, self.WuliuNoAddressView.bottom+10, YXScreenW, deatilHeight);
            
            if (self.heightblock) {
                self.heightblock(self.goodsdeatilView.bottom);
            }
           
        
        }
        
        
        
    }else if([typestr isEqualToString:@"来店自提"])
    {
        
        //**自提**/
        self.ZiTiaddressView.frame = CGRectMake(0, self.topbarview.bottom, YXScreenW, 200);
        
        self.goodsdeatilView.frame = CGRectMake(0, self.ZiTiaddressView.bottom+10, YXScreenW, deatilHeight);
        
        if (self.heightblock) {
            self.heightblock(self.goodsdeatilView.bottom);
        }
   
 
    }

}

-(UILabel *)setMyLable:(NSString *)textstr textfont:(NSInteger )fontNumber
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = textstr;
    lable.textColor =  [UIColor mainThemColor];
    lable.font = YXRegularfont(fontNumber);
    
    return lable;
    
}

/**
 懒加载
 */

/*
 @brief 物流没有地址的view
 */
-(YXOneMouthPriceZiTiView*)ZiTiaddressView
{
    if (!_ZiTiaddressView) {
        _ZiTiaddressView = [[YXOneMouthPriceZiTiView alloc]init];
        _ZiTiaddressView.backgroundColor = [UIColor whiteColor];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickgotochooseaddress)];
        //        [_WuliuNoAddressView addGestureRecognizer:tap];
        
        
    }
    return _ZiTiaddressView;
}


/*
 @brief 物流有地址的view
 */

-(YXOneMouthPriceWuLiuAddressView*)WuliuAddressView
{
    if (!_WuliuAddressView) {
        _WuliuAddressView = [[YXOneMouthPriceWuLiuAddressView alloc]init];
        _WuliuAddressView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAddressview)];
        [_WuliuAddressView.addressBavkview addGestureRecognizer:addressTap];
        
        UITapGestureRecognizer *IdCardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIdCardview)];
        [_WuliuAddressView.idcardbackview addGestureRecognizer:IdCardTap];
        
    }
    return _WuliuAddressView;
}


/*
 @brief 物流没有地址的view
 */
-(YXOneMouthPriceWuLiuNoAddressView*)WuliuNoAddressView
{
    if (!_WuliuNoAddressView) {
        _WuliuNoAddressView = [[YXOneMouthPriceWuLiuNoAddressView alloc]init];
        _WuliuNoAddressView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickgotochooseaddress)];
        [_WuliuNoAddressView addGestureRecognizer:tap];
        
        
    }
    return _WuliuNoAddressView;
}
/*
 @brief 商品详情的view
 */
-(YXOneMouthPriceGoodsDeatilView*)goodsdeatilView
{
    if (!_goodsdeatilView) {
        _goodsdeatilView = [[YXOneMouthPriceGoodsDeatilView alloc]init];
        _goodsdeatilView.backgroundColor = [UIColor whiteColor];
    }
    return _goodsdeatilView;
}
@end
