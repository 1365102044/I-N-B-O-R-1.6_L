//
//  YXAlearFormMyView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAlearFormMyView.h"

#import "UILabel+Extension.h"

@interface YXAlearFormMyView ()
{
    UILabel *alearviewlable;
}
@end
@implementation YXAlearFormMyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.frame = CGRectMake(YXScreenW*0.2, 60+64, YXScreenW*0.6, 30);
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        
        self.backgroundColor = [UIColor grayColor];
        
        alearviewlable = [[UILabel alloc]init];
        alearviewlable.text = self.alearstr;
        alearviewlable.textColor = [UIColor whiteColor];
        alearviewlable.font = YXRegularfont(14);
        alearviewlable.frame = self.bounds;
        alearviewlable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:alearviewlable];
        alearviewlable.numberOfLines = 0;
        
        
    }
    return self;
}
-(void)setAlearstr:(NSString *)alearstr
{
    /**
     防止 在展示objc时 后台返回字典对象
     */
    if([alearstr isKindOfClass:[NSDictionary class]])
    {
        
        alearstr =  [[[YXStringFilterTool alloc]init] dictionaryToJson:(NSDictionary*)alearstr];
        
    }
    
    _alearstr = alearstr;
    
    self.height = 30;
    alearviewlable.frame  = self.bounds;
    
    alearviewlable.text = alearstr;
    
    CGFloat LableH = [alearviewlable heightWithWidth:YXScreenW*0.6];
    
    if (LableH >30) {
    
        self.height = 40;
        
        alearviewlable.height = LableH;
    }

    
    
    self.alpha = 1;
    
    CGFloat leftTime;
    if (self.time != 0) {
        leftTime = self.time;
    }else{
        leftTime = 3.0;
    }
    
    [UIView animateWithDuration:leftTime animations:^{
        
        self.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
}
@end
