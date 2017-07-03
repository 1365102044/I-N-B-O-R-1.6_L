//
//  YXStringFilterTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXStringFilterTool : NSObject

/**
 注册密码

 @param pwords          pwords
 @return                是否符合密码规则
 */
+(BOOL)filterByResginPwordsNumber:(NSString *)pwords;

/**
 重置密码验证&修改登录密码

 @param newPwd          newPwd
 @return                是否符合密码规则
 */
+ (BOOL)checkResetPwd:(NSString *)newPwd;

/**
 手机正则匹配

 @param phone           电话号码
 @return                是否是手机号
 */
+ (BOOL)filterByPhoneNumber:(NSString *)phone;

/**
 验证邮箱号

 @param mailNumber      用户输入邮箱
 @return                是否是邮箱号码
 */
+ (BOOL)filterByMailNumber:(NSString *)mailNumber;

/**
 注册昵称

 @param nickname        用户输入昵称
 @return                昵称匹配结果
 */
+ (BOOL)filterByReginsterNickName:(NSString *)nickname;

//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString;

//**身份证号码**/
+(BOOL)filterCheckIDCard:(NSString *)IDCard;

//**中文**/
+(BOOL)filterCheckChines:(NSString *)namestr;

//**银行卡**/
//+(BOOL)IsBankCard:(NSString *)cardNumber;

//**银行卡**/
+(BOOL)CheckBankCard:(NSString *)cardID;

/*
 @brief 设置支付密码
 */
+(BOOL)CheckPaymentPassword:(NSString *)paypassword;



//** -------对手机号判断 -----------**/
+(BOOL)checkInput:(NSString *)textString andsupview:(UIView *)supview;
/*
 @brief 当前毫秒值
 */
+ (NSString *)getTimeNow;

//把字符串替换成星号
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;

/*
 @brief 去掉字符串中的标签 
 */
+(NSString *)filterHTML:(NSString *)html;

/*
 @brief 金额 逗号 分割
 */
+(NSString*)strmethodComma:(NSString*)string;
/*
 @brief 后台时间戳转化成 时间的str
 */
//	createTime = 1476958289000,
+(NSString *)transformfromenumbertoTiemstr:(long long )timenumber;

/*
 @brief 字典转字符串
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 对textfiled 的字符串长度 限制
 */
-(void)limitTextFiledEditChange:(UITextField *)textField LimitNumber:(NSInteger)Number;


/**
 打电话 默认是 客服电话
 */
+(void)YXCallPhoneWith:(UIView*)backview;

/**
 显示金额 接受“分” 传出 “￥元”
 */
+(NSString *)formFenTransformaYuanWith:(NSString *)Fenstr;

@end
