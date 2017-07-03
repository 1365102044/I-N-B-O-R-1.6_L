//
//  YXWalletPayAndIncomeDataModel.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXWalletPayAndIncomeDataModel.h"

@implementation YXWalletPayAndIncomeDataModel

- (NSString *)dt_billtrans
{
    return [_dt_billtrans componentsSeparatedByString:@" "].firstObject;
}

- (NSString *)amt_inoccur
{
    if (!_amt_inoccur) {
        _amt_inoccur = [_amt_inoccur componentsSeparatedByString:@"."].firstObject;
    }
    return _amt_inoccur;
}

- (NSString *)amt_outoccur
{
    if (!_amt_outoccur) {
        _amt_outoccur = [_amt_outoccur componentsSeparatedByString:@"."].firstObject;
    }
    return _amt_outoccur;
}

@end
