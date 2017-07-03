//
//  YXBankCardInformationModel.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/21.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXBankCardDetailInformationModel.h"

@implementation YXBankCardDetailInformationModel

//银行卡类型  card_type  否  String  2-储蓄卡    3-信用卡
- (NSString *)card_type
{
    if (_card_type.length) {
        if ([_card_type isEqualToString:@"2"]) {
            _card_type = @"储蓄卡";
        }else if ([_card_type isEqualToString:@"3"]) {
            _card_type = @"信用卡";
        }
    }else{
        return nil;
    }
    return _card_type;
}

- (NSString *)logoImageUrlString
{
    if (!_logoImageUrlString) {
        _logoImageUrlString = [NSString stringWithFormat:@"%@/bank/%@.png",
                               @"http://inbid-pro.img-cn-beijing.aliyuncs.com",
                               self.bank_code];
    }
    return _logoImageUrlString;
}

@end
