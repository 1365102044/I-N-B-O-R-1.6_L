//
//  YXNewsEnsuremoneyNotiListTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsEnsuremoneyNotiListTableViewCell.h"
#import "NSString+File.h"

@interface YXNewsEnsuremoneyNotiListTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bigbackview;


@property (weak, nonatomic) IBOutlet UIImageView *leftimageview;

@property (weak, nonatomic) IBOutlet UILabel *titlenamelable;

@property (weak, nonatomic) IBOutlet UILabel *ensuremoneylable;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *namelablecontansHeight;


@end

@implementation YXNewsEnsuremoneyNotiListTableViewCell

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

+(instancetype)creatensuremoenyNotilistTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YXNewsEnsuremoneyNotiListTableViewCell" owner:nil options:nil] firstObject];
    
}

-(void)setEnsuremodle:(YXNewsEnsureNotiListModle *)ensuremodle
{
    _ensuremodle = ensuremodle;
    
    self.titlenamelable.text = ensuremodle.msgTitle;
   self.ensuremoneylable.text = [NSString stringWithFormat:@"保证金：￥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",ensuremodle.marginPrice/100] ]];
    
    NSArray *urlarr = [ensuremodle.imgUrl componentsSeparatedByString:@"?"];
    
    [self.leftimageview sd_setImageWithURL:[NSURL URLWithString:urlarr[0]] placeholderImage:[UIImage imageNamed:@"newsGoodslogo"]];
    
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:ensuremodle.msgTitle];
    NSRange namerange = [ensuremodle.msgTitle rangeOfString:ensuremodle.prodName];
    if (namerange.length) {
        
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(namerange.location ,namerange.length)];
    }

    
    self.titlenamelable.attributedText = attrStr;
    
    
    CGFloat nameW = [ensuremodle.msgTitle widthWithFont:YXRegularfont(11)];
    if (nameW < YXScreenW-100) {
        
        self.namelablecontansHeight.constant = 20;
    }else
    {
        CGFloat nameH = [ensuremodle.msgTitle heightWithFont:YXRegularfont(11) withinWidth:YXScreenW-100];
        self.namelablecontansHeight.constant = nameH;
    }
    

    
}


@end
