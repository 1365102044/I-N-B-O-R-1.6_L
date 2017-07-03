//
//  YXVersionModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/6.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXVersionModle : NSObject
/**
 isUpdate 1:不需要更新  2:需要更新
 */
@property(nonatomic,assign) NSInteger  isUpdate;

/**
 forceUpdate 是否强制更新:1=否,2=是
 */
@property(nonatomic,assign) NSInteger  forceUpdate;

/**
 appVersion 系统最新版本号
 */
@property(nonatomic,copy) NSString * appVersion;
/**
 更新内容
 */
@property(nonatomic,copy) NSString * updateDesc;
/**
 当前 版本号
 */
@property(nonatomic,copy) NSString * CurrenVersion;

/**
 补丁版本号
 */
@property (nonatomic, copy) NSString *patchVersion;

/**
 当前补丁版本号
 */
@property (nonatomic, copy) NSString *currentPatchVersion;

@end
