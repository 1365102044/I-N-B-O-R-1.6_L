//
//  YXNewsDingdanNotiListTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsDingdanNotiListTableViewCell.h"
#import "NSString+File.h"
@interface YXNewsDingdanNotiListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bigbackview;

@property (weak, nonatomic) IBOutlet UILabel *statuslable;

@property (weak, nonatomic) IBOutlet UIImageView *leftimageview;

@property (weak, nonatomic) IBOutlet UILabel *titlenamelable;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *namelablecontentHeight;


@end


@implementation YXNewsDingdanNotiListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bigbackview.layer.cornerRadius = 5;
    self.bigbackview.layer.masksToBounds =  YES;
    self.bigbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.bigbackview.layer.borderWidth = 0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)creatdingdanNotilistTableViewCell
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"YXNewsDingdanNotiListTableViewCell" owner:nil options:nil] firstObject];
    
}

-(void)setDingdanmodle:(YXNewsEnsureNotiListModle *)dingdanmodle
{
    _dingdanmodle = dingdanmodle;

    
    NSString *statustr ;
    if (dingdanmodle.deliveryMerchant) {
        
        statustr = [NSString stringWithFormat:@"%@  (%@)",dingdanmodle.msgTitle,dingdanmodle.deliveryMerchant];
    }
    
    NSMutableAttributedString* attrStr;
    if (dingdanmodle.msgTitle) {
        
        attrStr = [[NSMutableAttributedString alloc] initWithString:dingdanmodle.msgTitle];
        NSRange namerange;
        if (dingdanmodle.prodName) {
            
            namerange = [dingdanmodle.msgTitle rangeOfString:dingdanmodle.prodName];
            if (namerange.length) {
                
                [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(namerange.location-1 ,namerange.length+2)];
            }
        }
    }
    
    if (dingdanmodle.orderStatus == 4|| dingdanmodle.deliveryStatus == 4) {
        if (dingdanmodle.deliveryNum.length!=0) {
            
            NSRange deliveryNumrange = [dingdanmodle.msgTitle rangeOfString:dingdanmodle.deliveryNum];
            if (deliveryNumrange.length) {
                
                [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:deliveryNumrange];
            }
        }
        
    }
    
    

    self.titlenamelable.attributedText = attrStr;
    
    
    CGFloat nameW = [dingdanmodle.msgTitle widthWithFont:YXRegularfont(11)];
    if (nameW < YXScreenW-100) {
        
        self.namelablecontentHeight.constant = 20;
    }else
    {
        CGFloat nameH = [dingdanmodle.msgTitle heightWithFont:YXRegularfont(11) withinWidth:YXScreenW-100];
        self.namelablecontentHeight.constant = nameH;
    }
    
    //**状态**/
    self.statuslable.text =  dingdanmodle.MyOrderListStatus;
    
    if (dingdanmodle.msgType ==106){
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单已发货  (%@)",dingdanmodle.deliveryMerchant]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaa7a7) range:NSMakeRange(5, attrStr.length-5)];
        [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(10) range:NSMakeRange(5, attrStr.length-5)];
        self.statuslable.attributedText = attrStr;
        
    }else if (dingdanmodle.msgType==107)
    {
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单签收  (%@)",dingdanmodle.deliveryMerchant]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaa7a7) range:NSMakeRange(4, attrStr.length-4)];
        [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(10) range:NSMakeRange(4, attrStr.length-4)];
        self.statuslable.attributedText = attrStr;
    }
    

    NSArray *urlarr;
    if (dingdanmodle.imgUrl) {
        
        urlarr = [dingdanmodle.imgUrl componentsSeparatedByString:@"?"];
    }else if (dingdanmodle.identifyImgUrl)
    {
        urlarr = [dingdanmodle.identifyImgUrl componentsSeparatedByString:@"?"];
    }
    
    [self.leftimageview sd_setImageWithURL:[NSURL URLWithString:urlarr[0]] placeholderImage:[UIImage imageNamed:@"newsGoodslogo"]];
    
    
    
}

@end
