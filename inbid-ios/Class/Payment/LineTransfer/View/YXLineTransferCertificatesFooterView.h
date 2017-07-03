//
//  YXLineTransferCertificatesFooterView.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXLineTransferCertificatesFooterView;

@protocol YXLineTransferCertificatesFooterViewDelegate <NSObject>

/**
 功能按钮点击事件

 @param lineTransferCertificatesFooterView              lineTransferCertificatesFooterView
 @param sender                                          点击的按钮
 */
- (void)lineTransferCertificatesFooterView:(YXLineTransferCertificatesFooterView *)lineTransferCertificatesFooterView
                            andClickBUtton:(UIButton *)sender;

@end

@interface YXLineTransferCertificatesFooterView : UITableViewHeaderFooterView

/**
 功能按钮点击事件
 */
@property (nonatomic, weak) id<YXLineTransferCertificatesFooterViewDelegate> delegate;

@end
