//
//  YXSearchCollectionViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchCollectionViewCell.h"
#import "YXMySearchBtn.h"

@interface YXSearchCollectionViewCell ()

{
    
    UIImageView *imageview;
    UILabel *lable;
    UIImageView *selsectImageview;
    
    
}
@end

@implementation YXSearchCollectionViewCell


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (self.block) {
        self.block(selected);
    }
    
    if (selected) {
        
        self.layer.borderColor = [UIColor mainThemColor].CGColor;
        self.layer.borderWidth = 1;;
        selsectImageview.hidden = NO;
        
    }else{
        
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5 ;
        selsectImageview.hidden = YES;
    }
}



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5;
        
        lable = [[UILabel alloc]init];
        lable.font = YXRegularfont(13);
        lable.textColor = UIColorFromRGB(0x050505);
        lable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lable];
        
        selsectImageview = [[UIImageView alloc]init];
        selsectImageview.image = [UIImage imageNamed:@"xuanzhong-"];
        [self addSubview:selsectImageview];
        selsectImageview.hidden = YES;
        
        
        
    }
    return self;
}



-(void)setModle:(YXSearchModle *)modle
{
    _modle = modle;
    
    lable.text = modle.catName;
    

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    lable.frame = CGRectMake(0, 5, self.width, 20);
    selsectImageview.frame = CGRectMake(self.width-16, self.height-16, 16, 16);
    
    
}


@end
