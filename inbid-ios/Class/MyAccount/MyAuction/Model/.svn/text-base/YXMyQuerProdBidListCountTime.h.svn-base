//
//  YXMyQuerProdBidListCountTime.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/28.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMyQuerProdBidListCountTime : NSObject

@property (nonatomic, strong) NSString       *m_titleStr;
@property (nonatomic)         long long       m_countNum;

/**
 *  便利构造器
 *
 *  @param title         标题
 *  @param countdownTime 倒计时
 *
 *  @return 实例对象
 */
+ (instancetype)timeModelWithTitle:(NSString*)title time:(long long)time;

/**
 *  计数减1(countdownTime - 1)
 */
- (void)countDown;

/**
 *  将当前的countdownTime信息转换成字符串
 */
- (NSString *)currentTimeString;

@end
