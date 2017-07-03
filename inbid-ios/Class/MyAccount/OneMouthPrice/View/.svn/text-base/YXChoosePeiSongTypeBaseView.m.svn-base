//
//  YXChoosePeiSongTypeBaseView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChoosePeiSongTypeBaseView.h"
#import "YXChoosePeiSongTypeTopView.h"
#import "YXChoosePeiSongTypeBoomView.h"

@interface YXChoosePeiSongTypeBaseView ()


@property(nonatomic,strong) YXChoosePeiSongTypeTopView * topview;
@property(nonatomic,strong) YXChoosePeiSongTypeBoomView * boomview;

@property(nonatomic,assign) CGFloat topviewheight;
@property(nonatomic,assign) CGFloat boomviewheight;



@end
@implementation YXChoosePeiSongTypeBaseView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        __weak typeof(self)weakself = self;
        self.topview.heightblock =^(CGFloat height){
        
            weakself.topviewheight = height;
            [weakself layoutSubviews];
        };


        self.boomview.heightblock =^(CGFloat height){
            
            weakself.boomviewheight = height;
            
            [weakself layoutSubviews];
        };
        [self addSubview:self.topview];
        [self addSubview:self.boomview];

        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topview.frame = CGRectMake(0, 0, YXScreenW, self.topviewheight);
    self.boomview.frame = CGRectMake(0, self.topview.bottom+10, YXScreenW, self.boomviewheight);
    
    if ([self.baseheightdelegate respondsToSelector:@selector(baseviewheight:)]) {
        
        [self.baseheightdelegate baseviewheight:self.boomview.bottom+10];
    }

}


-(void)setSubviewUIWithAllprice:(NSInteger )allprice iscanDingjin:(NSInteger )iscandingjin
{
    [self.boomview setUIWithorderAllprice:allprice iscanDingjin:iscandingjin];
    
}

-(void)setPeisongtype:(NSString *)peisongtype
{
    _peisongtype = peisongtype;
    self.topview.peisongtype = peisongtype;
    self.boomview.peisongtype = peisongtype;
}

/**
 懒加载
 */
-(YXChoosePeiSongTypeTopView*)topview
{
    if (!_topview) {
        _topview = [[YXChoosePeiSongTypeTopView alloc]init];
        _topview.layer.borderWidth = 0.5;
        _topview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _topview.backgroundColor = [UIColor whiteColor];
    }
    return _topview ;
}
-(YXChoosePeiSongTypeBoomView*)boomview
{
    if (!_boomview) {
        _boomview = [[YXChoosePeiSongTypeBoomView alloc]init];
        _boomview.layer.borderWidth = 0.5;
        _boomview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _boomview.backgroundColor = [UIColor whiteColor];
    }
    return _boomview ;
}

@end
