//
//  YXEndBiddingCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXEndBiddingCell.h"
#import "YXMyAccountQueryProdOverList.h"
#import "YXStringFilterTool.h"

@interface YXEndBiddingCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followCount;
@property (weak, nonatomic) IBOutlet UILabel *bidCount;
@property (weak, nonatomic) IBOutlet UILabel *endPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *winerTipsImageView;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;


@end

@implementation YXEndBiddingCell

- (void)setModel:(id)model
{
    if ([model isKindOfClass:[YXMyAccountQueryProdOverList class]]){
        YXMyAccountQueryProdOverList *accountQueryProdOverModel = (YXMyAccountQueryProdOverList *)model;
        
        self.queryProdOverList = accountQueryProdOverModel;
        
        [self.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:accountQueryProdOverModel.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
        self.goodNameLabel.text = accountQueryProdOverModel.prodName;
        
        self.followCount.text = [NSString stringWithFormat:@"%zd人", accountQueryProdOverModel.actorNum];
        self.bidCount.text = [NSString stringWithFormat:@"%zd次", accountQueryProdOverModel.bidCount];
        self.endTimeLabel.text = accountQueryProdOverModel.endTime;
        
        self.endPriceLabel.text = [NSString stringWithFormat:@"¥%@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", accountQueryProdOverModel.currentPrice / 100]]];
        
        if ([[NSString stringWithFormat:@"%lld", accountQueryProdOverModel.memberId] isEqualToString: [YXUserDefaults objectForKey:@"userID"]]) {
            self.winerTipsImageView.hidden = NO;
        }else{
            self.winerTipsImageView.hidden = YES;
        }
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
