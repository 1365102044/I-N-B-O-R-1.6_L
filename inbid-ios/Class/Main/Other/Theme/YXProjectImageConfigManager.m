//
//  YXProjectImageConfigManager.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/27.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXProjectImageConfigManager.h"

@implementation YXProjectImageConfigManager

/**
 配置项目使用不同图片
 
 @param imageUrlString              imageUrlString
 @param configType                  configType
 @return                            处理后的ImageURLString
 */
+ (NSString *)projectImageConfigManagerWithImageUrlString:(NSString *)imageUrlString
                                               configType:(YXProjectImageConfigType)configType
{
    NSString *imageTypeString;
    
    if (configType == YXProjectImageConfigNone) {
        imageTypeString = @"";
    }else if (configType == YXProjectImageConfigList) {
        imageTypeString = @"?x-oss-process=style/ss200";
    }else if (configType == YXProjectImageConfigMid) {
        imageTypeString = @"?x-oss-process=style/ah450";
    }else if (configType == YXProjectImageConfigMidSS) {
        imageTypeString = @"?x-oss-process=style/ss450";
    }else if (configType == YXProjectImageConfigLarge) {
        imageTypeString = @"?x-oss-process=style/ah1000";
    }
    
    return [NSString stringWithFormat:@"%@%@", imageUrlString, imageTypeString];
}

@end
