//
//  ZJCalendarManager.h
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 控制器类型

 - ZJCalendaerViewControllerNone:               默认只显示当月之前
 - ZJCalendaerViewControllerMiddleType:         当前月前后各显示一半
 - ZJCalendaerViewControllerTypeNextType:       只显示当前月之后
 */
typedef NS_ENUM(NSUInteger, ZJCalendaerViewControllerType) {
    ZJCalendaerViewControllerNone,
    ZJCalendaerViewControllerMiddleType,
    ZJCalendaerViewControllerTypeNextType,
};

@interface ZJCalendarManager : NSObject

/**
 初始化管理对象

 @param showChineseHoliday  是否显示中国节日
 @param showChineseCalendar 是否显示农历
 @param startDate           开始时间
 @return                    日历管理对象
 */
- (instancetype)initWithShowChineseHoliday:(BOOL)showChineseHoliday
                       showChineseCalendar:(BOOL)showChineseCalendar
                                 startDate:(NSInteger)startDate;

/**
 获取日期数据源

 @param limitMonth      限制的月份
 @param type            类型
 @return                数据模型数组
 */
- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth
                                            type:(ZJCalendaerViewControllerType)type;

/**
 *  开始的位置
 */
@property (nonatomic,strong)NSIndexPath *startIndexPath;

@end
