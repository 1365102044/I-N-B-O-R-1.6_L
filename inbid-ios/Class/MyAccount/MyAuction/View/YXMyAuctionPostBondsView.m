//
//  YXMyAuctionPostBondsView.m
//  MyAuction
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAuctionPostBondsView.h"
#import "UILabel+Extension.h"
@interface YXMyAuctionPostBondsView()
@property (weak, nonatomic) IBOutlet UILabel *TipsWordsLable;

@property (weak, nonatomic) IBOutlet UILabel *EnsureMoneyLable;

@property (weak, nonatomic) IBOutlet UILabel *BoomTipsWordsLable;

@property (weak, nonatomic) IBOutlet UIButton *ComitBtn;
@property (weak, nonatomic) IBOutlet UIView *bigbackview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbackviewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbackviewWidth;

@end

@implementation YXMyAuctionPostBondsView









































-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.TipsWordsLable setRowSpace:10];
    
    if (YXScreenW <= 320) {
        [self.bigbackview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_offset(270);
            make.height.mas_offset(380);
        }];
        
    }
    
    if (YXScreenW >=414) {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        self.bigbackviewWidth.constant = 330;
        self.bigbackviewHeight.constant = 420;
        
    }
    self.bigbackview.layer.cornerRadius = 4;
    self.bigbackview.layer.masksToBounds = YES;
    
}

-(void)setEsureMoney:(NSString *)esureMoney
{
    _esureMoney = esureMoney;
    
//    NSInteger  esuremoneyStr = [esureMoney integerValue] /100;
    NSString *ensuremoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[esureMoney integerValue] /100]];
    self.EnsureMoneyLable.text = [NSString stringWithFormat:@"保证金: ￥%@",ensuremoneypricestr];

}

- (IBAction)cancleButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(myAuctionPostBondsDelegate:cancelButtonClick:)]) {
        [self.delegate myAuctionPostBondsDelegate:self cancelButtonClick:sender];
    }
}

- (instancetype)init
{
    return [[NSBundle mainBundle] loadNibNamed:@"YXMyAuctionPostBondsView" owner:nil options:nil].lastObject;
    
}

/*
 @brief 提交保证金
 */
- (IBAction)ClickComitEnsureBtn:(id)sender {

    if(self.commitblock)
    {
        self.commitblock();
    }
}

/*
 @brief 点击右边问好image
 */
- (IBAction)clickrightWENHAOimage:(id)sender {
    if (self.pushhelpblock) {
        self.pushhelpblock();
    }
}

@end
