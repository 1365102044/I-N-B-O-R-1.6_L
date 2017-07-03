//
//  YXWidthCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXWidthCell.h"
#import "YXFrameTableViewCell.h"

@implementation YXWidthCell

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
    
    frame.origin.x += 5;
    frame.size.width -= 10;
    
    [super setFrame:frame];
}

@end
