//
//  ZJCalendarViewController.h
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJCalendarViewController;

@protocol ZJCalendarViewControllerDelegate <NSObject>

/**
 选择时间范围成功回调

 @param calendarViewController      calendarViewController
 @param startTime                   startTime
 @param endTime                     endTime
 */
- (void)calendarViewController:(ZJCalendarViewController *)calendarViewController
         userSelectedStartTime:(NSInteger)startTime
           userSelectedEndTime:(NSInteger)endTime;

@end

@interface ZJCalendarViewController : UIViewController

/**
 *  代理
 */
@property (nonatomic, weak) id<ZJCalendarViewControllerDelegate> delegate;

@end
