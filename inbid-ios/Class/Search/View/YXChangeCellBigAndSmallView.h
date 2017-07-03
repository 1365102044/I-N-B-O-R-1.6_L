//
//  YXChangeCellBigAndSmallView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeBlock)(NSString* tag);
@interface YXChangeCellBigAndSmallView : UIView

@property(nonatomic,copy) changeBlock  changeBlock;

//{
//    
//    UIButton *Bigbtn;
//    UIButton   *smallbtn;
//    
//}

@property(nonatomic,strong) UIButton * Bigbtn;
@property(nonatomic,strong) UIButton * smallbtn;

@end
