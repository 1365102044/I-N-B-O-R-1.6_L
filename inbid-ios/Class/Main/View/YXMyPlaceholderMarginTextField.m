//
//  YXMyPlaceholderMarginTextField.m
//  
//
//  Created by 胤讯测试 on 16/10/27.
//
//

#import "YXMyPlaceholderMarginTextField.h"

@implementation YXMyPlaceholderMarginTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
     
        
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *placeholderColor = UIColorFromRGB(0xaaa7a7);//设置颜色
    [placeholderColor setFill];
    
    CGRect placeholderRect = CGRectMake(rect.origin.x+10, (rect.size.height- 30)/2, rect.size.width, 30);//设置距离
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}


@end
