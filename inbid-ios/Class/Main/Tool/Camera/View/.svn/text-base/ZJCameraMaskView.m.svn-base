//
//  ZJCameraMaskView.m
//  Project
//
//  Created by 郑键 on 17/3/2.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "ZJCameraMaskView.h"

@interface ZJCameraMaskView()

@end

@implementation ZJCameraMaskView

+ (instancetype)maskViewWithFrame:(CGRect)frame
                         cropRect:(CGRect)cropRect {
    
    ZJCameraMaskView *maskView              = [[self alloc] initWithFrame:frame];
    maskView.backgroundColor                = [UIColor clearColor];
    maskView.cropRect                       = cropRect;
    return maskView;
}

- (void)setCropRect:(CGRect)cropRect
{
    _cropRect = cropRect;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0.0 alpha:0.4] setFill];
    CGContextFillRect(ctx, rect);
    CGContextClearRect(ctx, self.cropRect);
    [[UIColor colorWithWhite:0.95 alpha:1.0] setStroke];
    CGContextStrokeRectWithWidth(ctx, CGRectInset(_cropRect, 1, 1), 1);
}

@end
