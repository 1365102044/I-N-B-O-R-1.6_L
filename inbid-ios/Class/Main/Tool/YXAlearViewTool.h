//
//  YXAlearViewTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXAlearViewTool : NSObject
+(instancetype)sharedAlearview;
/**
 弹出提示框  str 提示内容  type 图片的类型，
 1 成功 2 警示 3 继续支付 4 售罄
 */
-(void)ShowAlearViewWith:(NSString*)str Type:(NSInteger )type;


/**
 类似于 登录注册模块的 上半部分 出现的黑条 提示框
 */
-(void)ShowAlearTopBarViewWith:(NSString *)str;


@end
