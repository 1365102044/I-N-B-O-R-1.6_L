//
//  YXBankCardInformationModel.h
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXBankCardInformationSubModel;

@interface YXBankCardInformationModel : NSObject

/**
 sectionTitle
 */
@property (nonatomic, copy) NSString *sectionTitle;

/**
 cacheSectionHeaderHeight
 */
@property (nonatomic, assign) CGFloat cacheSectionHeaderHeight;

/**
 contentData
 */
@property (nonatomic, strong) NSArray<YXBankCardInformationSubModel *> *contentData;

/**
 cacheFooterHeight
 */
@property (nonatomic, assign) CGFloat cacheFooterHeight;

/**
 footerShowAgreementButton
 */
@property (nonatomic, assign, getter=isHiddenFooterAgreementButton) BOOL footerHiddenAgreementButton;

/**
 footerArgeementStatus
 */
@property (nonatomic, assign, getter=isAgreeFooterArgeement) BOOL footerArgeementStatus;

@end
