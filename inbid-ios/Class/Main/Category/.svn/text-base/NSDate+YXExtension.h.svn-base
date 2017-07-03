//
//  NSDate+YXExtension.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/3.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YXExtension)

/**
 获取当前时间戳

 @return 当前时间戳
 */
+ (long long)dateGetNowTime;

/**
 时间戳转时间

 @param timeStamp 时间戳
 @param format    格式

 @return 时间
 */
+ (NSString *)dateStrFromCstampTime:(long long)timeStamp
                     withDateFormat:(NSString *)format;

/**
 时间字符串转换为时间

 
 @param dataStr 时间字符串
 @param format  格式

 @return 转换好的时间
 */
+ (NSString *)dataStrFromDataStr:(NSString *)dataStr withDateFormat:(NSString *)format;

/**
 NSDate转str
 
 @param format 日期格式
 @return 返回指定日期格式的str
 */
- (NSString *)dataStrWithDateFormat:(NSString *)format;

/**
 时间转换时间戳

 @param timeStr 时间字符串

 @return 时间戳
 */
+ (long long )changeTimeToTimeSp:(NSString *)timeStr;

/**
 获取当前时间对象

 @return 时间对象
 */
+ (NSDate *)getCurrentDate;

@end
