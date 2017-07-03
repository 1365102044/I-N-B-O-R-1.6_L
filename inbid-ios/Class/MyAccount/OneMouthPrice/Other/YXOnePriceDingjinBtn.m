//
//  YXOnePriceDingjinBtn.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOnePriceDingjinBtn.h"

@interface YXOnePriceDingjinBtn ()
{
    UILabel *titlelable;
    UILabel *desclable;
}

@end
@implementation YXOnePriceDingjinBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
 
        titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height*2/3)];
        titlelable.textColor = [UIColor whiteColor];
        titlelable.font = YXSFont(12);
        titlelable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titlelable];
        
        desclable = [[UILabel alloc]initWithFrame:CGRectMake(0, titlelable.height-4, self.width, self.height/3)];
        desclable.textColor = [UIColor whiteColor];
        desclable.textAlignment = NSTextAlignmentCenter;
        desclable.font = YXRegularfont(9);
        [self addSubview:desclable];
        
    }
    return self;
}

-(void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    NSInteger price = [titleText integerValue]/100;
    NSString *pricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)price]];
    NSString *attr = [NSString stringWithFormat:@"先付定金 ￥%@",pricestr];
    if(attr.length==0)
    {
        return;
    }
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:attr];
    [attrStr addAttribute:NSFontAttributeName value:YXSFont(13) range:NSMakeRange(0, 4)];
    [attrStr addAttribute:NSFontAttributeName value:YXSFont(15) range:NSMakeRange(4, attrStr.length-4)];
    titlelable.attributedText = attrStr;

}
-(void)setDescText:(NSString *)descText
{
    _descText = descText;
    desclable.text = descText;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    titlelable.frame = CGRectMake(0, 0, self.width, self.height*2/3);
    desclable.frame = CGRectMake(0, titlelable.height-4, self.width, self.height/3);
    
}

@end
