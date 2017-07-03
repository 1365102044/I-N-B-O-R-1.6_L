//
//  YXMySendAuctionTimeListCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionTimeListCell.h"
#import "YXMySendAuctionTimeList.h"
#import "NSDate+YXExtension.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "YXSendAuctionGetIdentifuDetails.h"

@interface YXMySendAuctionTimeListCell()<YBAttributeTapActionDelegate>

//@property (nonatomic, strong) UIImageView *myImageView;
//@property (nonatomic, strong) UILabel *contentLable;
//@property (nonatomic, strong) UILabel *timeLable;

/**
 状态图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/**
 内容label
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/**
 时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation YXMySendAuctionTimeListCell

#pragma mark - 赋值

- (void)setIsLastTimeListStatus:(BOOL)isLastTimeListStatus
{
    if (isLastTimeListStatus) {
        self.iconImageView.image = [UIImage imageNamed:@"new_1"];
    }
    _isLastTimeListStatus = isLastTimeListStatus;
}

- (void)setMySendAuctionTimeListModel:(YXMySendAuctionTimeList *)mySendAuctionTimeListModel
{
    _mySendAuctionTimeListModel = mySendAuctionTimeListModel;
    
    self.timeLabel.text = mySendAuctionTimeListModel.createTime;
    
    /**
     * 鉴定类型：1.刚提交,2.审核失败,3.审核成功,4.支付鉴定费完成,5.立即邮寄完成,6.确认收货,7.鉴定失败,8.鉴定成功
     */
    //private Integer identifyType;
    //@property (nonatomic, assign) NSInteger identifyType;
    
    if (mySendAuctionTimeListModel.identifyType == 1) {
        [self setTipsText:@"您已提交商品图片和描述，等待审核中"];
    }else if (mySendAuctionTimeListModel.identifyType == 2) {
        //** 拼接服务器返回不合格商品信息 */
        [self setTipsTextWithSuccessOrFailResultString:self.identifuDetails.verifyResult andMark:NO];
        //[self setTipsText:@"您提交的商品图片无法被识别为奢侈品，请重新提交"];
    }else if (mySendAuctionTimeListModel.identifyType == 3) {
        
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]) {
            //立即鉴定
            [self setTipsTextWithSuccessOrFailResultString:self.identifuDetails.verifyResult andMark:NO];
            //[self setTipsText:@"您的商品需要进行官方鉴定，官方鉴定合格的商品将出示权威的鉴定报告"];
        }else{
            //立即验证
            [self setTipsText:@"您提交的商品已经通过初步审核，为了保证您后续的交易安全，请进行相关身份验证"];
        }
        
    }else if (mySendAuctionTimeListModel.identifyType == 4) {
        [self setTipsText:@"请在15日之内将您的商品邮寄到胤宝官方"];
    }else if (mySendAuctionTimeListModel.identifyType == 5) {
        if (mySendAuctionTimeListModel.isDelivery == 0) {
            [self setTipsText:@"待送往胤宝平台"];
        }else if (mySendAuctionTimeListModel.isDelivery == 1){
            [self setTipsText:@"商品已寄出"];
        }
        
    }else if (mySendAuctionTimeListModel.identifyType == 6) {
        [self setTipsText:@"正在为您鉴定商品，请耐心等待"];
    }else if (mySendAuctionTimeListModel.identifyType == 7) {
        //** 拼接不合格商品信息 */
        [self setTipsTextWithSuccessOrFailResultString:@"鉴定完毕，您的商品不符合售卖规定。" andMark:YES];
        //[self setTipsText:@"鉴定完毕，您的商品不符合售卖规定。（查看鉴定报告）"];
    }else if (mySendAuctionTimeListModel.identifyType == 8) {
        //** 拼接不合格商品信息 */
        [self setTipsTextWithSuccessOrFailResultString:@"鉴定完毕，您的商品符合售卖规定。" andMark:YES];
        //[self setTipsText:@"鉴定完毕，您的商品符合售卖规定。（查看鉴定报告）"];
    }else if (mySendAuctionTimeListModel.identifyType == 9) {
        [self setTipsText:@"交易已取消"];
    }
    
    
    /**
     * 订单状态
     * 1为刚提交，2为审核不通过，3为审核通过 ，4部分付款，5待发货，6待确认收货，7交易完成，8交易取消
     */
    //private Integer orderStatus;
    //@property (nonatomic, assign) NSInteger orderStatus;
  
    
}

/**
 更新提示标签文案
 
 @param tipsText 传入提示文字
 */
- (void)setTipsText:(NSString *)tipsText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0;
    NSString *psText = tipsText;
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:10],
                                    NSParagraphStyleAttributeName:paragraphStyle
                                    };
    [attributes addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    
    self.contentLabel.attributedText = attributes;
    self.contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
}

/**
 更新查看鉴定报告标签文案

 @param string 传入的结果文字
 */
- (void)setTipsTextWithSuccessOrFailResultString:(NSString *)string andMark:(BOOL)mark
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0;
    NSString *psText;
    if (mark) {
        psText = [NSString stringWithFormat:@"%@", string];
    }else{
        psText = string;
    }
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:10],
                                    NSParagraphStyleAttributeName:paragraphStyle
                                    };
    [attributes addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    
    if (mark) {
        //[attributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:151.0/255.0 green:29.0/255.0 blue:20.0/255.0 alpha:1.0] range:NSMakeRange(string.length, 8)];
        //--添加点击事件
        //[self.contentLabel yb_addAttributeTapActionWithStrings:@[@"（查看鉴定报告）"] delegate:self];
    }
    
    self.contentLabel.attributedText = attributes;
    self.contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //self.backgroundColor = UIColorFromRGB(0xf9f9f9);
//        self.backgroundColor = [UIColor whiteColor];
//        
//        self.myImageView = [[UIImageView alloc]init];
//        self.myImageView.layer.cornerRadius = 7;
//        self.myImageView.layer.masksToBounds = 7;
//        self.myImageView.backgroundColor = [UIColor greenColor];
//        self.myImageView.image = [UIImage imageNamed:@"椭圆-2-拷贝"];
//        
//        [self.contentView addSubview:self.myImageView];
//        
//        
//        self.contentLable = [[UILabel alloc]init];
//        
//        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"获取网络信息"];
//        
//        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle1 setLineSpacing:4.0];
//        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
//        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(0, attrStr.length)];
//        [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(12) range:NSMakeRange(0, attrStr.length)];
//        
//        self.contentLable.attributedText = attrStr;
//        self.contentLable.font = [UIFont systemFontOfSize:10];
//        [self.contentLable sizeToFit];
//        self.contentLable.numberOfLines = 0;
//        [self.contentView addSubview:self.contentLable];
//        
//        self.timeLable = [[UILabel alloc]init];
//        self.timeLable.text = @"2016-08-09 12:30";
//        self.timeLable.font = YXRegularfont(8);
//        self.timeLable.textColor = UIColorFromRGB(0x050505);
//        self.timeLable.alpha = 0.8;
//        [self.contentView addSubview:self.timeLable];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView).mas_offset(10);
//        make.left.mas_equalTo(self.contentView).mas_offset(15);
//        make.width.height.mas_equalTo(14);
//    }];
//    
//    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.myImageView).mas_offset(0);
//        make.left.mas_equalTo(self.myImageView.mas_right).mas_offset(5);
//        make.right.mas_equalTo(self.contentView).mas_equalTo(-10);
//    }];
//    
//    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentLable);
//        make.top.mas_equalTo(self.contentLable.mas_bottom).mas_offset(4);
//        make.height.mas_equalTo(10);
//        make.bottom.mas_equalTo(self.contentView);
//    }];
}

-(void)drawRect:(CGRect)rect
{
//    //    线条颜色
//    UIColor *color = UIColorFromRGB(0xbab9b9);
//    
//    [color set];
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    path.lineWidth = 1;
//    //    path.lineCapStyle = kCGLineCapRound;
//    //    path.lineJoinStyle = kCGLineJoinRound;
//    
//    CGFloat PathX = self.myImageView.x+self.myImageView.width/2;
//    [path moveToPoint:CGPointMake(PathX, 0)];
//    [path addLineToPoint:CGPointMake(PathX, self.myImageView.y)];
//    //    [path closePath];
//    [path stroke];
//    
//    UIBezierPath *path1 = [UIBezierPath bezierPath];
//    path1.lineWidth = 1;
//    [path1 moveToPoint:CGPointMake(PathX, self.myImageView.bottom)];
//    [path1 addLineToPoint:CGPointMake(PathX,self.height)];
//    [path1 stroke];
    
    
}
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineSpacing = 4.0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


#pragma mark - 赋值

/**
 UILabel点击文字事件
 
 @param string 点击的文字
 @param range  范围
 @param index  下标
 */
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    //回调到控制器，push鉴定报告界面
    if ([self.delegate respondsToSelector:@selector(mySendAuctionTimeListCell:clickText:andIdentifyId:)]) {
        [self.delegate mySendAuctionTimeListCell:self clickText:string andIdentifyId:self.mySendAuctionTimeListModel.orderId];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
