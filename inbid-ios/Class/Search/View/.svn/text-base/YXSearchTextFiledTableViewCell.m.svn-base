//
//  YXSearchTextFiledTableViewCell.m
//  inbid-ios
//
//  Created by 刘文强 on 2016/11/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchTextFiledTableViewCell.h"

@interface YXSearchTextFiledTableViewCell ()




@end

@implementation YXSearchTextFiledTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}


- (IBAction)clickCancleBtn:(id)sender {
    
    
    if (self.removebalcok) {
        
        self.removebalcok(self.texttitleLable.text);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)creatsearchtextfiledNotilistTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YXSearchTextFiledTableViewCell" owner:nil options:nil] firstObject];
    
}
@end
