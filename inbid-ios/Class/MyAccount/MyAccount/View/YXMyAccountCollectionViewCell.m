//
//  YXMyAccountCollectionViewCell.m
//  MyAccountView
//
//  Created by 胤讯测试 on 16/11/19.
//  Copyright © 2016年 胤讯--LWQ. All rights reserved.
//

#import "YXMyAccountCollectionViewCell.h"

@interface YXMyAccountCollectionViewCell ()

{
    UIImageView *imageview;
    
    UILabel *namelable;
}

@end

@implementation YXMyAccountCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@""];
        
        [self addSubview:imageview];
        
        
        namelable = [[UILabel alloc]init];
        namelable.textAlignment = NSTextAlignmentCenter;
        namelable.textColor = [UIColor blackColor];
        namelable.font = [UIFont systemFontOfSize:14];
        namelable.text = @"家具啊";
        [self addSubview:namelable];
        
        
  
        
        
        
    }
    
    return self;
}



-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    namelable.text =  dict[@"title"];
    
    NSString *iamgestr = dict[@"title"];
    
    imageview.image = [UIImage imageNamed:iamgestr];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    imageview.frame = CGRectMake((self.frame.size.width-40)/2, 25, 40,40 );
    
    namelable.frame = CGRectMake(0, imageview.bottom+15, self.frame.size.width, 20);
    
}
@end
