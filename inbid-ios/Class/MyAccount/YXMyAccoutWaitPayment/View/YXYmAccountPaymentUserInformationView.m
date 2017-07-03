//
//  YXYmAccountPaymentUserInformationView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXYmAccountPaymentUserInformationView.h"
#import "NSString+File.h"

@interface YXYmAccountPaymentUserInformationView ()

{
    UILabel *nameLable;
    
    /*
     @brief 没有地址的view
     */
    UIView*NoHaveAddressView;
    UILabel*addresslable;
    UIButton*addBtn;
    
    /*
     @brief 已经有地址view
     */
    UIView *HaveAddressView;
    UILabel *usernameLable;
    UILabel *phoneLablel;
    UILabel*addressTitleLable;
    UILabel*addressContentLable;
    
    UIImageView *rightimageview;
    
    UILabel*shouldPayCountLable;
    
    NSInteger addressSatatus;
    
    NSString * tagstr;
}

@end

@implementation YXYmAccountPaymentUserInformationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        NoHaveAddressView = [[UIView alloc]init];
        addBtn = [[UIButton alloc]init];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(ClickAddBtn) forControlEvents:UIControlEventTouchUpInside];
        addBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
        addBtn.layer.borderWidth = 0.5;
        [addBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        addBtn.titleLabel.font = YXRegularfont(12);
        addresslable = [self setLable:@"您没有默认收货地址，您可以点击" textcolor:UIColorFromRGB(0xaaa7a7) font:10];
        
        
        HaveAddressView = [[UIView alloc]init];
        nameLable = [self setLable:@"活动卡活动课安徽的卡上" textcolor:UIColorFromRGB(0x050505) font:13];
        usernameLable = [self setLable:@"联系人：因宝宝" textcolor:UIColorFromRGB(0xaaa7a7) font:10];
        phoneLablel = [self setLable:@"" textcolor:UIColorFromRGB(0xaaa7a7) font:10];
        addressTitleLable = [self setLable:@"收货地址:" textcolor:UIColorFromRGB(0xaaa7a7) font:10];
        addressContentLable = [self setLable:@"北京市朝阳区望京东路8号锐创国际A座20层" textcolor:UIColorFromRGB(0xaaa7a7) font:10];
        shouldPayCountLable = [self setLable:@"应付金额：￥133455" textcolor:[UIColor mainThemColor] font:10];
        
        NSString *phonestr = @"联系电话：1234567894";
        NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:phonestr];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x66ade9) range:NSMakeRange(5, currenattrStr.length-5)];
        phoneLablel.attributedText = currenattrStr;

        
        rightimageview = [[UIImageView alloc]init];
        rightimageview.image = [UIImage imageNamed:@"guize"];
        
        
        [self addSubview:nameLable];
        
        [self addSubview:NoHaveAddressView];
        [NoHaveAddressView addSubview:addresslable];
        [NoHaveAddressView addSubview:addBtn];
        
        
        [self addSubview:HaveAddressView];
        [HaveAddressView addSubview:usernameLable];
        [HaveAddressView addSubview:phoneLablel];
        [HaveAddressView addSubview:addressTitleLable];
        [HaveAddressView addSubview:addressContentLable];
        [HaveAddressView addSubview:rightimageview];
        [self addSubview:shouldPayCountLable];
        
        
        rightimageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickrightimageview)];
        [HaveAddressView addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Noti:) name:@"develyType" object:nil];
        addressSatatus = 1;
        
    }
    return self;
}

-(void)Noti:(NSNotification *)noti
{

    tagstr =  noti.userInfo[@"tag"];
    
    if ([tagstr isEqualToString:@"100"]) {
        
        NSArray *arr = self.dict[@"addressList"];
        
        NSDictionary *addressDic = arr[0];
        
        if (self.dict[@"addressList"] == nil) {
            addressSatatus = 2;
            HaveAddressView.hidden = YES;
            NoHaveAddressView.hidden = NO;
            
        }else{
            
            addressSatatus = 1;
            HaveAddressView.hidden = NO;
            NoHaveAddressView.hidden = YES;
            
            usernameLable.text = [NSString stringWithFormat:@"联系人：%@",addressDic[@"consigneeName"]];
            
            NSString * phonstr =  [NSString stringWithFormat:@"联系电话：%@",addressDic[@"consigneeMobile"]];
            phoneLablel.text = [YXStringFilterTool replaceStringWithAsterisk:phonstr startLocation:6 lenght:4];

            
            addressContentLable.text = [NSString stringWithFormat:@"%@%@%@",addressDic[@"consigneeProvince"],addressDic[@"consigneeCity"],addressDic[@"consigneeAddressDetail"]];
            
            rightimageview.hidden = NO;
        }
      

    }else if([tagstr isEqualToString:@"200"])
    {
        usernameLable.text = [NSString stringWithFormat:@"联系人：%@",self.addressDict[@"consigneeName"]];
        addressContentLable.text = [NSString stringWithFormat:@"%@",self.addressDict[@"consigneeAdress"]];
        
        rightimageview.hidden = YES;
        NSString *phonestr = [NSString stringWithFormat:@"联系电话：%@",self.addressDict[@"consigneePhone"]];
        
        NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:phonestr];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x66ade9) range:NSMakeRange(5, currenattrStr.length-5)];
        phoneLablel.attributedText = currenattrStr;
        
    }
      [self layoutSubviews];
}

-(void)clickrightimageview
{
    if ([tagstr isEqualToString:@"200"]) {
        return;
    }
    if(self.addAdressblock)
    {
        self.addAdressblock();
    }
    
}

-(void)setIsPartPay:(NSInteger)isPartPay
{
//    _isPartPay = isPartPay;
//    
//    if(isPartPay == 1)
//    {
//       NoHaveAddressView.hidden = YES;
//        
//    }else if (isPartPay == 2)
//    {
//        HaveAddressView.hidden = YES;
//        
//    }
//    [self layoutSubviews];
    
}


-(void)setDict:(NSDictionary *)dict{

    _dict = dict;
    
      NSString  *shouldpay = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[dict[@"payAmount"] integerValue]/100] ];
    
    shouldPayCountLable.text = [NSString stringWithFormat:@"应付金额：￥%@",shouldpay];
    
    
    NSArray *arr = dict[@"addressList"];
    NSDictionary *addressDic = arr[0];
    
    if (dict[@"addressList"] == nil) {
        addressSatatus = 2;
        HaveAddressView.hidden = YES;
        NoHaveAddressView.hidden = NO;
    }else{
        addressSatatus = 1;
        HaveAddressView.hidden = NO;
        NoHaveAddressView.hidden = YES;

        usernameLable.text = [NSString stringWithFormat:@"联系人：%@",addressDic[@"consigneeName"]];
        NSString * phonstr =  [NSString stringWithFormat:@"联系电话：%@",addressDic[@"consigneeMobile"]];
        phoneLablel.text = [YXStringFilterTool replaceStringWithAsterisk:phonstr startLocation:9 lenght:4];
        
        addressContentLable.text = [NSString stringWithFormat:@"%@%@%@",addressDic[@"consigneeProvince"],addressDic[@"consigneeCity"],addressDic[@"consigneeAddressDetail"]];
        
        
    }
    [self layoutSubviews];
    
}



-(void)setProname:(NSString *)proname
{
    _proname = proname;
    nameLable.text = proname;
}
/*
 @brief 添加地址
 */
-(void)ClickAddBtn
{
    if(self.addAdressblock)
    {
        self.addAdressblock();
    }
}

-(UILabel *)setLable:(NSString*)textstr textcolor:(UIColor*)color font:(NSInteger)font
{
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = color;
    lable.font = YXRegularfont(font);
    lable.text = textstr;
    return lable;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    CGFloat phonelableW = [phoneLablel.text widthWithFont:YXRegularfont(10)];
    CGFloat usernameW = [usernameLable.text widthWithFont:YXRegularfont(10)];
    
    
    if (usernameW>YXScreenW-35-phonelableW) {
        usernameW = YXScreenW-35-phonelableW;
    }
    
    nameLable.frame = CGRectMake(margin, 5, YXScreenW, 20);
    
    if(addressSatatus == 1)
    {
        usernameLable.frame = CGRectMake(margin, 5, usernameW, 15);
        phoneLablel.frame = CGRectMake(usernameLable.right+10, usernameLable.y, phonelableW, usernameLable.height);
        
        addressTitleLable.frame = CGRectMake(margin, usernameLable.bottom+5, 45, 15);
        
        CGFloat addresscontentW= [addressContentLable.text widthWithFont:YXRegularfont(10)];
        CGFloat addresscontentH ;
        if (addresscontentW<YXScreenW-20-addressTitleLable.width) {
            addresscontentH = 15;
        }else{
            addresscontentH = [addressTitleLable.text heightWithFont:YXRegularfont(10) withinWidth:YXScreenW-addressTitleLable.width-20-15];
        }
        
        addressContentLable.frame = CGRectMake(addressTitleLable.right, addressTitleLable.y, YXScreenW-addressTitleLable.width-20, addresscontentH);
        
        HaveAddressView.frame  = CGRectMake(0, nameLable.bottom, YXScreenW, 25+addresscontentH);
        rightimageview.size = CGSizeMake(7, 12);
        rightimageview.y = (HaveAddressView.height-12)/2;
        rightimageview.x = YXScreenW-15;

        
        shouldPayCountLable.frame = CGRectMake(margin, HaveAddressView.bottom+8, YXScreenW-20, 15);
    
    }else if(addressSatatus == 2)
    {
        NoHaveAddressView.frame =CGRectMake(0, nameLable.bottom, YXScreenW, 40);
        addresslable.frame = CGRectMake(10, 10, 160, 20);
        addBtn.frame = CGRectMake(addresslable.right, addresslable.y, 40, 20);
        shouldPayCountLable.frame = CGRectMake(margin, NoHaveAddressView.bottom+8, YXScreenW-20, 15);

    }

    if (self.uerinformationheightblock) {
        self.uerinformationheightblock(shouldPayCountLable.bottom+10);
    }
    
    
    
}
@end
