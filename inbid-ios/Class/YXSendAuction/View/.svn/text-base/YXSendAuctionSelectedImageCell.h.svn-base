//
//  YXSendAuctionSelectedImageCell.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXSendAuctionProgressModel;
@class YXSendAuctionSelectedImageCell;

@protocol YXSendAuctionSelectedImageCellDelegate <NSObject>

/**
 点击删除按钮

 @param sendAuctionSelectedImageCell sendAuctionSelectedImageCell
 @param sender                       sender
 */
- (void)sendAuctionSelectedImageCell:(YXSendAuctionSelectedImageCell *)sendAuctionSelectedImageCell clickButton:(UIButton *)sender;

/**
 点击重新上传

 @param sendAuctionSelectedImageCell sendAuctionSelectedImageCell
 @param imageModel imageModel
 */
- (void)sendAuctionSelectedImageCell:(YXSendAuctionSelectedImageCell *)sendAuctionSelectedImageCell reUploadImageModel:(YXSendAuctionProgressModel *)imageModel;

@end

@interface YXSendAuctionSelectedImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

/**
 进度模型
 */
@property (nonatomic, strong) YXSendAuctionProgressModel *progressModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXSendAuctionSelectedImageCellDelegate> delegate;

@end
