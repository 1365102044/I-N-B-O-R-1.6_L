//
//  YXLineTransferCertificatesCell.h
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXLineTransferCertificatesCell;
@class YXPaymentHomepageViewDataModel;
@class YXSendAuctionProgressModel;

@protocol YXLineTransferCertificatesCellDelegate <NSObject>

/**
 按钮点击事件回调

 @param lineTransferCertificatesCell    当前cell
 @param clickButton                     点击的按钮
 */
- (void)lineTransferCertificatesCell:(YXLineTransferCertificatesCell *)lineTransferCertificatesCell
                         clickButton:(UIButton *)clickButton;

/**
 上传失败点击重新上传

 @param lineTransferCertificatesCell 上传凭证
 @param sender                       扩展传递（可为空）
 */
- (void)lineTransferCertificatesCell:(YXLineTransferCertificatesCell *)lineTransferCertificatesCell
                       reUploadImage:(id)sender;

@end

@interface YXLineTransferCertificatesCell : UITableViewCell

/**
 代理
 */
@property (nonatomic, weak) id<YXLineTransferCertificatesCellDelegate> delegate;

/**
 基础数据模型
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *dataModel;

/**
 进度及选中图片模型
 */
@property (nonatomic, strong) YXSendAuctionProgressModel *progressModel;

@end
