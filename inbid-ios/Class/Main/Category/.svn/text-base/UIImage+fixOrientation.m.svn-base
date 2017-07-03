//
//  UIImage+fixOrientation.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "UIImage+fixOrientation.h"

@implementation UIImage (fixOrientation)

- (UIImage *)fixOrientation {
    
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch(self.imageOrientation) {
            
            
            
        case UIImageOrientationDown:
            
            
            
        case UIImageOrientationDownMirrored:
            
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
        case UIImageOrientationLeft:
            
        case UIImageOrientationLeftMirrored:
            
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            
            transform = CGAffineTransformRotate(transform, M_PI_2);
            
            break;
            
        case UIImageOrientationRight:
            
        case UIImageOrientationRightMirrored:
            
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            
            break;
            
        case UIImageOrientationUp:
            
        case UIImageOrientationUpMirrored:
            
            break;
            
    }
    
    
    
    switch
    
    (self.imageOrientation) {
            
        case UIImageOrientationUpMirrored:
            
        case UIImageOrientationDownMirrored:
            
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            
            transform = CGAffineTransformScale(transform, -1, 1);
            
            break;
            
        case UIImageOrientationLeftMirrored:
            
        case UIImageOrientationRightMirrored:
            
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationUp:
            
        case UIImageOrientationDown:
            
            case UIImageOrientationLeft:
            
        case UIImageOrientationRight:
            
            break;
            
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             
                                             CGImageGetBitsPerComponent(self.CGImage), 0,                                   
                                             
                                             CGImageGetColorSpace(self.CGImage),
                                             
                                             CGImageGetBitmapInfo(self.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    
    switch (self.imageOrientation) {
            
        case UIImageOrientationLeft:  
            
        case UIImageOrientationLeftMirrored:
            
        case UIImageOrientationRight:
            
        case UIImageOrientationRightMirrored:  
            
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            
            break;   
            
        default: 
            
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            
            break;
            
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    
    CGContextRelease(ctx);
    
    CGImageRelease(cgimg);
    
    return img;
    
}

/**
 *  压缩图片
 *  image:将要压缩的图片   size：压缩后的尺寸
 */
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

/**
 将占位图片绘制在当前图片中央
 
 @param image           image 居中的logo图片
 @param size            size 当前需要施画的范围
 @param backgroundColor backgroundColor 背景画布颜色
 
 @return 绘制好的logo居中图片
 */
+ (UIImage *)drawImage:(UIImage*)image
                  size:(CGSize)size
       backgroundColor:(UIColor *)backgroundColor
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [backgroundColor set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    CGFloat imageX = (size.width / 2) - (image.size.width / 2);
    CGFloat imageY = (size.height / 2) - (image.size.height / 2);
    [image drawInRect:CGRectMake(imageX, imageY, image.size.width, image.size.height)];
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

/**
 *  根据尺寸压缩图片
 *
 *  @param size 要压缩的尺寸
 *
 *  @return 压缩后的图片
 */
- (UIImage*)ex_originWithScaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage                    = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

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
                         scale:(CGFloat)scale
{
    CGImageRef sourceImageRef               = [image CGImage];
    CGRect currentImageReact                = CGRectMake(rect.origin.x * scale,
                                                         rect.origin.y * scale,
                                                         rect.size.width * scale,
                                                         rect.size.height * scale);
    CGImageRef newImageRef                  = CGImageCreateWithImageInRect(sourceImageRef,
                                                                           currentImageReact);
    UIImage *newImage                       = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

@end
