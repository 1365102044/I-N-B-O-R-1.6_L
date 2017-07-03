//
//  UIColor+YXColor_Extension.m
//  Carousel for external development
//
//  Created by 郑键 on 16/8/19.
//  Copyright © 2016年 郑键. All rights reserved.
//

#import "UIColor+YXColor_Extension.h"

@implementation UIColor (YXColor_Extension)



#pragma mark - 测试用随机色

//** 随机色函数 */
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/**
 系统主题主色彩
 */
+ (UIColor *)mainThemColor
{
    return YXColor(25.0, 10.0, 11.0);
}

+ (UIColor *)themGrayColor
{
    return YXColor(229.0, 229.0, 229.0);
}

+ (UIColor *)themLightGrayColor
{
    return YXColor(249.0, 249.0, 249.0);
}

+ (UIColor *)themGoldColor
{
    return YXColor(169.0, 3.0, 17.0);
}

+ (UIColor *)themBlueColor
{
    return YXColor(125.0, 173.0, 234.0);
}



/**
 f6cb01
 
 @return return 发布黄色
 */
+ (UIColor *)sendAuctionThemColor
{
    return YXColor(246.0, 203.0, 1.0);
}

/**
 未选中文字颜色
 
 @return #050505
 */
+ (UIColor *)normalTextColor
{
    return YXColor(5.0, 5.0, 5.0);
}

/**
 订单步骤未选中背景色
 
 @return #bbbbbb
 */
+ (UIColor *)orderStepNormalColor
{
    return YXColor(187.0, 187.0, 187.0);
}

/**
 订单文字颜色
 
 @return #262626
 */
+ (UIColor *)orderTextColor
{
    return YXColor(38.0, 38.0, 38.0);
}

/**
 订单单价虚化文字颜色#939393
 
 @return #939393
 */
+ (UIColor *)orderUnitPriceTextColor
{
    return YXColor(147.0, 147.0, 147.0);
}

/**
 确认分笔支付虚化文字颜色#8d8d8d
 
 @return #8d8d8d
 */
+ (UIColor *)surePaymentLightGrayTextColor
{
    return YXColor(141.0, 141.0, 141.0);
}

/**
 钱包的黑色字
 
 @return #333333
 */
+ (UIColor *)walletTextColor
{
    return YXColor(51.f, 51.f, 51.f);
}

/**
 系统淡蓝色按钮颜色
 
 @return #108ee9
 */
+ (UIColor *)systemButtonTextColor
{
    return YXColor(16.f, 142.f, 233.f);
}

/**
 钱包的浅色字
 
 @return #999999
 */
+ (UIColor *)walletTextLightColor
{
    return YXColor(153.f, 153.f, 153.f);
}

/**
 钱包信用卡禁止点击的颜色
 
 @return #f8f8f8
 */
+ (UIColor *)walletBankCardDisableColor
{
    return YXColor(248.f, 248.f, 248.f);
}

@end
