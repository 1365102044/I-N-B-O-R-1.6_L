//
//  YXSendAuctionInformationImagesCell.h
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionGetIdentifuDetails;

@interface YXSendAuctionInformationImagesCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *imageViewsArray;

/**
 模型数据
 */
@property (nonatomic, strong) YXSendAuctionGetIdentifuDetails *identifuDetailModel;

/**
 来源控制器
 */
@property (nonatomic, strong) UIViewController *sourceController;

@end
