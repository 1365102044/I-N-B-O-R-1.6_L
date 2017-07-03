//
//  YXRequestZitiInformationManager.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXRequestZitiInformationManager.h"
#import "YXMyAccountNetRequestTool.h"

@interface YXRequestZitiInformationManager ()

@property(nonatomic,assign) BOOL  iscanloadBool;

@end
@implementation YXRequestZitiInformationManager

+(instancetype)sharedZiti
{
    static dispatch_once_t onceToken;
    static YXRequestZitiInformationManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXRequestZitiInformationManager alloc]init];
    });
    return instance;
}

- (void)loadZiTiInfor
{
    [[YXMyAccountNetRequestTool sharedTool] mailNowLoadMyAddressWithSuccess:^(id objc, id respodHeader) {

        @try {
            
            //** 数据本地化 */
            
            /**
             *  客服电话
             */
            [YXUserDefaults setObject:objc[@"customerPhone"] forKey:@"customerPhone"];
            
            /**
             *  自提地址
             */
            [YXUserDefaults setObject:objc[@"consigneeAddress"] forKey:@"consigneeAddress"];
            
            /**
             *  自提人姓名
             */
            [YXUserDefaults setObject:objc[@"consigneeName"] forKey:@"consigneeName"];
            
            /**
             *  自提电话
             */
            [YXUserDefaults setObject:objc[@"consigneePhone"] forKey:@"consigneePhone"];
            
            /**
             *  营业时间
             */
            [YXUserDefaults setObject:objc[@"businessTime"] forKey:@"businessTime"];
            
            /**
             *  佣金
             */
            [YXUserDefaults setObject:objc[@"commissionRatio"] forKey:@"commissionRatio"];
            
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
            [YXNetworkHUD dismiss];
        }
        
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
}

-(NSString *)objectZiTiWithforKey:(NSString *)Inforkey
{
    NSString *str = [self checkoutinfor:Inforkey];
    
    if (!str.length) {

        [self loadZiTiInfor];
        
        str =   [self checkoutinfor:Inforkey];
        
    }
    
    return str;
}

-(NSString *)checkoutinfor:(NSString *)Inforkey
{
    NSString *informastr ;
    if ([Inforkey isEqualToString:@"customerPhone"]) {
        
        informastr = [YXUserDefaults objectForKey:@"customerPhone"];;
        
    }else if ([Inforkey isEqualToString:@"consigneeAddress"]) {
        
        informastr = [YXUserDefaults objectForKey:@"consigneeAddress"];;
        
    }else if ([Inforkey isEqualToString:@"consigneeName"]) {
        
        informastr = [YXUserDefaults objectForKey:@"consigneeName"];
        
    }else if ([Inforkey isEqualToString:@"consigneePhone"]) {
        
        informastr = [YXUserDefaults objectForKey:@"consigneePhone"];;
        
    }else if ([Inforkey isEqualToString:@"businessTime"]) {
        
        informastr = [YXUserDefaults objectForKey:@"businessTime"];;
        
    }else if ([Inforkey isEqualToString:@"commissionRatio"]) {
        
        informastr = [YXUserDefaults objectForKey:@"commissionRatio"];;
    }
    return informastr;
}


@end
