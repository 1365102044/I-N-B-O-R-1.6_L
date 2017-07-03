//
//  ZJCalendarHeaderView.m
//  Project
//
//  Created by 郑键 on 17/2/27.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "ZJCalendarHeaderView.h"
#import "NSDate+YXExtension.h"

@interface ZJCalendarHeaderView()

/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *marginLine;

/**
 *  开始日期
 */
@property (weak, nonatomic) IBOutlet UILabel *startLabel;

/**
 *  计算label
 */
@property (weak, nonatomic) IBOutlet UILabel *calculationLabel;

/**
 *  结束日期label
 */
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@end

@implementation ZJCalendarHeaderView

#pragma mark - Setter

- (void)setStartTime:(NSInteger)startTime
{
    _startTime = startTime;
    
    self.calculationLabel.text = @" ";
    self.endLabel.text = @"选择结束日期";
    self.startLabel.text = [self showTimeStringWithTime:startTime];
}

- (void)setEndTime:(NSInteger)endTime
{
    _endTime = endTime;
    
    self.calculationLabel.text = [NSString stringWithFormat:@"（共%zd天）",
                                  [self getDifferenceByDate:self.startTime otherDate:self.endTime] + 1];
    self.endLabel.text = [self showTimeStringWithTime:endTime];
}

/**
 计算时间差

 @param date        date
 @return            时间差的天数
 */
- (NSInteger)getDifferenceByDate:(NSInteger)date otherDate:(NSInteger)otherDate
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:otherDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags
                                           fromDate:startDate
                                             toDate:endDate
                                            options:0];
    return [comps day];
}

/**
 显示选中时间

 @param time time 时间戳
 */
- (NSString *)showTimeStringWithTime:(NSInteger)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

#pragma mark - LifeCycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor themLightGrayColor];
    self.marginLine.backgroundColor = [UIColor themGrayColor];
}

@end
