//
//  ZJCalendarMonthModel.m
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import "ZJCalendarMonthModel.h"

@implementation ZJCalendarMonthModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@\ndaysArray:%@", _title, _daysArray];
}

@end
