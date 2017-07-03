//
//  YXWalletPayAndIncomeModel.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXWalletPayAndIncomeModel.h"
#import "YXWalletPayAndIncomeDataModel.h"

@implementation YXWalletPayAndIncomeModel

- (void)setData:(NSArray<YXWalletPayAndIncomeDataModel *> *)data
{
    _data = [YXWalletPayAndIncomeDataModel mj_objectArrayWithKeyValuesArray:data];
}

@end
