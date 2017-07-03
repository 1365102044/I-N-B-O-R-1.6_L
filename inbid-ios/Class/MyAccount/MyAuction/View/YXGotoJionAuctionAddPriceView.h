//
//  YXGotoJionAuctionAddPriceView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 @brief 提交
 */
typedef void(^ClickCommitBtnBlock)(NSString* price);

typedef void(^helpblock)();



@class YXGotoJionAuctionAddPriceView;

@protocol YXGotoJionAuctionAddPriceViewDelegate <NSObject>

- (void)GotoJionAuctionAddPriceDelegate:(YXGotoJionAuctionAddPriceView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender;




@end




@interface YXGotoJionAuctionAddPriceView : UIView

@property (weak, nonatomic) IBOutlet UITextField *AddPriceTextfile;
@property (weak, nonatomic) IBOutlet UIButton *CommitBtn;


@property(nonatomic,copy) ClickCommitBtnBlock  CommitBlock;


@property(nonatomic,strong) NSDictionary * dataDict;

@property (nonatomic, weak)id<YXGotoJionAuctionAddPriceViewDelegate> delegate;

@property(nonatomic,copy) helpblock  pushhelpblock;

/*
 @brief 1 加价失败   
 */
@property(nonatomic,assign) NSInteger  addpricStatus;



@property(nonatomic,assign) CGFloat  bigviewY;


@end
