//
//  YXMyLabelFirestSectionReusableView.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyLabelFirestSectionReusableView.h"

@interface YXMyLabelFirestSectionReusableView()

/**
 提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;


@end

@implementation YXMyLabelFirestSectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        self.tipsLabel.text = @"（点击删除标签）";
    }
}

@end
