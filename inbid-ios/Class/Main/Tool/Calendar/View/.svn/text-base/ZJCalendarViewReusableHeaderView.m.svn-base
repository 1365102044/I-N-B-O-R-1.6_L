//
//  ZJCalendarViewReusableHeaderView.m
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import "ZJCalendarViewReusableHeaderView.h"
#import "ZJCalendarMonthModel.h"

@interface ZJCalendarViewReusableHeaderView()

/**
 tileLabel
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZJCalendarViewReusableHeaderView

#pragma mark - Setter

- (void)setMonthModel:(ZJCalendarMonthModel *)monthModel
{
    _monthModel = monthModel;
    
    self.titleLabel.text = monthModel.title;
}

#pragma mark - LifeCycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer *layer                                 = [[CAShapeLayer alloc] init];
    UIBezierPath *path                                  = [UIBezierPath bezierPathWithRect: CGRectMake(0,
                                                                                                       0,
                                                                                                       YXScreenW,
                                                                                                       1)];
    layer.path                                          = path.CGPath;
    layer.fillColor                                     = [UIColor themGrayColor].CGColor;
    [self.titleLabel.layer addSublayer:layer];
}

@end
