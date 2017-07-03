//
//  YXSaveLoginDataTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/5.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXSaveLoginDataTool.h"
#import "JPush.h"
#import "twlt_uuid_util.h"

static NSString *MYBROWSRECORDARR = @"MYBROWSRECORDARR";
@interface YXSaveLoginDataTool ()

@property (nonatomic, strong) NSMutableArray * myrecordArr;
@end

@implementation YXSaveLoginDataTool

+(instancetype)shared
{
    static dispatch_once_t onceToken;
    static YXSaveLoginDataTool *instance ;
    dispatch_once(&onceToken, ^{
        instance = [[YXSaveLoginDataTool alloc]init];
        
    });
    return instance;
    
}

-(void)SaveLoginDataWithObjc:(id)objc responseheaderID:(NSString *)responseheaderID phone:(NSString *)phone
{
    if ([objc isKindOfClass:[NSNull class]]|| objc == nil) {
        
        return ;
    }
    
    /*
  @brief 把 拼接后的token
  */


    NSString *tokenID = [NSString stringWithFormat:@"%@%@", twlt_uuid_create(),responseheaderID];
    
    [[YXLoginStatusTool sharedLoginStatus] setTokenId:tokenID];
    
//    登录成功后 清空本地的足迹数据
    [self RemoveAllMyBrowsRecordData];
    
    /**
     * 手机
     */
    if (phone.length) {
        
        [YXUserDefaults setObject:phone forKey:@"PHONE"];
    }
    /**
     * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"validateStatus"]] forKey:@"validateStatus"];
    /**
     * 会员性别
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"sex"]] forKey:@"sex"];
    /**
     * 会员ID
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"id"]] forKey:@"userID"];
    /**
     * 昵称
     */
    [YXUserDefaults setObject:objc[@"nickname"] forKey:@"nickname"];
    /**
     * 头像
     */
    [YXUserDefaults setObject:objc[@"head"] forKey:@"head"];
    
    
    /**
     * 会员生日
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"birthday"]] forKey:@"birthday"];
    /**
     * 邮箱账号
     */
    [YXUserDefaults setObject:objc[@"email"] forKey:@"email"];
    /**
     * 是否设置支付密码：设置为1，默认为0没有
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"isPaymentCode"]] forKey:@"isPaymentCode"];
    /**
     * 绑定银行卡 0未绑定 1表示绑定
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"cardStatus"]] forKey:@"cardStatus"];
    /**
     * 修改时间
     */
    [YXUserDefaults setObject:objc[@"updateTime"] forKey:@"updateTime"];
    
    /**
     保存用户头像 客服的时候使用
     */
     NSArray *arr = [(NSString *)[YXUserDefaults objectForKey:@"head"] componentsSeparatedByString:@"?"];
    UIImage *headimage = [UIImage imageNamed:@"ic_default"];
    NSData *headerimageData = UIImagePNGRepresentation(headimage);
    if (arr.count>1) {
        NSString *str = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100",arr[0]];
        headerimageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    }
    [YXUserDefaults setObject:headerimageData forKey:@"headimagedata"];
    
    NSString *userID = [NSString stringWithFormat:@"%@",objc[@"id"]];
    
    [JPush setAlias:userID];
    
    [YXUserDefaults synchronize];

    
    //** 登录成功发送通知 */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil userInfo:nil];
    /**
     扫码登录
     */
//    [YXNotificationTool postNotificationName:@"scancodeTologinformeLoginVC" object:nil userInfo:@{@"ISAlearlyLoginSuccess":@"YES"}];
    
    /**
     一口价商品详情，登录之后，直接触发对应的方法
     */
    [YXNotificationTool postNotificationName:@"OnemouthPriceGoodsDeatilVcWithClickfromeloginSel" object:nil userInfo:@{@"islogin":@"YES"}];
    
}

/**
 退出账户 清除数据
 */
-(void)loginOutClearUserData{
    
    //退出成功， 清除缓存
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isDefaultLayout"];
    
    //**退出登录 推送解绑**/
    [JPush setAlias:@""];
    /**
     * 手机
     */
    [YXUserDefaults removeObjectForKey:@"PHONE"];
    /**
     * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
     */
    [YXUserDefaults removeObjectForKey:@"validateStatus"];
    /**
     * 会员性别
     */
    [YXUserDefaults removeObjectForKey:@"sex"];
    /**
     * 会员ID
     */
    [YXUserDefaults removeObjectForKey:@"userID"];
    /**
     * 昵称
     */
    [YXUserDefaults removeObjectForKey:@"nickname"];
    /**
     * 头像
     */
    [YXUserDefaults removeObjectForKey:@"head"];
    /**
     * 会员生日
     */
    [YXUserDefaults removeObjectForKey:@"birthday"];
    /**
     * 邮箱账号
     */
    [YXUserDefaults removeObjectForKey:@"email"];
    /**
     * 是否设置支付密码：设置为1，默认为0没有
     */
    [YXUserDefaults removeObjectForKey:@"isPaymentCode"];
    /**
     * 绑定银行卡 0未绑定 1表示绑定
     */
    [YXUserDefaults removeObjectForKey:@"cardStatus"];
    /**
     * 修改时间
     */
    [YXUserDefaults removeObjectForKey:@"updateTime"];
    /**
     * 清除headerid
     */
    //[YXUserDefaults removeObjectForKey:@"TokenID"];
    [[YXLoginStatusTool sharedLoginStatus] removeTokenId];
    /**
     清除 头像Data
     */
    [YXUserDefaults removeObjectForKey:@"headimagedata"];
}


    
#pragma mark  *** 浏览记录
/*
 @brief 保存为登陆的状态下的 浏览记录
 
 */
-(void)saveMyBrowsRecordWith:(NSString *)prodBidId {
    
    
    if (prodBidId.length==0) {
        return;
    }
    
    self.myrecordArr  = [NSMutableArray arrayWithArray:[YXUserDefaults objectForKey:MYBROWSRECORDARR]];
    if (self.myrecordArr.count>=20) {
        
        [self.myrecordArr removeObjectAtIndex:0];
    }
    
    if ([self.myrecordArr containsObject:prodBidId]) {
        
        [self.myrecordArr removeObject:prodBidId];
    }
    [self.myrecordArr addObject:prodBidId];
    
    [YXUserDefaults setValue:self.myrecordArr forKey:MYBROWSRECORDARR];
    
}
    
/*
 @brief 取浏览记录 数据
 */
-(NSString *)ReadMyBrowsRecord{

    [self.myrecordArr removeAllObjects];
    self.myrecordArr  = [NSMutableArray arrayWithArray:[YXUserDefaults objectForKey:MYBROWSRECORDARR]];
    if (self.myrecordArr.count<1) {
        return nil;
    }
    NSString *prodBidsStr = self.myrecordArr[0];
    for (int i=0; i<self.myrecordArr.count-1; i++) {
        prodBidsStr = [NSString stringWithFormat:@"%@,%@",prodBidsStr,self.myrecordArr[i+1]];
    }
    return  prodBidsStr;
}
    
/*
 @brief 清空记录
 
 */
-(void)RemoveAllMyBrowsRecordData{
    
    [YXUserDefaults removeObjectForKey:MYBROWSRECORDARR];
}
    
    
-(NSMutableArray *)myrecordArr{
    if (!_myrecordArr) {
        _myrecordArr = [[NSMutableArray alloc]init];
    }
    return _myrecordArr;
}

/**
 存 数据
 */
-(void )SaveMyDataWithKey:(NSString *)Key Info:(NSString *)info{
    
    if (Key.length==0||Key==nil) {
        return ;
    }
    [YXUserDefaults setObject:info forKey:Key];
}
/**
 取信息
 */
-(NSString *)GetMyDataWithKey:(NSString *)Key{
    
    return [YXUserDefaults objectForKey:Key];
}

/**
 获取真实姓名
 */
- (NSString *)getRealName
{
    return [self GetMyDataWithKey:@"realName"];
}

@end
