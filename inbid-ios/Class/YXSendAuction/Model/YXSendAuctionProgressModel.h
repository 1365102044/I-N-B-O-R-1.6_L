//
//  YXSendAuctionProgressModel.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXSendAuctionProgressModel : NSObject

/**
 图片上传进度
 */
@property (nonatomic, assign) CGFloat progress;

/**
 图片下标
 */
@property (nonatomic, assign) NSInteger imageIndex;

/**
 选中的图片
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 压缩后图片
 */
@property (nonatomic, strong) UIImage *compressImage;

/**
 上传成功的url
 */
@property (nonatomic, copy) NSString *successImageUrlString;

/**
 是否成功 YES.上传失败  NO.上传成功
 */
@property (nonatomic, assign, getter=isSuccess) BOOL successed;

@end
