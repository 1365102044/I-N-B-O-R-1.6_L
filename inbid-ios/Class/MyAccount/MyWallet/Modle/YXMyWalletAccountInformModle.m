//
//  YXMyWalletAccountInformModle.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletAccountInformModle.h"

@implementation YXMyWalletAccountInformModle
/**
 * 用户状态：
 * 0  ：V0(待实名认证) 1：V1（完成信息认证） 2：V2（V1+证件认证）3：暂停
 * 4：注销 5：审核 6：登录锁定 7：待激活
 */
-(NSString *)stat_user{
    
    if ([_stat_user isEqualToString:@"0"]) {
        return @"V0 (待实名认证)";
    }else if ([_stat_user isEqualToString:@"1"]){
        return @"V1 (完成信息认证)";
    }else if ([_stat_user isEqualToString:@"2"]){
        return  @"V2 (V1+证件认证)";
    }
    return nil;
}


@end
