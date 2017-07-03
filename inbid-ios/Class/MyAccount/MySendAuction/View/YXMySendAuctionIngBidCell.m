//
//  YXMySendAuctionIngBidCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionIngBidCell.h"
#import "YXMySendAuctionIngBid.h"
#import "NSDate+YXExtension.h"
#import "YXStringFilterTool.h"

@interface YXMySendAuctionIngBidCell()

//** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
//** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
//** 加价次数 */
@property (weak, nonatomic) IBOutlet UILabel *biddingCountLabel;
//** 结束时间 */
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//** 当前价格 */
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
//** 状态按钮 */
@property (weak, nonatomic) IBOutlet UIButton *statusButton;

//** 结束或开始时间 */
@property (weak, nonatomic) IBOutlet UILabel *endOrStartTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@end


@implementation YXMySendAuctionIngBidCell

#pragma mark - 赋值

//** 设置控件数据 */
- (void)setMySendAuctionIngBidModel:(YXMySendAuctionIngBid *)mySendAuctionIngBidModel
{
    _mySendAuctionIngBidModel = mySendAuctionIngBidModel;
    [self.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:mySendAuctionIngBidModel.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
    
    self.goodNameLabel.text = mySendAuctionIngBidModel.prodName;
    self.biddingCountLabel.text = [NSString stringWithFormat:@"%zd", mySendAuctionIngBidModel.bidCount];
    //+(NSString*)strmethodComma:(NSString*)string;
    if (mySendAuctionIngBidModel.bidCount == 0) {
        self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", mySendAuctionIngBidModel.startPrice / 100]]];
    }else{
        self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", mySendAuctionIngBidModel.currentPrice / 100]]];
    }

    /**
     * 拍卖状态：1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
     */
    //private Integer bidStatus;
    //@property (nonatomic, assign) NSInteger bidStatus;
    
    if (mySendAuctionIngBidModel.bidStatus == 1) {
        
        self.endOrStartTimeLabel.text = @"开始时间：";
        self.endTimeLabel.text = mySendAuctionIngBidModel.endTime;
        self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_start"];
        
    }else if (mySendAuctionIngBidModel.bidStatus == 2) {
        
        self.endOrStartTimeLabel.text = @"结束时间：";
        self.endTimeLabel.text = mySendAuctionIngBidModel.endTime;
        self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_biding"];
        
    }else if (mySendAuctionIngBidModel.bidStatus == 3) {
        
        self.endOrStartTimeLabel.text = @"结束时间：";
        self.endTimeLabel.text = mySendAuctionIngBidModel.endTime;
        self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_ing"];
        
    }else if (mySendAuctionIngBidModel.bidStatus == 4) {
        
        self.endOrStartTimeLabel.text = @"结束时间：";
        self.endTimeLabel.text = mySendAuctionIngBidModel.endTime;
        
        
    }else if (mySendAuctionIngBidModel.bidStatus == 5) {
        
        self.endOrStartTimeLabel.text = @"结束时间：";
        self.endTimeLabel.text = mySendAuctionIngBidModel.endTime;
    }
}




#pragma mark - 初始化设置

- (void)awakeFromNib {
    [super awakeFromNib];
 
    [self.statusButton setBackgroundColor:[UIColor mainThemColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

@end
