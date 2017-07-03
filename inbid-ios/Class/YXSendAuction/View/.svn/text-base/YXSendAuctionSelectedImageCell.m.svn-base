//
//  YXSendAuctionSelectedImageCell.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionSelectedImageCell.h"
#import "M13ProgressViewPie.h"
#import "YXSendAuctionProgressModel.h"

@interface YXSendAuctionSelectedImageCell()

/**
 进度视图
 */
@property (weak, nonatomic) IBOutlet M13ProgressViewPie *progressView;

/**
 蒙版视图
 */
@property (weak, nonatomic) IBOutlet UIView *imageMaskView;

/**
 失败提醒，点击冲新上传
 */
@property (weak, nonatomic) IBOutlet UILabel *faildLabel;

@end

@implementation YXSendAuctionSelectedImageCell

/**
 蒙版视图点击事件
 
 @param tap tap
 */
- (void)uploadFaildTap:(UIGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(sendAuctionSelectedImageCell:reUploadImageModel:)]) {
        [self.delegate sendAuctionSelectedImageCell:self reUploadImageModel:self.progressModel];
    }
}

/**
 删除按钮点击事件

 @param sender sender
 */
- (IBAction)delButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(sendAuctionSelectedImageCell:clickButton:)]) {
        [self.delegate sendAuctionSelectedImageCell:self clickButton:sender];
    }
}

/**
 接收到进度更新通知

 @param no no
 */
- (void)changeProgressShow:(NSNotification *)no
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.progressModel) {
            self.progressView.hidden = YES;
            self.imageMaskView.hidden = YES;
            self.faildLabel.hidden = YES;
        }
        
        if (self.progressModel.successImageUrlString) {
            self.progressView.hidden = YES;
            self.imageMaskView.hidden = YES;
            self.faildLabel.hidden = YES;
            return;
        }
        
        if (self.progressModel.successed) {
            self.progressView.hidden = NO;
            self.imageMaskView.hidden = NO;
            self.faildLabel.hidden = YES;
        }
        
        [self.progressView setProgress:self.progressModel.progress animated:YES];
        if (self.progressModel.progress == 1) {
            self.progressView.hidden = YES;
            self.imageMaskView.hidden = YES;
        }
    });
}

/**
 接收到上传失败通知

 @param no no
 */
- (void)showIsFaild:(NSNotification *)no
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.progressModel.isSuccess) {
            self.imageMaskView.hidden = NO;
            self.faildLabel.hidden = NO;
            self.progressView.hidden = YES;
        }else{
            self.imageMaskView.hidden = YES;
            self.faildLabel.hidden = YES;
        }        
    });
}

/**
 赋值

 @param progressModel progressModel
 */
- (void)setProgressModel:(YXSendAuctionProgressModel *)progressModel
{
    _progressModel = progressModel;
    [self changeProgressShow:nil];
    if (progressModel.progress == 0 && progressModel) {
        [self.progressView setProgress:0 animated:NO];
        self.progressView.hidden = NO;
        self.imageMaskView.hidden = NO;
    }
    
    if (!progressModel.isSuccess && progressModel) {
        self.faildLabel.hidden = NO;
    }else{
        self.faildLabel.hidden = YES;
    }
}

/**
 从xib初始化
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageMaskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    self.faildLabel.text = @"上传失败，点击重新上传";
    
    //** 添加监听 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeProgressShow:) name:@"uploadImageProgressNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIsFaild:) name:@"uploadImageFaildNotification" object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadFaildTap:)];
    self.faildLabel.userInteractionEnabled = YES;
    [self.faildLabel addGestureRecognizer:tap];
    
    _progressView.backgroundRingWidth = 0.5;
    //** 控件背景色 */
    _progressView.backgroundColor = [UIColor clearColor];
    //** 进度条颜色 */
    _progressView.primaryColor = [[UIColor mainThemColor] colorWithAlphaComponent:0.5];
    //** 圆环颜色 */
    _progressView.secondaryColor = [[UIColor mainThemColor] colorWithAlphaComponent:0.5];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadImageProgressNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadImageFaildNotification" object:nil];
}

@end
