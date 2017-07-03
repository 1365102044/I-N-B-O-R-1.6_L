//
//  YXPayHistroyModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayHistroyModle.h"

@implementation YXPayHistroyModle
-(NSString *)MypayType
{
    
    if (self.payType==1) {
        
        return @"PC网银";
    }else if (self.payType==2){
    
        return @"微信";
    }else if (self.payType ==3){
        
        return @"支付宝";
    }else if (self.payType ==4){
        
        return @"Apply Pay";
    }else if (self.payType ==5){
        
        return @"银行卡";
    }else if (self.payType ==6){
        
        return @"";
    }else if (self.payType == 8)
    {
        return @"银行卡";
    }
    return nil;
}

-(NSString *)MyPayMoneyType
{
    if (self.isDepositPay==1) {
        
        return @"定金";
    }else{
        if (self.isPartPay==1) {
            
            return @"分笔";
        }else{
            return @"全额";
        }
    }

    return nil;
}


-(NSString *)MyPayStatus
{
    if (self.payStatus ==0) {
        
        return @"未支付";
    }else if (self.payStatus ==1){
        
        return @"支付中";
    }else if (self.payStatus ==2){
        
        return @"支付成功";
    }else if (self.payStatus ==3){
        
        return @"支付失败";
    }
    return nil;
}

@end
