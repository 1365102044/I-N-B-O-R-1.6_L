//
//  YXLoginStatusTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/24.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXLoginStatusTool : NSObject

+(instancetype)sharedLoginStatus;

/**
 *  保存tokenId
 *
 *  @param tokenId tokenId
 *  @return 是否保存成功
 */
- (BOOL)setTokenId:(NSString *)tokenId;

/**
 *  获取tokenId
 *
 *  @return tokenId
 */
- (NSString *)getTokenId;

/**
 *  删除tokenId
 */
- (BOOL)removeTokenId;

/**
 YES  有token NO  没有Token
 */
-(BOOL)GetCureentLoginStatus;

@end
