//
//  YXSendAuctionSecondOtherHeaderView.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionSecondOtherHeaderView.h"

@interface YXSendAuctionSecondOtherHeaderView()

/**
 选择品牌点击视图
 */
@property (weak, nonatomic) IBOutlet UIView *selectedBranceTapView;

/**
 分割线
 */
@property (weak, nonatomic) IBOutlet UIView *splitLineView;

@end

@implementation YXSendAuctionSecondOtherHeaderView

#pragma mark - First.点击事件

/**
 点击选择品牌

 @param tap 点击手势
 */
- (void)selectedBranceTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(sendAuctionSecondOtherHeaderView:showSelectedBranceLabel:)]) {
        //** TODO:label暂时传nil，界面出来后，填写选中的label */
        [self.delegate sendAuctionSecondOtherHeaderView:self showSelectedBranceLabel:nil];
    }
}

/**
 xib初始化入口
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 配置界面 */
    self.backgroundColor = [UIColor whiteColor];
    self.selectedBranceTapView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    self.splitLineView.backgroundColor = [UIColor themLightGrayColor];
    self.showBranceLabel.text = @"点击选择品牌";
    self.showBranceLabel.textColor = [UIColor colorWithWhite:172.0/255.0 alpha:1.0];
    self.showBranceLabel.font = [UIFont systemFontOfSize:13];
    
    //** 添加边框 */
    [self.splitLineView.layer setBorderWidth:0.5];
    CGColorRef color = [UIColor colorWithWhite:238.0/255.0 alpha:1.0].CGColor;
    [self.splitLineView.layer setBorderColor:color];
    
    //** 添加监听 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedBranceTap:)];
    [self.selectedBranceTapView addGestureRecognizer:tap];
}

@end
