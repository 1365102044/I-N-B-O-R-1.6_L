//
//  YXSearchBrandsCollectionViewCell.m
//  inbid-ios
//
//  Created by 1 on 16/9/7.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchBrandsCollectionViewCell.h"
@interface YXSearchBrandsCollectionViewCell ()

{
    
    UIImageView *imageview;
    UILabel *lable;
    NSString *brandId;
    UIImageView *selsectImageview;
    
    /*
     @brief 没有商品的遮罩层
     */
    UILabel *nohavelable;
    
}
@end

@implementation YXSearchBrandsCollectionViewCell

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    
    if (self.block) {
        self.block(selected,brandId);
    }
    if (selected) {
        self.layer.borderColor = [UIColor mainThemColor].CGColor;
        self.layer.borderWidth = 1;
        selsectImageview.hidden = NO;
    }else{
        
        self.layer.borderColor =  [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5;
        selsectImageview.hidden = YES;
        
    }
}




-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor =  [UIColor blackColor].CGColor;
        
        self.layer.borderWidth = 0.5;
        
        imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"ic_pinpai"];
        [self.contentView addSubview:imageview];
        
        lable = [[UILabel alloc]init];
        lable.font = YXRegularfont(13);
        lable.textColor = UIColorFromRGB(0x050505);
        lable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lable];
        
        
        selsectImageview = [[UIImageView alloc]init];
        selsectImageview.image = [UIImage imageNamed:@"xuanzhong-"];
        [self addSubview:selsectImageview];
        selsectImageview.hidden = YES;
        
        
        nohavelable = [[UILabel alloc]init];
        nohavelable.alpha = 0.8;
        nohavelable.backgroundColor = [UIColor whiteColor];
        nohavelable.text = @"暂无商品";
        nohavelable.textAlignment = NSTextAlignmentCenter;
        nohavelable.font = YXRegularfont(8);
        nohavelable.textColor = UIColorFromRGB(0x050505);
        [self addSubview:nohavelable];
        
        nohavelable.hidden = YES;
        
        
    }
    return self;
}




- (void)setBrand:(YXSearchBrandsModle *)brand{
    
    _brand = brand;
    
    YXLog(@"---celll----%ld------",(long)brand.hasGoods);
    
    brandId = brand.brandId;
    
    lable.text = brand.prodBrandName;
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:brand.prodBrandLogoUrl]];
    
    if (brand.hasGoods != 1) {
        
        lable.textColor = [UIColor grayColor];
        self.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
         self.layer.borderWidth = 0.5;
        self.userInteractionEnabled = NO;
        nohavelable.hidden = NO;

        
    }else
    {
        lable.textColor =  UIColorFromRGB(0x050505);
        self.layer.borderColor = [UIColor blackColor].CGColor;
         self.layer.borderWidth = 0.5;
        self.userInteractionEnabled = YES;
        nohavelable.hidden = YES;
    }
    
    if(self.selected)
    {
        nohavelable.hidden = YES;
        selsectImageview.hidden = NO;
        self.layer.borderColor = [UIColor mainThemColor].CGColor;
        self.layer.borderWidth = 1;
        
    }
    
}

-(void)setSelectBrandsNumber:(NSInteger)selectBrandsNumber{
    _selectBrandsNumber = selectBrandsNumber;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    imageview.frame = CGRectMake((self.width-35)/2, 8, 35, 25);
    lable.frame = CGRectMake(0, imageview.bottom+5, self.width, 20);
    
    selsectImageview.frame = CGRectMake(self.width-16, self.height-16, 16, 16);
    nohavelable.frame = self.bounds;
    
    
}

@end
