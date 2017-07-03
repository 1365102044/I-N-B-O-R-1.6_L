//
//  YXMyAccountPaymentChoosePayTypeView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountPaymentChoosePayTypeView.h"
#import "YXKeyboardToolbar.h"


@interface YXMyAccountPaymentChoosePayTypeView ()<UITextFieldDelegate,YXKeyboardToolbarDelegate>

{
    UIButton *weixinpaybtn;
    UIButton *zhifubaopaybtn;
    UIButton *yinlianpaybtn;
    UITextField*MoneycountTextfield;
    UILabel*desclable;
 
    NSInteger paytypestatus;
    
    /*
     @brief 1 全额的  2 粉笔的
     */
    
    NSInteger PAYTYPE;
    
    
    /*
     @brief 选择银联扫码支付 改变底部视图
     */
    NSInteger chooseYinLianType;
    
    
    /*
     @brief 选择保证金的时候，提示语
     */
    
    UILabel*YinLianTypeTishiLable;
    
}
//** 辅助视图 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;
@end
@implementation YXMyAccountPaymentChoosePayTypeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        weixinpaybtn = [[UIButton alloc]init];
        [weixinpaybtn addTarget:self action:@selector(clickweixin) forControlEvents:UIControlEventTouchUpInside];
        [weixinpaybtn setImage:[UIImage imageNamed:@"ic_wxzwx"] forState:UIControlStateNormal];
        [weixinpaybtn setImage:[UIImage imageNamed:@"ic_xuanzwx"] forState:UIControlStateSelected];
        [weixinpaybtn setAdjustsImageWhenHighlighted:NO];
        
        zhifubaopaybtn = [[UIButton alloc]init];
        [zhifubaopaybtn addTarget:self action:@selector(clickzhifubao) forControlEvents:UIControlEventTouchUpInside];
        [zhifubaopaybtn setImage:[UIImage imageNamed:@"ic_zfbwxz"] forState:UIControlStateNormal];
        [zhifubaopaybtn setImage:[UIImage imageNamed:@"ic_xuanzfbxz"] forState:UIControlStateSelected];
        [zhifubaopaybtn setAdjustsImageWhenHighlighted:NO];
        yinlianpaybtn = [[UIButton alloc]init];
        [yinlianpaybtn addTarget:self action:@selector(clickyinlianpay) forControlEvents:UIControlEventTouchUpInside];
        [yinlianpaybtn setImage:[UIImage imageNamed:@"ic_ylwxz"] forState:UIControlStateNormal];
        [yinlianpaybtn setImage:[UIImage imageNamed:@"ic_xuanylxz"] forState:UIControlStateSelected];
        [yinlianpaybtn setAdjustsImageWhenHighlighted:NO];
        
        
        MoneycountTextfield = [[UITextField alloc]init];
        MoneycountTextfield.placeholder = @"输入金额";
        MoneycountTextfield.keyboardType = UIKeyboardTypeNumberPad;
        MoneycountTextfield.backgroundColor = UIColorFromRGB(0xf7f7f7);
        MoneycountTextfield.layer.cornerRadius = 3;
        MoneycountTextfield.layer.masksToBounds = YES;
        MoneycountTextfield.textAlignment = NSTextAlignmentCenter;
        MoneycountTextfield.font = YXRegularfont(14);
        MoneycountTextfield.delegate = self;
        [MoneycountTextfield setInputAccessoryView:self.customAccessoryView];
        MoneycountTextfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        MoneycountTextfield.autocorrectionType = UITextAutocorrectionTypeNo;//关闭联想
        
        desclable = [[UILabel alloc]init];
        desclable.text = @"每笔不得低于￥2000元";
        desclable.textColor = UIColorFromRGB(0x050505);
        desclable.font =YXRegularfont(10);
        desclable.alpha = 0.6;
        desclable.textAlignment = NSTextAlignmentCenter;
        
        
        /*
         @brief 选择保证金的时候，提示语
         */
        YinLianTypeTishiLable = [[UILabel alloc]init];
        YinLianTypeTishiLable.font = YXRegularfont(12);
        NSString *str = @"电脑打开inborn.com/pay扫描二维码即可在线支付";
        NSMutableAttributedString *atter = [[NSMutableAttributedString alloc]initWithString:str];
        [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(0, atter.length)];
        [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x419bef) range:NSMakeRange(4, 14)];
        [atter addAttribute:NSFontAttributeName value:YXRegularfont(12) range:NSMakeRange(0, atter.length)];
        YinLianTypeTishiLable.attributedText = atter;
        YinLianTypeTishiLable.textAlignment = NSTextAlignmentCenter;
        YinLianTypeTishiLable.hidden = YES;
        
        
        [self addSubview:weixinpaybtn];
        [self addSubview:zhifubaopaybtn];
        [self addSubview:yinlianpaybtn];
        [self addSubview:MoneycountTextfield];
        [self addSubview:desclable];
        [self addSubview:YinLianTypeTishiLable];
        
        PAYTYPE = 1;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextfieldEndEditing) name:@"MyAccoutPayMentTextfieldEndEditing" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePaytype:) name:@"PAYTYPETAG" object:nil];
     
        
        weixinpaybtn.selected = YES;
        
        [YXNotificationTool addObserver:self selector:@selector(tishilable:) name:@"moneycounttishiyu" object:nil];
        
    }
    return self;
}
-(void)tishilable:(NSNotification*)noti
{
    NSString *tishistr = noti.userInfo[@"dayuORxiaoyu"];
    
    /*
     @brief 1 小于最低要求加价金额
     */
    if ([tishistr isEqualToString:@"1"]) {
        desclable.text = @"输入金额不能小于2000";
        desclable.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            desclable.hidden = NO;
        });
    }else if([tishistr isEqualToString:@"2"])
    {
        desclable.text = @"输入金额不能大于剩余金额";
        desclable.hidden = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            desclable.hidden = NO;
        });

    }
}


-(void)setIscanChangeShengyuCount:(NSInteger)iscanChangeShengyuCount
{
//    _iscanChangeShengyuCount = iscanChangeShengyuCount;
//    if (iscanChangeShengyuCount==1) {
//        
//        MoneycountTextfield.enabled = NO;
//    }
    
//    MoneycountTextfield.text = [NSString stringWithFormat:@"%ld",self.shengyuMoneyCount];
}

-(void)setShengyuMoneyCount:(NSInteger)shengyuMoneyCount
{
    _shengyuMoneyCount = shengyuMoneyCount;
    
    if (_isPartPay == 1) {
        
        paytypestatus = 1;
        
        if(self.shengyuMoneyCount <=200000)
        {
            MoneycountTextfield.text = [NSString stringWithFormat:@"%ld",self.shengyuMoneyCount/100];
            MoneycountTextfield.enabled = NO;
        }else
        {
             paytypestatus = 1;
        }
        
        
    }else if (_isPartPay == 2)
    {
        
        if(self.shengyuMoneyCount <=200000)
        {
            paytypestatus = 2;
            
        }else
        {
            paytypestatus = 1; // >2000 可分笔  可全额
        }
        
        
    }

    [self layoutSubviews];
}


-(void)changePaytype:(NSNotification*)noti
{
    NSString *selextstr = noti.userInfo[@"SELECTINDEX"];
    if ([selextstr isEqualToString:@"1"]) {
        
        /*
         @brief 全额的
         */
        PAYTYPE = 1;
        
        MoneycountTextfield.hidden = YES;
        desclable.hidden = YES;
        
    }else if ([selextstr isEqualToString:@"2"])
    {
        /*
         @brief 分笔
         */
        PAYTYPE = 2;
        
        MoneycountTextfield.hidden = NO;
        desclable.hidden = NO;
        
    }
    
    [self layoutSubviews];
}



//@brief 2 全额支付     1 分笔支付
-(void)setIsPartPay:(NSInteger)isPartPay
{
    _isPartPay = isPartPay;
    
    
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = (self.width-40)/3;
    CGFloat H = W*78/122;
    CGFloat topY = 15;
    
    weixinpaybtn.frame = CGRectMake(10, 15, W, H);
    zhifubaopaybtn.frame = CGRectMake(W+10*2, topY, W, H);
    yinlianpaybtn.frame = CGRectMake(W*2+10*3, topY, W, H);
    
    if (paytypestatus == 1) {
        
        if (PAYTYPE == 1) {
            
            MoneycountTextfield.frame = CGRectMake(0, 0, 0, 0);
            desclable.frame = CGRectMake(0, 0, 0, 0);
            if (self.heightblock) {
                self.heightblock(weixinpaybtn.bottom+20);
            }

        }else{
        
            MoneycountTextfield.frame = CGRectMake((YXScreenW-YXScreenW*0.55)/2, weixinpaybtn.bottom+20, YXScreenW*0.55, 40);
            desclable.frame = CGRectMake(10, MoneycountTextfield.bottom+5, YXScreenW-20, 10);
            
            if (self.heightblock) {
                self.heightblock(desclable.bottom+20);
            }
        }
    }else if (paytypestatus == 2)
    {
        MoneycountTextfield.frame = CGRectMake(0, 0, 0, 0);
        desclable.frame = CGRectMake(0, 0, 0, 0);
        
        if (self.heightblock) {
            self.heightblock(yinlianpaybtn.bottom+20);
        }
    }
    
    if (chooseYinLianType==1) {
        
        
        YinLianTypeTishiLable.frame = CGRectMake(10, yinlianpaybtn.bottom+25, YXScreenW-20, 20);
        MoneycountTextfield.frame = CGRectMake(0, 0, 0, 0);
        desclable.frame = CGRectMake(0, 0, 0, 0);
        
        if (self.heightblock) {
            self.heightblock(YinLianTypeTishiLable.bottom+20);
        }
        
    }
    
}


-(void)clickweixin
{
    weixinpaybtn.selected = YES;
    zhifubaopaybtn.selected = NO;
    yinlianpaybtn.selected = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHOOSEPAYTYPE" object:nil userInfo:@{@"paytypetag":@"1"}];
    chooseYinLianType = 0;
    YinLianTypeTishiLable.hidden = YES;
    [self layoutSubviews];

}
-(void)clickzhifubao
{    weixinpaybtn.selected = NO;
    zhifubaopaybtn.selected = YES;
    yinlianpaybtn.selected = NO;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"CHOOSEPAYTYPE" object:nil userInfo:@{@"paytypetag":@"2"}];
    chooseYinLianType = 0;
    YinLianTypeTishiLable.hidden = YES;
    [self layoutSubviews];

}

-(void)clickyinlianpay
{    weixinpaybtn.selected = NO;
    zhifubaopaybtn.selected = NO;
    yinlianpaybtn.selected = YES;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"CHOOSEPAYTYPE" object:nil userInfo:@{@"paytypetag":@"3"}];
    
    chooseYinLianType = 1;
    YinLianTypeTishiLable.hidden = NO;
    [self layoutSubviews];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

    if (self.editingblock) {
        self.editingblock(2,[textField.text integerValue]);
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.editingblock) {
        self.editingblock(1,0);
    }
    
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.editingblock) {
        self.editingblock(3,[textField.text integerValue]);
    }
    
    return YES;
}
-(void)TextfieldEndEditing
{
    [MoneycountTextfield endEditing:YES];
}

#pragma mark - 懒加载
- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class]) owner:nil options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}
#pragma mark - 代理方法

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self endEditing:YES];
}

@end
