//
//  ZJCalendarManager.m
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import "ZJCalendarManager.h"
#import "ZJCalendarMonthModel.h"
#import "ZJCalendarDayModel.h"

@interface ZJCalendarManager()

/**
 *  当前时间的NSDate
 */
@property (nonatomic, strong) NSDate *todayDate;

/**
 *  dataFormatter
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

/**
 *  开始时间
 */
@property (nonatomic, assign) NSInteger startDate;

@property (nonatomic,strong)NSCalendar *greCalendar;

@end

@implementation ZJCalendarManager

- (instancetype)initWithShowChineseHoliday:(BOOL)showChineseHoliday
                       showChineseCalendar:(BOOL)showChineseCalendar
                                 startDate:(NSInteger)startDate
{
    self = [super init];
    {
        self.startDate = startDate;
    }
    return self;
}

/**
 获取日历数据源
 
 @param limitMonth 限制的月份数量
 @param type 月份递减或月份递增类型
 
 @return 存放月份的模型数组
 */
- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth type:(ZJCalendaerViewControllerType)type
{
    /**
     *  实例化存放日历月份模型数组
     */
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    /**
     *  获取当前时间组件
     */
    NSDateComponents *components = [self dateToComponents:self.todayDate];
    
    /**
     *  初始化天为每月第一天
     */
    components.day = 1;
    
    /**
     *  判断当前需要的日历类型
     */
    if(type == ZJCalendaerViewControllerTypeNextType)
    {
        components.month -= 1;
    }
    else if(type == ZJCalendaerViewControllerNone)
    {
        components.month -= limitMonth;
    }
    else
    {
        components.month -= (limitMonth + 1) / 2;
    }
    
    /**
     *  初始化日历数据模型
     */
    NSInteger i = 0;
    for(i = 0;i < limitMonth;i++)
    {
        components.month++;
        ZJCalendarMonthModel *calendarMothModel     = [[ZJCalendarMonthModel alloc]init];
        
        /**
         *  将时间组件转换为NSDate类型时间,并转换为string
         */
        NSDate *date                                = [self componentsToDate:components];
        [self.dateFormatter setDateFormat: @"yyyy年MM月"];
        NSString *dateString                        = [self.dateFormatter stringFromDate:date];
        calendarMothModel.title                     = dateString;
        
        /**
         *  获取月份中的每一天的数据
         */
        calendarMothModel.daysArray = [self getCalendarItemArrayWithDate:date section:i];
        [resultArray addObject:calendarMothModel];
    }
    return resultArray;
}

/**
 获取每个月中的天
 
 @param date        当前月的NSDate
 @param section     第几月
 @return            每个月对应的天的数组
 */
- (NSArray *)getCalendarItemArrayWithDate:(NSDate *)date section:(NSInteger)section
{
    /**
     *  数组实例化,用于存档月对应天的数据模型
     */
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    /**
     *  获取每个月的天数
     */
    NSInteger tatalDay = [self numberOfDaysInCurrentMonth:date];
    
    /**
     *  获取对应月的第一天是星期几
     */
    NSInteger firstDay = [self startDayOfWeek:date];
    
    /**
     *  获取传入Date时间组件, 可改造当前方法的参数, 通过前面传递, 避免性能浪费
     */
    NSDateComponents *components = [self dateToComponents:date];
    
    /**
     *  判断日历有多少列
     */
    NSInteger tempDay = tatalDay + (firstDay - 1);
    NSInteger column = 0;
    if(tempDay % 7 == 0) {
        column = tempDay / 7;
    }else{
        column = tempDay / 7 + 1;
    }
    
    NSInteger i = 0;
    NSInteger j = 0;
    components.day = 0;
    for(i = 0;i < column;i++) {
        for(j = 0;j < 7;j++) {
            if(i == 0 && j < firstDay - 1) {
                ZJCalendarDayModel *dayModel    = [[ZJCalendarDayModel alloc]init];
                dayModel.year                   = 0;
                dayModel.month                  = 0;
                dayModel.day                    = 0;
                dayModel.week                   = -1;
                dayModel.dateInterval           = -1;
                [resultArray addObject:dayModel];
                continue;
            }
            components.day += 1;
            if(components.day == tatalDay + 1) {
                i = column;// 结束外层循环
                break;
            }
            ZJCalendarDayModel *dayModel        = [[ZJCalendarDayModel alloc]init];
            dayModel.year                       = components.year;
            dayModel.month                      = components.month;
            dayModel.day                        = components.day;
            dayModel.week                       = j;
            NSDate *date                        = [self componentsToDate:components];
            
            /**
             *  时间戳
             */
            dayModel.dateInterval = [self dateToInterval:date];
            
            if(self.startDate == dayModel.dateInterval) {
                self.startIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            }
            
            [resultArray addObject:dayModel];
        }
    }
    return resultArray;
}

/**
 获取一个月有多少天
 
 @param date            月的NSDate对象
 @return                返回对应的date月对应的天数
 */
- (NSUInteger)numberOfDaysInCurrentMonth:(NSDate *)date
{
    return [self.greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

/**
 确定这个月的第一天是星期几
 
 @param date            月的NSDate对象
 @return                返回星期几
 */
- (NSUInteger)startDayOfWeek:(NSDate *)date
{
    NSDate *startDate = nil;
    BOOL result = [self.greCalendar rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:date];
    if(result)
    {
        return [self.greCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:startDate];
    }
    return 0;
}

/**
 *  日期转时间戳
 */
- (NSInteger)dateToInterval:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}

/**
 当前时间转为时间组件
 
 @param date date
 @return 时间组件
 */
- (NSDateComponents *)dateToComponents:(NSDate *)date
{
    NSDateComponents *components = [self.greCalendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    return components;
}

- (NSDate *)componentsToDate:(NSDateComponents *)components
{
    // 不区分时分秒
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate *date = [self.greCalendar dateFromComponents:components];
    return date;
}

- (NSCalendar *)greCalendar
{
    if (!_greCalendar) {
        _greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _greCalendar;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (NSDate *)todayDate
{
    if(!_todayDate){
        _todayDate = [NSDate date];
    }
    return _todayDate;
}

@end
