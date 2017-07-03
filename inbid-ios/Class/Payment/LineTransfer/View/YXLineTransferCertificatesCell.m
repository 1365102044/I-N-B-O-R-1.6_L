//
//  YXLineTransferCertificatesCell.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXLineTransferCertificatesCell.h"
#import "YXPaymentHomepageViewDataModel.h"
#import "M13ProgressViewPie.h"
#import "YXSendAuctionProgressModel.h"
#import <UIImageView+WebCache.h>

@interface YXLineTransferCertificatesCell()

/**
 凭证按钮
 */
@property (weak, nonatomic) IBOutlet UIImageView *certificatesImageView;

/**
 删除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

/**
 图片蒙版视图
 */
@property (weak, nonatomic) IBOutlet UIView *imageMaskView;

/**
 进度视图
 */
@property (weak, nonatomic) IBOutlet M13ProgressViewPie *progressView;

/**
 失败label
 */
@property (weak, nonatomic) IBOutlet UILabel *failLabel;

@end

@implementation YXLineTransferCertificatesCell

#pragma mark - First.通知

/**
 接收到进度更新通知
 
 @param no no
 */
- (void)changeProgressShow:(NSNotification *)no
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setProgress:self.progressModel.progress animated:YES];
        if (self.progressModel.progress == 1) {
            self.progressView.hidden = YES;
            self.imageMaskView.hidden = YES;
        }else{
            self.progressView.hidden = NO;
            self.imageMaskView.hidden = NO;
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
            self.failLabel.hidden = NO;
            self.progressView.hidden = YES;
        }else{
            self.imageMaskView.hidden = YES;
            self.failLabel.hidden = YES;
        }
    });
}

#pragma mark - Second.赋值

/**
 赋值

 @param urlString 凭证照片
 */
- (void)setDataModel:(YXPaymentHomepageViewDataModel *)dataModel
{
    _dataModel = dataModel;
    if (dataModel.offlineCertificatesImageUrlString
        && dataModel.offlineCertificatesImageUrlString.length != 0
        && ![dataModel.offlineCertificatesImageUrlString isEqualToString:@""]) {
        self.cancelButton.hidden = NO;
        [self.certificatesImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.offlineCertificatesImageUrlString] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    }else{
        if (self.progressModel.selectedImage) return;
        self.cancelButton.hidden = YES;
    }
}

/**
 选中图片模型赋值

 @param progressModel progressModel 选中图片模型
 */
- (void)setProgressModel:(YXSendAuctionProgressModel *)progressModel
{
    _progressModel = progressModel;
    
    if (!progressModel) {
        [self hiddenSubViews:YES];
        self.certificatesImageView.image = [UIImage imageNamed:@"icon_Payment_offLine"];
        return;
    }
    
    [self hiddenSubViews:NO];
    if (progressModel.selectedImage) {
        self.certificatesImageView.image = progressModel.selectedImage;
        self.cancelButton.hidden = NO;
    }
}

/**
 是否隐藏控件

 @param isHidden 是否
 */
- (void)hiddenSubViews:(BOOL)isHidden
{
    self.imageMaskView.hidden = isHidden;
    self.progressView.hidden = isHidden;
    self.failLabel.hidden = isHidden;
}

#pragma mark - Third.点击事件

/**
 选择图片点击事件

 @param tap
 */
- (void)selectedImage:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(lineTransferCertificatesCell:clickButton:)]) {
        [_delegate lineTransferCertificatesCell:self clickButton:nil];
    }
}

/**
 蒙版视图点击事件
 
 @param tap tap
 */
- (void)uploadFaildTap:(UIGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(lineTransferCertificatesCell:reUploadImage:)]) {
        [_delegate lineTransferCertificatesCell:self reUploadImage:nil];
    }
}

/**
 删除按钮点击事件

 @param sender 删除按钮
 */
- (IBAction)cancelButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(lineTransferCertificatesCell:clickButton:)]) {
        [self.delegate lineTransferCertificatesCell:self clickButton:sender];
    }
}

/**
 凭证照片按钮点击事件

 @param sender 照片凭证按钮
 */
- (IBAction)imageButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(lineTransferCertificatesCell:clickButton:)]) {
        [self.delegate lineTransferCertificatesCell:self clickButton:sender];
    }
}

/**
 提交按钮点击事件

 @param sender 提交按钮
 */
- (IBAction)submitButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(lineTransferCertificatesCell:clickButton:)]) {
        [self.delegate lineTransferCertificatesCell:self clickButton:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控件生命周期

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 配置界面 */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.certificatesImageView.backgroundColor = [UIColor themGrayColor];
    
    self.imageMaskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    self.failLabel.text = @"上传失败，点击重新上传";
    self.failLabel.hidden = YES;
    
    //** 添加监听 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeProgressShow:) name:@"uploadImageProgressNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIsFaild:) name:@"uploadImageFaildNotification" object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadFaildTap:)];
    self.failLabel.userInteractionEnabled = YES;
    [self.failLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *addImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImage:)];
    [self.certificatesImageView addGestureRecognizer:addImageTap];
    
    _progressView.backgroundRingWidth = 0.5;
    //** 控件背景色 */
    _progressView.backgroundColor = [UIColor clearColor];
    //** 进度条颜色 */
    _progressView.primaryColor = [[UIColor mainThemColor] colorWithAlphaComponent:0.5];
    //** 圆环颜色 */
    _progressView.secondaryColor = [[UIColor mainThemColor] colorWithAlphaComponent:0.5];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadImageProgressNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadImageFaildNotification" object:nil];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
