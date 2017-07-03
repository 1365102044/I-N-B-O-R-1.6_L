//
//  YXHomeAuctionDeatilHeaderView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//


#import "YXHomeAuctionDeatilHeaderView.h"
#import "YXPictureCarouselView.h"
#import "NSString+File.h"
#import "Masonry.h"
#import "YXHomeAuctionDeatilProgressBarView.h"
#import "YXHomeAuctionDeatilSeactionView.h"
#import "YXHomeAuctionDeatilCellIndexPathOne.h"
//#import "YXHomeAuctionDeatilCellIndexPathThree.h"
#import "YXHomeAuctionDeatilCellIndexPathFour.h"
#import "YXHomeAuctionDeatilCellIndexPathTwo.h"
#import "YXHomeDeatilImgesModle.h"



#define widthScreen [UIScreen mainScreen].bounds.size.width
#define heightScreen [UIScreen mainScreen].bounds.size.height
/*
 @brief 细字体
 */
#define  YXThinfont(x) [UIFont fontWithName:@"PingFangSC-Thin"size:x]
#define  YXBoldfont(x) [UIFont fontWithName:@"PingFangSC-Semibold"size:x]
//#define  YXThinfont(x) [UIFont fontWithName:@"PingFangSC-Regular"size:x]

#define yxUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.7]

@interface YXHomeAuctionDeatilHeaderView ()

{
    //    YXPictureCarouselView *adPictureCarouseView;
    UILabel *title;
    UILabel *currenPrice;
    UILabel *originalPrice;
    
    YXHomeAuctionDeatilProgressBarView * timeProgressView;
//    YXHomeAuctionDeatilSeactionView *seactionView;
    
    YXHomeAuctionDeatilCellIndexPathOne* cellOneView;
    YXHomeAuctionDeatilCellIndexPathTwo *cellTwoView;
    
//    YXHomeAuctionDeatilCellIndexPathThree *cellThreeView;
    YXHomeAuctionDeatilCellIndexPathFour *cellFourView;
    
    CGFloat threeviewheight;
    
    CGFloat fourviewheight;
    
    
}
@property(nonatomic,strong) YXPictureCarouselView *adPictureCarouseView;


@property(assign,nonatomic) CGFloat HeaderHeight;

@property(nonatomic,strong) YXHomeAuctionDeatilSeactionView * seactionView;

@end


@implementation YXHomeAuctionDeatilHeaderView
-(YXHomeAuctionDeatilSeactionView*)seactionView
{
    if(!_seactionView)
    {
        _seactionView = [[YXHomeAuctionDeatilSeactionView alloc]init];
    }
   return  _seactionView;
}


- (YXPictureCarouselView *)adPictureCarouseView
{
    if (!_adPictureCarouseView) {
        CGFloat imageheight;
        if (iPHone6Plus) {
            imageheight = 378;
        }else if (iPHone6)
        {
            imageheight=342;
        
        }else if (iPHone5)
        {
            imageheight = 292;
            
        }else{
            imageheight = 342;
        }

        _adPictureCarouseView = [[YXPictureCarouselView alloc] initWithFrame:CGRectMake(0, 0, YXScreenW, imageheight)];
    }
    return _adPictureCarouseView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:self.adPictureCarouseView];
    
        
        title = [[UILabel alloc]init];
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"[A级]  IWC万国葡萄牙计时腕表经典版"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x9f7941) range:NSMakeRange(0, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:YXHomeDeatilcolor range:NSMakeRange(4, attrStr.length-4)];
        [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(14) range:NSMakeRange(0, attrStr.length)];
        title.attributedText = attrStr;
        title.numberOfLines = 0;
        [self addSubview:title];
        
        
        currenPrice = [[UILabel alloc]init];
        NSMutableAttributedString* currenPriceStr = [[NSMutableAttributedString alloc] initWithString:@"当前价格：¥123456"];
        [currenPriceStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x030303) range:NSMakeRange(0, currenPriceStr.length)];
        [currenPriceStr addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(0, 5)];
        [currenPriceStr addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(5, currenPriceStr.length-5)];
        currenPrice.attributedText = currenPriceStr;
        [self addSubview:currenPrice];
        
        originalPrice = [[UILabel alloc]init];
        originalPrice.text = @"(起拍价：¥123456)";
        originalPrice.font = [UIFont systemFontOfSize:12];
        originalPrice.textColor = [UIColor lightGrayColor];
        //        [self addSubview:originalPrice];
        
        __weak typeof(self)weakself = self;
        
        //** -------进行中view -----------**/
        timeProgressView = [[YXHomeAuctionDeatilProgressBarView alloc]init];
        [self addSubview:timeProgressView];
        
        
        
        //** -------类适组头的view -----------**/
        self.seactionView.seactionblock = ^(NSInteger tag,NSInteger attentstatus){
            
            if (weakself.seactionBlock) {
                weakself.seactionBlock(tag,attentstatus);
            }
            
        };
        [self addSubview:self.seactionView];
        
        
        //** -------竞拍规则 -----------**/
        cellOneView = [[YXHomeAuctionDeatilCellIndexPathOne alloc]init];
        [self addSubview:cellOneView];
        cellOneView.myblock = ^(){
            if (weakself.taponeviewblock) {
                weakself.taponeviewblock();
            }
        };
        cellTwoView = [[YXHomeAuctionDeatilCellIndexPathTwo alloc]init];
        [self addSubview:cellTwoView];
        
        
        //** -------商品属性 -----------**/
//        cellThreeView = [[YXHomeAuctionDeatilCellIndexPathThree alloc]init];
//        cellThreeView.heightblock = ^(CGFloat height1){
//            
//            threeviewheight = height1;
//            
//        };
//        [self addSubview:cellThreeView];
        
        //** -------商品描述 -----------**/
        cellFourView = [[YXHomeAuctionDeatilCellIndexPathFour alloc]init];
        cellFourView.heightblock = ^(CGFloat height){
            
            fourviewheight = height;
            
            
            weakself.HeaderAllHeight = weakself.HeaderHeight - 120 + height;
            
            if (weakself.HeaderHeightblock) {
                weakself.HeaderHeightblock(weakself.HeaderAllHeight);
            }
        };
        [self addSubview:cellFourView];
        
    }
    
    return self;
}

-(void)setLoopmodle:(YXHomeDeatilModle *)loopmodle
{

    _loopmodle = loopmodle;
    timeProgressView.loopmodle = loopmodle;
    
    NSString *nowtimestr = [YXStringFilterTool getTimeNow];
    NSString *startimestr = [NSString stringWithFormat:@"%@",loopmodle.startTime];
    
    double nowint = [nowtimestr doubleValue];
    double startint = [startimestr doubleValue];
    
    /*
     @brief 如果当前价为0 就显示开始价
     */
    long long price = loopmodle.currentPrice /100;
    
    if (!price) {
        price = loopmodle.startPrice /100;
    }
    
    NSString *str1 =[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",price]];
    NSString *currenstr = [NSString stringWithFormat:@"当前价格:￥%@",str1];

    if(nowint<startint){
        
        /*
         @brief 如果当前价为0 就显示开始价
         */
        long long price = loopmodle.currentPrice /100;
        
        if (!price) {
            price = loopmodle.startPrice /100;
        }
        
        NSString *str0 = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)price]];
        currenstr = [NSString stringWithFormat:@"起拍价格:￥%@",str0];
    }
    
    
    NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:currenstr];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:yxUIColorFromRGB(0x030303) range:NSMakeRange(0, 4)];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(4, currenattrStr.length-4)];
    [currenattrStr addAttribute:NSFontAttributeName value:YXRegularfont(14) range:NSMakeRange(0, 4)];
    [currenattrStr addAttribute:NSFontAttributeName value:YXRegularfont(18) range:NSMakeRange(4, 1)];
    [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(15) range:NSMakeRange(5, currenattrStr.length-5)];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(5, currenattrStr.length-5)];
    currenPrice.attributedText = currenattrStr;
    

}


//参与人数
-(void)setActorNum:(NSInteger)actorNum
{
    _actorNum = actorNum;
    _seactionView.actorNum = actorNum;
}
-(void)setGuanzhuNum:(NSInteger)guanzhuNum
{
    _guanzhuNum = guanzhuNum;
    _seactionView.guanzhuNum = guanzhuNum;
}

/*
 @brief 赋值
 */

-(void)setDeatilmodle:(YXHomeDeatilModle *)deatilmodle
{
    _deatilmodle = deatilmodle;
    
    
    
    self.adPictureCarouseView.deatilmodle = deatilmodle;
    

    NSString *levelstr = [NSString stringWithFormat:@"%@",deatilmodle.identifyLevel];
    NSString *name =  [NSString stringWithFormat:@"[%@]  %@",levelstr,deatilmodle.prodName];
    
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:name];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5.0];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(0, levelstr.length+2)];
      [attrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(14) range:NSMakeRange(0, levelstr.length+2)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(4, attrStr.length-4)];
    [attrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(14) range:NSMakeRange(levelstr.length+2, attrStr.length-levelstr.length-2)];
    title.attributedText = attrStr;
    
    
    
    NSString *nowtimestr = [YXStringFilterTool getTimeNow];
    NSString *startimestr = [NSString stringWithFormat:@"%@",deatilmodle.startTime];
    
    double nowint = [nowtimestr doubleValue];
    double startint = [startimestr doubleValue];

    
    /*
     @brief 如果当前价为0 就显示开始价
     */
    NSInteger price = deatilmodle.currentPrice /100;
    
    if (!price) {
        price = deatilmodle.startPrice /100;
    }
    NSString *str1 =[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",price]];
    NSString *currenstr = [NSString stringWithFormat:@"当前价格:￥%@",str1];

    
    if(nowint<startint){
    
        /*
         @brief 如果当前价为0 就显示开始价
         */
        NSInteger price = deatilmodle.currentPrice /100;
        
        if (!price) {
            price = deatilmodle.startPrice /100;
        }

        NSString *str0 = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)price]];
        currenstr = [NSString stringWithFormat:@"起拍价格:￥%@",str0];
    }
    
 
   
    NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:currenstr];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:yxUIColorFromRGB(0x030303) range:NSMakeRange(0, 4)];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(4, currenattrStr.length-4)];
    
    [currenattrStr addAttribute:NSFontAttributeName value:YXRegularfont(14) range:NSMakeRange(0, 4)];
    [currenattrStr addAttribute:NSFontAttributeName value:YXRegularfont(18) range:NSMakeRange(4, 1)];
    [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(15) range:NSMakeRange(5, currenattrStr.length-5)];
      [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(5, currenattrStr.length-5)];
    currenPrice.attributedText = currenattrStr;
    
  
    
    
    //** -------view赋值 -----------**/
    timeProgressView.modle = deatilmodle;
    
    self.seactionView.modle = deatilmodle;
    cellOneView.modle = deatilmodle;
    cellTwoView.modle = deatilmodle;
//    cellThreeView.modle = deatilmodle;
    
    cellFourView.modle = deatilmodle;
    
    [self layoutSubviews];
}


-(void)setGuanzhuSTR:(NSString *)guanzhuSTR
{
    _guanzhuSTR = guanzhuSTR;
    
    self.seactionView.guanzhubtn = guanzhuSTR;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageheight;
    if (iPHone6Plus) {
        imageheight = 378;
    }else if (iPHone6)
    {
        imageheight=342;
        
    }else if (iPHone5)
    {
        imageheight = 292;
        
    }else{
        imageheight = 342;
    }
    self.adPictureCarouseView.frame = CGRectMake(0, 0, YXScreenW, imageheight);
    
    CGFloat titleHeight = [self getSpaceLabelHeight:title.text withFont:YXRegularfont(14) withWidth:YXScreenW-20];
    title.frame = CGRectMake(10, self.adPictureCarouseView.bottom+5, YXScreenW-20, titleHeight);
    currenPrice.frame = CGRectMake(10, title.bottom, YXScreenW-20, 25);
    timeProgressView.frame = CGRectMake(0, currenPrice.bottom, YXScreenW, 115);
    self.seactionView.frame = CGRectMake(0, timeProgressView.bottom, YXScreenW, 40);
    cellOneView.frame = CGRectMake(0, self.seactionView.bottom, YXScreenW, 60);
    cellTwoView.frame = CGRectMake(0, cellOneView.bottom, YXScreenW, 200+35-10+70);
//    cellThreeView.frame = CGRectMake(0, cellTwoView.bottom, YXScreenW, threeviewheight);
    cellFourView.frame = CGRectMake(0, cellTwoView.bottom, YXScreenW, fourviewheight);
    
    __weak typeof(self)weakself = self;
    
    if (self.HeaderHeightblock) {
        
        weakself.HeaderAllHeight = cellTwoView.bottom + threeviewheight + fourviewheight;
        
        self.HeaderHeightblock(self.HeaderAllHeight);
    }
    
}



-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineSpacing = 5;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
@end
