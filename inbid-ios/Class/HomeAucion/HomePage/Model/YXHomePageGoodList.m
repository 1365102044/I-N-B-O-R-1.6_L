//
//  YXHomePageGoodList.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomePageGoodList.h"
#import "NSDate+YXExtension.h"
#import "UIImage+fixOrientation.h"
#import <SDWebImageManager.h>

@implementation YXHomePageGoodList

#pragma mark Zero.Const

CGFloat spacing     = 15.f;
CGFloat margin      = 15.f;


- (void)setProdBrandName:(NSString *)prodBrandName
{
    _prodBrandName = prodBrandName;
}

- (void)setImgUrl:(NSString *)imgUrl
{

    NSRange widthStartRange = [imgUrl rangeOfString:@"w="];
    NSRange endRange = [imgUrl rangeOfString:@"&"];
    NSRange widthRange = NSMakeRange(widthStartRange.location + widthStartRange.length, endRange.location - widthStartRange.location - widthStartRange.length);
    NSString *width = [imgUrl substringWithRange:widthRange];
    
    

    NSRange heightStartRange = [imgUrl rangeOfString:@"h="];
    NSRange heightEndRange = [imgUrl rangeOfString:@"&s"];
    NSRange heightRange = NSMakeRange(heightStartRange.location + heightStartRange.length, heightEndRange.location - heightStartRange.location - heightStartRange.length);
    NSString *height = [imgUrl substringWithRange:heightRange];
    

    self.imageWidth = width.integerValue;
    self.imageHeight = height.integerValue;
    
    //_imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_270", [imgUrl componentsSeparatedByString:@"?"].firstObject];
    _imgUrl = [imgUrl componentsSeparatedByString:@"?"].firstObject;
//    _imgUrl = imgUrl;
    //根据url缓存图片
//    [self cacheImageWithURL:_imgUrl];
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

//- (NSInteger)bidStatus
//{
//    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
//    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
//    NSInteger nowtime = [currentTimeStr integerValue];
//    
//    double endtime = [NSDate changeTimeToTimeSp:_endTime];
//    double startTime = [NSDate changeTimeToTimeSp:_startTime];
//    
//    //** 未开始 */
//    if (startTime > nowtime) return 1;
//    
//    //** 进行中 */
//    if (startTime <= nowtime && endtime >= nowtime) return 2;
//    
//    //** 已结束 */
//    if (endtime <= nowtime) return 3;
//    
//    return -1;
//}

- (NSTimeInterval)surplusBidTime
{
    if (!_surplusBidTime) {
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *now;
        if (self.bidStatus == 1) {
            now = [dateformatter dateFromString:self.startTime];
        }else if (self.bidStatus == 2) {
            now = [dateformatter dateFromString:self.endTime];
        }else{
            now = [dateformatter dateFromString:self.endTime];
        }
        //        NSDate *now = [dateformatter dateFromString:@"2016-09-28 16:06:40"];
        _surplusBidTime = [now timeIntervalSinceNow];
        
    }
    return _surplusBidTime;
}

- (UIImage *)placeHolderImage
{
    if (!_placeHolderImage) {
        _placeHolderImage = [UIImage drawImage:[UIImage imageNamed:@"ic_zhanwf"] size:CGSizeMake(_imageWidth, _imageHeight) backgroundColor:[UIColor whiteColor]];
    }
    return _placeHolderImage;
}


- (CGFloat)goodNameTextHeight
{
    if (!_goodNameTextHeight) {
        _goodNameTextHeight = [self getTextHeightWithString:self.prodName
                                                    andFont:YXRegularfont(12.f)];
    }
    return _goodNameTextHeight;
}

/**
 *  文字的内容、字体大小 计算文字所占的尺寸
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *
 *  @return 文字所占的高
 */
- (CGFloat)getTextHeightWithString:(NSString *)text
                  andFont:(UIFont *)font
{
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 2 * spacing - margin) / 2 - 14;
    CGSize size = [self ex_sizeWithText:text
                                andFont:font
                             andMaxSize:CGSizeMake(w, CGFLOAT_MAX)];
    return size.height;
}

/**
 *  根据文字的内容、字体大小、最大尺寸范围 计算文字所占的尺寸
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *  @param maxSize 最大尺寸范围
 *
 *  @return 文字所占的尺寸
 */
- (CGSize)ex_sizeWithText:(NSString *)text
                  andFont:(UIFont *)font
               andMaxSize:(CGSize)maxSize
{
    CGSize expectedLabelSize                    = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle     = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode                = NSLineBreakByWordWrapping;
    [paragraphStyle setLineSpacing:0];
    NSDictionary *attributes                    = @{NSFontAttributeName:font,
                                                    NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    expectedLabelSize                           = [text boundingRectWithSize:maxSize
                                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                  attributes:attributes
                                                                     context:nil].size;
    
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

//- (CGFloat)getTextHeightWithString:(NSString *)string
//                          fontSize:(CGFloat)fontSize
//{
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    UIFont *font = [UIFont systemFontOfSize:fontSize];
//    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
//    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
//    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 2 * spacing - margin) / 2 - 14;
//    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(w - 8, CGFLOAT_MAX) options:options context:nil];
//    return rect.size.height;
//}

@end
