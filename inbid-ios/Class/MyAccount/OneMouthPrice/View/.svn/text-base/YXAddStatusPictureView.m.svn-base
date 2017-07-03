//
//  YXAddStatusPictureView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAddStatusPictureView.h"
#import "YXTimeCountDownManger.h"

@interface YXAddStatusPictureView ()

@property(nonatomic,strong) UILabel * statuslable;

@end
@implementation YXAddStatusPictureView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = self.height/2;
        self.layer.masksToBounds = YES;
        
        UIView *backview = [[UIView alloc]initWithFrame:self.bounds];
        backview.backgroundColor = [UIColor blackColor];
        backview.alpha = 0.45;
        [self addSubview:backview];
        
        self.statuslable = [[UILabel alloc]initWithFrame:self.bounds];
        self.statuslable.textColor = [UIColor whiteColor];
        self.statuslable.font = YXSFont(15);
        self.statuslable.textAlignment = NSTextAlignmentCenter;
        self.statuslable.numberOfLines = 0;
        [self addSubview:self.statuslable];
        
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotificationonemouthprice1) name:KCountDownNotiWithPictureStatus object:nil];
        self.alpha = 0;
    }
    return self;
}
-(void)setEndstatus:(NSString *)endstatus
{
    self.alpha = 1;
    _endstatus = endstatus;
    
    self.statuslable.text = endstatus;

    [YXNotificationTool removeObserver:self name:KCountDownNotiWithPictureStatus object:nil];
    
}
-(void)setEndtimestr:(NSString *)endtimestr
{
    self.alpha = 1;
    _endtimestr = endtimestr;
    
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    long long  currentime = [currentTimeStr longLongValue];
    
    long long endtime = [self.endtimestr longLongValue]/1000;
    
    /// 计算倒计时
    long long countDown = endtime - currentime;
    NSString *str = [NSString stringWithFormat:@"%02lld:%02lld:%02lld", countDown/3600, (countDown/60)%60, countDown%60];
    NSString *status = [NSString stringWithFormat:@"付款中 \n %@",str];
    
    self.statuslable.text = status;
}

-(void)countDownNotificationonemouthprice1
{
    
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    long long  currentime = [currentTimeStr longLongValue];
    
   long long endtime = [self.endtimestr longLongValue]/1000;
    
    /// 计算倒计时
    long long countDown = endtime - currentime;

    NSString *str = [NSString stringWithFormat:@"%02lld:%02lld:%02lld", countDown/3600, (countDown/60)%60, countDown%60];
    NSString *status = [NSString stringWithFormat:@"付款中 \n %@",str];

    self.statuslable.text = status;

    
}

@end
