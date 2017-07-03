//
//  YXHomeAuctionDeatilSeactionView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilSeactionView.h"

@interface YXHomeAuctionDeatilSeactionView ()
{
    NSArray *dataArrNumber;
    NSArray *arriamge;
    
    
    CGFloat Mar;
}

@end

@implementation YXHomeAuctionDeatilSeactionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //        NSArray *arr = [[NSArray alloc]init];
        //                NSArray *arriamge = [[NSArray alloc]init];
        //        arriamge = @[@"icon_guanzhu",@"icon_canyu",@"icon_kefu_1"];
        
        
        //        [self addbtn];
        
         arriamge = @[@"icon_guanzhu",@"icon_canyu",@"icon_kefu_1"];
    }
    
    Mar = 9;
    return self;
    
}

-(void)setModle:(YXHomeDeatilModle *)modle
{
    _modle = modle;
    
    NSString *str0 = [NSString stringWithFormat:@" 关注  (%ld人)",(long)modle.collectNum];
    NSString *str1 = [NSString stringWithFormat:@" 参与  (%ld人)",(long)modle.actorNum];
    dataArrNumber = @[str0,str1,@" 联系客服"];
    if(modle.isCollect ==1)
    {
     arriamge = @[@"yijignguanzhu",@"icon_canyu",@"icon_kefu_1"];
    }else{
    
     arriamge = @[@"icon_guanzhu",@"icon_canyu",@"icon_kefu_1"];
    }
    [self addbtn];
    
}

-(void)addbtn
{
   
    CGFloat width = YXScreenW/3;
    for (int i=0; i<3; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:dataArrNumber[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(width*i , 0, width, 40);
        [btn setTitleColor:UIColorFromRGB(0x030303) forState:UIControlStateNormal];
        btn.titleLabel.font = YXRegularfont(12);
        
        [btn setImage:[UIImage imageNamed:arriamge[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        
        NSMutableArray *tagArr = [[NSMutableArray alloc]init];
        for (UIView *views in self.subviews) {
            
            [tagArr addObject:[NSString stringWithFormat:@"%ld",(long)views.tag]];
        }
        if (![tagArr containsObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]]) {
            
            [self addSubview:btn];
        }
        
    
        
    }
    
    
}

-(void)setGuanzhubtn:(NSString *)guanzhubtn
{
    _guanzhubtn = guanzhubtn;
    //**关注**/
    if ([_guanzhubtn isEqualToString:@"1"]) {
        

        for (UIButton *btn in self.subviews) {
            
            if (btn.tag == 0) {
                [btn setImage:[UIImage imageNamed:@"yijignguanzhu"] forState:UIControlStateNormal];
                NSInteger num = self.modle.collectNum;
                if(self.modle.isCollect ==1){
                    [btn setTitle:[NSString stringWithFormat:@" 关注（%ld人）",num] forState:UIControlStateNormal];
                    self.modle.collectNum = num;
                }else{
                    [btn setTitle:[NSString stringWithFormat:@" 关注（%ld人）",num+1] forState:UIControlStateNormal];
                    self.modle.collectNum = num+1;
                }
            }
             btn.imageEdgeInsets = UIEdgeInsetsMake(0, Mar, 0, 0);
             btn.titleEdgeInsets = UIEdgeInsetsMake(0, Mar, 0, 0);
        }

               self.modle.isCollect = 1;

    }else if ([_guanzhubtn isEqualToString:@"2"]){
    
        //**取消关注**/
        for (UIButton *btn in self.subviews) {
            
            if (btn.tag == 0) {
                [btn setImage:[UIImage imageNamed:@"icon_guanzhu"] forState:UIControlStateNormal];
                  NSInteger num = self.modle.collectNum;

                  if(self.modle.isCollect ==1){
                  [btn setTitle:[NSString stringWithFormat:@" 关注（%ld人）",num-1] forState:UIControlStateNormal];
                      self.modle.collectNum = num-1;
                  }else
                  {
                        [btn setTitle:[NSString stringWithFormat:@" 关注（%ld人）",num] forState:UIControlStateNormal];
                      self.modle.collectNum = num;
                  }
                
            }
            
        
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, Mar, 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, Mar, 0, 0);
        }

            self.modle.isCollect = 0;
    }
    
}


//** -------点击组头的方法 -----------**/
-(void)clickBtn:(UIButton*)btn
{
    if (self.seactionblock) {
        
        self.seactionblock(btn.tag,self.modle.isCollect);
    }
}

//** -------画边框 -----------**/
-(void)drawRect:(CGRect)rect
{
    //    线条颜色
    UIColor *color = UIColorFromRGB(0xe5e5e5);
    
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    
    [path moveToPoint:CGPointMake(-1, 0)];
    [path addLineToPoint:CGPointMake(-1, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(YXScreenW+2, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(YXScreenW, 0)];
    
    [path closePath];
    [path stroke];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 1;
    [path1 moveToPoint:CGPointMake(YXScreenW/3, 5)];
    [path1 addLineToPoint:CGPointMake(YXScreenW/3, self.frame.size.height-5)];
    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    path2.lineWidth = 1;
    [path2 moveToPoint:CGPointMake(YXScreenW*2/3, 5)];
    [path2 addLineToPoint:CGPointMake(YXScreenW*2/3, self.frame.size.height-5)];
    [path2 stroke];
    
}

-(void)setActorNum:(NSInteger)actorNum
{
    _actorNum = actorNum;
     for (UIButton *btn in self.subviews) {
     
         if (btn.tag==1) {
             
             NSString *numberstr = [NSString stringWithFormat:@" 参与  (%ld人)",(long)actorNum];
             [btn setTitle:numberstr forState:UIControlStateNormal];
         }
     }
    
}

-(void)setGuanzhuNum:(NSInteger)guanzhuNum
{
    _guanzhuNum = guanzhuNum;
    for (UIButton *btn in self.subviews) {
        
        if (btn.tag==0) {
            
            NSString *numberstr = [NSString stringWithFormat:@" 关注  (%ld人)",(long)guanzhuNum];
            [btn setTitle:numberstr forState:UIControlStateNormal];
            
        }
    }

    
    
}

@end
