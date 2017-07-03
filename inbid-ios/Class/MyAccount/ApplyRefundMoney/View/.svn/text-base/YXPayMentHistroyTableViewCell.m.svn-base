//
//  YXPayMentHistroyTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayMentHistroyTableViewCell.h"

@interface YXPayMentHistroyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *PaymentType;

@property (weak, nonatomic) IBOutlet UILabel *PaymoneyType;

@property (weak, nonatomic) IBOutlet UILabel *PriceLable;
@property (weak, nonatomic) IBOutlet UILabel *PayTimeLable;


@end

@implementation YXPayMentHistroyTableViewCell


-(void)setListModle:(YXPayHistroyModle *)listModle
{
    _listModle = listModle;
    
    self.PaymentType.text = listModle.MypayType;
    
    NSString *timestr = [YXStringFilterTool transformfromenumbertoTiemstr:[listModle.payedTime longLongValue]];
    NSArray *timeArr = [timestr componentsSeparatedByString:@"-"];
    if (timeArr.count>2) {
        
        self.PayTimeLable.text = [NSString stringWithFormat:@"%@-%@",timeArr[1],timeArr[2]];
    }
    
    self.PriceLable.text = [YXStringFilterTool formFenTransformaYuanWith:listModle.payAmt];
    self.PaymoneyType.text = listModle.MyPayMoneyType;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
