//
//  YXResginsterAgreenmentViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXResginsterAgreenmentViewController.h"

@interface YXResginsterAgreenmentViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView * scrollerview;

@end

@implementation YXResginsterAgreenmentViewController
-(UIScrollView*)scrollerview
{
    if (!_scrollerview) {
        
        _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH)];
        _scrollerview.contentSize = CGSizeMake(YXScreenW, YXScreenH);
        _scrollerview.delegate= self;
        
    }
    return _scrollerview;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"胤宝用户协议";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollerview];
    
    UIImage *helpimage = [UIImage imageNamed:@"胤宝服务协议"];
    UIImageView *helpimageview = [[UIImageView alloc]init];
    helpimageview.frame = CGRectMake(0, 0, YXScreenW, helpimage.size.height);
    helpimageview.image = helpimage;
    
    [self.scrollerview addSubview:helpimageview];
    self.scrollerview.contentSize = CGSizeMake(YXScreenW, helpimage.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
