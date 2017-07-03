//
//  YXNewsEnsureNotiListModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsEnsureNotiListModle.h"

@implementation YXNewsEnsureNotiListModle
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"MyId" : @"id",
             };
}
-(void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}

/*
 订单
 msg_type=101  订单下单成功
 msg_type=102  订单下单未支付
 msg_type=103  订单分笔支付一次
 msg_type=104  订单分笔支付完成
 msg_type=105  订单全额支付完成
 msg_type=106  订单发货
 msg_type=107  订单收货成功
 msg_type=108  订单未支付超时取消
 msg_type=109  订单部分支付，超时未支付
 
 鉴定订单
 msg_type=301 代表鉴定订单未支付
 msg_type=302 代表鉴定订单已支付
 */
-(NSString *)MyOrderListStatus
{

    if (self.msgType == 101)
    {
        return  @"下单成功";
    }else if (self.msgType == 102)
    {
        return  @"待付款";
    }else if(self.msgType ==103){
        
        return  @"分笔支付中";
    }else if(self.msgType ==104){
        
        return  @"分笔支付成功";
    }else if(self.msgType ==105){
        
        return  @"全额支付成功";
    }else if(self.msgType ==106){
        
        return  @"已发货";
    }else if(self.msgType ==107){
        
        return @"已签收";
    }else if(self.msgType ==108){
        
        return @"订单已取消";
    }else if(self.msgType ==109){
        
        return @"订单已取消";
    }else if(self.msgType==301){
    
        return @"待付款";
    }else if(self.msgType==302){
       
        return @"已付款";
    }
    return nil;
}


@end
