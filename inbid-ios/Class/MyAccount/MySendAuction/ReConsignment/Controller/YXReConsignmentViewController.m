//
//  YXReConsignmentViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXReConsignmentViewController.h"
#import "YXReturnGoodsViewController.h"
#import "YXYXReConsignmentContentTableController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXAppraisaReportIdentifyModel.h"
#import <MQChatViewManager.h>
#import  <MeiQiaSDK/MQManager.h>

@interface YXReConsignmentViewController ()<YXReturnGoodsViewControllerDelegate, YXYXReConsignmentContentTableControllerDelegate>

/**
 鉴定结果页
 */
@property (weak, nonatomic) IBOutlet UILabel *identifyResultLabel;

/**
 申请退回界面
 */
@property (weak, nonatomic) IBOutlet UIButton *backButton;

/**
 联系客服
 */
@property (weak, nonatomic) IBOutlet UIButton *customSeverButton;

/**
 底部功能视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 底部视图上边线
 */
@property (weak, nonatomic) IBOutlet UIView *bottomViewTopMarginView;

/**
 嵌入的内容控制器
 */
@property (nonatomic, weak) YXYXReConsignmentContentTableController *contentTableViewController;

/**
 网络数据
 */
@property (nonatomic, strong) YXAppraisaReportIdentifyModel *appraisaReportIdentifyModel;

@end

@implementation YXReConsignmentViewController

#pragma mark - Zero.获取嵌入的控制器

/**
 通过segue获取嵌入控制器
 
 @param segue  segue
 @param sender sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //** 获取目标控制器 */
    _contentTableViewController = segue.destinationViewController;
    _contentTableViewController.delegate = self;
}

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 更新界面
 
 @param appraisaReportIdentifyModel appraisaReportIdentifyModel
 */
- (void)setAppraisaReportIdentifyModel:(YXAppraisaReportIdentifyModel *)appraisaReportIdentifyModel
{
    _appraisaReportIdentifyModel = appraisaReportIdentifyModel;
    
    //** 顶部状态显示栏 */
    self.identifyResultLabel.text = @"以下商品规定时间内未售出，请重新选择寄卖方式";
    //** 通知内容视图，更新数据 */
    _contentTableViewController.appraisaReportIdentifyModel = appraisaReportIdentifyModel;
}

#pragma mark - Third.点击事件

/**
 申请退回按钮点击事件
 
 @param sender sender
 */
- (IBAction)backButtonClick:(UIButton *)sender
{
    //** TODO:我要退回数据传递及界面刷新开关 */
    YXReturnGoodsViewController *returnGoodsViewController = [[YXReturnGoodsViewController alloc] init];
    returnGoodsViewController.goodName = self.appraisaReportIdentifyModel.prodName;
    returnGoodsViewController.fixGoodReturnId = self.appraisaReportIdentifyModel.identifyId;
    returnGoodsViewController.prodId = self.appraisaReportIdentifyModel.prodId;
    returnGoodsViewController.buyoutId = self.appraisaReportIdentifyModel.indentifyOrderId;
    returnGoodsViewController.delegate = self;
    [self.navigationController pushViewController:returnGoodsViewController animated:YES];
}

/**
 联系客服按钮点击事件
 
 @param sender sender
 */
- (IBAction)customSeverButtonClick:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"联系客服" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    UIAlertAction *severPhoneNumberAction = [UIAlertAction actionWithTitle:@"电话客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self callSever];
    }];
    
    UIAlertAction *onLineSeverAction = [UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self onLineSever];
    }];
    
    [alertController addAction:defaultAction];
    [alertController addAction:severPhoneNumberAction];
    [alertController addAction:onLineSeverAction];//代码块前的括号是代码块返回的数据类型
    [self presentViewController: alertController animated:YES completion:nil];
}

/**
 电话客服
 */
- (void)callSever
{
    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phonestr];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

/**
 在线客服
 */
- (void)onLineSever
{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc]init];
    
    //    //**顾客头像**/
    NSString *sexstr = [YXUserDefaults objectForKey:@"head"];
    UIImage *avatar = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@",sexstr]];
    
    MQChatViewStyle *chatViewStyle = [chatViewManager chatViewStyle];
    
    //    设置发送过来的message的文字颜色；
    [chatViewStyle setIncomingMsgTextColor:UIColorFromRGB(0x050505)];
    //    设置发送过来的message气泡颜色
    [chatViewStyle setIncomingBubbleColor:[UIColor whiteColor]];
    //    设置发送出去的message的文字颜色；
    [chatViewStyle setOutgoingMsgTextColor:UIColorFromRGB(0x050505)];
    //    设置发送的message气泡颜色
    [chatViewStyle setOutgoingBubbleColor:UIColorFromRGB(0xb0e46e)];
    //    是否开启圆形头像；默认不支持
    [chatViewStyle setEnableRoundAvatar:true];
    //    设置顾客的头像图片；
    [chatViewManager setoutgoingDefaultAvatarImage:avatar];
    //     设置客服的名字
    [chatViewManager setAgentName:@"Angle"];
    
    chatViewStyle.navBackButtonImage = [UIImage imageNamed:@"icon_fanhui"];
    chatViewManager.chatViewStyle.navBarTintColor = UIColorFromRGB(0x050505);
    
    [chatViewManager setMessageLinkRegex:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
    //    [chatViewManager.chatViewStyle setIncomingMsgSoundFileName:@"MQNewMessageRingStyleTwo.wav"];
    [chatViewManager enableMessageSound:true];
    
    [chatViewManager setNavTitleText:@"胤宝客服"];
    //    [chatViewManager setLoginCustomizedId:@"122322"];
    //开启同步消息
    [chatViewManager enableSyncServerMessage:true];
    [chatViewManager pushMQChatViewControllerInViewController:self];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXYXReConsignmentContentTableControllerDelegate>

/**
 监听用户点击，打开刷新列表开关

 @param reConsignmentContentTableController reConsignmentContentTableController
 @param isRestPage isRestPage
 */
- (void)reConsignmentContentTableController:(YXYXReConsignmentContentTableController *)reConsignmentContentTableController changeRestPageON:(BOOL)isRestPage
{
    if ([self.delegate respondsToSelector:@selector(reConsignmentViewController:changeRestPageON:)]) {
        [self.delegate reConsignmentViewController:self changeRestPageON:isRestPage];
    }
}

#pragma mark <YXReturnGoodsViewControllerDelegate>

/**
 监听用户点击事件

 @param returnGoodsViewController returnGoodsViewController
 @param isRestPage isRestPage
 */
- (void)returnGoodsViewController:(YXReturnGoodsViewController *)returnGoodsViewController changeRestPageON:(BOOL)isRestPage
{
    if ([self.delegate respondsToSelector:@selector(reConsignmentViewController:changeRestPageON:)]) {
        [self.delegate reConsignmentViewController:self changeRestPageON:isRestPage];
    }
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 界面样式配置 */
    self.view.backgroundColor = [UIColor themLightGrayColor];
    [self.backButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [self.customSeverButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.customSeverButton setBackgroundColor:[UIColor mainThemColor]];
    self.bottomViewTopMarginView.backgroundColor = [UIColor themGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"设置寄卖方式";
    
    
    
    //** 加载数据 */
    [self loadData];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.加载数据

/**
 加载数据
 */
- (void)loadData
{
    [[YXMyAccountNetRequestTool sharedTool] setBuyoutChooseWithIdentifyId:self.identifyId success:^(id objc, id respodHeader) {
        self.appraisaReportIdentifyModel = [YXAppraisaReportIdentifyModel mj_objectWithKeyValues:objc];
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
}

#pragma mark - Eighth.懒加载

@end
