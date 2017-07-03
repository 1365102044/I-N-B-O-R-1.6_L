//
//  YXInbornTickByTickPayViewModel.m
//  Payment
//
//  Created by 郑键 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXInbornTickByTickPayViewModel.h"

@implementation YXInbornTickByTickPayViewModel

- (CGFloat)heightForRow
{
    if (!_heightForRow) {
        _heightForRow = _rowHeight.floatValue;
    }
    return _heightForRow;
}

@end
