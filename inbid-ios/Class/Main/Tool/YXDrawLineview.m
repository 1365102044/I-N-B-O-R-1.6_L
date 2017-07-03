//
//  YXDrawLineview.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXDrawLineview.h"

@implementation YXDrawLineview


-(void)setDrawlineviewOrgin:(CGPoint)orginpoint movetoPoint:(CGPoint)movetopoint color:(UIColor*)color
{

    [color set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 1;
    [path1 moveToPoint:orginpoint];
    [path1 addLineToPoint:movetopoint];
    [path1 stroke];

}
@end
