//
//  YXApplyRefundSultModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApplyRefundSultModle.h"

@implementation YXApplyRefundSultModle
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"refundId":@"id"
             };
}

-(NSString *)MyRefundStatus
{
    if (self.refundStatus==1) {
        
        return @"处理中";
    }else if (self.refundStatus ==2){
    
        return @"处理中";
    }else if (self.refundStatus ==3){
        
        return @"退款成功";
    }else if (self.refundStatus ==4){
        
        return @"退款驳回";
    }
    
    return nil;
}

@end
