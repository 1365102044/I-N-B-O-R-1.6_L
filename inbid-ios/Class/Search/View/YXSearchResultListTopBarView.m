//
//  YXSearchResultListTopBarView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchResultListTopBarView.h"



@interface YXSearchResultListTopBarView ()

{
    
    NSInteger   selectBtnTag;

}

@end

@implementation YXSearchResultListTopBarView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // ic_homePageScreenView_hig  ic_homePageScreenView_no  ic_homePageScreenViewPriceType_hig_a  ic_homePageScreenViewPriceType_hig_d ic_homePageScreenViewPriceType_no
        NSArray *arr = @[@"综合",@"价格",@"品类",@"图片模式"];
        NSArray *arr1 = @[@"ic_homePageScreenView_no",@"ic_homePageScreenViewPriceType_no",@"ic_homePageScreenView_no",@"ic_homePageScreenView_no"];
        
        CGFloat w = YXScreenW/arr.count;
        
        for (int i=0; i<=arr.count; i++) {
            
            UIButton *topbtn = [[UIButton alloc]init];
            topbtn.frame  = CGRectMake(i*w, 5, w, 30);
            [topbtn setTitle:arr[i] forState:UIControlStateNormal];
            [topbtn setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
            [topbtn setImage:[UIImage imageNamed:arr1[i]] forState:UIControlStateNormal];
            topbtn.tag = i+1;
            topbtn.titleLabel.font = YXSFont(15);
            [topbtn addTarget:self action:@selector(clicktopbtn:) forControlEvents:UIControlEventTouchUpInside];
            [topbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -topbtn.imageView.bounds.size.width, 0, topbtn.imageView.bounds.size.width)];
            [topbtn setImageEdgeInsets:UIEdgeInsetsMake(0, topbtn.titleLabel.bounds.size.width, 0, -topbtn.titleLabel.bounds.size.width)];
            
            [self addSubview:topbtn];
            
        }
        
        [YXNotificationTool addObserver:self selector:@selector(changeselectTAG:) name:@"changeselectTAG" object:nil];
        
        //**改变文字**/
        [YXNotificationTool addObserver:self selector:@selector(ChoolseItem:) name:@"ChooselItem" object:nil];
        //**改变图片**/
        [YXNotificationTool addObserver:self selector:@selector(clickTopView:) name:@"ClickItemTopviewTag" object:nil];
        
    }
    
    return self;
    

}
/*
 @brief 改变文字
 */
-(void)ChoolseItem:(NSNotification*)noti
{
    
    for (UIButton *btns in self.subviews) {
        
        if ([noti.userInfo[@"Itemtag"] integerValue] == btns.tag ) {
            
            [btns setTitle:noti.userInfo[@"ItemStr"] forState:UIControlStateNormal];
            [btns setTitleEdgeInsets:UIEdgeInsetsMake(0, -btns.imageView.bounds.size.width, 0, btns.imageView.bounds.size.width)];
            [btns setImageEdgeInsets:UIEdgeInsetsMake(0, btns.titleLabel.bounds.size.width, 0, -btns.titleLabel.bounds.size.width)];
        }
        
    }
}
//**改变图片**/
-(void)clickTopView:(NSNotification*)noti
{

    for (UIButton *btn in self.subviews) {
        
        if ([noti.userInfo[@"selecttag"] integerValue] == btn.tag) {
            
            if (btn.tag == 2) {
            
                if ([noti.userInfo[@"paixu"] isEqualToString:@"1"] ) {
                    [btn setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_hig_d"] forState:UIControlStateNormal];
                }else if([noti.userInfo[@"paixu"] isEqualToString:@"2"])
                {
                    
                    [btn setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_hig_a"] forState:UIControlStateNormal];
                
                }else if([noti.userInfo[@"paixu"] isEqualToString:@"0"])
                {
                    
                    [btn setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_no"] forState:UIControlStateNormal];
                }
                
                [btn setTitleColor:UIColorFromRGB(0x251011) forState:UIControlStateNormal];
                
            }else{
            
                [btn setImage:[UIImage imageNamed:@"ic_homePageScreenView_hig"] forState:UIControlStateNormal];
                [btn setTitleColor:UIColorFromRGB(0x251011) forState:UIControlStateNormal];
            }
            
            if (btn.tag==1) {
                
                if (![YXUserDefaults objectForKey:@"selectzognhe"]) {
                    [btn setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"ic_homePageScreenView_no"] forState:UIControlStateNormal];
                }
                
            }
            if (btn.tag==3) {
                
                if (![YXUserDefaults objectForKey:@"selectpinlei"]) {
                    [btn setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"ic_homePageScreenView_no"] forState:UIControlStateNormal];
                }

            }
            
            
        }else
        {
            [btn setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"ic_homePageScreenView_no"] forState:UIControlStateNormal];
         
            if(btn.tag ==2)
            {
                [btn setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_no"] forState:UIControlStateNormal];
                
            }else if(btn.tag ==3){
            
                [btn setTitle:@"品类" forState:UIControlStateNormal];
            }else if (btn.tag ==1){
                [btn setTitle:@"综合" forState:UIControlStateNormal];
            }
            
        
        }
    }
    

    
}



-(void)changeselectTAG:(NSNotification*)noti
{
    selectBtnTag = 0;
}

/*
 @brief 为了判断在点击相同的btn的时候 收起 用 tag=10代表需要收起
 */

-(void)clicktopbtn:(UIButton*)sender
{

    NSInteger TAG=0 ;
    
    if (selectBtnTag == sender.tag ) {
        
        selectBtnTag = 0;
        TAG = 10;
    }else{
   
        TAG = sender.tag;
        selectBtnTag =sender.tag ;
    }
    
    if (self.BarBtnTagBlock) {
        
        self.BarBtnTagBlock(TAG);
        
    }
    
   
    
    
    
}

@end
