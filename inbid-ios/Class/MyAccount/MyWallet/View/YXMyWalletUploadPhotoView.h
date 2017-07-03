//
//  YXMyWalletUploadPhotoView.h
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickImageBlcok)(NSString *titstr);

@interface YXMyWalletUploadPhotoView : UIView

@property(nonatomic,copy) clickImageBlcok  clickImageBlock;

@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) UIImageView * photoimage;
@property(nonatomic,strong) UIView *linetop;
@property(nonatomic,strong) UIView *lineboom;
@end
