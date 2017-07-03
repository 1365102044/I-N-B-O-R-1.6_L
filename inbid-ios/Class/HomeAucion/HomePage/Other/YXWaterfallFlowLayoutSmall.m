//
//  YXWaterfallFlowLayoutSmall.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXWaterfallFlowLayoutSmall.h"

@implementation YXWaterfallFlowLayoutSmall

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return 1;
    }
}

@end
