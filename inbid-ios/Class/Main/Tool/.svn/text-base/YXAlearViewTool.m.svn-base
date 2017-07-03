//
//  YXAlearViewTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAlearViewTool.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXAlearFormMyView.h"

@interface YXAlearViewTool ()
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXAlearViewTool
+(instancetype)sharedAlearview
{
    static dispatch_once_t onceToken;
    static YXAlearViewTool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXAlearViewTool alloc]init];
    });
    return instance;
}

/**
 1 成功 2 警示 3 继续支付 4 售罄
 */
-(void)ShowAlearViewWith:(NSString*)str Type:(NSInteger )type
{
    if([str isKindOfClass:[NSDictionary class]])
    {
        
        str =  [[[YXStringFilterTool alloc]init] dictionaryToJson:(NSDictionary*)str];
        
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    [self.RemindGoodsView ShowAlearViewWith:str type:type];
    self.RemindGoodsView.frame = CGRectMake(0, 0, YXScreenW, YXScreenH);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.RemindGoodsView removeFromSuperview];
        self.RemindGoodsView = nil;
    });
    
}

/**
 类似于 登录注册模块的 上半部分 出现的黑条 提示框
 */
-(void)ShowAlearTopBarViewWith:(NSString *)str
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.alearMyview];
    self.alearMyview.alearstr = str;
}


-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}

-(YXMyOrderSuccessAlerview*)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

@end
