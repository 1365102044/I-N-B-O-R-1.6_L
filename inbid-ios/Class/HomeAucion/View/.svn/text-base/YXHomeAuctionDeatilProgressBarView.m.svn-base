//
//  YXHomeAuctionDeatilProgressBarView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilProgressBarView.h"
#import "Masonry.h"

#define  timetextcolor [UIColor mainThemColor]


#import "YXTimeCountDownManger.h"

@interface YXHomeAuctionDeatilProgressBarView ()

{
        NSTimer *_timer;

    UILabel *progressTitle;
    UIProgressView *progressview;
    
    UIButton *brankBtn;    // 品牌
    UIButton *categoryBtn;  //品类
    
    UILabel *daojishilable;
    BOOL daojishubool;
    
    long long daojishiTiem;
    
    BOOL daojishiStatus;
    
}

@end

@implementation YXHomeAuctionDeatilProgressBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
   
        
        progressTitle = [[UILabel alloc]init];
        progressTitle.text = @"进行中";
        progressTitle.font = YXSFont(18);
        progressTitle.textColor = timetextcolor;
        progressTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:progressTitle];
        
        
        brankBtn = [[UIButton alloc]init];
        [brankBtn setTitle:@" IWC万国" forState:UIControlStateNormal];
        [brankBtn setImage:[UIImage imageNamed:@"icon_4"] forState:UIControlStateNormal];
        [brankBtn setTitleColor:timetextcolor forState:UIControlStateNormal];
        brankBtn.titleLabel.font = YXSFont(12);
        brankBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        //        brankBtn.backgroundColor= [UIColor redColor];
        [self addSubview:brankBtn];
        
        categoryBtn = [[UIButton alloc]init];
        [categoryBtn setTitle:@" 腕表" forState:UIControlStateNormal];
        [categoryBtn setImage:[UIImage imageNamed:@"icon_4"] forState:UIControlStateNormal];
        [categoryBtn setTitleColor:timetextcolor forState:UIControlStateNormal];
        categoryBtn.titleLabel.font = YXSFont(12);
        categoryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        [self addSubview:categoryBtn];
        
        //        categoryBtn.backgroundColor= [UIColor redColor];
        
        
        
        progressview = [[UIProgressView alloc]init];
        //设置进度条颜色
        progressview.trackTintColor= UIColorFromRGB(0xf0f0f0);
        //设置进度条上进度的颜色
        progressview.progressTintColor= timetextcolor;
        //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
        progressview.progress=0.7;
        progressview.layer.masksToBounds = YES;
        progressview.layer.cornerRadius = 2;
        [self addSubview:progressview];
        
        
        daojishilable = [[UILabel alloc]init];
        [self addSubview:daojishilable];
        daojishilable.text = @"";
        daojishilable.textColor = [UIColor mainThemColor];
        daojishilable.font = YXRegularfont(12);
        daojishilable.textAlignment = NSTextAlignmentRight;
     
        [YXNotificationTool addObserver:self selector:@selector(stoptimedaojishi) name:@"SOPTTIMEDAOJISHI" object:nil];
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    
    return self;
}

/*
 @brief 关闭倒计时
 */
-(void)stoptimedaojishi
{
//    [self timerStop];
}

-(void)setLoopmodle:(YXHomeDeatilModle *)loopmodle
{
    _loopmodle = loopmodle;
    
    self.modle.endTime = loopmodle.endTime;

    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    
    long long nowtime = [currentTimeStr longLongValue];
    
    long long  endtime = [loopmodle.endTime longLongValue]/1000;
    
    if ([loopmodle.prodStatus isEqualToString:@"3"]) {
        
        progressTitle.text = @"已下架";
        
    }else{
        if (nowtime > endtime) {
            
            progressTitle.text = @"已结束";
            
        }else{
            progressTitle.text = @"进行中";
            
        }
    }
    
    
    NSString *startimestr = [NSString stringWithFormat:@"%@",_modle.startTime];
    long long startint = [startimestr longLongValue]/1000;
    
    NSDate *date;
    date = [NSDate dateWithTimeIntervalSince1970:([loopmodle.endTime longLongValue] / 1000.0)];
    if(nowtime<startint)
    {
        progressTitle.text = @"未开始";
        date = [NSDate dateWithTimeIntervalSince1970:([loopmodle.startTime longLongValue] / 1000.0)];
    }


    
    //    已过的时间
    long long oldtime = nowtime - startint;
    //    总时间
    long long alltime = endtime - startint;
    //    计算比例
    double progresstime = (double)oldtime/alltime;
    
    progressview.progress = progresstime;
    
    
    /*
     @brief 结束竞拍
     */
    if([currentTimeStr longLongValue] > endtime)
    {
        NSDate *endtimedate = [NSDate dateWithTimeIntervalSince1970:([loopmodle.endTime longLongValue] / 1000.0)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        NSString *endtime = [formatter stringFromDate:endtimedate];
        
        daojishilable.text = [NSString stringWithFormat:@"结束时间：%@", endtime];
    }
    
    
}



/*
 @brief 赋值
 */
-(void)setModle:(YXHomeDeatilModle *)modle
{
    _modle = modle;
    
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    long long nowtime = [currentTimeStr longLongValue];
    
    
    long long  endtime = [modle.endTime longLongValue]/1000;
    
    if ([modle.prodStatus isEqualToString:@"3"]) {
        
        progressTitle.text = @"已下架";
        
    }else{
        if (nowtime > endtime) {
            
            progressTitle.text = @"已结束";
            
        }else{
            progressTitle.text = @"进行中";
            
        }
    }
    
    [brankBtn setTitle:modle.prodBrandName forState:UIControlStateNormal];
    [categoryBtn setTitle:modle.catName forState:UIControlStateNormal];
    
    
    
    NSString *startimestr = [NSString stringWithFormat:@"%@",modle.startTime];
    NSString *endtimestr = [NSString stringWithFormat:@"%@",modle.endTime];
    
    long long startint = [startimestr longLongValue]/1000;
    long long endint = [endtimestr longLongValue]/1000;
    
    //    已过的时间
    long long oldtime = nowtime - startint;
    //    总时间
    long long alltime = endint - startint;
    
    //    计算比例
    double progresstime = (double)oldtime/alltime;
    
    progressview.progress = progresstime;
 
    NSDate *date;
    date = [NSDate dateWithTimeIntervalSince1970:([modle.endTime longLongValue] / 1000.0)];
    
    if(nowtime<startint)
    {
        progressTitle.text = @"未开始";
        date = [NSDate dateWithTimeIntervalSince1970:([modle.startTime longLongValue] / 1000.0)];
          long long countDown = startint - [currentTimeStr longLongValue] ;
        
        NSString *str = [NSString stringWithFormat:@"距开拍:%02lld小时%02lld分钟%02lld秒", countDown/3600, (countDown/60)%60, countDown%60];
        NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(0, 3)];
        [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(12) range:NSMakeRange(0,3)];
        /// 重新赋值
        daojishilable.attributedText = currenattrStr;
    }else if ([currentTimeStr longLongValue] > startint)
    {
         /*
         @brief 结束竞拍
         */
        if([currentTimeStr longLongValue] > endint)
        {
            NSDate *endtimedate = [NSDate dateWithTimeIntervalSince1970:([modle.endTime longLongValue] / 1000.0)];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            NSString *endtime = [formatter stringFromDate:endtimedate];
            
            NSString *str =  [NSString stringWithFormat:@"结束时间：%@", endtime];
            NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
            [currenattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(0, 4)];
            [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(12) range:NSMakeRange(0,4)];
            /// 重新赋值
            daojishilable.attributedText = currenattrStr;
            
            
            daojishubool = 1;
        }else{
        
            long long countDown = endint - [currentTimeStr longLongValue];
            
            
            NSString *str = [NSString stringWithFormat:@"距结束:%02lld小时%02lld分钟%02lld秒", countDown/3600, (countDown/60)%60, countDown%60];
            NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
            [currenattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(0, 3)];
            [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(12) range:NSMakeRange(0,3)];
            /// 重新赋值
            daojishilable.attributedText = currenattrStr;
            
        }

    }
}


-(void)countDownNotification
{
   
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    long long  currentime = [currentTimeStr longLongValue];
    
    long long endtime = [self.modle.endTime longLongValue]/1000;
    
    long long startime = [self.modle.startTime longLongValue]/1000;
    
    if([currentTimeStr longLongValue] > endtime)
    {
        daojishubool = 1;
    }
    
    if (daojishubool) {
        return;
    }
    
    
    if (currentime<startime) {
        //**未开拍**/
        
        /// 计算倒计时
        long long countDown = startime - currentime;
        
        NSString *str = [NSString stringWithFormat:@"距开拍:%02lld小时%02lld分钟%02lld秒", countDown/3600, (countDown/60)%60, countDown%60];
        NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(0, 3)];
        [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(12) range:NSMakeRange(0,3)];
        /// 重新赋值
        daojishilable.attributedText = currenattrStr;
        
    }else{
        
        
        /// 计算倒计时
        long long countDown = endtime - currentime;
        
        NSString *str = [NSString stringWithFormat:@"距结束:%02lld小时%02lld分钟%02lld秒", countDown/3600, (countDown/60)%60, countDown%60];
        NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(0, 3)];
        [currenattrStr addAttribute:NSFontAttributeName value:YXRegularSoldfont(12) range:NSMakeRange(0,3)];
        /// 重新赋值
        daojishilable.attributedText = currenattrStr;
      
        if (countDown<=0) {
            
            [YXNotificationTool postNotificationName:@"JISHUDAOJISHI" object:nil];
        }
        
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [progressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(0);
        make.height.with.offset(20);
        
    }];
    

    [brankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).with.offset(YXScreenW*0.1);
        make.top.equalTo(progressTitle.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.4);
        make.height.with.offset(20);
        
    }];

    [categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).with.offset(-20);
        make.centerY.equalTo(brankBtn.mas_centerY);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.4);
        make.height.with.offset(20);
        
    }];
    
    [progressview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(brankBtn.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(4);
        
    }];
    
    
    daojishilable.frame = CGRectMake(progressview.x, progressview.bottom+5, progressview.width, 20);
    
    
   
}
@end
