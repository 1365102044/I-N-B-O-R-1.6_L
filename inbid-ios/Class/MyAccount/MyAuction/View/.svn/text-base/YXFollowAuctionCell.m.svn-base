//
//  YXFollowAuctionCell.m
//  MyAuction
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXFollowAuctionCell.h"
#import "YXMyAccountFollowAuctionList.h"
#import "NSString+YXExtension.h"
#import "NSDate+YXExtension.h"
#import "YXStringFilterTool.h"
#import <UIImageView+WebCache.h>

@interface YXFollowAuctionCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *followPeopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *startBidPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

//** 开始时间提示label */
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabelTips;
@property (weak, nonatomic) IBOutlet UIButton *goodStatusButton;

/**
 商品状态
 */
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

/**
 顶部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *topSpacingView;

/**
 底部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomSpacingView;

@end

@implementation YXFollowAuctionCell

#pragma mark - 赋值

- (void)setModel:(id)model
{
    if ([model isKindOfClass:[YXMyAccountFollowAuctionList class]]) {
        YXMyAccountFollowAuctionList *accountFollowAuctionList = (YXMyAccountFollowAuctionList *)model;
        
        self.followAuctionList = accountFollowAuctionList;
        
        [self.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:accountFollowAuctionList.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
        self.goodNameLabel.text = accountFollowAuctionList.prodName;
        self.followPeopleCountLabel.text = [NSString stringWithFormat:@"%zd人", accountFollowAuctionList.memCount];
        
        self.startBidPriceLabel.text = [NSString stringWithFormat:@"¥ %@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", accountFollowAuctionList.currentPrice / 100]]];
        
        /**
         * 拍卖状态：1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
         */
        //private Integer bidStatus;
        
        if (accountFollowAuctionList.bidStatus == 1) {
            //[self.goodStatusButton setTitle:@"未开始" forState:UIControlStateNormal];
            self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_start"];
        }else if (accountFollowAuctionList.bidStatus == 2){
            //[self.goodStatusButton setTitle:@"已开始" forState:UIControlStateNormal];
            self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_biding"];
        }else{
            //[self.goodStatusButton setTitle:@"已结束" forState:UIControlStateNormal];
            self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_end"];
        }
        
        //统一title参与竞拍
        /**
         * 加价按钮显示：0=参与竞拍，大于0=我要加价
         */
        //private Integer hasOffered
        //@property (nonatomic, assign) NSInteger hasOffered;
        
//        if (accountFollowAuctionList.hasOffered == 0) {
//            [self.cellButton setTitle:@"参与竞拍" forState:UIControlStateNormal];
//        }else if (accountFollowAuctionList.hasOffered > 0){
//            [self.cellButton setTitle:@"我要加价" forState:UIControlStateNormal];
//        }
        
        /**
         * 拍卖状态：1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
         */
        //private Integer bidStatus;
        //@property (nonatomic, assign) NSInteger bidStatus;
        
        if (accountFollowAuctionList.bidStatus == 1) {
            self.startTimeLabel.text = [NSDate dataStrFromDataStr:accountFollowAuctionList.startTime withDateFormat:@"yyyy-MM-dd HH:mm"];
//            [self.goodStatusButton setTitle:@"未开始" forState:UIControlStateNormal];
            self.startTimeLabelTips.hidden = YES;
            self.cellButton.hidden = YES;
        }else if (accountFollowAuctionList.bidStatus == 2){
            
            self.startTimeLabel.text = [NSDate dataStrFromDataStr:accountFollowAuctionList.endTime withDateFormat:@"yyyy-MM-dd HH:mm"];
            //            [self.goodStatusButton setTitle:@"已开始" forState:UIControlStateNormal];
            self.startTimeLabelTips.hidden = NO;
            self.startTimeLabelTips.text = @"结束时间";
            self.cellButton.hidden = NO;
            
        }else{
            
            self.startTimeLabel.text = [NSDate dataStrFromDataStr:accountFollowAuctionList.endTime withDateFormat:@"yyyy-MM-dd HH:mm"];
            //            [self.goodStatusButton setTitle:@"已开始" forState:UIControlStateNormal];
            self.startTimeLabelTips.hidden = NO;
            self.startTimeLabelTips.text = @"结束时间";
            self.cellButton.hidden = YES;
        }
    }
}



- (IBAction)followAuctionButtonClick:(UIButton *)sender
{
    
    if ([self.delegate respondsToSelector:@selector(myAuctionBaseCell:partInAuction:withProBidId:withProId:)]) {
        [self.delegate myAuctionBaseCell:self partInAuction:sender withProBidId: self.followAuctionList.prodBidId withProId:self.followAuctionList.prodId];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //--设置状态按钮边框及文字颜色
    //--边框
    [self.goodStatusButton.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){159.0/255.0,120.0/255.0,65.0/255.0,1});
    [self.goodStatusButton.layer setBorderColor:color];
    [self.goodStatusButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    
    self.topSpacingView.backgroundColor = [UIColor themGrayColor];
    self.bottomSpacingView.backgroundColor = [UIColor themGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
