//
//  YXProjectImageConfigManager.h
//  inbid-ios
//
//  Created by 郑键 on 17/2/27.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 图片URL处理类型

 - YXProjectImageConfigNone:            YXProjectImageConfigNone    不处理
 - YXProjectImageConfigList:            YXProjectImageConfigList    列表使用小图
 - YXProjectImageConfigMid:             YXProjectImageConfigMid     中图
 - YXProjectImageConfigLarge:           YXProjectImageConfigLarge   大图，点击查看
 - YXProjectImageConfigMidSS:           YXProjectImageConfigMidSS   中图，方形轮播器展示
 */
typedef NS_ENUM(NSUInteger, YXProjectImageConfigType) {
    YXProjectImageConfigNone,
    YXProjectImageConfigList,
    YXProjectImageConfigMid,
    YXProjectImageConfigLarge,
    YXProjectImageConfigMidSS
};

@interface YXProjectImageConfigManager : NSObject

/**
 配置项目使用不同图片

 @param imageUrlString              imageUrlString
 @param configType                  configType
 @return                            处理后的ImageURLString
 */
+ (NSString *)projectImageConfigManagerWithImageUrlString:(NSString *)imageUrlString
                                               configType:(YXProjectImageConfigType)configType;

@end
