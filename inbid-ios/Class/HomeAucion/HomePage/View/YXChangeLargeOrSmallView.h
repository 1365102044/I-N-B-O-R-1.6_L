//
//  YXChangeLargeOrSmallView.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/24.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXChangeLargeOrSmallView;

@protocol YXChangeLargeOrSmallViewDelegate <NSObject>

/**
 切换大小图按钮

 @param changeLargeOrSmallView 当前切换视图
 @param btn                    选中的按钮
 */
- (void)changeLargeOrSmallView:(YXChangeLargeOrSmallView *)changeLargeOrSmallView andClickButton:(UIButton *)btn;

@end

@interface YXChangeLargeOrSmallView : UIView

@property (nonatomic, weak) id<YXChangeLargeOrSmallViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *largeButton;
@property (weak, nonatomic) IBOutlet UIButton *smallButton;
@property (weak, nonatomic) IBOutlet UIView *buttonSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonSuperViewHeightCons;

@property (nonatomic, strong) UIButton *currentButton;

@end
