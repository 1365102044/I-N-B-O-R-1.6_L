//
//  NSString+File.m

//
//  Created by 👄 on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+File.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (File)

/**
 四舍五入

 @param price    数字
 @param position 保留位数

 @return 返回四舍五入字符串
 */
+ (NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

- (float) heightWithFont: (UIFont *) font withinWidth: (float) width
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return ceil(textRect.size.height);
}

- (float) widthWithFont: (UIFont *) font
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect.size.width;
}

- (long long)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 1.路径不存在就返回
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (fileExists == NO) return 0;
    
    // 2.判断路径是不是文件夹
    if (isDirectory) { // 是
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize];
        }
        return totalSize;
    } else { // 不是
        // 计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

/**
 *  md5
 *
 *  @return md5后的字符串
 */
- (NSString *)ex_md5String
{
    const char *str                 = self.UTF8String;
    int length                      = (int)strlen(str);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, length, bytes);
    return [self ex_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)ex_stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

@end
