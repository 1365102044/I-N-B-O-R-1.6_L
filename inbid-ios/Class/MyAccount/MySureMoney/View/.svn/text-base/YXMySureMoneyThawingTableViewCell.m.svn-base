//
//  YXMySureMoneyThawingTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyThawingTableViewCell.h"
#import "YXStringFilterTool.h"
@interface YXMySureMoneyThawingTableViewCell ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconimage;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *suremoneyLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIButton *statusBtn;

/*
 @brief 是否自己拍成功
 */
@property(nonatomic,strong) NSString * userhold;

@end

@implementation YXMySureMoneyThawingTableViewCell



-(void)setFromVCtype:(NSString *)FromVCtype
{
    _FromVCtype = FromVCtype;
    
    if([self.FromVCtype isEqualToString:@"已解冻"])
    {
          self.statusBtn.hidden = NO;
        self.statusBtn.userInteractionEnabled = NO;
        
    }else if([self.FromVCtype isEqualToString:@"冻结中"])
    {
        self.statusBtn.hidden = YES;
        
    }

}




+(instancetype)creatMySureMoneyThawingTableViewCell
{

    return [[[NSBundle mainBundle] loadNibNamed:@"YXMySureMoneyThawingTableViewCell" owner:nil options:nil] firstObject];

}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}


-(void)setModle:(YXMySureMoneyNopaymentModle *)modle
{
    _modle = modle;
    
//    self.iconimage.userInteractionEnabled = YES;
//    self.titleLable.userInteractionEnabled = YES;
    
    self.titleLable.text = modle.prodName;
      NSString  *suremoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",modle.marginPrice/100] ];
    
    NSString *str = [NSString stringWithFormat:@"保证金: ¥%@",suremoneypricestr];
    NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa90311) range:NSMakeRange(4, str.length-4)];
    self.suremoneyLable.attributedText = currenattrStr;
    

    
    self.timeLable.text = [NSString stringWithFormat:@"提交时间：%@",[YXStringFilterTool transformfromenumbertoTiemstr:[modle.createTime doubleValue]]];
    
    
    
    if (modle.marginStatus == 6) {
        [self.statusBtn setTitle:@"抵扣完成" forState:UIControlStateNormal];
    }else if (modle.marginStatus == 5) {
        [self.statusBtn setTitle:@"罚扣" forState:UIControlStateNormal];
    }else if (modle.marginStatus == 4) {
        [self.statusBtn setTitle:@"退款完成" forState:UIControlStateNormal];
    }else  {
        [self.statusBtn setTitle:@"等待退款" forState:UIControlStateNormal];
    }
    
    NSArray *urlarr = [modle.imgUrl componentsSeparatedByString:@"?"];
    if (urlarr.count) {
        
        NSString *imageurl  = urlarr[0];
        
        [_iconimage sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    }
    
}

@end
