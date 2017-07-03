//
//  YXBrowsRecordTableViewCell.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/17.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXBrowsRecordTableViewCell.h"
#import "UILabel+Extension.h"
@interface YXBrowsRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;

@property (weak, nonatomic) IBOutlet UILabel *descLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLableContant;

@end


@implementation YXBrowsRecordTableViewCell


-(void)setMyordermodle:(YXOrderDetailBaseDataModel *)myordermodle{
    
    self.goodsNameLable.text = [NSString stringWithFormat:@"%@",myordermodle.dataModel.prodName];
    
    CGFloat Hei = [self.goodsNameLable heightWithWidth:YXScreenW-120];
    if (Hei>=30) {
        if (Hei>=50) {
            Hei = 50;
        }
        self.nameLableContant.constant = Hei;
        
    }
    
    self.descLable.text = myordermodle.dataModel.prodBrandName;
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:myordermodle.dataModel.mainImg] placeholderImage:[UIImage imageNamed:@"newsGoodslogo"]];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"YXBrowsRecordTableViewCell" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

@end
