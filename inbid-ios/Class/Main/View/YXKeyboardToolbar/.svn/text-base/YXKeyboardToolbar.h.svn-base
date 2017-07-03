//
//  YXKeyboardToolbar.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXKeyboardToolbar;

@protocol YXKeyboardToolbarDelegate <NSObject>

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick;

@end

@interface YXKeyboardToolbar : UIToolbar

@property (nonatomic, weak) id<YXKeyboardToolbarDelegate> customDelegate;

@end
