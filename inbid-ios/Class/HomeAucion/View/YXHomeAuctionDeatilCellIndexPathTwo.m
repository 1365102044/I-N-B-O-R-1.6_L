//
//  YXHomeAuctionDeatilCellIndexPathTwo.m
//  inbid-ios
//
//  Created by 1 on 16/9/3.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilCellIndexPathTwo.h"
/*
 起拍价    保证金
 最小加价   延长周期
 鉴定级别
 起拍时间
 
 */

#define  kMagin 15

@interface YXHomeAuctionDeatilCellIndexPathTwo ()
{
    UIButton * auctionInformationBtn;
    
    UILabel * starPriceLable;
    UILabel * ensurelMoneyLable;
    UILabel * minAddPriceLable;
    UILabel * addTimeLable;
    UILabel * levelLable;
    UILabel * auctionStarTimeLable;
    
    UILabel *endtimeLable;
    
    
    UILabel *toWhereLable;
    UILabel *timeLable;
    
}

@end

@implementation YXHomeAuctionDeatilCellIndexPathTwo

-(instancetype)initWithFrame:(CGRect)frame
{
    if( self= [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        auctionInformationBtn = [[UIButton alloc]init];
        [auctionInformationBtn setTitle:@"竞拍信息" forState:UIControlStateNormal];
        [auctionInformationBtn setTitleColor:YXHomeDeatilcolor forState:UIControlStateNormal];
        auctionInformationBtn.titleLabel.font = YXRegularfont(13);
        [auctionInformationBtn setImage:[UIImage imageNamed:@"icon_xinxi"] forState:UIControlStateNormal];
        auctionInformationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -59, 0, 0);
        auctionInformationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        [self addSubview:auctionInformationBtn];
        
        
        starPriceLable = [self addLable:@"起拍价：¥6000"];
        ensurelMoneyLable = [self addLable:@"保证金：¥3000"];
        minAddPriceLable = [self addLable:@"最小加价：¥300"];
        addTimeLable = [self addLable:@"延时周期：5分钟／次"];
        levelLable = [self addLable:@"鉴定级别：A级"];
        auctionStarTimeLable = [self addLable:@"起拍时间：2016年9月3日 10:54"];
        
        endtimeLable = [self addLable:@"结束时间：2016年9月3日 10:54"];
        
        toWhereLable = [self addLable:@"送货区域: 北上广深"];
        timeLable = [self addLable:@"发货时间: 付款后72小时内"];
        
        
    }
    
    return self;
}

-(void)setModle:(YXHomeDeatilModle *)modle
{
    _modle = modle;


    NSString *startpricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",modle.startPrice /100]];
    starPriceLable.text = [NSString stringWithFormat:@"· 起拍价：¥%@",startpricestr];
    

    NSString *ensurepricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",modle.marginPrice /100]];
    ensurelMoneyLable.text = [NSString stringWithFormat:@"· 保证金：¥%@",ensurepricestr];
    

     NSString *minaddpricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",modle.minAddPrice /100]];
    minAddPriceLable.text = [NSString stringWithFormat:@"· 最小加价：¥%@",minaddpricestr];
    
    addTimeLable.text = [NSString stringWithFormat:@"· 延时周期：%@",modle.extendCron];
    
    levelLable.text  = [NSString stringWithFormat:@"· 鉴定级别：%@",modle.identifyLevel];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([modle.startTime doubleValue] / 1000.0)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *strtime = [formatter stringFromDate:date];
    auctionStarTimeLable.text = [NSString stringWithFormat:@"· 起拍时间：%@",strtime];
    
    NSDate *endtimedate = [NSDate dateWithTimeIntervalSince1970:[modle.endTime longLongValue]/1000];
    NSString *time = [formatter stringFromDate:endtimedate];
    endtimeLable.text  = [NSString stringWithFormat:@"· 结束时间：%@",time];

    
    toWhereLable.text = [NSString stringWithFormat:@"· 送货区域: %@",modle.deliverArea];
    timeLable.text = [NSString stringWithFormat:@"· 发货时间: %@",modle.deliverTime];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemHeight = 30;
    
    [auctionInformationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(5);
        make.width.mas_offset(120);
        make.height.mas_offset(30);
        
    }];
    
    //** -------- -----------**/
    [starPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(auctionInformationBtn.mas_bottom).with.offset(8);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_offset(itemHeight);
        
    }];
    
    [ensurelMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(YXScreenW/2);
        make.centerY.mas_equalTo(starPriceLable.mas_centerY);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_offset(itemHeight);
        
    }];
    
    
    [minAddPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(starPriceLable.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_offset(itemHeight);
        
    }];
    
    [addTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(YXScreenW/2);
        make.centerY.mas_equalTo(minAddPriceLable.mas_centerY);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_offset(itemHeight);
        
    }];
    
    
    
    [levelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(minAddPriceLable.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(kMagin);
        make.height.mas_offset(itemHeight);
        
    }];
    
    
    [auctionStarTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(levelLable.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(kMagin);
        make.height.mas_offset(itemHeight);
        
    }];
    
    [endtimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(auctionStarTimeLable.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(kMagin);
        make.height.mas_offset(itemHeight);
    }];
    
    [toWhereLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(endtimeLable.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(kMagin);
        make.height.mas_offset(itemHeight);
    }];
    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kMagin);
        make.top.equalTo(toWhereLable.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(kMagin);
        make.height.mas_offset(itemHeight);
    }];
    
}
-(void)drawRect:(CGRect)rect
{
    UIColor *color = UIColorFromRGB(0xe5e5e5);
    [color set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 1;
    [path1 moveToPoint:CGPointMake(0, 40)];
    [path1 addLineToPoint:CGPointMake(YXScreenW,40)];
    [path1 stroke];
    
    
}

//** -------创建Lable -----------**/
-(UILabel *)addLable:(NSString *)textstr
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = [NSString stringWithFormat:@"· %@",textstr];
    lable.textColor = UIColorFromRGB(0x262626);
    lable.font = YXRegularfont(13);
    [self addSubview:lable];
    return lable;
}
@end
