//
//  YXWalletPayAndIncomeModel.h
//  inbid-ios
//
//  Created by 郑键 on 17/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXWalletPayAndIncomeDataModel;

@interface YXWalletPayAndIncomeModel : NSObject

/**
 totalRows
 */
@property (nonatomic, copy) NSString *totalRows;

/**
 curPage
 */
@property (nonatomic, copy) NSString *curPage;

/**
 data
 */
@property (nonatomic, strong) NSArray<YXWalletPayAndIncomeDataModel *> *data;

@end
