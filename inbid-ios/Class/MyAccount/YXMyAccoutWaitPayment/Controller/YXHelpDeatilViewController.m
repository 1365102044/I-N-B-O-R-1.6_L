//
//  YXHelpDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/25.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHelpDeatilViewController.h"

@interface YXHelpDeatilViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView * scrollerview;


@end

@implementation YXHelpDeatilViewController
-(UIScrollView*)scrollerview
{
    if (!_scrollerview) {
        
        _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH)];
        _scrollerview.contentSize = CGSizeMake(YXScreenW, YXScreenH);
        _scrollerview.delegate= self;
        
    }
    return _scrollerview;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"帮助中心";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollerview];
    
    UIImage *helpimage = [UIImage imageNamed:@"帮助页面-psd.jpg"];
    UIImageView *helpimageview = [[UIImageView alloc]init];
    helpimageview.frame = CGRectMake(0, 0, YXScreenW, helpimage.size.height);
    helpimageview.image = helpimage;
    
    [self.scrollerview addSubview:helpimageview];
    
    self.scrollerview.contentSize = CGSizeMake(YXScreenW, helpimage.size.height);
//    if (self.scrolleroffeY>4000) {
//        self.scrollerview.contentSize = CGSizeMake(YXScreenW, helpimage.size.height+YXScreenH-300);
//    }
    
    if (self.scrolleroffeY==0) {
        
        [self.scrollerview setContentOffset:CGPointMake(0, self.scrolleroffeY+0) animated:YES];
    
    }else{
    
        [self.scrollerview setContentOffset:CGPointMake(0, self.scrolleroffeY+64) animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
//    YXLog(@"---------%f",offsetY);
    
//    if (offsetY>4505) {
//        [self.scrollerview setContentOffset:CGPointMake(0, 4441) animated:YES];
//    }
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
