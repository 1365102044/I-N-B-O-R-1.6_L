//
//  YXSearchResultNavTextfiledView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchResultNavTextfiledView.h"


@interface YXSearchResultNavTextfiledView ()<UITextFieldDelegate>

@property(nonatomic,strong) UIButton * backBtn;



@end

@implementation YXSearchResultNavTextfiledView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 30, 44, 44)];
        [self.backBtn setImage:[UIImage imageNamed:@"sousuotextfiledVCback"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"sousuotextfiledVCback"] forState:UIControlStateHighlighted];
        [self.backBtn addTarget:self action:@selector(ClickBackBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtn];

        
        self.searchTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(40, 30, YXScreenW-50, 30)];
        self.searchTextFiled.placeholder = @"输入您要搜索的商品";
        self.searchTextFiled.delegate = self;
        [self addSubview:self.searchTextFiled];
        //        [self.searchTextFiled setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self.searchTextFiled setValue:YXRegularfont(13) forKeyPath:@"_placeholderLabel.font"];
        self.searchTextFiled.font = YXRegularfont(13);
        self.searchTextFiled.textColor = [UIColor mainThemColor];
        self.searchTextFiled.returnKeyType = UIReturnKeySearch;
        self.backBtn.centerY = self.searchTextFiled.centerY;
        
        UIImageView *searchleftimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
        searchleftimage.frame = CGRectMake(0, 0, 30, 30);
        self.searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        self.searchTextFiled.leftView = searchleftimage;
        self.searchTextFiled.layer.masksToBounds = YES;
        self.searchTextFiled.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        self.searchTextFiled.layer.borderWidth = 1;
        self.searchTextFiled.layer.masksToBounds = YES;
        self.searchTextFiled.layer.cornerRadius = 3;

        
        
    }
    return self;
}
-(void)ClickBackBtn
{
    if (self.backblock) {
        self.backblock();
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.clicktextBlock) {
        self.clicktextBlock();
    }
}

@end
