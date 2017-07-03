//
//  YXSendAuctionInformationSectionHeaderView.h
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionGetIdentifuDetails;

@interface YXSendAuctionInformationSectionHeaderView : UITableViewHeaderFooterView

/**
 来源控制器
 */
@property (nonatomic, strong) UIViewController *sourceController;

@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) YXSendAuctionGetIdentifuDetails *identifuDetails;

@end
