//
//  YXChoosePeiSongTypeTopView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChoosePeiSongTypeTopView.h"
#import "UILabel+Extension.h"

@interface YXChoosePeiSongTypeTopView ()
{
    UILabel *titlelable;
    UIView *choosebtnview;
    UIView *boomview;
    UILabel *addresslable;
    UILabel *phonelable;
    UILabel *timelable;
    UILabel *desclable;
    UIButton *lastbtn;
}

@end
@implementation YXChoosePeiSongTypeTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor *color = UIColorFromRGB(0x050505);
        titlelable = [self setmylable:@"配送方式" color:color font:15];
        [self addSubview:titlelable];
        
        choosebtnview = [[UIView alloc]init];
        choosebtnview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        choosebtnview.layer.borderWidth = 0.5;
        [self addSubview:choosebtnview];
        
        NSArray *arr = @[@"快递送货",@"来店自提"];
        for (int i=0; i<2; i++) {
            
            CGFloat btnW = 100;
            CGFloat btnH = 40;
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake((btnW + 20)*i+10, 15, btnW, btnH);
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
            btn.titleLabel.font= YXSFont(13);
            btn.tag = i+1;
            btn.layer.borderColor = [UIColor mainThemColor].CGColor;
            btn.layer.borderWidth = 1;
            btn.layer.cornerRadius = 2;
            btn.layer.masksToBounds = YES;
            [choosebtnview addSubview:btn];
            if (i==0) {
                lastbtn = btn;
            }
        }
        
        
        boomview = [[UIView alloc]init];
        [self addSubview:boomview];
        
        addresslable = [self setmylable:[NSString stringWithFormat:@"自提地址：%@",[YXLoadZitiData objectZiTiWithforKey:@"consigneeAddress"]] color:color font:11];
        addresslable.numberOfLines = 0;
        phonelable = [self setmylable:[NSString stringWithFormat:@"贵宾专线：%@",[YXLoadZitiData objectZiTiWithforKey:@"customerPhone"]] color:color font:11];
        timelable = [self setmylable:[NSString stringWithFormat:@"营业时间：%@",[YXLoadZitiData objectZiTiWithforKey:@"businessTime"]] color:color font:11];
        desclable = [self setmylable:@"贵重商品提货时需要验证提货人身份信息，请提货人携带本人身份证到自提地址提取您购买的商品，如需其他人代提货，请携带代办人及提货人本人身份证" color:UIColorFromRGB(0xfd060c) font:9];
        desclable.numberOfLines = 0;
        [desclable setRowSpace:5];
        
        [boomview addSubview:addresslable];
        [boomview addSubview:phonelable];
        [boomview addSubview:timelable];
        [boomview addSubview:desclable];
        boomview.hidden = YES;
    }
    return self;
}


/**
 赋值
 */
-(void)setPeisongtype:(NSString *)peisongtype
{
    _peisongtype = peisongtype;
    NSString *titlestr = [peisongtype componentsSeparatedByString:@"\n"][1];
    
    if ([titlestr isEqualToString:@"来店自提"]) {
        boomview.hidden = NO;
    }
    for (UIButton *btns in choosebtnview.subviews) {
        if ([btns.titleLabel.text isEqualToString:titlestr]) {
            btns.selected = YES;
            [btns setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btns.backgroundColor = [UIColor mainThemColor];
            lastbtn = btns;
        }
    }

}

/**
 点击
 */
-(void)ClickBtn:(UIButton *)sender
{
//    YXLog(@"---点击-%@",sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"快递送货"]) {
        
        boomview.hidden = YES;
    }else if ([sender.titleLabel.text isEqualToString:@"来店自提"])
    {
        boomview.hidden = NO;
    }
    [YXNotificationTool postNotificationName:@"changebtncount" object:nil userInfo:@{@"btntitle":sender.titleLabel.text}];
    lastbtn.selected = NO;
    sender.selected = YES;
    [lastbtn setTitleColor: [UIColor mainThemColor] forState:UIControlStateNormal];
    lastbtn.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor mainThemColor];
    lastbtn = sender;

    [YXNotificationTool postNotificationName:@"onepricewuliustr" object:nil userInfo:@{@"wuliu":lastbtn.titleLabel.text}];
    
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftmar = 10;
    CGFloat textH = 20;
    titlelable.frame = CGRectMake(leftmar, 10, YXScreenW-20, textH);
    choosebtnview.frame = CGRectMake(0, titlelable.bottom+10, YXScreenW, 70);

    CGFloat addH = [addresslable heightWithWidth:YXScreenW-20];
    if (addH<=textH) {
        addH = textH;
    }
    addresslable.frame = CGRectMake(leftmar, 5, YXScreenW-20, addH);
    phonelable.frame = CGRectMake(leftmar, addresslable.bottom+5, YXScreenW-20, textH);
    timelable.frame = CGRectMake(leftmar, phonelable.bottom+5, YXScreenW-20, textH);
    CGFloat descH = [desclable heightWithWidth:YXScreenW-20];
    if (descH<=textH) {
        descH = textH;
    }
    desclable.frame = CGRectMake(leftmar, timelable.bottom+5, YXScreenW-20, descH);
    CGFloat boomH = desclable.bottom+10;
    boomview.frame = CGRectMake(0, choosebtnview.bottom, YXScreenW, boomH);
    if ([lastbtn.titleLabel.text isEqualToString:@"快递送货"]) {

        if (self.heightblock) {
            self.heightblock(choosebtnview.bottom);
        }
        
    }else if ([lastbtn.titleLabel.text isEqualToString:@"来店自提"])
    {
        if (self.heightblock) {
            self.heightblock(boomview.bottom+10);
        }
    }
}

-(UILabel *)setmylable:(NSString *)str color:(UIColor*)color font:(NSInteger)font
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = str;
    lable.textColor = color;
    lable.font = YXRegularfont(font);
    return lable;
}
@end
