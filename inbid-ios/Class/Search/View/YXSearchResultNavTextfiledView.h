//
//  YXSearchResultNavTextfiledView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backblock)();


typedef void(^clicktextfiledblock)();


@interface YXSearchResultNavTextfiledView : UIView

@property (nonatomic, copy) backblock backblock;

@property(nonatomic,copy)  clicktextfiledblock clicktextBlock;

@property(nonatomic,strong) UITextField * searchTextFiled;


@end
