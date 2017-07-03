//
//  YXMyQuerProdBidListCountTime.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/28.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyQuerProdBidListCountTime.h"

@implementation YXMyQuerProdBidListCountTime


+ (instancetype)timeModelWithTitle:(NSString*)title time:(long long)time {
    
    YXMyQuerProdBidListCountTime *model = [self new];
    
    model.m_titleStr = title;
    model.m_countNum = time;
    
    return model;
}

- (void)countDown {
    
    _m_countNum -= 1;
}

- (NSString*)currentTimeString {
    
    if (_m_countNum <= 0) {
        
        return @"00:00:00";
        
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)_m_countNum/3600, (long)_m_countNum%3600/60,(long)_m_countNum%60];
//        return [NSString stringWithFormat:@"%ld天%02ld:%02ld:%02ld", (long)_m_countNum/86400, (long)_m_countNum%86400/3600, (long)_m_countNum%3600/60,(long)_m_countNum%60];
    }
}


@end
