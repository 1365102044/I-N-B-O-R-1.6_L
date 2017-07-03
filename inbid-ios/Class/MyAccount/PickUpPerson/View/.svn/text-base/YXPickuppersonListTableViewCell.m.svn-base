//
//  YXPickuppersonListTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPickuppersonListTableViewCell.h"


@interface YXPickuppersonListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *phoneLable;

@property (weak, nonatomic) IBOutlet UILabel *IdcardLable;
@property (weak, nonatomic) IBOutlet UIButton *MorenBtn;
@property (weak, nonatomic) IBOutlet UIButton *BianJiBtn;
@property (weak, nonatomic) IBOutlet UIButton *RemoveBtn;

@end

@implementation YXPickuppersonListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//** 设置frame */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)creatMySureMoneyNoPaymentTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YXPickuppersonListTableViewCell" owner:nil options:nil] firstObject];
}


-(void)setModle:(YXPickUpPersonListModle *)modle
{
    _modle = modle;
    
    self.MorenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.BianJiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.RemoveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.nameLable.text = modle.name;
    self.IdcardLable.text = modle.idcard;
    self.phoneLable.text = modle.mobile;
    
    if ([modle.isDefault integerValue]) {
        
        [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress_highlight"] forState:UIControlStateNormal];
        
    }else{
        
        [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)clickMorenBtn:(id)sender {
    
    
    self.MorenBtn.selected = !self.MorenBtn.selected;
    if (self.MorenBtn.selected) {
        
        [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress_highlight"] forState:UIControlStateNormal];

    }else{
        [self.MorenBtn setImage:[UIImage imageNamed:@"icon_morenAddress"] forState:UIControlStateNormal];

    }
    
    if (self.morenblock) {
        self.morenblock(self.modle.myID);
    }
    
}
- (IBAction)clickRemoveBtn:(id)sender {
    if (self.removeblock) {
        self.removeblock(self.modle.myID);
    }
    
}
- (IBAction)clickBianJiBtn:(id)sender {
    
    if (self.bianjiblock) {
        self.bianjiblock(self.modle);
    }
}


@end
