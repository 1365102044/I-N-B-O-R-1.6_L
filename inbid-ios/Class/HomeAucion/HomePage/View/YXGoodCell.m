//
//  YXGoodCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXGoodCell.h"
#import <UIImageView+WebCache.h>
#import "YXHomePageGoodList.h"
#import "YXContentLabel.h"
#import "YXStringFilterTool.h"
#import "YXMyQuerProdBidListCountTime.h"
#import "YXProjectImageConfigManager.h"

@interface YXGoodCell()

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

/**
 品牌label
 */
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

/**
 物品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

/**
 价格label
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/**
 状态指示
 */
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

/**
 用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

/**
 用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

/**
 是否是自营状态
 */
@property (weak, nonatomic) IBOutlet UIImageView *isSelfStatusImageView;

/**
 底部视图高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightCons;

/**
 状态蒙层视图
 */
@property (weak, nonatomic) IBOutlet UIView *StatusBackview;

/**
 状态文字label
 */
@property (weak, nonatomic) IBOutlet UILabel *StatusLable;

/**
 底部功能视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 金钱标志
 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLogoLabel;

/**
 背景图
 */
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation YXGoodCell


//** 接收到倒计时定时器通知 */
//- (void)countDownTimeTextLael
//{
//    if (self.good.bidStatus == 1) {
//        //** 未开始 */
//        self.countDownLabel.text = @"距离开始:";
//    }else if (self.good.bidStatus == 2) {
//        //** 进行中 */
//        self.countDownLabel.text = @"距离结束:";
//    }
//    
//    if ([[self.timeModel currentTimeString] isEqualToString:@"00:00:00"]) {
//        self.countDownLabel.font = YXRegularfont(10.0);
//        self.countDownContentLabel.font = YXRegularfont(10.0);
//        self.countDownLabel.text = @"已结";
//        self.countDownContentLabel.text = @"束";
//    }else{
//        self.countDownLabel.font = YXRegularfont(10.0);
//        self.countDownContentLabel.font = YXRegularfont(12.0);
//        self.countDownContentLabel.text = [self.timeModel currentTimeString];
//    }
//}

/**
 给倒计时赋值

 @param timeModel timeModel
 */
- (void)setTimeModel:(YXMyQuerProdBidListCountTime *)timeModel
{
    _timeModel = timeModel;
    
    //** 赋值cell倒计时 */
    //[self countDownTimeTextLael];
}

- (void)pinchGesture:(UIPinchGestureRecognizer * )pinchGesture
{
    //是否缩放
    BOOL isScale = NO;
    
    if (pinchGesture.scale > 1) {
        isScale = YES;
    }else{
        isScale = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(goodCell:isScalItem:)]) {
        [self.delegate goodCell:self isScalItem:isScale];
    }
}

- (void)setGood:(YXHomePageGoodList *)good
{
    _good = good;
//    YXLog(@"++name+%@++%ld+++",good.prodName,(long)good.bidStatus);
    if (good.imgUrl) {
        [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:[YXProjectImageConfigManager projectImageConfigManagerWithImageUrlString:good.imgUrl configType:YXProjectImageConfigMid]] placeholderImage:nil options:SDWebImageRetryFailed];
    }else{
        self.goodImageView.backgroundColor = [UIColor whiteColor];
    }
    
    
    /**
     * 拍卖状态:1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
     */
    //private Integer bidStatus;
    //@property (nonatomic, assign)NSInteger bidStatus;
    
    [self resetStatusLabel];
    long long yuan = good.currentPrice / 100;
    if (good.bidStatus == 1) {
//        self.countDownContentLabel.text = [self.timeModel currentTimeString];
    }else if (good.bidStatus == 2){
//        self.countDownContentLabel.text = [self.timeModel currentTimeString];
    }else if (good.bidStatus == 3){
        [self showStatusTextWithText:@"付款中"];
    }else if (good.bidStatus == 4){
        [self showStatusTextWithText:@"已售罄"];
    }else if (good.bidStatus == 5){
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", yuan]]];
    self.brandLabel.text = good.prodBrandName;
    self.goodNameLabel.text = good.prodName;
    
//    if (good.nickname) {
//        self.userNameLabel.text = good.nickname;
//    }else{
//        self.userNameLabel.text = @"未获取昵称";
//    }
    
//    if ([good.head isEqualToString:@"default"] || [good.head isEqualToString:@""] || [good.head isKindOfClass:[NSNull class]]) {
//        self.userIconImageView.image = [UIImage imageNamed:@"ic_default"];
//    }else if ([good.head isEqualToString:@"male"]) {
//        self.userIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@", good.head]];
//    }else if ([good.head isEqualToString:@"female"]) {
//        self.userIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@", good.head]];
//    }else{
//        [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:good.head] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
//    }
    
    //** 暂时隐藏 */
    if (good.isSelf == 1) {
        self.isSelfStatusImageView.hidden = YES;
    }else{
    self.isSelfStatusImageView.hidden = YES;
    }
}

/**
 展示状态文字

 @param text 文字
 */
- (void)showStatusTextWithText:(NSString *)text
{
    self.StatusLable.text = text;
    self.StatusBackview.alpha = 0.45;
    self.StatusLable.alpha = 1;
}

- (void)resetStatusLabel
{
    self.StatusLable.alpha = 0;
    self.StatusBackview.alpha = 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.good.goodNameTextHeight < 27) {
        self.bottomViewHeightCons.constant = 90;
    }else{
        self.bottomViewHeightCons.constant = 107;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
    
    self.layer.shadowColor          = [UIColor blackColor].CGColor;
    self.layer.masksToBounds        = NO;
    self.layer.contentsScale        = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity        = 0.06f;
    self.layer.shadowRadius         = 3.0f;
    self.layer.shadowOffset         = CGSizeMake(0,0);
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shouldRasterize      = YES;
    self.layer.rasterizationScale   = [UIScreen mainScreen].scale;
    
    self.userIconImageView.layer.cornerRadius = 12.5;
    self.userIconImageView.layer.masksToBounds = YES;
    
//    self.priceLabel.textColor = [UIColor themGoldColor];
//    [self.broderView.layer setBorderWidth:1.0];
//    CGColorRef color = [UIColor themGrayColor].CGColor;
//    [self.broderView.layer setBorderColor:color];
    
    //** 字体设置 */
//    self.countDownLabel.font = YXRegularfont(10.0);
//    self.countDownContentLabel.font = YXRegularfont(12.0);
//    
//    self.userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0];
//    self.userNameLabel.textColor = [UIColor colorWithWhite:76.0/255.0 alpha:1.0];
    
    //self.priceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    self.priceLabel.textColor = [UIColor themGoldColor];
    self.priceLabel.font = [UIFont systemFontOfSize:14.f];
    
    self.priceLabel.backgroundColor = [UIColor whiteColor];
    self.brandLabel.backgroundColor = [UIColor whiteColor];
//    self.userNameLabel.backgroundColor = [UIColor themLightGrayColor];
    
    self.StatusLable.layer.masksToBounds = YES;
    self.StatusLable.layer.cornerRadius = 35;
    self.StatusBackview.layer.masksToBounds = YES;
    self.StatusBackview.layer.cornerRadius = 35;
    self.StatusLable.textColor = [UIColor whiteColor];
    self.StatusLable.alpha = 0;
    self.StatusBackview.alpha = 0;
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.StatusBackview.backgroundColor = [UIColor blackColor];
    
    self.brandLabel.font = [UIFont systemFontOfSize:13];
    self.brandLabel.textColor = UIColorFromRGB(0x262626);
    
    self.goodNameLabel.font = YXRegularfont(12);
    self.goodNameLabel.textColor = UIColorFromRGB(0x4c4c4c);
    self.goodNameLabel.backgroundColor = [UIColor whiteColor];
    
    self.moneyLogoLabel.textColor = [UIColor themGoldColor];
    self.moneyLogoLabel.backgroundColor = [UIColor whiteColor];
}

@end
