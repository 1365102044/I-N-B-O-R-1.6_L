//
//  YXOneMouthPriceTopView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXOneMouthPriceConfirmOrderModle.h"

#import "YXOneMouthPriceZiTiView.h"

#import "YXMyAddressList.h"




//**填写身份证号**/
typedef void(^wanshaiIDCardBlock)();

/*
 @brief 切换地址
 */
typedef void(^changeAddressBlock)();


typedef void(^TopBaseviewheightblock)(CGFloat height);

@interface YXOneMouthPriceTopView : UIView

@property(nonatomic,strong) YXOneMouthPriceZiTiView * ZiTiaddressView;





@property(nonatomic,copy) wanshaiIDCardBlock  IDCardblock;

@property(nonatomic,copy) changeAddressBlock  changeAddressBlock;


@property(nonatomic,strong) UIView * topbarview;


/*
 @brief 配送方式
 */
@property(nonatomic,strong) NSString * peisongtypestr;

@property(nonatomic,copy) TopBaseviewheightblock  heightblock;


@property(nonatomic,strong) YXOneMouthPriceConfirmOrderModle * OneMouthPriceConfirmModel;

/*
 @brief选择地址回来的
 */
@property(nonatomic,strong) YXMyAddressList * chooseaddressmodle;


@property(nonatomic,strong) NSString *  haveaddress;

//** 默认显示 */
@property(nonatomic,assign) NSInteger  morenpaytype;

@end
