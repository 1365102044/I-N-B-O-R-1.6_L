//
//  YXSearchNavTextFiledView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchNavTextFiledView.h"


@interface YXSearchNavTextFiledView ()<UITextFieldDelegate,YXKeyboardToolbarDelegate>

/*
 @brief 搜索导航栏视图
 */
@property(nonatomic,strong) UIView * searchNavView;

@property(nonatomic,strong) UIButton * backBtn;



@property(nonatomic,strong) UIButton * searchBtn;

@property(nonatomic,strong) YXKeyboardToolbar * customAccessoryView;

@end

@implementation YXSearchNavTextFiledView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.searchTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 30, YXScreenW-60, 30)];
        self.searchTextFiled.placeholder = @"输入您要搜索的商品";
        self.searchTextFiled.delegate = self;
        [self addSubview:self.searchTextFiled];
        [self.searchTextFiled setValue:YXRegularfont(13) forKeyPath:@"_placeholderLabel.font"];
        //[self.searchTextFiled setInputAccessoryView:self.customAccessoryView];
        self.searchTextFiled.font = YXRegularfont(13);
        self.searchTextFiled.textColor = [UIColor mainThemColor];
        self.searchTextFiled.returnKeyType = UIReturnKeySearch;
        
        UIImageView *searchleftimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
        searchleftimage.frame = CGRectMake(0, 0, 30, 30);
        self.searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        self.searchTextFiled.leftView = searchleftimage;
        self.searchTextFiled.layer.masksToBounds = YES;
        self.searchTextFiled.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        self.searchTextFiled.layer.borderWidth = 1;
        self.searchTextFiled.layer.masksToBounds = YES;
        self.searchTextFiled.layer.cornerRadius = 3;
        
        self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-50, 0, 50, 30)];
        [self.searchBtn setTitle:@"取消"  forState:UIControlStateNormal];
        self.searchBtn.titleLabel.font = YXRegularfont(13);
        [self.searchBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        [self.searchBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
        self.searchBtn.centerY = self.searchTextFiled.centerY;
        [self addSubview:self.searchBtn];
        
        

        [YXNotificationTool addObserver:self selector:@selector(becomeFirstResponderMethod) name:@"becomeFirstResponderMethod" object:nil];
    }
    
    return self;
}
-(void)becomeFirstResponderMethod
{
     [self.searchTextFiled becomeFirstResponder];
}
-(void)clickCancleBtn
{
    if(self.clickcancleblock)
    {
        self.clickcancleblock(self.searchTextFiled.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.searchTextFiled resignFirstResponder];
    
    if (self.keysearchblock) {
        self.keysearchblock(self.searchTextFiled.text);
    }
    
    return  YES;
}


@end
