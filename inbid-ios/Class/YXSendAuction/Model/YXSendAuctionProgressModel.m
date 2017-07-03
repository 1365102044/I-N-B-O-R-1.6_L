//
//  YXSendAuctionProgressModel.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionProgressModel.h"

@implementation YXSendAuctionProgressModel

/**
 进度值赋值

 @param progress progress
 */
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //** 通知 */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadImageProgressNotification" object:nil userInfo:nil];
    });
}

/**
 上传图片是否成功

 @param successed successed
 */
- (void)setSuccessed:(BOOL)successed
{
    _successed = successed;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //** 通知 */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadImageFaildNotification" object:nil userInfo:nil];
    });
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"progress:%f\nimageIndex:%zd\nselectedImage:%@\n", _progress, _imageIndex, _selectedImage];
}

@end
