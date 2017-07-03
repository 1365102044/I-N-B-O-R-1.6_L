//
//  ELFamilyViewController.h
//  eshenghuo
//
//  Created by 李金蔚 on 16/6/27.
//  Copyright © 2016年 SYP. All rights reserved.
//


#import "NSDate+Utils.h"
#import <time.h>

@implementation NSDate (Utils)

+ (NSString *)prettyDateDescription:(NSTimeInterval)interval
{
    // 现在的时间
    time_t nowdate = time(NULL);
    struct tm nowtm = {0};
    localtime_r(&nowdate, &nowtm);
    // 创建的时间
    time_t pubdate = interval;
    struct tm pubtm = {0};
    localtime_r(&pubdate, &pubtm);
    
    if (pubtm.tm_year < nowtm.tm_year || (nowtm.tm_yday-pubtm.tm_yday) > 1) {
        return [[NSString alloc] initWithFormat:@"%d月%d日", pubtm.tm_mon+1, pubtm.tm_mday];
    } else if (pubtm.tm_year > nowtm.tm_year) {
        return @"未来";
    } else {
        if ((nowtm.tm_yday-pubtm.tm_yday) == 1) {
            return @"昨天";
        } else if ((nowtm.tm_hour-pubtm.tm_hour) >= 1) {
            if (nowtm.tm_hour-pubtm.tm_hour == 1 && (nowtm.tm_min-pubtm.tm_min) < 0) {
                return [[NSString alloc] initWithFormat:@"%d分钟前", (60+nowtm.tm_min-pubtm.tm_min)];
            } else {
                return [[NSString alloc] initWithFormat:@"%d小时前", (nowtm.tm_hour-pubtm.tm_hour)];
            }
        } else if ((nowtm.tm_min-pubtm.tm_min) <= 0) {
            return @"刚刚";
        } else {
            return [[NSString alloc] initWithFormat:@"%d分钟前", (nowtm.tm_min-pubtm.tm_min)];
        }
    }
}

- (NSString *)prettyDateDescription
{
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSDate prettyDateDescription:interval];
}

+ (NSString *)dateTimeDescription:(NSTimeInterval)interval
{
    time_t pubdate = interval;
    struct tm pubtm = {0};
    localtime_r(&pubdate, &pubtm);
    
    return [[NSString alloc] initWithFormat:@"%04d-%02d-%02d %02d:%02d",
            pubtm.tm_year+1900, pubtm.tm_mon+1, pubtm.tm_mday,
            pubtm.tm_hour, pubtm.tm_min];
}

+ (NSString *)dateDescription:(NSTimeInterval)interval
{
    time_t pubdate = interval;
    struct tm pubtm = {0};
    localtime_r(&pubdate, &pubtm);

    return [[NSString alloc] initWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d",
            pubtm.tm_year+1900, pubtm.tm_mon+1, pubtm.tm_mday,pubtm.tm_hour,pubtm.tm_min,pubtm.tm_sec];
}

@end
