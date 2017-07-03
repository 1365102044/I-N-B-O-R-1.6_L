//
//  YXMyWalletMainHeaderView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletMainHeaderView.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface YXMyWalletMainHeaderView ()
{
    UIImageView *backimage;
    UIImageView *iconimageview;
    UIButton *setbtn;
    UILabel *namelable;
    UILabel *desclable;
}
@end

@implementation YXMyWalletMainHeaderView


-(void)setDataModel:(YXMyWalletAccountInformModle *)dataModel{
    _dataModel = dataModel;
    NSString *headerstr = [YXUserDefaults objectForKey:@"head"];
    NSString *str  = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [[YXUserDefaults objectForKey:@"head"] componentsSeparatedByString:@"?"].firstObject];
    [iconimageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ic_default"]];
    if (headerstr.length==0) {
        iconimageview.image = [UIImage imageNamed:@"ic_default"];
    }
    
    [setbtn setTitle:dataModel.name_user forState:UIControlStateNormal];
    namelable.text = dataModel.mob_bind;
    
    if ([dataModel.kyc_status containsString:@" "]) {
        
        NSMutableAttributedString* des = [[NSMutableAttributedString alloc] initWithString:dataModel.kyc_status];
        [des addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 2)];
        [des addAttribute:NSForegroundColorAttributeName value:YXColor(51, 143, 240) range:NSMakeRange(2, des.length-2)];
        desclable.attributedText = des;
    }else{
        //实名认证中 ， 认证成功， 认证失败，
        NSString *des;
        if ([dataModel.kyc_status isEqualToString:@"3"]) {
            des =  @"实名认证中";
        }else if ([dataModel.kyc_status isEqualToString:@"4"]){
            des =  @"实名认证成功";
        }else if ([dataModel.kyc_status isEqualToString:@"5"] || [dataModel.kyc_status isEqualToString:@"1"]){
            des =  @"实名认证失败";
        }
        desclable.text = des;
        desclable.textColor = YXColor(51, 143, 240);
    }
}

-(void)clickDescLableTap:(UITapGestureRecognizer *)tap
{
    if (self.clickDescLableblock) {
        self.clickDescLableblock([_dataModel.kyc_status integerValue]);
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        backimage = [[UIImageView alloc]init];
        backimage.image = [UIImage imageNamed:@"icon_mywalletBackImage"];
        [self addSubview:backimage];
        
        iconimageview = [[UIImageView alloc]init];
//        iconimageview.image = [UIImage imageNamed:@"ic_default"];
        iconimageview.layer.cornerRadius = 37.5;
        iconimageview.layer.masksToBounds = YES;
        [self addSubview:iconimageview];
        
        
        setbtn = [[UIButton alloc]init];
        [setbtn setTitle:@"" forState:UIControlStateNormal];
        [setbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        setbtn.titleLabel.font = YXSFont(15);
        setbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:setbtn];
        
        namelable = [[UILabel alloc]init];
        namelable.textColor = [UIColor whiteColor];
        namelable.font= YXSFont(15);
        [self addSubview:namelable];
        
        desclable = [[UILabel alloc]init];
        desclable.textColor = [UIColor whiteColor];
        desclable.font= YXSFont(15);
        desclable.userInteractionEnabled = YES;
        [self addSubview:desclable];
        
        UITapGestureRecognizer *clickdesc = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDescLableTap:)];
        [desclable addGestureRecognizer:clickdesc];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    backimage.frame = self.bounds;
    iconimageview.frame = CGRectMake(35, 55, 75, 75);
    setbtn.frame = CGRectMake(iconimageview.right+20, iconimageview.y, YXScreenW-iconimageview.right-30, 30);
    namelable.frame = CGRectMake(setbtn.x, setbtn.bottom+5, setbtn.width, 20);
    desclable.frame = CGRectMake(setbtn.x, namelable.bottom+5, setbtn.width, 20);
}
@end
