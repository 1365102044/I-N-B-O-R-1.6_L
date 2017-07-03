//
//  YXSearchModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchModle.h"

@interface YXSearchModle()<NSCoding>

@end

@implementation YXSearchModle

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             
             @"brands":[YXSearchBrandsModle class],
             
             };
    
    

}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger: self.catId forKey:@"catId"];
    [aCoder encodeObject: self.catName forKey:@"catName"];
    [aCoder encodeObject: self.brands forKey:@"brands"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%@@13w_12h", [self.iconPath componentsSeparatedByString:@"?"].firstObject] forKey:@"iconPath"];
    [aCoder encodeInteger: self.hasGoods forKey:@"hasGoods"];
    [aCoder encodeBool:self.isSelected forKey:@"isSelected"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.catId = [aDecoder decodeIntegerForKey: @"catId"];
    self.catName = [aDecoder decodeObjectForKey: @"catName"];
    self.brands = [aDecoder decodeObjectForKey:@"brands"];
    self.iconPath = [aDecoder decodeObjectForKey:@"iconPath"];
    self.hasGoods = [aDecoder decodeIntegerForKey:@"hasGoods"];
    self.isSelected = [aDecoder decodeBoolForKey:@"isSelected"];
    
    return self;
}


@end
