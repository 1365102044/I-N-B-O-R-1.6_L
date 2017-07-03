//
//  YXBankCardInformationBottomFuncFooter.h
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXBankCardInformationModel;
@class YXBankCardInformationBottomFuncFooter;

@protocol YXBankCardInformationBottomFuncFooterDelegate <NSObject>

/**
 按钮点击事件

 @param bankCardInformationBottomFuncFooter         bankCardInformationBottomFuncFooter
 @param sender                                      按钮
 */
- (void)bankCardInformationBottomFuncFooter:(YXBankCardInformationBottomFuncFooter *)bankCardInformationBottomFuncFooter
                                buttonClick:(UIButton *)sender;

@end


@interface YXBankCardInformationBottomFuncFooter : UITableViewHeaderFooterView

/**
 模型
 */
@property (nonatomic, strong) YXBankCardInformationModel *model;

/**
 代理
 */
@property (nonatomic, weak) id<YXBankCardInformationBottomFuncFooterDelegate> delegate;

@end
