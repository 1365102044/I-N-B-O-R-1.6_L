//
//  YXYXMySureMoneyNoPaymentTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXYXMySureMoneyNoPaymentTableViewCell.h"
#import "YXStringFilterTool.h"
@interface YXYXMySureMoneyNoPaymentTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconimageview;

@property (weak, nonatomic) IBOutlet UILabel *titleLbale;

@property (weak, nonatomic) IBOutlet UILabel *suremoneyLable;

@property (weak, nonatomic) IBOutlet UILabel *alearlyAndNopaymentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *StutasBtn;


@end


@implementation YXYXMySureMoneyNoPaymentTableViewCell


+(instancetype)creatMySureMoneyNoPaymentTableViewCell
{
  return [[[NSBundle mainBundle] loadNibNamed:@"YXYXMySureMoneyNoPaymentTableViewCell" owner:nil options:nil] firstObject];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}



-(void)setNopayMentModle:(YXMySureMoneyNopaymentModle *)NopayMentModle
{
    _NopayMentModle = NopayMentModle;
    
    
    self.StutasBtn.layer.cornerRadius = 3;
    self.StutasBtn.layer.masksToBounds = YES;
    
    self.titleLbale.text = NopayMentModle.prodName;
    
    
    NSString  *Pricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",NopayMentModle.marginPrice/100] ];
    
    NSString *str = [NSString stringWithFormat:@"保证金: ¥%@",Pricestr];
    NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa90311) range:NSMakeRange(4, str.length-4)];
    self.suremoneyLable.attributedText = currenattrStr;
    

   NSString *timestr = [YXStringFilterTool transformfromenumbertoTiemstr:[NopayMentModle.createTime doubleValue]];
    self.timeLable.text = [NSString stringWithFormat:@"提交时间：%@",timestr];
    
    
    /*
     @brief  * 状态：1=未支付,2=部分支付，7 已取消
     */
    if(NopayMentModle.marginStatus == 1)
    {
        [self.StutasBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        self.alearlyAndNopaymentLable.hidden = YES;
        
   
    }else if(NopayMentModle.marginStatus == 2)
    {
        [self.StutasBtn setTitle:@"继续支付" forState:UIControlStateNormal];
        
        NSInteger NOpay = NopayMentModle.marginPrice /100 - NopayMentModle.alreadyPayAmount/100;
        NSString  *nopaypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",NOpay] ];
         NSString  *aleatlypaypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",NopayMentModle.alreadyPayAmount/100] ];
        
        NSString *str = [NSString stringWithFormat:@"已支付:￥%@  未支付:￥%@",aleatlypaypricestr,nopaypricestr];
        NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa90311) range:NSMakeRange(4, aleatlypaypricestr.length+1)];
        [currenattrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa90311) range:NSMakeRange(8+aleatlypaypricestr.length+3, nopaypricestr.length+1)];
        
        self.alearlyAndNopaymentLable.attributedText = currenattrStr;
        
        
    }else if(NopayMentModle.marginStatus == 7)
    {
           self.alearlyAndNopaymentLable.hidden = YES;
        [self.StutasBtn setTitle:@"已取消" forState:UIControlStateNormal];
        self.StutasBtn.backgroundColor = [UIColor clearColor];
        [self.StutasBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        
    }
    
    NSArray *urlarr = [NopayMentModle.imgUrl componentsSeparatedByString:@"?"];
    if (urlarr.count) {
        
        NSString *imageurl  = urlarr[0];
        [_iconimageview sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    }
    
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_NopayMentModle.marginStatus == 1||_NopayMentModle.marginStatus == 7) {
        
        self.suremoneyLable.frame = CGRectMake(self.iconimageview.right+10, self.titleLbale.bottom+20, 180, 15);
    }
    

}
- (IBAction)ClickPayStatusBtn:(id)sender {
    
    if(self.NopayMentModle.marginStatus == 7)
    {
        return;
    }
    if (self.clickblock) {
        self.clickblock(self.NopayMentModle.marginStatus,self.NopayMentModle.NopaymentId,self.NopayMentModle.marginPrice,self.NopayMentModle.alreadyPayAmount,self.NopayMentModle.prodName);
    }
    
}




@end
