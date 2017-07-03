//
//  ZJCalendarViewDayCell.m
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import "ZJCalendarViewDayCell.h"
#import "ZJCalendarDayModel.h"

@interface ZJCalendarViewDayCell()

/**
 *  日期展示Label
 */
@property (weak, nonatomic) IBOutlet UILabel *dayTextLabel;

/**
 bgView
 */
@property (nonatomic, strong) UIView *myBackgorundView;

@end

@implementation ZJCalendarViewDayCell

#pragma mark - Setter

- (void)setDayModel:(ZJCalendarDayModel *)dayModel
{
    _dayModel = dayModel;

    /**
     *  过滤每月开头日期
     */
    if(dayModel.day > 0) {
        self.dayTextLabel.text = [NSString stringWithFormat:@"%ld",(long)dayModel.day];
    }else{
        self.dayTextLabel.text = @" ";
    }
    
    /**
     *  根据日期类型做不同的显示
     */
    if (dayModel.dayStatus == 1) {
        self.myBackgorundView.backgroundColor = [UIColor mainThemColor];
        self.dayTextLabel.textColor = [UIColor whiteColor];
    } else if (dayModel.dayStatus == 2) {
        self.myBackgorundView.backgroundColor = YXColor(146.f, 135.f, 136.f);
        self.dayTextLabel.textColor = [UIColor mainThemColor];
    } else if (dayModel.dayStatus == 3) {
        self.myBackgorundView.backgroundColor = [UIColor mainThemColor];
        self.dayTextLabel.textColor = [UIColor whiteColor];
    } else {
        self.myBackgorundView.backgroundColor = [UIColor whiteColor];
        self.dayTextLabel.textColor = [UIColor blackColor];
    }
}

#pragma mark - LifeCycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = self.myBackgorundView;
    
}

#pragma mark - LazyLoad

- (UIView *)myBackgorundView
{
    if (!_myBackgorundView) {
        _myBackgorundView = [[UIView alloc] initWithFrame:CGRectMake(-4, -4, self.width + 4, self.height + 4)];
        _myBackgorundView.backgroundColor = [UIColor whiteColor];
    }
    return _myBackgorundView;
}

@end
