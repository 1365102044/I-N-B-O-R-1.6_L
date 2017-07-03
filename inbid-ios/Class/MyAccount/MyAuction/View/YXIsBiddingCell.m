//
//  YXIsBiddingCell.m
//  MyAuction
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXIsBiddingCell.h"
#import <UIImageView+WebCache.h>
#import "YXMyAccountQueryProdBidList.h"
#import "YXMyAccountQueryProdOverList.h"
#import "NSString+YXExtension.h"
#import "NSDate+YXExtension.h"
#import "ZJCountDownView.h"
#import "YXMyQuerProdBidListCountTime.h"
#import "YXStringFilterTool.h"

@interface YXIsBiddingCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *partInPeopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *addPriceCount;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

//** 倒计时控件 */
@property (nonatomic, strong) ZJCountDownView *countDownView;

//** 时间label */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//** 时间提示label */
@property (weak, nonatomic) IBOutlet UILabel *timeTipsLabel;

@end

@implementation YXIsBiddingCell

#pragma mark - 赋值

- (void)setModel:(id)model
{
    if ([model isKindOfClass:[YXMyAccountQueryProdBidList class]]) {
        YXMyAccountQueryProdBidList *accountQueryProdBidModel = (YXMyAccountQueryProdBidList *)model;
        
        self.accountQueryProdBidModel = accountQueryProdBidModel;
        
        [self.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:accountQueryProdBidModel.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
        
        self.goodNameLabel.text = accountQueryProdBidModel.prodName;
        
        self.nowPriceLabel.text = [NSString stringWithFormat:@"¥ %@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", accountQueryProdBidModel.currentPrice / 100]]];
        
        self.partInPeopleCountLabel.text = [NSString stringWithFormat:@"%zd人", accountQueryProdBidModel.actorNum];
        self.addPriceCount.text = [NSString stringWithFormat:@"%zd次", accountQueryProdBidModel.bidCount];
        self.timeLabel.text = [NSDate dataStrFromDataStr:accountQueryProdBidModel.endTime withDateFormat:@"yyyy-MM-dd HH:mm"];

        /**
         * 加价按钮显示：0=参与竞拍，大于0=我要加价
         */
        //private Integer hasOffered
        //@property (nonatomic, assign) NSInteger hasOffered;
        
//        if (accountQueryProdBidModel.hasOffered == 0) {
            [self.cellButton setTitle:@"参与竞拍" forState:UIControlStateNormal];
//        }else if (accountQueryProdBidModel.hasOffered > 0){
//            [self.cellButton setTitle:@"我要加价" forState:UIControlStateNormal];
//        }
        
        //--重置控件
        self.countDownLabel.hidden = YES;
        self.cellButton.enabled = YES;
        [self.cellButton setBackgroundColor: [UIColor mainThemColor]];

        
//        if ( -accountQueryProdBidModel.surplusBidTime / 60 < 0  && -accountQueryProdBidModel.surplusBidTime / 60 > -5) {
//            
//            //如果有cell要开始倒计时，发送通知，通知控制器， 开启timer
//            [[NSNotificationCenter defaultCenter] postNotificationName:kYXMyAuctionCellCountDownTimeToControllerCreatTimerNotification object:nil userInfo:nil];
//            
//            //接收通知， 倒计时
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownTimeTextLael) name:kYXMyAuctionControllerCountDownTimerNotification object:nil];
//            
//            [self.goodIconImageView addSubview:self.countDownView];
//            //--赋值开始倒计时
//            self.countDownLabel.hidden = NO;
//            self.cellButton.enabled = NO;
//            [self.cellButton setBackgroundColor: [UIColor colorWithWhite:170.0/255.0 alpha:1.0]];
//            [self.cellButton setTitle:@"参与竞拍" forState:UIControlStateNormal];
//            
//        } else if ( -accountQueryProdBidModel.surplusBidTime > 0 ) {
//            
//            [self.goodIconImageView addSubview:self.countDownView];
//            
//            self.countDownLabel.hidden = NO;
//            self.cellButton.enabled = NO;
//            [self.cellButton setBackgroundColor: [UIColor colorWithWhite:170.0/255.0 alpha:1.0]];
//            [self.cellButton setTitle:@"我要加价" forState:UIControlStateNormal];
//        }
    }
}

#pragma mark - 响应事件

- (IBAction)fuctionButtonClick:(UIButton *)sender
{
//    if ([self.delegate respondsToSelector:@selector(myAuctionBaseCell:partInAuction:withBidId:)]) {
//        [self.delegate myAuctionBaseCell:self partInAuction:sender withBidId:[NSString stringWithFormat:@"%zd", self.accountQueryProdBidModel.bidId]];
//    }
    
    if ([self.delegate respondsToSelector:@selector(myAuctionBaseCell:partInAuction:withProBidId:withProId:)]) {
        [self.delegate myAuctionBaseCell:self partInAuction:sender withProBidId:self.accountQueryProdBidModel.bidId withProId:self.accountQueryProdBidModel.prodId];
    }
    
}


////** 接收到倒计时定时器通知 */
//- (void)countDownTimeTextLael
//{   
//    self.countDownView.leftTime = [self.timeModel currentTimeString];
//    
//}


#pragma mark - 懒加载

//- (ZJCountDownView *)countDownView
//{
//    if (!_countDownView) {
//        _countDownView = [[ZJCountDownView alloc] initWithFrame:CGRectMake(0, 0, 54, 54)];
//        _countDownView.backgroundColor = [UIColor colorWithWhite:255.0/255.0 alpha:0.5];
//
//    }
//    return _countDownView;
//}


#pragma mark - 系统方法

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kYXMyAuctionControllerCountDownTimerNotification object:nil];
}

@end
