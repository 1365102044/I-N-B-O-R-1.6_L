//
//  YXHomeAuctionDeatilTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilTableViewCell.h"
#import "YXHomeDeatilBidRecordVosListModle.h"


@interface YXHomeAuctionDeatilTableViewCell ()

{

    UIImageView *iconImageview;
    UILabel *maxPriceLable;
    UILabel *addPriceLable;
    UILabel *cureenPriceLable;
    UILabel *nameLable;
    UILabel *timeLable;

    NSMutableArray *imageArr;
    
}

@end

@implementation YXHomeAuctionDeatilTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = [NSString stringWithFormat:@"HomeDeatiladdPriceList%ld",(long)[indexPath row]];
    YXHomeAuctionDeatilTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[YXHomeAuctionDeatilTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID indexpath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSIndexPath *)indexpath
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        iconImageview = [[UIImageView alloc]init];
//        iconImageview.image = [UIImage imageNamed:@"watch_1"];
        iconImageview.layer.masksToBounds = YES;
        iconImageview.layer.cornerRadius = 15;
        
        
        if (indexpath.row==0) {
            maxPriceLable = [self addLable:@"领先"];
        }else{
            maxPriceLable = [self addLable:@"出局"];
        }
        
        maxPriceLable.textColor = [UIColor mainThemColor];
        addPriceLable = [self addLable:@"加价¥"];
        addPriceLable.backgroundColor = [UIColor clearColor];
        addPriceLable.textAlignment = NSTextAlignmentCenter;

        cureenPriceLable = [self addLable:@"当前价¥"];
        cureenPriceLable.backgroundColor = [UIColor clearColor];
        cureenPriceLable.textAlignment = NSTextAlignmentRight;
        cureenPriceLable.textColor = [UIColor mainThemColor];
        
        
        nameLable = [self addLable:@"喜洋洋"];
//        nameLable.textAlignment = NSTextAlignmentRight;
        
        timeLable = [self addLable:@"2016年9月2号 14:00"];
        timeLable.textAlignment = NSTextAlignmentRight;
        timeLable.textColor = UIColorFromRGB(0x696969);
        timeLable.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:iconImageview];
        [self.contentView addSubview:maxPriceLable];
        [self.contentView addSubview:addPriceLable];
        [self.contentView addSubview:cureenPriceLable];
        [self.contentView addSubview:nameLable];
        [self.contentView addSubview:timeLable];
    }
    return self;
}

-(void)setModle:(YXHomeDeatilBidRecordVosListModle *)modle
{
    _modle = modle;
    

    nameLable.text = modle.nickName;
    NSString *headimagestr = [NSString stringWithFormat:@"ic_%@",modle.head];
    iconImageview.image = [UIImage imageNamed:headimagestr];
    
    
     NSString  *addprice = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",[modle.addPrice longLongValue]/100] ];
    addPriceLable.text = [NSString stringWithFormat:@"加价¥%@",addprice];
    
    
     NSString  *currenprice = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",[modle.price longLongValue]/100] ];
    cureenPriceLable.text = [NSString stringWithFormat:@"¥%@",currenprice];
    NSArray *arr = [modle.createTime componentsSeparatedByString:@"."];
    timeLable.text = arr[0];

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    iconImageview.frame = CGRectMake(30, 10, 30, 30);
    maxPriceLable.frame = CGRectMake(iconImageview.right+20, 10, 30, 30);
    
    cureenPriceLable.frame = CGRectMake(YXScreenW-210, 10, 200, 30);
    
    nameLable.frame =CGRectMake(20, iconImageview.bottom+5, YXScreenW-40-140, 20);
    
    timeLable.frame = CGRectMake(YXScreenW-150, iconImageview.bottom+5, 140, 20);
    
    
    
//    [iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(30);
//        make.top.equalTo(self).offset(10);
//        make.width.mas_offset(30);
//        make.height.mas_offset(30);
//    }];
//    
//    [maxPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(iconImageview.mas_right).offset(20);
//        make.centerY.equalTo(iconImageview.mas_centerY);
//        make.width.mas_offset(30);
//        make.height.mas_offset(30);
//    }];
//    
//    
//    [addPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(maxPriceLable.mas_right).offset(10);
//        make.centerY.equalTo(iconImageview.mas_centerY);
//        make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
//        make.height.mas_offset(30);
//    }];
//    
//
//    
//    [cureenPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.centerY.equalTo(iconImageview.mas_centerY);
//        make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
//        make.height.mas_offset(30);
//    }];
//    
//    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(20);
//        make.top.equalTo(iconImageview.mas_bottom).offset(5);
//        make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
//        make.height.mas_offset(20);
//    }];
//
//    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.centerY.equalTo(nameLable.mas_centerY);
//        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
//        make.height.mas_offset(20);
//    }];
    
    
}










-(UILabel *)addLable:(NSString *)textStr
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = textStr;
    lable.textColor = YXHomeDeatilcolor;
    lable.font = YXRegularfont(13);
    return lable;
}
@end
