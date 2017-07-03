//
//  YXWithdrawalsModel.m
//  Project
//
//  Created by 郑键 on 17/2/16.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXWithdrawalsModel.h"
#import "YXWithdrawalsDataModel.h"

@implementation YXWithdrawalsModel

- (void)setDataModel:(YXWithdrawalsDataModel *)dataModel
{
    if ([dataModel isKindOfClass:[YXWithdrawalsModel class]]) {
        _dataModel = dataModel;
    }else{
        _dataModel = [YXWithdrawalsDataModel mj_objectWithKeyValues:dataModel];
    }
}

@end
