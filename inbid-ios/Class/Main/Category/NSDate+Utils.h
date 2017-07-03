//
//  ELFamilyViewController.h
//  eshenghuo
//
//  Created by 李金蔚 on 16/6/27.
//  Copyright © 2016年 SYP. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDate (Utils)

/**
 设置时间的显示形式
 */
// 1分钟前，刚刚...
- (NSString *)prettyDateDescription;
+ (NSString *)prettyDateDescription:(NSTimeInterval)interval;

+ (NSString *)dateTimeDescription:(NSTimeInterval)interval; // yyyy-MM-dd HH:mm
+ (NSString *)dateDescription:(NSTimeInterval)interval; // yyyy-MM-dd

@end




