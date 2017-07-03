//
//  YXMyAccountAboutUSViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountAboutUSViewController.h"
#import "YXMyAccountFeedbookViewController.h"


@interface YXMyAccountAboutUSViewController ()

@property (weak, nonatomic) IBOutlet UIView *Bigbackview;

/**
 版本label
 */
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation YXMyAccountAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"关于胤宝";
    self.versionLabel.text = [NSString stringWithFormat:@"胤宝%@",
                              [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
    
    [self setViewUI];
    
}

-(void)setViewUI
{
    self.Bigbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.Bigbackview.layer.borderWidth = 0.5;
}

- (IBAction)ClickGotoScore:(id)sender {
    
}
- (IBAction)ClickBackAdvice:(id)sender {
    
    YXMyAccountFeedbookViewController *feedbookVC = [[YXMyAccountFeedbookViewController alloc]init];
    [self.navigationController pushViewController:feedbookVC animated:YES];
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
