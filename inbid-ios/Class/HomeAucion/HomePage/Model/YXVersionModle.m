//
//  YXVersionModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/6.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXVersionModle.h"

@implementation YXVersionModle

- (NSString *)currentPatchVersion
{
    if (!_currentPatchVersion) {
        _currentPatchVersion = [YXUserDefaults objectForKey:@"currentPatchVersion"];
    }
    return _currentPatchVersion;
}

@end
