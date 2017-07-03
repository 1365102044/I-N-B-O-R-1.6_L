//
//  YXTimeCountDownManger.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXTimeCountDownManger.h"

#import "YXHomeAuctionDeatilProgressBarView.h"

@interface YXTimeCountDownManger ()

@property (nonatomic, strong) NSTimer *timer;



@end


@implementation YXTimeCountDownManger
+ (instancetype)manager {
    
    static YXTimeCountDownManger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXTimeCountDownManger alloc]init];
    });
    return manager;
}


-(void)stopTime
{
    [_timer invalidate];
    _timer = nil;
    
//    [YXNotificationTool removeObserver:self name:kCountDownNotification object:self];
//    [YXNotificationTool removeObserver:self];
    
    
}

- (void)start {
    // 启动定时器
    [self timer];
}

- (void)reload {
    // 刷新只要让时间差为0即可
    _timeInterval = 0;
}

- (void)timerAction {
    
    // 时间差+1
    self.timeInterval ++;
    // 发出通知--可以将时间差传递出去,或者直接通知类属性取
    [YXNotificationTool postNotificationName:kCountDownNotification object:nil userInfo:@{@"TimeInterval" : @(self.timeInterval)}];
    
    [YXNotificationTool postNotificationName:KCountDownNotiWithPictureStatus object:nil userInfo:@{@"TimeInterval":@(self.timeInterval)}];
    
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}


@end
