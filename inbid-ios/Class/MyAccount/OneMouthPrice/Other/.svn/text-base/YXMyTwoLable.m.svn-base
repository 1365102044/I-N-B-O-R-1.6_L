//
//  YXMyTwoLable.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyTwoLable.h"

@interface YXMyTwoLable ()
@property(nonatomic,strong) UILabel * leftlable;
@property(nonatomic,strong) UILabel * rightlable;

@end

@implementation YXMyTwoLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UILabel *leftlable = [[UILabel alloc]init];
        leftlable.textColor = UIColorFromRGB(0x050505);
        leftlable.font = YXRegularfont(11);
        [self addSubview:leftlable];
        self.leftlable = leftlable;
        
        UILabel *rightlable = [[UILabel alloc]init];
        rightlable.textAlignment = NSTextAlignmentRight;
        rightlable  .textColor = UIColorFromRGB(0x050505);
        rightlable.font = YXRegularfont(11);
        [self addSubview:rightlable];
        self.rightlable= rightlable;
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat H = 20;
    CGFloat W = (self.width-20)/2;
    self.leftlable.frame = CGRectMake(10,0,W ,H);
    self.rightlable.frame = CGRectMake(self.width-W-10, 0, W, H);
    
}

-(void)setLeftstr:(NSString *)leftstr
{
    _leftstr = leftstr;
    self.leftlable.text = leftstr;
    if ([leftstr isEqualToString:@"待付款金额"]) {
        _rightlable.textColor = UIColorFromRGB(0xa90311);
    }else if ([leftstr isEqualToString:@"-已付金额"]||[leftstr isEqualToString:@"+运费(含商品保价费)"]||[leftstr isEqualToString:@"-活动优惠(包邮)"] )
    {
        _leftlable.textColor = UIColorFromRGB(0x939393);
    }
}
-(void)setRightstr:(NSString *)rightstr
{
    _rightstr = rightstr;
    self.rightlable.text = rightstr;
}

-(void)setMycolor:(UIColor *)mycolor
{
    _mycolor = mycolor;
    self.leftlable.textColor = mycolor;
    self.rightlable.textColor = mycolor;
}
-(void)setMyfont:(UIFont *)myfont
{
    _myfont = myfont;
    self.leftlable.font = myfont;
    self.rightlable.font = myfont;
    
}


@end
