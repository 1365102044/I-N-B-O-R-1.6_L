//
//  YXSaveLoginDataTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/5.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXSaveLoginDataTool : NSObject

+(instancetype)shared;

/**
   手机号为明文
*/
-(void)SaveLoginDataWithObjc:(id)objc responseheaderID:(NSString *)responseheaderID phone:(NSString *)phone;
    /**
     退出账户 清除数据
     */
-(void)loginOutClearUserData;


/*
 @brief 保存为登陆的状态下的 浏览记录
 
 */
-(void)saveMyBrowsRecordWith:(NSString *)prodBidId;

/*
 @brief 取浏览记录 数据
 */
-(NSString *)ReadMyBrowsRecord;



/*
 @brief 清空记录
 
 */
-(void)RemoveAllMyBrowsRecordData;


/**
 存 数据
 */
-(void )SaveMyDataWithKey:(NSString *)Key Info:(NSString *)info;
/**
 取信息
 */
-(NSString *)GetMyDataWithKey:(NSString *)Key;

/**
 获取真实姓名
 */
- (NSString *)getRealName;

@end
