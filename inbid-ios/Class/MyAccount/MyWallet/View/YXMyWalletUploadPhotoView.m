//
//  YXMyWalletUploadPhotoView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletUploadPhotoView.h"

@interface YXMyWalletUploadPhotoView ()
{
    UILabel *titlelable;
    UIImageView *photoimageview;
    
}

@end

@implementation YXMyWalletUploadPhotoView


/**
 点击方法
 */
-(void)clickimage{

    if (self.clickImageBlock) {
        self.clickImageBlock(titlelable.text);
    }
}
/**
 赋值
 */
-(void)setNameStr:(NSString *)nameStr{

    titlelable.text = nameStr;
    photoimageview.image = [UIImage imageNamed:nameStr];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, YXScreenW-20, 30)];
        titlelable.text = @"拍摄正面";
        titlelable.textColor = UIColorFromRGB(0x333333);
        titlelable.font = YXSFont(13);
        titlelable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titlelable];
        
        
        photoimageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, titlelable.bottom+10, 220, 150)];
        photoimageview.centerX = self.centerX;
        [self addSubview:photoimageview];
        self.photoimage = photoimageview;
        photoimageview.userInteractionEnabled = YES;
        photoimageview.layer.cornerRadius = 5;
        photoimageview.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(clickimage)];
        [photoimageview addGestureRecognizer:tap];
        
        
        _linetop= [[UIView alloc]initWithFrame:CGRectMake(15, 0, YXScreenW-30, 1)];
        _linetop.backgroundColor = UIColorFromRGB(0xe5e5e5);
        _linetop.hidden = YES;
        [self addSubview:_linetop];
        _lineboom= [[UIView alloc]initWithFrame:CGRectMake(15, photoimageview.bottom+10, YXScreenW-30, 1)];
        _lineboom.backgroundColor = UIColorFromRGB(0xe5e5e5);
        _lineboom.hidden = YES;
        [self addSubview:_lineboom];
    }
    return self;
}

@end
