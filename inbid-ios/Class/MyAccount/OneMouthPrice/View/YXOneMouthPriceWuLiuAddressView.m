//
//  YXOneMouthPriceWuLiuAddressView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceWuLiuAddressView.h"
#import "UILabel+Extension.h"

@interface YXOneMouthPriceWuLiuAddressView ()

{

    
    
    UILabel *xinxititleLable;
    UILabel *nameLable;
    UILabel *shouhuoaddressLable;
    UIImageView*addressjiantouimageview;
    
    
    
    UILabel *IdcardtitleLable;
//    UILabel *idcardContentLable;
    UIImageView *idcardimageview;
    
    
    UIView *line ;
    UILabel *idcarddescLable;
    
}

@end

@implementation YXOneMouthPriceWuLiuAddressView


-(void)setOneMouthPriceConfirmModel:(YXOneMouthPriceConfirmOrderModle *)OneMouthPriceConfirmModel
{
    _OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
    
//    NSString*phonestr = [YXStringFilterTool replaceStringWithAsterisk:OneMouthPriceConfirmModel.consigneeMobile startLocation:3 lenght:4];
    nameLable.text = [NSString stringWithFormat:@"%@   %@",OneMouthPriceConfirmModel.consigneeName,OneMouthPriceConfirmModel.consigneeMobile];
    
    shouhuoaddressLable.text = [NSString stringWithFormat:@"收货地址：%@%@%@",OneMouthPriceConfirmModel.consigneeProvince,OneMouthPriceConfirmModel.consigneeCity,OneMouthPriceConfirmModel.consigneeAddressDetail];
    
    if (OneMouthPriceConfirmModel.consigneeIdcard) {
    
        _idcardContentLable.text = OneMouthPriceConfirmModel.consigneeIdcard;
        idcardimageview.hidden = YES;
        idcarddescLable.hidden = YES;
    }
    
    [YXNotificationTool postNotificationName:@"ISCLICKIDCARDVIEW" object:nil userInfo:@{@"consigneeIdcard":OneMouthPriceConfirmModel.consigneeIdcard}];
    
    [self layoutSubviews];
    
}

/*
 @brief 从地址列表选择的地址数据
 */

-(void)setChooseaddressmodle:(YXMyAddressList *)chooseaddressmodle
{
    _chooseaddressmodle = chooseaddressmodle;
    
    nameLable.text = [NSString stringWithFormat:@"%@   %@",chooseaddressmodle.consigneeName,chooseaddressmodle.consigneeMobile];
    
    shouhuoaddressLable.text = [NSString stringWithFormat:@"收货地址：%@%@%@",chooseaddressmodle.consigneeProvince,chooseaddressmodle.consigneeCity,chooseaddressmodle.consigneeAddressDetail];
    
    self.OneMouthPriceConfirmModel.consigneeIdcard = chooseaddressmodle.consigneeIdcard;
    
    if (chooseaddressmodle.consigneeIdcard) {
        
        _idcardContentLable.text = chooseaddressmodle.consigneeIdcard;
        idcardimageview.hidden = YES;
        idcarddescLable.hidden = YES;
         [self layoutSubviews];
    
    }else{
        
        idcardimageview.hidden = NO;
        idcarddescLable.hidden = NO;
        _idcardContentLable.text = @"请填写收货人证件号码";
         [self layoutSubviews];
    }
    
    [YXNotificationTool postNotificationName:@"ISCLICKIDCARDVIEW" object:nil userInfo:@{@"consigneeIdcard":self.OneMouthPriceConfirmModel.consigneeIdcard}];
    
   
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        _addressBavkview = [[UIView alloc]init];
        [self addSubview:_addressBavkview];
        
        xinxititleLable = [self setlable:@"收货人信息"];
        xinxititleLable.font = YXSFont(13);
        xinxititleLable.textColor = UIColorFromRGB(0x050505);
        
        nameLable = [self setlable:@""];
        shouhuoaddressLable = [self setlable:@""];
        shouhuoaddressLable.numberOfLines = 4;
        [_addressBavkview addSubview:xinxititleLable];
        [_addressBavkview addSubview:nameLable];
        [_addressBavkview addSubview:shouhuoaddressLable];
        
        addressjiantouimageview = [[UIImageView alloc]init];
        addressjiantouimageview.image = [UIImage imageNamed:@"shangpingdeatiljaintou"];
        [_addressBavkview addSubview:addressjiantouimageview];
        
        _idcardbackview = [[UIView alloc]init];
        _idcardbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _idcardbackview.layer.borderWidth = 0.5;
        [self addSubview:_idcardbackview];
        
        IdcardtitleLable = [[UILabel alloc]init];
        IdcardtitleLable.textColor = UIColorFromRGB(0x050505);
        IdcardtitleLable.font = YXSFont(13);
        IdcardtitleLable.text = @"身份证号";
        [_idcardbackview addSubview:IdcardtitleLable];
        
        _idcardContentLable = [[UILabel alloc]init];
        _idcardContentLable.textColor = UIColorFromRGB(0x939393);
        _idcardContentLable.font = YXRegularfont(13);
        _idcardContentLable.text = @"请填写收货人证件号码";
        [_idcardbackview addSubview:_idcardContentLable];
        _idcardContentLable.textAlignment = NSTextAlignmentRight;
        
        idcardimageview = [[UIImageView alloc]init];
        idcardimageview.image = [UIImage imageNamed:@"shangpingdeatiljaintou"];
        [_idcardbackview addSubview:idcardimageview];
        
        idcarddescLable = [[UILabel alloc]init];
        idcarddescLable.textColor= UIColorFromRGB(0xa90311);
        idcarddescLable.text = @"为保证您的交易安全，请填写收货人的证件号码，用于物流派送时快递员验证收货人身份。如不填写有效证件号码，导致您的物品丢失，责任需买家自行承担。";
        idcarddescLable.font = YXRegularfont(9);
        idcarddescLable.numberOfLines = 0;
        [idcarddescLable setRowSpace:5];
        [self addSubview:idcarddescLable];
     
        
        /*
         @brief 设置完身份证后改变布局
         */
        [YXNotificationTool addObserver:self selector:@selector(IDCardInformation:) name:@"shezhiSUCCESSIDCard" object:nil];
        
    }
    return  self;
}
-(void)IDCardInformation:(NSNotification*)noti
{
    
    NSString *idcardstr = noti.userInfo[@"IDCADRDS"];
    self.OneMouthPriceConfirmModel.consigneeIdcard = idcardstr;
    _idcardContentLable.text = [YXStringFilterTool replaceStringWithAsterisk:idcardstr startLocation:1 lenght:idcardstr.length-2];
    idcardimageview.hidden = YES;
    idcarddescLable.hidden = YES;
    
    [self layoutSubviews];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    CGFloat leftmargin = 20;
    
    _addressBavkview.frame= CGRectMake(0, 0, YXScreenW, 100);
    
    xinxititleLable.frame = CGRectMake(margin, margin, YXScreenW-20, 20);
    nameLable.frame = CGRectMake(leftmargin, xinxititleLable.bottom+margin, YXScreenW-20, 20);
    CGFloat addressH = [shouhuoaddressLable heightWithWidth:YXScreenW-40];
    if (addressH<=20) {
        addressH =20;
    }
    shouhuoaddressLable.frame = CGRectMake(leftmargin, nameLable.bottom+margin, YXScreenW-40, addressH);
    
    addressjiantouimageview.size = CGSizeMake(6, 11);
    addressjiantouimageview.y = (shouhuoaddressLable.bottom-11)/2;
    addressjiantouimageview.x = YXScreenW-6-10;
    
    _addressBavkview.height = shouhuoaddressLable.bottom;
    
    
    _idcardbackview.frame = CGRectMake(0, shouhuoaddressLable.bottom+10, YXScreenW, 40);
    IdcardtitleLable.frame = CGRectMake(margin, 5, 120, 30);
    idcardimageview.frame = CGRectMake(YXScreenW-10-6, (_idcardbackview.height-11)/2, 6, 11);
    if (idcardimageview.hidden) {
        
        _idcardContentLable.frame = CGRectMake(YXScreenW-10-150, 5, 150, 30);
        
    }else{
        _idcardContentLable.frame = CGRectMake(YXScreenW-idcardimageview.width-10-6-150, 5, 150, 30);
    }
    
    if (self.OneMouthPriceConfirmModel.consigneeIdcard) {

        if (self.heightblcok) {
            
            
            self.heightblcok(_idcardbackview.bottom);
        }
        
    }else{
    
        idcarddescLable.frame = CGRectMake(margin, _idcardbackview.bottom, YXScreenW-20, 65);
        if (self.heightblcok) {
            
             
            self.heightblcok(idcarddescLable.bottom);
        }
    }
    
    
    
}

-(UILabel*)setlable:(NSString *)textstr
{
    UILabel *label = [[UILabel alloc]init];
    label.text = textstr;
    label.font = YXSFont(11);
    label.textColor = UIColorFromRGB(0x939393);
    return label;
}
@end
