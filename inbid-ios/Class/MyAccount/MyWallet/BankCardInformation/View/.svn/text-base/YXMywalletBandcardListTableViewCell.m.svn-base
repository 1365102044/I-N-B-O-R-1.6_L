//
//  YXMywalletBandcardListTableViewCell.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMywalletBandcardListTableViewCell.h"

@interface YXMywalletBandcardListTableViewCell ()
{
    UIImageView *iconimageview;
    UILabel *titlelable;
    UILabel *deslable;
    UIView *_myBgView;
}
@end

@implementation YXMywalletBandcardListTableViewCell

-(void)setListModle:(YXBankCardDetailInformationModel *)listModle{

    titlelable.text = listModle.bank_name;
    deslable.text = [NSString stringWithFormat:@"尾号%@%@",listModle.card_no,listModle.card_type];
    [iconimageview sd_setImageWithURL:[NSURL URLWithString:listModle.logoImageUrlString] placeholderImage:[UIImage imageNamed:@"银联"] options:SDWebImageRetryFailed];
    
    if ([listModle.card_type isEqualToString:@"储蓄卡"]) {
        
        /**
         *  储蓄卡
         */
        _myBgView.backgroundColor = [UIColor whiteColor];
    }else if ([listModle.card_type isEqualToString:@"信用卡"]) {
        
        /**
         *  信用卡
         */
        _myBgView.backgroundColor = [UIColor walletBankCardDisableColor];
    }else{
        
        /**
         *  其他卡
         */
        _myBgView.backgroundColor = [UIColor whiteColor];
    }
}

-(void)setNamestr:(NSString *)namestr{
    titlelable.text  =namestr;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
        [self addSubview:iconimageview];
//        iconimageview.backgroundColor = [UIColor redColor];
        
        
        titlelable = [[UILabel alloc]initWithFrame:CGRectMake(iconimageview.right+10, iconimageview.y, YXScreenW-iconimageview.right-20, 20)];
//        titlelable.text = @"teest";
        titlelable.textColor = UIColorFromRGB(0x333333);
        titlelable.font = YXSFont(16);
        [self addSubview:titlelable];
        
        
        deslable = [[UILabel alloc]initWithFrame:CGRectMake(titlelable.x , titlelable.bottom, titlelable.width, 20)];
//        deslable.text = @"teest";
        deslable.textColor = UIColorFromRGB(0x999999);
        deslable.font = YXSFont(13);
        [self addSubview:deslable];
        
        _myBgView = [UIView new];
        _myBgView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = _myBgView;
    }

    return self;
}




@end
