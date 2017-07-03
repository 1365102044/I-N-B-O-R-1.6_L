//
//  YXMyAccountPaymenChooseFenbiOrQuaneView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountPaymenChooseFenbiOrQuaneView.h"

@interface YXMyAccountPaymenChooseFenbiOrQuaneView ()
{
    UIButton *leftbtn;
    UIButton *rightbtn;
}


@property(nonatomic,strong) UISegmentedControl * segmentControl;



@end
@implementation YXMyAccountPaymenChooseFenbiOrQuaneView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
//        NSArray*arr = [[NSArray alloc]init];
//        arr = @[@"全额支付",@"分笔支付"];
//        self.segmentControl = [[UISegmentedControl alloc]initWithItems:arr];
//        
//        self.segmentControl.tintColor = [UIColor clearColor];
//        [self.segmentControl addTarget:self action:@selector(clicksegement:) forControlEvents:UIControlEventValueChanged];
//
////        self.segmentControl.segmentedControlStyle = UISegmentedControlStylePlain;
//        self.segmentControl.backgroundColor = [UIColor clearColor];
//
//        // 设置UISegmentedControl选中的图片
//        [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"huangse"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//        // 正常的图片
//        [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//
//        
//        
//        NSDictionary * selectedTextAttr = @{NSFontAttributeName:YXRegularfont(14),NSForegroundColorAttributeName:UIColorFromRGB(0x050505)};
//        [self.segmentControl setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
//        
//        NSDictionary * unselectedTextAttr = @{NSFontAttributeName:YXRegularfont(14),NSForegroundColorAttributeName:UIColorFromRGB(0x050505)};
//        [self.segmentControl setTitleTextAttributes:unselectedTextAttr forState:UIControlStateNormal];
//        
//        self.segmentControl.selectedSegmentIndex = 0;
        
        
//        [self addSubview:self.segmentControl];
        
        
        
        
        leftbtn = [[UIButton alloc]init];
        [leftbtn setTitle:@"全额支付" forState:UIControlStateNormal];
        [leftbtn setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        leftbtn.titleLabel.font = YXRegularfont(14);
        [leftbtn addTarget:self action:@selector(clicksegement:) forControlEvents:UIControlEventTouchUpInside];
        leftbtn.tag = 0;
        
        
        rightbtn = [[UIButton alloc]init];
        [rightbtn setTitle:@"分笔支付" forState:UIControlStateNormal];
        [rightbtn setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        rightbtn.titleLabel.font = YXRegularfont(14);
        [rightbtn addTarget:self action:@selector(clicksegement:) forControlEvents:UIControlEventTouchUpInside];
        rightbtn.tag = 1;
        
        [self addSubview:leftbtn];
        [self addSubview:rightbtn];
        
        leftbtn.selected = YES;
          leftbtn.backgroundColor = UIColorFromRGB(0xf3ece2);
    }
    
    return self;
}
-(void)clicksegement:(UIButton*)sender
{
    if (sender.tag == 0) {
        leftbtn.backgroundColor = UIColorFromRGB(0xf3ece2);
        rightbtn.backgroundColor = [UIColor whiteColor];
        rightbtn.selected = NO;
    }else if (sender.tag == 1)
    {
        leftbtn.backgroundColor = [UIColor whiteColor];
        rightbtn.backgroundColor = UIColorFromRGB(0xf3ece2);
        leftbtn.selected = NO;
    }

    NSString *selectstr = [NSString stringWithFormat:@"%ld",sender.tag+1];
        [[NSNotificationCenter defaultCenter]  postNotificationName:@"PAYTYPETAG" object:nil userInfo:@{@"SELECTINDEX" :selectstr}];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.segmentControl.frame = CGRectMake(0, 0, self.width-0, 46);

    CGFloat W = (self.width)/2;
    leftbtn.frame = CGRectMake(0, 0,W , 46);
    rightbtn.frame = CGRectMake(leftbtn.right, leftbtn.y, W, 46);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:leftbtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = leftbtn.bounds;
    maskLayer.path = maskPath.CGPath;
    [leftbtn.layer addSublayer:maskLayer];
    leftbtn.layer.mask = maskLayer;
    
    UIBezierPath *rightmaskPath = [UIBezierPath bezierPathWithRoundedRect:rightbtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *rightmaskLayer = [CAShapeLayer layer];
    rightmaskLayer.frame = rightbtn.bounds;
    rightmaskLayer.path = rightmaskPath.CGPath;
    [rightbtn.layer addSublayer:rightmaskLayer];
    rightbtn.layer.mask = rightmaskLayer;


}

@end
