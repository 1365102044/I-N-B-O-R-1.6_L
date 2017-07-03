//
//  YXPayMentOrderdeatilTopview.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentOrderdeatilTopview.h"

#define mainThemColor   YXColor(25.0, 10.0, 11.0)
@interface YXPayMentOrderdeatilTopview ()
{

    UILabel *Circlelable;
    UILabel *desc1;
    UILabel *desc2;
    
}
@end

@implementation YXPayMentOrderdeatilTopview

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *labletextarr =@[@"已拍下",@"待付款",@"待发货",@"待收货",@"已签收"];
        
        CGFloat lableW = (YXScreenW-60)/labletextarr.count;
        CGFloat lableH = 20;
        
        CGFloat CirclelableW = 18;
        CGFloat CirclelableMargin = (YXScreenW-40-CirclelableW*labletextarr.count)/(labletextarr.count-1);
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 15+lableH+15+CirclelableW/2, YXScreenW-40, 1)];
        line.backgroundColor = UIColorFromRGB(0x050505);
        [self addSubview:line];
        
        for (int i=0; i<5; i++)
        {
            
            Circlelable = [[UILabel alloc]init];
            Circlelable.frame = CGRectMake(20+i*CirclelableMargin+i*CirclelableW, 15+lableH+15, CirclelableW, CirclelableW);
            Circlelable.tag = 1;
            Circlelable.backgroundColor =[UIColor whiteColor];
            Circlelable.textAlignment = NSTextAlignmentCenter;
            Circlelable.font = YXSFont(10);
            Circlelable.text = [NSString stringWithFormat:@"%d",i+1];
            Circlelable.textColor = mainThemColor;
            Circlelable.layer.borderColor = mainThemColor.CGColor;
            Circlelable.layer.borderWidth = 1;
            Circlelable.layer.masksToBounds = YES;
            Circlelable.layer.cornerRadius = CirclelableW/2;
            [self addSubview:Circlelable];
            
            
            UILabel *lable = [[UILabel alloc]init];
            lable.frame = CGRectMake(20+i*lableW, 15, lableW, lableH);
            lable.text = labletextarr[i];
            lable.tag= 1;
            lable.textColor = mainThemColor;
            lable.font= YXSFont(10);
            lable.textAlignment = NSTextAlignmentCenter;
            lable.centerX = Circlelable.centerX;
            [self addSubview:lable];
            
            
            
        }
        
        desc1 = [[UILabel alloc]initWithFrame:CGRectMake(20, Circlelable.bottom+10, YXScreenW-40, 20)];
        desc1.text= @"卖家采用网银转账汇款，款项带入帐";
        desc1.textColor = [UIColor blackColor];
        desc1.font = YXSFont(12);
        [self addSubview:desc1];
        
        desc2 = [[UILabel alloc]initWithFrame:CGRectMake(desc1.x, desc1.bottom+10, desc1.width, 40)];
        desc2.text= @"汇款信息已提交，待客服审核转账信息，如上传凭证有误，可重新编辑上传凭证";
        desc2.numberOfLines = 2;
        desc2.textColor = [UIColor blackColor];
        desc2.font = YXSFont(12);
        [self addSubview:desc2];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}


@end
