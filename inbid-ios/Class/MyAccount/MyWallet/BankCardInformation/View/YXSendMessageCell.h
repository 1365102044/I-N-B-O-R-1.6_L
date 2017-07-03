//
//  YXSendMessageCell.h
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXBankCardInformationSubModel;
@class YXSendMessageCell;

@protocol YXSendMessageCellDelegate <NSObject>

/**
 cell按钮点击事件

 @param sendMessageCell     sendMessageCell
 @param button              button
 */
- (void)sendMessageCell:(YXSendMessageCell *)sendMessageCell
            buttonClick:(UIButton *)button;

@end

@interface YXSendMessageCell : UITableViewCell

/**
 模型
 */
@property (nonatomic, strong) YXBankCardInformationSubModel *model;

/**
 代理
 */
@property (nonatomic, weak) id<YXSendMessageCellDelegate> delegate;

@end
