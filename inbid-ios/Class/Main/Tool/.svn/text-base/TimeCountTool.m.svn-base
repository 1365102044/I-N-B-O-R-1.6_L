//
//  TimeCountTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "TimeCountTool.h"

@implementation TimeCountTool

+(instancetype)sharedTimeTool{
    
    static TimeCountTool *timeTool;
    static dispatch_once_t Onetimecount;
    dispatch_once(&Onetimecount, ^{
        timeTool = [[TimeCountTool alloc] init];
    });
    return timeTool;
    
}

-(void)updateDisplay
{


}



@end
