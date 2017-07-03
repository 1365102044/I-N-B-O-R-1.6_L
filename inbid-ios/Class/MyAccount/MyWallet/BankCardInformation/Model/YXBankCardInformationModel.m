//
//  YXBankCardInformationModel.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXBankCardInformationModel.h"
#import "YXBankCardInformationSubModel.h"

@implementation YXBankCardInformationModel

- (void)setContentData:(NSArray<YXBankCardInformationSubModel *> *)contentData
{
    _contentData = [YXBankCardInformationSubModel mj_objectArrayWithKeyValuesArray:contentData];
}

- (CGFloat)cacheFooterHeight
{
    if (!_cacheFooterHeight) {
        if (_cacheFooterHeight == 0.1) {
            return _cacheFooterHeight;
        }
        _cacheFooterHeight = ADJUST_PERCENT_FLOAT(_cacheFooterHeight);
    }
    return _cacheFooterHeight;
}

- (CGFloat)cacheSectionHeaderHeight
{
    if (!_cacheSectionHeaderHeight) {
        _cacheSectionHeaderHeight = ADJUST_PERCENT_FLOAT(_cacheSectionHeaderHeight);
    }
    return _cacheSectionHeaderHeight;
}

@end
