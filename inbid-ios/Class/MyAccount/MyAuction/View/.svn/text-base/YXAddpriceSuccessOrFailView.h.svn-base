//
//  YXAddpriceSuccessOrFailView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelbtnBlock)();

@class YXAddpriceSuccessOrFailView;

@protocol YXAddpriceSuccessOrFailViewdelegate <NSObject>

- (void)AddPriceStatusviewDelegate:(YXAddpriceSuccessOrFailView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender;

@end

@interface YXAddpriceSuccessOrFailView : UIView

//@property(nonatomic,copy)  cancelbtnBlock cancleblock;

@property (nonatomic, weak)id<YXAddpriceSuccessOrFailViewdelegate> delegate;

@property(nonatomic,strong) NSString * status;

@property(nonatomic,strong) NSString * addpricestr;

@property(nonatomic,strong) NSString * currentpricestr;

@end
