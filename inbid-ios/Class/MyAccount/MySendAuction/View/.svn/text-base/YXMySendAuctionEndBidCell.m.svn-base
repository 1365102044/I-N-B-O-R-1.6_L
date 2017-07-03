//
//  YXMySendAuctionEndBidCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionEndBidCell.h"
#import "YXMySendAuctionEndBid.h"

@interface YXMySendAuctionEndBidCell()

//** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
//** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
//** 参与人数 */
@property (weak, nonatomic) IBOutlet UILabel *partInPeopleCountLabel;
//** 出价次数 */
@property (weak, nonatomic) IBOutlet UILabel *biddingCountLabel;
//** 成交价格 */
@property (weak, nonatomic) IBOutlet UILabel *endPriceLabel;
//** 结束时间 */
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//** 已流拍状态指示按钮 */
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//** 状态提示imageView */
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
//** 状态按钮宽度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusButtonWidthCons;

@end

@implementation YXMySendAuctionEndBidCell

#pragma mark - 响应事件

- (IBAction)backButtonClick:(UIButton *)sender
{
    //跳转我要退回界面
    if ([self.delegate respondsToSelector:@selector(sendAuctionEndBidCell:)]) {
        [self.delegate sendAuctionEndBidCell:self];
    }
}


#pragma mark - 赋值

- (void)setMySendAuctionEndBidModel:(YXMySendAuctionEndBid *)mySendAuctionEndBidModel
{
    _mySendAuctionEndBidModel = mySendAuctionEndBidModel;
    
    [self.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:mySendAuctionEndBidModel.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
    
    self.goodNameLabel.text = mySendAuctionEndBidModel.prodName;
    self.partInPeopleCountLabel.text = [NSString stringWithFormat:@"%zd人", mySendAuctionEndBidModel.actorNum];
    self.biddingCountLabel.text = [NSString stringWithFormat:@"%zd次", mySendAuctionEndBidModel.bidCount];
    self.endTimeLabel.text = mySendAuctionEndBidModel.endTime;
    self.endPriceLabel.text = [NSString stringWithFormat:@"¥%zd", mySendAuctionEndBidModel.orderTotalAmount / 100];
    
    self.backButton.hidden = YES;
    /**
     * 拍卖状态：1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
     */
    //private Integer bidStatus;
    //@property (nonatomic, assign) NSInteger bidStatus;
    if (mySendAuctionEndBidModel.bidStatus == 5) {
        
        self.endTimeLabel.hidden = YES;
        self.backButton.hidden = NO;
        self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_liupai"];
        self.statusButtonWidthCons.constant = 75;
        /**
         * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
         */
        //private Integer refundStatus;
        if (mySendAuctionEndBidModel.refundStatus == 1) {
            self.backButton.userInteractionEnabled = YES;
            [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (mySendAuctionEndBidModel.refundStatus == 2) {
            //添加已申请
            //self.identificationLabel.text = @"      已申请退回";
            self.backButton.backgroundColor = [UIColor whiteColor];
            [self.backButton setTitle:@"已申请退回" forState:UIControlStateNormal];
            [self.backButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
            self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            self.backButton.userInteractionEnabled = NO;
            self.statusButtonWidthCons.constant = 150;
        }else if (mySendAuctionEndBidModel.refundStatus == 3) {
            //添加已申请
            //self.identificationLabel.text = @"      退回中";
            self.backButton.backgroundColor = [UIColor whiteColor];
            [self.backButton setTitle:@"退回中..." forState:UIControlStateNormal];
            [self.backButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
            self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            self.backButton.userInteractionEnabled = NO;
            self.statusButtonWidthCons.constant = 150;
        }else if (mySendAuctionEndBidModel.refundStatus == 4) {
            //添加已申请
            //self.identificationLabel.text = @"      已退回";
            self.backButton.backgroundColor = [UIColor whiteColor];
            [self.backButton setTitle:@"已退回" forState:UIControlStateNormal];
            [self.backButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
            self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            self.backButton.userInteractionEnabled = NO;
            self.statusButtonWidthCons.constant = 150;
        }
        
    }else if (mySendAuctionEndBidModel.bidStatus == 4) {
        /**
         * 打款状态; 1=平台未打款,2=平台打款中,3=平台已打款
         */
        //private Integer paymentStatus;
        //@property (nonatomic, assign) NSInteger paymentStatus;
        if (mySendAuctionEndBidModel.paymentStatus == 2) {
            self.statusImageView.hidden = NO;
            self.statusImageView.image = [UIImage imageNamed:@"ic_mySendAuction_paying"];
            self.endTimeLabel.hidden = NO;
        }else if (mySendAuctionEndBidModel.paymentStatus == 3){
            self.endTimeLabel.hidden = NO;
            self.statusImageView.hidden = YES;
        }
    }
    
    
//    {
//        self.auctionsStatusButton.hidden = YES;
//        self.endTimeLabel.hidden = NO;
//    }
    
    
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.backButton setBackgroundColor:[UIColor mainThemColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
