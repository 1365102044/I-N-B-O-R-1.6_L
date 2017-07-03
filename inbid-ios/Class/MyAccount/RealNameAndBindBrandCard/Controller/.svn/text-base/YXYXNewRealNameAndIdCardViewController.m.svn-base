//
//  YXYXNewRealNameAndIdCardViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXYXNewRealNameAndIdCardViewController.h"
#import "UILabel+Extension.h"
@interface YXYXNewRealNameAndIdCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topviewdescLable;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfiled;
@property (weak, nonatomic) IBOutlet UIView *IdCardBackView;
@property (weak, nonatomic) IBOutlet UITextField *IdCardTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *BrandCardTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *CommitBtn;
@property (weak, nonatomic) IBOutlet UILabel *BoomdescLable;

@end

@implementation YXYXNewRealNameAndIdCardViewController

/**
 点击提交按钮
 */
- (IBAction)ClickCommitBtn:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUI
{
    [self.topviewdescLable setRowSpace:5];
    self.topviewdescLable.text = @"仅限绑定本人名下银行卡，实名信息提交后无法修改。\n请认真填写";
    
    [self.BoomdescLable setRowSpace:5];
    self.BoomdescLable.text = @"1.实名认证后无法修改。\n2.仅限绑定本人名下银行卡，用于退款，提现账户。\n3.为了保证您的资金安全，请确保您填写的信息真实有效。";
    
    self.CommitBtn.layer.cornerRadius = 4;
    self.CommitBtn.layer.masksToBounds = YES;
    
    self.IdCardBackView.layer.borderWidth = 1;
    self.IdCardBackView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    
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
