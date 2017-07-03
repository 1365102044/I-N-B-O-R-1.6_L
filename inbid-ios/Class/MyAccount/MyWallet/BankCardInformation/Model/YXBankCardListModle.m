//
//  YXBankCardListModle.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXBankCardListModle.h"
#import "YXBankCardDetailInformationModel.h"

@implementation YXBankCardListModle

- (NSArray *)locAgreement_list
{
    if (!_locAgreement_list) {
        
        NSData *data = [self.agreement_list dataUsingEncoding:NSUTF8StringEncoding];
        if (data ==nil) {
            return nil;
        }
        NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *tempArrayM = [NSMutableArray array];
        for (NSDictionary *dataDict in tempArray) {
            [tempArrayM addObject:[YXBankCardDetailInformationModel mj_objectWithKeyValues:dataDict]];
        }
        _locAgreement_list = tempArrayM.copy;
    }
    return _locAgreement_list;
}

@end
