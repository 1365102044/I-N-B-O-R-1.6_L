//
//  NSDate+YXExtension.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/3.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "NSDate+YXExtension.h"

@implementation NSDate (YXExtension)

+ (long long)dateGetNowTime
{
    NSDate* date = [self dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
     return [NSNumber numberWithDouble: a].longLongValue;
}

+ (NSString *)dateStrFromCstampTime:(long long)timeStamp withDateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+ (NSString *)dataStrFromDataStr:(NSString *)dataStr withDateFormat:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:dataStr];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:format];
    return [outputFormatter stringFromDate:inputDate];
}

/**
 NSDate转str

 @param format 日期格式
 @return 返回指定日期格式的str
 */
- (NSString *)dataStrWithDateFormat:(NSString *)format
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:format];
    return [outputFormatter stringFromDate:self];
}

+ (long long)changeTimeToTimeSp:(NSString *)timeStr
{
    NSInteger time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}

/**
 获取当前时间对象
 
 @return 时间对象
 */
+ (NSDate *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateTime];
    return destDate;
    
}

@end
