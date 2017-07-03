//
//  YXLineInformationCommitSuccessViewController.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXLineInformationCommitSuccessViewController.h"
#import "UILabel+Extension.h"
#import "YXChatViewManger.h"
#import "UIBarButtonItem+Extension.h"
#import "YXOrderDetailViewController.h"

@interface YXLineInformationCommitSuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIButton *ToSeeOrderDeatilBtn;
@property (weak, nonatomic) IBOutlet UIButton *titlebtn;
@end

@implementation YXLineInformationCommitSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息提交成功";
    self.ToSeeOrderDeatilBtn.layer.masksToBounds = YES;
    self.ToSeeOrderDeatilBtn.layer.cornerRadius = 4;
    self.desclabel.text = @"我们会在2个工作日内核对您的付款信息\n结果会以短信的形式通知您";
    [self.desclabel setRowSpace:10];
    self.desclabel.textAlignment = NSTextAlignmentCenter;
    self.titlebtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self setNavItemsView];
    
}
-(void)setNavItemsView
{
    
    UIBarButtonItem *leftitemt = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftItem) image:@"icon_PayFenBiClose" highImage:@"icon_PayFenBiClose"];
    self.navigationItem.leftBarButtonItem = leftitemt;
    
    UIBarButtonItem *rightitem = [UIBarButtonItem itemWithTarget:self action:@selector(clickRightItem) image:@"ico_payNews" highImage:@"ico_payNews"];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)clickRightItem
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];

}
-(void)clickLeftItem
{
    [self pushToOrderDetailViewController];
}


- (IBAction)ClickToSeeOrderDeatil:(id)sender
{
    [self pushToOrderDetailViewController];
}

/**
 展示订单详情界面
 */
- (void)pushToOrderDetailViewController
{
    if (self.navigationController.viewControllers.count == 5) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
        return;
    }
    if (self.navigationController.viewControllers.count == 4) {
        YXOrderDetailViewController *detailController = [YXOrderDetailViewController orderDetailViewControllerWithOrderId:self.orderId andExtend:self];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [YXNotificationTool removeObserver:self];
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
