//
//  YXPayMentOrderBaseView.h
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^heightblock)(CGFloat height);
@interface YXPayMentOrderBaseView : UIView

@property(nonatomic,copy) heightblock heightblock;


@end