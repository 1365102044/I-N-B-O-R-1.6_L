//
//  YXOneMouthPriceDeatilBaseView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceDeatilBaseView.h"

#import "UILabel+Extension.h"
#import "YXTimeCountDownManger.h"


@interface YXOneMouthPriceDeatilBaseView ()<UIWebViewDelegate>

{
   UILabel *title;
    UILabel *onemouthprice;
    
    UILabel *daojishilable;
    UIButton *daojishiBtn;
    
    UIView*seactionview;
    UILabel *jiandingjibieLable;
//    UILabel *songhuoquyuLable;
    UILabel *fahuoTimeLable;
    
    UIView *shuline1;
    UIView *shuline2;
    
    UIButton *shangpintitle;
    UITextView *shangpincontent;
    UIView *shangpinline;
    
    UIButton *jiaoyiliuchengtitle;
    UIImageView *liuchengimageview;
    UIView*liuchengline;
    
    UIWebView *webview;
    CGFloat webviewHeight;
    
    UIView *topbackBackview;
    UIView *goodsDeatilBackView;
    UIView *LiuchengBackView;
}



@end

@implementation YXOneMouthPriceDeatilBaseView

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
        
        self.backgroundColor  = UIColorFromRGB(0xf9f9f9);
        
        
        [self addSubview:self.adPictureCarouseView];
        
        
        topbackBackview = [[UIView alloc]init];
        topbackBackview.backgroundColor = [UIColor whiteColor];
        [self addSubview:topbackBackview];
        
        
        title = [[UILabel alloc]init];
        title.textColor = UIColorFromRGB(0x030303);
        title.numberOfLines = 0;
        title.font = YXSFont(14);
        [topbackBackview addSubview:title];

        
        
        onemouthprice = [[UILabel alloc]init];
        NSMutableAttributedString* priceattrStr = [[NSMutableAttributedString alloc] initWithString:@"一口价：¥123456"];
        [priceattrStr addAttribute:NSForegroundColorAttributeName value:YXHomeDeatilcolor range:NSMakeRange(0, 4)];
        [priceattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa90311) range:NSMakeRange(4, priceattrStr.length-4)];
        [priceattrStr addAttribute:NSFontAttributeName value:YXRegularfont(14) range:NSMakeRange(0, 4)];
         [priceattrStr addAttribute:NSFontAttributeName value:YXSFont(15) range:NSMakeRange(4, priceattrStr.length-4)];
        onemouthprice.attributedText = priceattrStr;
        [topbackBackview addSubview:onemouthprice];

        
        
        
        daojishilable = [[UILabel alloc]init];
        daojishilable.font = YXSFont(14);
//        [self addSubview:daojishilable];
        daojishilable.textAlignment = NSTextAlignmentRight;
        

        daojishiBtn = [[UIButton alloc]init];
        [daojishiBtn setTitle:@"" forState:UIControlStateNormal];
        [daojishiBtn setImage:[UIImage imageNamed:@"onemouthpricedaojishi"] forState:UIControlStateNormal];
        daojishiBtn.titleLabel.font = YXRegularfont(11);
//        [self addSubview:daojishiBtn];
        [daojishiBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        daojishiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        daojishiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0  );
        daojishiBtn.hidden = YES;
        daojishilable.hidden = YES;
        
        seactionview = [[UIView alloc]init];
        seactionview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        seactionview.layer.borderWidth = 0.5;
        [topbackBackview addSubview:seactionview];
        
        UIColor *seactioncolor = UIColorFromRGB(0x030303);
        jiandingjibieLable = [[UILabel alloc]init];
        jiandingjibieLable.text = @"鉴定级别: A级";
        jiandingjibieLable.textColor = seactioncolor;
        jiandingjibieLable.font = YXRegularfont(12);
        jiandingjibieLable.textAlignment = NSTextAlignmentCenter;
        jiandingjibieLable.numberOfLines = 2;
        jiandingjibieLable.alpha = 0.7;
//        songhuoquyuLable = [[UILabel alloc]init];
//        songhuoquyuLable.text = @"送货区域: 全国";
//        songhuoquyuLable.textColor = seactioncolor;
//        songhuoquyuLable.font = YXRegularfont(12);
//        songhuoquyuLable.textAlignment = NSTextAlignmentCenter;
//        songhuoquyuLable.numberOfLines = 2;
//        songhuoquyuLable.alpha = 0.7;
        
        fahuoTimeLable = [[UILabel alloc]init];
        fahuoTimeLable.text = @"发货时间: 付款后的1-2天";
        fahuoTimeLable.textColor = seactioncolor;
        fahuoTimeLable.font = YXRegularfont(12);
        fahuoTimeLable.textAlignment = NSTextAlignmentCenter;
        fahuoTimeLable.numberOfLines = 2;
        fahuoTimeLable.alpha = 0.7;
        [seactionview addSubview:jiandingjibieLable];
//        [seactionview addSubview:songhuoquyuLable];
        [seactionview addSubview:fahuoTimeLable];
        
        
        shuline1 = [[UIView alloc]init];
        shuline1.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [seactionview addSubview:shuline1];
        
        shuline2 = [[UIView alloc]init];
        shuline2.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [seactionview addSubview:shuline2];
        
        
        
        goodsDeatilBackView = [[UIView alloc]init];
        goodsDeatilBackView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        goodsDeatilBackView.layer.borderWidth = 0.5;
        goodsDeatilBackView.backgroundColor  = [UIColor whiteColor];
        [self addSubview:goodsDeatilBackView];
        
        
        shangpintitle = [[UIButton alloc]init];
        [shangpintitle setTitle:@"商品信息" forState:UIControlStateNormal];
        [shangpintitle setImage:[UIImage imageNamed:@"icon_xinxi"] forState:UIControlStateNormal];
        [shangpintitle setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        shangpintitle.titleLabel.font = YXSFont(13);
        shangpintitle.imageEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
        shangpintitle.titleEdgeInsets = UIEdgeInsetsMake(0, -21, 0, 0);
        [goodsDeatilBackView addSubview:shangpintitle];
        
        shangpinline = [[UIView alloc]init];
        shangpinline.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [goodsDeatilBackView addSubview:shangpinline];
        
        /**
         textview
         */
//        shangpincontent = [[UITextView alloc]init];
//        shangpincontent.text = @"";
//        shangpincontent.editable = NO;
//        [self addSubview:shangpincontent];
//        shangpincontent.userInteractionEnabled = NO;
        
       /**
         webview
         */
        webview = [[UIWebView alloc]init];
        [goodsDeatilBackView addSubview:webview];
        webview.delegate = self;
        webview.dataDetectorTypes = UIDataDetectorTypeNone;
        
        LiuchengBackView = [[UIView alloc]init];
        LiuchengBackView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        LiuchengBackView.layer.borderWidth = 0.5;
        LiuchengBackView.backgroundColor  = [UIColor whiteColor];
        [self addSubview:LiuchengBackView];
        
        jiaoyiliuchengtitle = [[UIButton alloc]init];
        [jiaoyiliuchengtitle setTitle:@"交易流程" forState:UIControlStateNormal];
        [jiaoyiliuchengtitle setImage:[UIImage imageNamed:@"交易流程"] forState:UIControlStateNormal];
        [jiaoyiliuchengtitle setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        jiaoyiliuchengtitle.titleLabel.font = YXSFont(13);
        jiaoyiliuchengtitle.imageEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
        jiaoyiliuchengtitle.titleEdgeInsets = UIEdgeInsetsMake(0, -21, 0, 0);
        [LiuchengBackView addSubview:jiaoyiliuchengtitle];
        
        liuchengline = [[UIView alloc]init];
        liuchengline.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [LiuchengBackView addSubview:liuchengline];
        
        
        
        liuchengimageview = [[UIImageView alloc]init];
        liuchengimageview.image = [UIImage imageNamed:@"交易流程大图"];
        [LiuchengBackView addSubview:liuchengimageview];
        
        
        
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotificationonemouthprice) name:kCountDownNotification object:nil];
        
        
    }
    
    return self;
}


-(void)setOneMouthPriceDeatilData:(YXHomeDeatilModle *)OneMouthPriceDeatilData
{
    _OneMouthPriceDeatilData = OneMouthPriceDeatilData;
    
    /**
      * 拍卖状态,1:未开拍,2:拍卖中,3:中拍未支付；4:拍卖完成 5流拍
     */
    if ([OneMouthPriceDeatilData.bidStatus isEqualToString:@"4"]) {
     
        daojishiBtn.hidden = YES;
        daojishilable.text = @"已结束";
          [kCountDownManager stopTime];
        
    }else if([self.OneMouthPriceDeatilData.prodStatus integerValue] ==3||[OneMouthPriceDeatilData.bidStatus isEqualToString:@"5"]){
        daojishiBtn.hidden = YES;
        daojishilable.text = @"已下架";
        [kCountDownManager stopTime];
    
    }
    
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    long long endtime = [self.OneMouthPriceDeatilData.endTime longLongValue]/1000;
    if([currentTimeStr longLongValue] > endtime)
    {
        daojishiBtn.hidden = YES;
        daojishilable.text = @"已结束";
        [kCountDownManager stopTime];
        
    }
    
    [self countDownNotificationonemouthprice];
    self.adPictureCarouseView.deatilmodle = OneMouthPriceDeatilData;
    title.text = OneMouthPriceDeatilData.prodName;
    jiandingjibieLable.text = [NSString stringWithFormat:@"鉴定级别\n%@",OneMouthPriceDeatilData.identifyLevel];
//    songhuoquyuLable.text = [NSString stringWithFormat:@"送货区域\n%@",OneMouthPriceDeatilData.deliverArea];
    fahuoTimeLable.text = [NSString stringWithFormat:@"发货时间\n%@",OneMouthPriceDeatilData.deliverTime];
    
    NSString *pricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",OneMouthPriceDeatilData.currentPrice/100]];
    NSMutableAttributedString* priceattrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"一口价: ￥%@",pricestr]];
    [priceattrStr addAttribute:NSForegroundColorAttributeName value:YXHomeDeatilcolor range:NSMakeRange(0, 4)];
    [priceattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa90311) range:NSMakeRange(4, priceattrStr.length-4)];
    [priceattrStr addAttribute:NSFontAttributeName value:YXRegularfont(14) range:NSMakeRange(0, 4)];
    [priceattrStr addAttribute:NSFontAttributeName value:YXSFont(15) range:NSMakeRange(4, priceattrStr.length-4)];
    onemouthprice.attributedText = priceattrStr;

    // 354   346
    [self HandleHtmlstr:OneMouthPriceDeatilData.prodDetailContent];
    
    [self layoutSubviews];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    webviewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] floatValue];
    
    [self layoutSubviews];
}
/**
 HTML  处理
 */
-(void)HandleHtmlstr:(NSString *)Html
{
    CGFloat fontSize = 13;
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin:0;font-family: \"%@\";font-size: %f;color: %@;}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",@"PingFangSC-Light",fontSize,YXHomeDeatilcolor,Html];
    
    [webview loadHTMLString:BookStr baseURL:nil];
    
    
}


-(void)countDownNotificationonemouthprice
{
    
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    long long  currentime = [currentTimeStr longLongValue];
    
    long long endtime = [self.OneMouthPriceDeatilData.endTime longLongValue]/1000;
    
    long long startime = [self.OneMouthPriceDeatilData.startTime longLongValue]/1000;
    
    if([currentTimeStr longLongValue] > endtime)
    {
        daojishiBtn.hidden = YES;
        daojishilable.text = @"已结束";
        [kCountDownManager stopTime];
        return;
    }
    
    if (currentime<startime) {
        //**未开拍**/
        daojishiBtn.hidden = NO;
        /// 计算倒计时
        long long countDown = startime - currentime;
        
        NSString *str = [NSString stringWithFormat:@"%02lld:%02lld:%02lld", countDown/3600, (countDown/60)%60, countDown%60];
        [daojishiBtn setTitle:@"距开始:" forState:UIControlStateNormal];
        daojishilable.text = str;
        [self layoutSubviews];
    }else{
        
        daojishiBtn.hidden = NO;
        
        /// 计算倒计时
        long long countDown = endtime - currentime;
        
        NSString *str = [NSString stringWithFormat:@"%02lld:%02lld:%02lld", countDown/3600, (countDown/60)%60, countDown%60];
        [daojishiBtn setTitle:@"距结束:" forState:UIControlStateNormal];
        daojishilable.text = str;
        if (countDown<=0) {
            daojishiBtn.hidden = YES;
            daojishilable.text = @"已结束";
            [kCountDownManager stopTime];
        }
        
        [self layoutSubviews];
    }
    
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
    topbackBackview.frame = CGRectMake(0, self.adPictureCarouseView.bottom, YXScreenW, titleHeight+25+55-1+5);
    
    title.frame = CGRectMake(10, 5, YXScreenW-20, titleHeight);
    onemouthprice.frame = CGRectMake(10, title.bottom+5, YXScreenW*5, 20);
    CGFloat daojishiW = [daojishilable widthWithHeight:20];
    daojishilable.frame = CGRectMake(YXScreenW-10-daojishiW, title.bottom+5, daojishiW, 20);
    daojishilable.centerY = onemouthprice.centerY;
//    daojishiimage.frame = CGRectMake(YXScreenW-daojishiW-15, title.bottom+5+5, 10, 10);
    daojishiBtn.frame= CGRectMake(YXScreenW-daojishiW-12-65, title.bottom+10, 65, 20);
    daojishiBtn.centerY = daojishilable.centerY;
    
    seactionview.frame = CGRectMake(-1, onemouthprice.bottom+10, YXScreenW+2, 44);
    CGFloat textW = YXScreenW/2;
    fahuoTimeLable.frame = CGRectMake(0, 0, textW, seactionview.height);
    jiandingjibieLable.frame = CGRectMake(textW, 0, textW, seactionview.height);
//    songhuoquyuLable.frame = CGRectMake(textW*2, 0, textW, seactionview.height);
    shuline1.frame = CGRectMake(textW, 5, 0.5, seactionview.height-10);
    shuline2.frame = CGRectMake(textW*2, 5, 0.5, seactionview.height-10);
    
    
    
    goodsDeatilBackView.frame = CGRectMake(0, topbackBackview.bottom+10, YXScreenW, webviewHeight+40+25);
    shangpintitle.frame = CGRectMake(10, 0, 100, 40);
    shangpinline.frame = CGRectMake(0, shangpintitle.bottom, YXScreenW, 0.5);
    webview.frame = CGRectMake(10, shangpinline.bottom+10, YXScreenW-20, webviewHeight);
    
    
    
    CGFloat liuchengbackviewheight  = liuchengimageview.image.size.height+20+20+20;
    if (YXScreenW<=320) {
        
        liuchengbackviewheight = 300+40+20;
    }
    LiuchengBackView.frame = CGRectMake(0, goodsDeatilBackView.bottom+10, YXScreenW, liuchengbackviewheight);
    
    jiaoyiliuchengtitle.frame =  CGRectMake(10, 0, 100, 40);
    liuchengline .frame = CGRectMake(0, jiaoyiliuchengtitle.bottom, YXScreenW, 0.5);
    
    liuchengimageview.frame = CGRectMake(10, liuchengline.bottom+5, liuchengimageview.image.size.width, liuchengimageview.image.size.height);
    if (YXScreenW<=320) {
        
        liuchengimageview.size = CGSizeMake(300, 300);
    }
    liuchengimageview.centerX = self.centerX;
    
    
    
    if (self.heightBlock) {
        self.heightBlock(LiuchengBackView.bottom+10);
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
