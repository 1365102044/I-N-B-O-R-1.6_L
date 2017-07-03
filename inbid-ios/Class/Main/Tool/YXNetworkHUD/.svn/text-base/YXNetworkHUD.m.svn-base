//
//  YXNetworkHUD.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNetworkHUD.h"

@implementation YXNetworkHUD

+ (void)show
{
    NSMutableArray *tempArrayM = [NSMutableArray array];
    for (NSInteger i = 0; i < 64; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_networkInd_%zd", (i+1)]];
        [tempArrayM addObject:image];
    }
    
//    [self setGifWithImageName:@"networkHUD.gif"];
    [self setGifWithImages:tempArrayM.copy];
    [super show];
}

@end
