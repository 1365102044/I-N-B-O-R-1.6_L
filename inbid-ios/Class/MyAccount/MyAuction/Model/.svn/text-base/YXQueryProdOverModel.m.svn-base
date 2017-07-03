//
//  YXQueryProdOverModel.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXQueryProdOverModel.h"
#import "YXMyAccountQueryProdOverList.h"

@implementation YXQueryProdOverModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"dataList" : @"data",
             };
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = [YXMyAccountQueryProdOverList mj_objectArrayWithKeyValuesArray:dataList];
}

- (void)setCurPage:(NSInteger)curPage
{
    _curPage = curPage;
    for (YXMyAccountQueryProdOverList *list in _dataList) {
        list.currentPage = curPage;
    }
}

@end
