//
//  YXChoosePeiSongTypeBaseView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 @brief 返回总高度
 */
@protocol baseviewheightDelegate <NSObject>

-(void)baseviewheight:(CGFloat)baseviewheight;

@end



@interface YXChoosePeiSongTypeBaseView : UIView

@property(nonatomic,weak) id<baseviewheightDelegate>  baseheightdelegate;

@property(nonatomic,strong) NSString * peisongtype;

//** 订单总金额 大于2000 不显示分笔 */
//@property(nonatomic,assign) NSInteger  orderAllPrice;

-(void)setSubviewUIWithAllprice:(NSInteger )allprice iscanDingjin:(NSInteger )iscandingjin;

@end
