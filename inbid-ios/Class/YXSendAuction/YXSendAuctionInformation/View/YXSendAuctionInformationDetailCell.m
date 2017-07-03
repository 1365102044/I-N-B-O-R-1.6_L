//
//  YXSendAuctionInformationDetailCell.m
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionInformationDetailCell.h"
#import "YXSendAuctionGetIdentifuDetails.h"
#import "YXMySendAuctionSubTableViewController.h"

@interface YXSendAuctionInformationDetailCell()

@end

@implementation YXSendAuctionInformationDetailCell

- (void)setIdentifuDetailModel:(YXSendAuctionGetIdentifuDetails *)identifuDetailModel
{
    _identifuDetailModel = identifuDetailModel;
    
    if (!identifuDetailModel) {
        return;
    }
    
    //--初始化
    self.myDetaileLabel.textInsets = UIEdgeInsetsMake(0, 12, 0, 12);
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 10;
    
    NSDictionary *attributes1 = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:13],
                                  NSParagraphStyleAttributeName:paragraphStyle1,
                                  NSForegroundColorAttributeName:[UIColor darkTextColor]
                                  };
    self.myDetaileLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", identifuDetailModel.orderContent] attributes:attributes1];
}

- (void)setSourceController:(UIViewController *)sourceController
{
    _sourceController = sourceController;
    
//    if ([self.sourceController isKindOfClass:[YXMySendAuctionSubTableViewController class]]) {
//        return;
//    }
//    
//    //设置文案行间距
//    //--初始化
//    self.myDetaileLabel.textInsets = UIEdgeInsetsMake(0, 12, 0, 12);
//    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle1.lineSpacing = 10;
//    
//    NSDictionary *attributes1 = @{
//                                  NSFontAttributeName:[UIFont systemFontOfSize:13],
//                                  NSParagraphStyleAttributeName:paragraphStyle1,
//                                  NSForegroundColorAttributeName:[UIColor darkTextColor]
//                                  };
//    self.myDetaileLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"商品名称：%@\n%@", [YXSendAuctionManager defaultSendAuctionManager].prodName, [YXSendAuctionManager defaultSendAuctionManager].orderContent] attributes:attributes1];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
   
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
