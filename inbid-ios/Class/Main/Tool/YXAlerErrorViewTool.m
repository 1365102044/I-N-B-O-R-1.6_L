//
//  YXAlerErrorViewTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAlerErrorViewTool.h"

@interface YXAlerErrorViewTool ()
@property(nonatomic,strong) UILabel * errorbigLable;

@end

@implementation YXAlerErrorViewTool

-(void)showAlerErrorView:(NSString *)titleStr andSupview:(UIView*)supview
{

    for (UIView *subview in supview.subviews)
    {
        if (subview.tag == 1000) {
            return;
        }
    }
    
    
    UILabel *errorbigLable = [[UILabel alloc]initWithFrame:CGRectMake(0, YXScreenH, YXScreenW, 50)];
    errorbigLable.tag = 1000;
    errorbigLable.backgroundColor  = UIColorFromRGB(0xae3946);
    errorbigLable.text = titleStr;
    errorbigLable.textColor = [UIColor whiteColor];
    errorbigLable.font = [UIFont systemFontOfSize:16];
    errorbigLable.textAlignment = NSTextAlignmentCenter;
    [supview addSubview:errorbigLable];
    self.errorbigLable = errorbigLable;
    
   
    
    [UIView animateWithDuration:0.3 animations:^{
        
      self.errorbigLable.frame = CGRectMake(0, YXScreenH-50, YXScreenW, 50);
    
    } completion:^(BOOL finished) {
        
       
        [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.errorbigLable.frame = CGRectMake(0, YXScreenH, YXScreenW, 50);
            
        } completion:^(BOOL finished) {
            
            [self.errorbigLable removeFromSuperview];
            
        }];
    }];
    
}

//+(void)showAlerErrorView:(NSString *)str andSupview:(UIView*)view
//{
//    [self showAlerErrorView:str andSupview:view];
//}

@end
