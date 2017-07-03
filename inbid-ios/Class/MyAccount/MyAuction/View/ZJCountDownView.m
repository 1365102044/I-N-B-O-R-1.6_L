//
//  ZJCountDownView.m
//  countDownDemo
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 郑键. All rights reserved.
//

#import "ZJCountDownView.h"

@interface ZJCountDownView () 

//** 倒计时定时器 */
@property (nonatomic, strong) NSTimer *countDownTimer;

//** timeLabel */
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ZJCountDownView


#pragma amrk - 赋值

- (void)setLeftTime:(NSString *)leftTime
{
    _leftTime = leftTime;
    
    self.timeLabel.text = leftTime;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        //** 40--圆的宽高 */
        UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.bounds.size.width / 2 - 20, self.bounds.size.height / 2 - 20, 40, 40) cornerRadius:20.5];
        //先画一个圆
        CAShapeLayer *layer=[CAShapeLayer layer];
        layer.path=beizPath.CGPath;
        layer.fillColor=[UIColor whiteColor].CGColor;//填充色
        layer.strokeColor=[UIColor colorWithRed:156.0/255.0 green:127.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor;//边框颜色
        layer.lineWidth=1.0f;
        layer.lineCap=kCALineCapRound;//线框类型
        [self.layer addSublayer:layer];
        
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"倒计时";
        titleLabel.font = [UIFont systemFontOfSize:7.5];
        titleLabel.textColor = [UIColor colorWithRed:156.0/255.0 green:127.0/255.0 blue:88.0/255.0 alpha:1.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(self.bounds.size.width / 2 - 12, self.bounds.size.height / 2 - 7.5, 24, 7.5);
        [self addSubview:titleLabel];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"已结束";
        timeLabel.font = [UIFont systemFontOfSize:7.5];
        timeLabel.textColor = [UIColor colorWithRed:156.0/255.0 green:127.0/255.0 blue:88.0/255.0 alpha:1.0];
        timeLabel.frame = CGRectMake(self.bounds.size.width / 2 - 12, self.bounds.size.height / 2 + 5.5, 24, 7.5);
        _timeLabel = timeLabel;
        [self addSubview:timeLabel];
        
    }
    return self;
}

@end
