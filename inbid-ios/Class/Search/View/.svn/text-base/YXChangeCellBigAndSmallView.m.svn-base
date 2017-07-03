//
//  YXChangeCellBigAndSmallView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChangeCellBigAndSmallView.h"

@interface YXChangeCellBigAndSmallView ()




@end

@implementation YXChangeCellBigAndSmallView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        //        ic_homePage_large_sel
        _Bigbtn = [[UIButton alloc]init];
        //ic_homePage_small_sel
        _smallbtn = [[UIButton alloc]init];
        
        
      
        

        
        [_Bigbtn setImage:[UIImage imageNamed:@"ic_homePage_large_no"] forState:UIControlStateNormal];
        [_Bigbtn setImage:[UIImage imageNamed:@"ic_homePage_large_sel"] forState:UIControlStateSelected];
        [_Bigbtn setTitle:@"大图模式" forState:UIControlStateNormal];
        [_Bigbtn addTarget:self action:@selector(clickbigbtn) forControlEvents:UIControlEventTouchUpInside];
        [_Bigbtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        _Bigbtn.titleLabel.font = YXSFont(15);
        [self addSubview:_Bigbtn];
        
        
        //ic_homePage_small_sel
        _smallbtn = [[UIButton alloc]init];
        [_smallbtn setImage:[UIImage imageNamed:@"ic_homePage_small_no"] forState:UIControlStateNormal];
        [_smallbtn setImage:[UIImage imageNamed:@"ic_homePage_small_sel"] forState:UIControlStateSelected];
        [_smallbtn addTarget:self action:@selector(clicksmallbtn) forControlEvents:UIControlEventTouchUpInside];
        [_smallbtn setTitle:@"小图模式" forState:UIControlStateNormal];
        [_smallbtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        _smallbtn.titleLabel.font = YXSFont(15);
        [self addSubview:_smallbtn
         
         ];
        
     
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _Bigbtn.frame = CGRectMake(0, 0, YXScreenW/2, self.height);
    _smallbtn.frame = CGRectMake(YXScreenW/2, 0, YXScreenW/2, self.height);
    
}

-(void)clicksmallbtn
{

   
    
    if (_Bigbtn.selected) {
        
        
    }else{
    }
    _Bigbtn.selected = NO;
    [_smallbtn setImage:[UIImage imageNamed:@"ic_homePage_small_sel"] forState:UIControlStateNormal];
    [_Bigbtn setImage:[UIImage imageNamed:@"ic_homePage_large_no"] forState:UIControlStateNormal];
    
    _smallbtn.selected = YES;

    if(self.changeBlock)
    {
        self.changeBlock(@"small");
    }
   

    
}

-(void)clickbigbtn
{
  
    if (_Bigbtn.selected) {
        

    }else{
        
    }
    _smallbtn.selected = NO;
    [_Bigbtn setImage:[UIImage imageNamed:@"ic_homePage_large_sel"] forState:UIControlStateNormal];
    [_smallbtn setImage:[UIImage imageNamed:@"ic_homePage_small_no"] forState:UIControlStateNormal];
    
    _Bigbtn.selected = YES;
    
    if(self.changeBlock)
    {
        self.changeBlock(@"big");
    }
    
  
}
@end
