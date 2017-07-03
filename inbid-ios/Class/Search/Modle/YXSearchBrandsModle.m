//
//  YXSearchBrandsModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchBrandsModle.h"

@interface YXSearchBrandsModle()<NSCoding>

@end

@implementation YXSearchBrandsModle


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.brandId forKey:@"brandId"];
    [aCoder encodeObject: [NSString stringWithFormat:@"%@@13w_12h", [self.prodBrandLogoUrl componentsSeparatedByString:@"?"].firstObject] forKey:@"prodBrandLogoUrl"];
    [aCoder encodeObject: self.prodBrandName forKey:@"prodBrandName"];
    [aCoder encodeObject: self.prodBidId forKey:@"prodBidId"];
    [aCoder encodeInteger: self.hasGoods forKey:@"hasGoods"];
    [aCoder encodeBool: self.isSelected forKey:@"isSelected"];


    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.brandId = [aDecoder decodeObjectForKey:@"brandId"];
    self.prodBrandLogoUrl = [aDecoder decodeObjectForKey:@"prodBrandLogoUrl"];
    self.prodBrandName = [aDecoder decodeObjectForKey:@"prodBrandName"];
    self.prodBidId = [aDecoder decodeObjectForKey:@"prodBidId"];
    self.hasGoods = [aDecoder decodeIntegerForKey:@"hasGoods"];
    self.isSelected = [aDecoder decodeBoolForKey:@"isSelected"];
    
    return self;
}

@end
