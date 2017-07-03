//
//  YXHomeDeatilModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeDeatilModle.h"
#import "YXHomeDeatilBidRecordVosListModle.h"

@implementation YXHomeDeatilModle

/*
 @brief 图片
 */
- (void)setProdImgs:(NSArray *)prodImgs
{
    _prodImgs = prodImgs;
    
    [YXHomeDeatilModle mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"prodImgs" : @"YXHomeDeatilImgesModle"};
        
    }];

    
}

/*
 @brief 属性
 */
-(void)setProdProps:(NSArray *)prodProps
{
    _prodProps = prodProps;
    
    [YXHomeDeatilModle mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"prodProps" : @"YXHomeDeatilShuxingModle"};
        
    }];

    
}

/*
 @brief 出价记录
 */
-(void)setBidRecordVos:(NSArray *)bidRecordVos
{
    _bidRecordVos = bidRecordVos;
    
    [YXHomeDeatilModle mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"bidRecordVos" : @"YXHomeDeatilBidRecordVosListModle"};
        
    }];

}

+(NSDictionary *)mj_objectClassInArray
{
    
    return @{@"prodImgs" : @"YXHomeDeatilImgesModle",
             @"prodProps" : @"YXHomeDeatilShuxingModle",
             @"bidRecordVos" : @"YXHomeDeatilBidRecordVosListModle"};

}



- (NSString *)description
{
    return [NSString stringWithFormat:@"prodImgs---%@", _prodImgs];
}


@end
