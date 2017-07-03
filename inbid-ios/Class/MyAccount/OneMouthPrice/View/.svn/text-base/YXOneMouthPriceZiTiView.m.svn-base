//
//  YXOneMouthPriceZiTiView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceZiTiView.h"
#import "UILabel+Extension.h"

#import "YXOneMouthPriceWuLiuNoAddressView.h"

@interface YXOneMouthPriceZiTiView ()

{
    UIView*zitideatilBackBigview;
    
    UILabel*zitiAddressLable;
    UILabel*phoneLable;
    UILabel*timeLable;
    UIView*line;

    
    UIView*zitiInformationBackview;
    UILabel *zitiInforTitle;
    UILabel*nameandphoneLable;
    UILabel *idcardLable;
    UIImageView*jiantouiamge;
    
    BOOL isHaveInform;
    
    
}


@property(nonatomic,strong) YXOneMouthPriceWuLiuNoAddressView * WuliuNoAddressView;

@end

@implementation YXOneMouthPriceZiTiView
/*
 @brief 物流没有地址的view
 */
-(YXOneMouthPriceWuLiuNoAddressView*)WuliuNoAddressView
{
    if (!_WuliuNoAddressView) {
        _WuliuNoAddressView = [[YXOneMouthPriceWuLiuNoAddressView alloc]init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktianxieZiTiInformation)];
        [_WuliuNoAddressView addGestureRecognizer:tap];
        
        
    }
    return _WuliuNoAddressView;
}


#pragma mark  ******************* 自提个人信息赋值**********************
-(void)setZitiiformationModle:(YXZiTiInformationModle *)zitiiformationModle
{
    _zitiiformationModle = zitiiformationModle;
    
    _WuliuNoAddressView.hidden = YES;
    
    isHaveInform = YES;
    
    nameandphoneLable.text = [NSString stringWithFormat:@"%@  %@",zitiiformationModle.name,zitiiformationModle.mobile];
    idcardLable.text = zitiiformationModle.idcard;
    
    
    [self layoutSubviews];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        zitideatilBackBigview = [[UIView alloc]init];
//        zitideatilBackBigview.layer.borderWidth = 0.5;
//        zitideatilBackBigview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        [self addSubview:zitideatilBackBigview];
        
        
        UIColor *textColor = UIColorFromRGB(0x251011);
        
        zitiAddressLable = [[UILabel alloc]init];
        zitiAddressLable.textColor=textColor;
        zitiAddressLable.font = YXRegularfont(11);
        zitiAddressLable.numberOfLines = 0;
        [zitideatilBackBigview addSubview:zitiAddressLable];
        zitiAddressLable.text = [NSString stringWithFormat:@"自提地址：%@",[YXUserDefaults objectForKey:@"consigneeAddress"]] ;
        [zitiAddressLable setRowSpace:5];
        
        phoneLable = [[UILabel alloc]init];
        phoneLable.textColor=textColor;
        phoneLable.font = YXRegularfont(11);
        [zitideatilBackBigview addSubview:phoneLable];
        phoneLable.text = [NSString stringWithFormat:@"贵宾专线：%@",[YXLoadZitiData objectZiTiWithforKey:@"consigneePhone"] ];
        
        timeLable = [[UILabel alloc]init];
        timeLable.textColor=textColor;
        timeLable.font = YXRegularfont(11);
        [zitideatilBackBigview addSubview:timeLable];
        timeLable .text = [NSString stringWithFormat:@"营业时间：%@",[YXLoadZitiData objectZiTiWithforKey:@"businessTime"]];
        
        line = [[UIView alloc]init];
        line.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [zitideatilBackBigview addSubview:line];
        
        
        [self addSubview:self.WuliuNoAddressView];
        self.WuliuNoAddressView.descstr = @"您还没有提货人信息，点击这里添加";
        
        
        
        zitiInformationBackview = [[UIView alloc]init];
        [self addSubview:zitiInformationBackview];
        
        zitiInforTitle = [[UILabel alloc]init];
        zitiInforTitle.text = @"自提联系人信息";
        zitiInforTitle.textColor = UIColorFromRGB(0x251011);
        zitiInforTitle.font = YXRegularfont(11);
        [zitiInformationBackview addSubview:zitiInforTitle];
        
        nameandphoneLable = [[UILabel alloc]init];
        nameandphoneLable.text = @"王鹏  1452454242";
        nameandphoneLable.textColor = UIColorFromRGB(0x251011);
        nameandphoneLable.font = YXRegularfont(11);
        [zitiInformationBackview addSubview:nameandphoneLable];
        
        idcardLable = [[UILabel alloc]init];
        idcardLable.text = @"5456464242424646";
        idcardLable.textColor = UIColorFromRGB(0x251011);
        idcardLable.font = YXRegularfont(11);
        [zitiInformationBackview addSubview:idcardLable];
        
        jiantouiamge = [[UIImageView alloc]init];
        jiantouiamge.image = [UIImage imageNamed:@"shangpingdeatiljaintou"];
        [zitiInformationBackview addSubview:jiantouiamge];
        
        
        UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickchooseinformationview)];
        [zitiInformationBackview addGestureRecognizer:tap];
        
        //**选择提货人信息后 回传数据**/
        [YXNotificationTool addObserver:self selector:@selector(choolsetihuorenData:) name:@"choolsetihuorenData" object:nil];
        
        
    }
    return self;
}

//**选择提货人信息后  回传数据**/
-(void)choolsetihuorenData:(NSNotification *)noti
{
    _WuliuNoAddressView.hidden = YES;
    zitiInformationBackview.hidden = NO;
    isHaveInform = YES;
    NSString *namestr  = noti.userInfo[@"name"];
    NSString *phonestr = noti.userInfo[@"mobile"];
    NSString *idcardstr = noti.userInfo[@"idcard"];
    NSString *ishaveData = noti.userInfo[@"IsHaveData"];
    nameandphoneLable.text = [NSString stringWithFormat:@"%@  %@",namestr,phonestr];
    idcardLable.text = idcardstr;
    // 没有数据还是显示 没有数据的view
    if ([ishaveData isEqualToString:@"0"]) {
        isHaveInform = NO;
        zitiInformationBackview.hidden = YES;
        _WuliuNoAddressView.hidden = NO;
        
    }
    
    [self layoutSubviews];

}


/*
 @brief 有提货人信息的时候  去信息列表选择提货人信息的方法
 */
-(void)clickchooseinformationview
{
    YXLog(@"++ 去信息列表选择提货人信息的方法+++");

    [YXNotificationTool postNotificationName:@"choosezitipersoninfomation" object:nil];
    
}

/*
 @brief 点击完善自提信息
 */
-(void)clicktianxieZiTiInformation
{
    
    [YXNotificationTool postNotificationName:@"wanshanZitiInformatioN" object:nil];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    zitideatilBackBigview.frame = CGRectMake(0, margin/2, YXScreenW, 100);
    CGFloat addreessH = [zitiAddressLable heightWithWidth:YXScreenW-20];
    if (addreessH<=20) {
        addreessH = 20;
    }
    zitiAddressLable.frame = CGRectMake(margin, 8, YXScreenW-20, addreessH);
    phoneLable.frame = CGRectMake(margin, zitiAddressLable.bottom+10, YXScreenW-20, 20);
    timeLable.frame = CGRectMake(margin, phoneLable.bottom+10, YXScreenW-20, 20);
    line.frame = CGRectMake(0, timeLable.bottom+5, YXScreenW, 0.5);
    
    if (isHaveInform) {
        
        zitiInformationBackview.frame = CGRectMake(0, line.bottom+5, YXScreenW, 120);
        zitiInforTitle.frame = CGRectMake(margin, 10, YXScreenW-20, 20);
        nameandphoneLable.frame = CGRectMake(margin, zitiInforTitle.bottom+margin, YXScreenW-20, 20);
        idcardLable.frame =CGRectMake(margin, nameandphoneLable.bottom+margin, YXScreenW-20, 20);
        jiantouiamge.size  =CGSizeMake(6, 11);
        jiantouiamge.x = YXScreenW-10-6 ;
        jiantouiamge.y = (zitiInformationBackview.height-jiantouiamge.height)/2;
        
        
    }else{
    
        self.WuliuNoAddressView.frame = CGRectMake(0, zitideatilBackBigview.bottom, YXScreenW, 100);
    }

    
    
    
    
}
@end
