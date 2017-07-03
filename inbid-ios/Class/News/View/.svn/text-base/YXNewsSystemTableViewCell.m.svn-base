//
//  YXNewsSystemTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsSystemTableViewCell.h"

#import "UILabel+Extension.h"

@interface YXNewsSystemTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *namelable;
@property (weak, nonatomic) IBOutlet UIView *bigbackview;
@property (weak, nonatomic) IBOutlet UIImageView *jiantouImage;

@end

@implementation YXNewsSystemTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
+(instancetype)creatsystemNotilistTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YXNewsSystemTableViewCell" owner:nil options:nil] firstObject];
    
}
-(void)awakeFromNib{

    [super awakeFromNib];
    
    [self.namelable setRowSpace:5];
    self.bigbackview.layer.cornerRadius = 5;
    self.bigbackview.layer.masksToBounds = YES;
    self.bigbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.bigbackview.layer.borderWidth = 0.5;
    
}

/**
系统通知,提现成功
Integer CASHOUT_APPLY_SUCCESS = 405;
 * 系统通知,提现失败
Integer CASHOUT_APPLY_FAILURE = 406;
* */
-(void)setModle:(YXNewsEnsureNotiListModle *)modle
{
    _modle = modle;
    
    self.namelable.text = modle.msgTitle;
    
    if(modle.msgType==403||modle.msgType == 405||modle.msgType == 406)
    {
        self.jiantouImage.hidden = YES;
    }
    
}


@end
