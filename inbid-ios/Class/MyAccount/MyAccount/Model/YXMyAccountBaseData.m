//
//  YXMyAccountBaseData.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountBaseData.h"

@implementation YXMyAccountBaseData

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"vipId" : @"id",
             };
}

- (void)setCardStatus:(NSInteger)cardStatus
{
    _cardStatus = cardStatus;
}

- (void)setEmail:(NSString *)email
{
    _email = email;
    
    [YXUserDefaults setObject:email forKey:@"email"];
}

-(void)setHead:(NSString *)head
{
    if([head componentsSeparatedByString:@"?"].count>1)
    {
        _head = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [head componentsSeparatedByString:@"?"].firstObject];
    }else{
        
        _head = head;
    }
    
}

@end
