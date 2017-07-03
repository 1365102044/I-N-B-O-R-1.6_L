//
//  UIImage+fixOrientation.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

/**
 给图片加方向

 @return 返回加方向参数的图片
 */
- (UIImage *)fixOrientation;

/**
 *  压缩图片
 *  image:将要压缩的图片   size：压缩后的尺寸
 */
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 将占位图片绘制在当前图片中央
 
 @param image           image 居中的logo图片
 @param size            size 当前需要施画的范围
 @param backgroundColor backgroundColor 背景画布颜色
 
 @return 绘制好的logo居中图片
 */
+ (UIImage *)drawImage:(UIImage*)image
                  size:(CGSize)size
       backgroundColor:(UIColor *)backgroundColor;

/**
 *  根据尺寸压缩图片
 *
 *  @param size 要压缩的尺寸
 *
 *  @return 压缩后的图片
 */
- (UIImage*)ex_originWithScaleToSize:(CGSize)size;

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image 要截取的图片
 *  @param rect 截取的范围
 *  @param scale 屏幕缩放因子范围1~3，UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale)配合使用，当图片按照固定尺寸重绘后，截取时，需要对应图片的缩放因子
 *  @return 截取后的图片
 */
- (UIImage *)ex_imageFromImage:(UIImage *)image
                        inRect:(CGRect)rect
                         scale:(CGFloat)scale;

@end
