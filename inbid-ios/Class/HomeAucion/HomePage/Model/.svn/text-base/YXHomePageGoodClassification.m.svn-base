//
//  YXHomePageGoodClassification.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomePageGoodClassification.h"

@implementation YXHomePageGoodClassification

- (void)setIcon:(NSString *)icon
{
    if (![icon isEqualToString:@"image"]) {
//        _icon = [NSString stringWithFormat:@"%@@13w_12h", [icon componentsSeparatedByString:@"?"].firstObject];
//        [self cacheImageWithURL:_icon];
        _icon = [NSString stringWithFormat:@"%@@13w", [icon componentsSeparatedByString:@"?"].firstObject];
        [self cacheImageWithURL:_icon];
    }
//    [self cacheImageWithURL:[icon componentsSeparatedByString:@"?"].firstObject];
//    _icon = [icon componentsSeparatedByString:@"?"].firstObject;
}

- (NSMutableArray *)goodListArray
{
    if (!_goodListArray) {
        _goodListArray = [NSMutableArray array];
    }
    return _goodListArray;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger: self.labelId forKey:@"labelId"];
    [aCoder encodeObject: self.name forKey:@"name"];
    [aCoder encodeObject: self.icon forKey:@"icon"];
    [aCoder encodeInteger: self.isSelect forKey:@"isSelect"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{   
    self.labelId = [aDecoder decodeIntegerForKey: @"labelId"];
    self.name = [aDecoder decodeObjectForKey: @"name"];
    self.icon = [aDecoder decodeObjectForKey:@"icon"];
    self.isSelect = [aDecoder decodeIntegerForKey:@"isSelect"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%zd, %@, %@, %zd", _labelId, _name, _icon, _isSelect];
}

//** 缓存图片 */
- (void)cacheImageWithURL:(NSString *)url
{
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        
//    }];
}

@end
