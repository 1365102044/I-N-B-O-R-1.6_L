//
//  YXReLoginViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXReLoginViewController.h"
#import "YXTheAccountAlearlybindingView.h"


@interface YXReLoginViewController ()
//@property(nonatomic,strong) YXReLoginView * MyReloginView;
@property(nonatomic,strong) YXTheAccountAlearlybindingView * reloginView;

@property(nonatomic,strong) UIButton * ReLoginBtn;

@end

@implementation YXReLoginViewController


/**
 重新 登录
 */
-(void)ClickReLoginBtn
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:NO completion:nil];
//    if(self.reloginBlock){
//        self.reloginBlock();
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"重新登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.MyTableView.frame = CGRectMake(0, 0, YXScreenW, YXScreenH);
    [self setUI];
}
-(void)setUI
{
    [self.view addSubview:self.MyTableView];
    self.MyTableView.tableHeaderView = self.reloginView;
    [self.reloginView setLoginTypeWith:self.thirdModle.loginType];
    __weak typeof(self)weakself = self;
    self.reloginView.loginBlock = ^(){
        [weakself ClickReLoginBtn];
    };

}


-(YXTheAccountAlearlybindingView *)reloginView
{
    if (!_reloginView) {
        
        _reloginView = [[YXTheAccountAlearlybindingView  alloc]initWithFrame:CGRectMake(0, 0, YXScreenW,YXScreenH)];
    }
    return _reloginView;
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
