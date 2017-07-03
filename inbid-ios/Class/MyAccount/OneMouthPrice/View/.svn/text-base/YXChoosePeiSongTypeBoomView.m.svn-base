//
//  YXChoosePeiSongTypeBoomView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChoosePeiSongTypeBoomView.h"
#import "UILabel+Extension.h"



@interface YXChoosePeiSongTypeBoomView ()
{

    UILabel *titlelable;
    UIView *btnbackview;
    UIView *lineview;
    UILabel *desclable;
    CGFloat btnviewboom;
    UIButton *lastbtn;

}
@property(nonatomic,assign) BOOL  isCanfenbi;
@property (nonatomic, strong) NSMutableArray * typearr;
@end

@implementation YXChoosePeiSongTypeBoomView


-(void)setUIWithorderAllprice:(NSInteger )orderallprice iscanDingjin:(NSInteger)iscandingjin
{
    _isCanfenbi = YES;
    
    if (orderallprice/100 <= 4000 ) {
        _isCanfenbi = NO;
        
    }
    _typearr = [NSMutableArray array];
    
    _typearr = [NSMutableArray arrayWithArray:@[@"全额支付",@"定金支付",@"分笔支付"]];
    
    
    if (!_isCanfenbi) {
        _typearr = [NSMutableArray arrayWithArray:@[@"全额支付",@"定金支付"]];
    }
    if (iscandingjin==0) {
        [_typearr removeObjectAtIndex:1];
    }
    for (int i=0; i<_typearr.count; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        NSInteger colnumber = 3;
        CGFloat btnW= (YXScreenW-60)/3;
        CGFloat btnH= 40.0;
        NSInteger cols = i%colnumber;
        NSInteger rows = i/colnumber;
        btn.frame = CGRectMake(cols*(btnW+20)+10, rows*(20+btnH)+10, btnW, btnH);
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.typearr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        btn.titleLabel.font= YXSFont(13);
        btn.tag = 1+i;
        btnviewboom = btn.bottom+10;
        [btnbackview addSubview:btn];
        btn.layer.borderColor = [UIColor mainThemColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
        [btnbackview layoutSubviews];
    }
    
    
    [self layoutSubviews];

}




/**
 赋值
 */
-(void)setPeisongtype:(NSString *)peisongtype
{
    _peisongtype = peisongtype;
    NSString *titlestr = [peisongtype componentsSeparatedByString:@"\n"][0];
    for (UIButton *btns in btnbackview.subviews) {
        
        if ([btns.titleLabel.text isEqualToString:titlestr]) {
            
            btns.selected = YES;
            [btns setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btns.backgroundColor = [UIColor mainThemColor];
            lastbtn = btns;
            
            if ([titlestr isEqualToString:@"定金支付"]) {
                desclable.hidden = NO;
                desclable.text = @"先支付10%定金，余额可在48小时内支付，如规定时间内未支付余款，定金将被扣除";
                [self layoutSubviews];
            }
            
        }
    }
    
}
/**
 点击
 */
-(void)ChangebtnCout:(NSNotification *)noti
{
    NSString *titlestr = noti.userInfo[@"btntitle"];
    
//    if ([titlestr isEqualToString:@"快递送货"]) {
//        
//        for (UIButton * btns in btnbackview.subviews) {
//            if([btns.titleLabel.text isEqualToString:@"订金+刷卡"])
//            {
//                btns.hidden = YES;
//      
//            }
//        }
//       
//    }else if ([titlestr isEqualToString:@"来店自提"])
//    {
//        for (UIButton * btns in btnbackview.subviews) {
//             if([btns.titleLabel.text isEqualToString:@"订金+刷卡"])
//            {
//                btns.hidden = NO;
//               
//            }
//        }
//        
//    }
    
    [self changebtnviewboomwith:titlestr];
}

-(void)changebtnviewboomwith:(NSString *)str
{
//    if ([str isEqualToString:@"快递送货"]) {
//        if (_typearr.count>3) {
//            btnviewboom = 120;
//        }else
//        {
//            btnviewboom = 60;
//        }
//        
//    }else if ([str isEqualToString:@"来店自提"])
//    {
//      
//
//    }
    
    
//    if (_typearr.count>3) {
//        
//        btnviewboom = 120;
//    }else
//    {
//    
//    }
//    NSInteger  cols =  _typearr.count/3;
    if (_typearr.count>3) {
        
        btnviewboom = 60*2;
    }else{
    
        btnviewboom = 60;
    }
    [self layoutSubviews];

}

-(void)clickbtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"定金支付"] ) {
        
        desclable.hidden = NO;
        desclable.text = @"先支付10%定金，余额可在48小时内支付，如规定时间内未支付余款，定金将被扣除";
        
    }else
    {
        desclable.hidden = YES;
    }
    lastbtn.selected = NO;
    sender.selected = YES;
    [lastbtn setTitleColor: [UIColor mainThemColor] forState:UIControlStateNormal];
    lastbtn.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor mainThemColor];
    lastbtn = sender;
    
    [YXNotificationTool postNotificationName:@"onepricepaystr" object:nil userInfo:@{@"pay":lastbtn.titleLabel.text}];
    
    [self layoutSubviews];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        titlelable = [[UILabel alloc]init];
        titlelable.text = @"付款方式";
        titlelable.textColor = UIColorFromRGB(0x050505);
        titlelable.font = YXRegularfont(15);
        [self addSubview:titlelable];
        
        lineview = [[UIView alloc]init];
        lineview.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:lineview];
        
        
        btnbackview = [[UIView alloc]init];
        [self addSubview:btnbackview];
     

        desclable = [[UILabel alloc]init];
        desclable.textColor =UIColorFromRGB(0xfd060c);
        desclable.font = YXRegularfont(9);
        desclable.numberOfLines = 0;
        [desclable setRowSpace:5];
        [self addSubview:desclable];
        
        [YXNotificationTool addObserver:self selector:@selector(ChangebtnCout:) name:@"changebtncount" object:nil];
        desclable.hidden = YES;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    titlelable.frame = CGRectMake(10, 10, YXScreenW-20, 20);
    lineview.frame = CGRectMake(0, titlelable.bottom+10, YXScreenW, 0.5);
    btnbackview.frame = CGRectMake(0, lineview.bottom, YXScreenW, btnviewboom);
    
    CGFloat desH = [desclable heightWithWidth:YXScreenW-20];
    if (desH<=20) {
        desH = 20;
    }
    desclable.frame = CGRectMake(10, btnbackview.bottom, YXScreenW-20, desH);
    if (desclable.hidden) {
        
        if (self.heightblock) {
            self.heightblock(btnbackview.bottom+10);
        }
    }else{
        if (self.heightblock) {
            self.heightblock(desclable.bottom+10);
        }
    }
    
}

@end
