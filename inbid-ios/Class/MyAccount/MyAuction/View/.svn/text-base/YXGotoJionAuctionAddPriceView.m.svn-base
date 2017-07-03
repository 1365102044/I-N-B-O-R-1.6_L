//
//  YXGotoJionAuctionAddPriceView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#define MOVEHEIGHT 30
#import "YXKeyboardToolbar.h"

#import "YXGotoJionAuctionAddPriceView.h"

@interface YXGotoJionAuctionAddPriceView ()<UITextFieldDelegate,YXKeyboardToolbarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *CurrenPriceLable;

@property (weak, nonatomic) IBOutlet UILabel *JionPersonNmuber;

@property (weak, nonatomic) IBOutlet UILabel *JionNumber;

@property (weak, nonatomic) IBOutlet UILabel *MinAddPrice;

@property (weak, nonatomic) IBOutlet UIView *BigBackView;

@property (weak, nonatomic) IBOutlet UILabel *addpriceFaillale;


@property(nonatomic,strong) YXKeyboardToolbar * customAccessoryView;

@property(nonatomic,assign) CGFloat  orginY;


@end


@implementation YXGotoJionAuctionAddPriceView

/*
 {
	bidCount = 1,
	actorNum = 2,
	id = 2,
	currentPrice = 112000,
	minAddPrice = 1000,
 }
 */



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self =  [[NSBundle mainBundle] loadNibNamed:@"YXGotoJionAuctionAddPriceView" owner:nil options:nil].lastObject;
        
        self.addpriceFaillale.hidden = YES;
        
           [self.AddPriceTextfile setInputAccessoryView:self.customAccessoryView];
        self.AddPriceTextfile.delegate = self;
        
        self.CommitBtn.backgroundColor = UIColorFromRGB(0xbbbbbb);
        self.CommitBtn.enabled = NO;
        
        if (YXScreenW <= 320) {
            [self.BigBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_offset(270);
                make.height.mas_offset(380);
            }];
        }
        
        if (YXScreenW >= 414) {
            [self.BigBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_offset(370);
                make.height.mas_offset(420);
            }];
        }
        
        self.CommitBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20];
        self.BigBackView.layer.cornerRadius = 5;
        self.BigBackView.layer.masksToBounds = YES;
        
        self.CommitBtn.layer.cornerRadius = 5;
        self.CommitBtn.layer.masksToBounds = YES;
        self.AddPriceTextfile.delegate = self;
        
        self.AddPriceTextfile.keyboardType = UIKeyboardTypeNumberPad;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickBigView)];
        [self.BigBackView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbackview:)];
        [self addGestureRecognizer:tap1];
    }
    
    return self;
}

-(void)setAddpricStatus:(NSInteger)addpricStatus
{
    if(addpricStatus==1)
    {
        _addpricStatus = addpricStatus;
        self.addpriceFaillale.hidden = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.addpriceFaillale.hidden = NO;
        });
    } else if (addpricStatus ==2)
    {
        self.addpriceFaillale.hidden = YES;
    }
    else
    {
        self.addpriceFaillale.hidden = NO;
    }
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger currenprice = [_dataDict[@"currentPrice"] integerValue]/100;
    
    NSInteger MinPri = [_dataDict[@"minAddPrice"] integerValue]/100;
    
      NSString *tostring =[textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSInteger shuruprice =  [tostring integerValue];
    if(tostring.length>0)
    {
        if (shuruprice==0) {
            return NO;
        }
    }
    if (tostring.length>=10) {
        
        [self.AddPriceTextfile resignFirstResponder];
        shuruprice = [[tostring substringToIndex:9] integerValue];
    }
    
    
    YXLog(@"-------%ld",(long)shuruprice);
    if (shuruprice < (currenprice+MinPri)) {
        self.CommitBtn.backgroundColor = UIColorFromRGB(0xbbbbbb);
        self.CommitBtn.enabled = NO;
    }else{
        self.CommitBtn.backgroundColor = [UIColor mainThemColor];
        self.CommitBtn.enabled = YES;
    }
    
   
    
    return YES;
}


/*
 @brief 给背景添加点击方法
 */
-(void)ClickBigView
{
//    if(self.AddPriceTextfile.editing == NO)
//    {
//        return;
//    }
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        
//        [self.AddPriceTextfile endEditing:YES];
//
//    } completion:^(BOOL finished) {
//        
//        CGFloat bigviewY = self.BigBackView.frame.origin.y;
//        self.BigBackView.y = bigviewY+30;
//        
//    }];
    
}


- (IBAction)ClickCancleBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(GotoJionAuctionAddPriceDelegate:cancelButtonClick:)]) {
        [self.delegate GotoJionAuctionAddPriceDelegate:self cancelButtonClick:sender];
    }

}
-(void)clickbackview:(id)sender
{
    
//    if ([self.delegate respondsToSelector:@selector(GotoJionAuctionAddPriceDelegate:cancelButtonClick:)]) {
//        [self.delegate GotoJionAuctionAddPriceDelegate:self cancelButtonClick:sender];
//    }

}

/*
 @brief 开始编辑的时候
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        

        self.BigBackView.y -=38;
        
    } completion:^(BOOL finished) {
        
    }];

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.BigBackView.y +=38;

        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    NSInteger currenPri = [dataDict[@"currentPrice"] integerValue]/100;
    NSString *currenprice = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)currenPri]];
    self.CurrenPriceLable.text = [NSString stringWithFormat:@"当前价格：￥%@",currenprice];
    self.JionPersonNmuber.text = [NSString stringWithFormat:@"参与人数：%@人",dataDict[@"actorNum"]];
    self.JionNumber.text = [NSString stringWithFormat:@"参与次数：%@次",dataDict[@"bidCount"]];
    
    NSInteger MinPri = [dataDict[@"minAddPrice"] integerValue]/100;
    NSString *Minprice = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)MinPri]];
    self.MinAddPrice.text = [NSString stringWithFormat:@"最低加价额度：￥%@",Minprice];
    
}


- (IBAction)ClickCommitBtn:(id)sender {
    
    if (self.AddPriceTextfile.text.length == 0) {
        
        return;
    }
    
    if (self.CommitBlock) {
        self.CommitBlock(self.AddPriceTextfile.text);
    }

}

- (IBAction)clickWENHAOimage:(id)sender {
    if (self.pushhelpblock) {
        self.pushhelpblock();
    }

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
//
//-(void)setBigviewY:(CGFloat)bigviewY
//{
//    
////    self.BigBackView.y =+bigviewY;
//    
//    
//    
//}


@end
