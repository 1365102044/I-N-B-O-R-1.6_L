//
//  ZJCalendarViewDayCell.h
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJCalendarDayModel;

@interface ZJCalendarViewDayCell : UICollectionViewCell

/**
 *  日期数据模型
 */
@property (nonatomic, strong) ZJCalendarDayModel *dayModel;

@end
