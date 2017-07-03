//
//  YXMyAccountThridPartyTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/13.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyAccountThridPartyTableViewCell.h"

@interface YXMyAccountThridPartyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end

@implementation YXMyAccountThridPartyTableViewCell


-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    
    _title.text = dataDict[@"title"];
    _subtitle.text = dataDict[@"subtitle"];
    
}

-(void)setNamestr:(NSString *)namestr{

    _title.text = namestr;
    self.subtitle.hidden = YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"YXMyAccountThridPartyTableViewCell" owner:nil options:nil].lastObject;
        
        
    }
    return self;
}

@end
