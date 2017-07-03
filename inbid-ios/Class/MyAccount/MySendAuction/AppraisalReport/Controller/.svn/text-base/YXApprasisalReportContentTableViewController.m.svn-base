//
//  YXApprasisalReportContentTableViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApprasisalReportContentTableViewController.h"
#import "YXApprasisalReportCell.h"
#import "YXAppraisaReportViewDataModel.h"
#import "YXPlatformRecoveryController.h"
#import "YXSendAuctionConsignmentPlatformController.h"
#import "YXAppraisaReportIdentifyModel.h"
#import "YXStringFilterTool.h"
#import "YXSendAuctionInformationController.h"

@interface YXApprasisalReportContentTableViewController ()<YXSendAuctionConsignmentPlatformControllerDelegate, YXPlatformRecoveryControllerDelegate>

/**
 顶部窗帘视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

/**
 商品图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

/**
 文字内容视图
 */
@property (weak, nonatomic) IBOutlet UIView *textContentView;

/**
 鉴定编号label
 */
@property (weak, nonatomic) IBOutlet UILabel *identifyIdLabel;

/**
 鉴定名称label
 */
@property (weak, nonatomic) IBOutlet UILabel *identifyNameLabel;

/**
 成色等级label
 */
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

/**
 商品描述label
 */
@property (weak, nonatomic) IBOutlet UILabel *goodDetailLabel;

/**
 查看详情按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *checkDetailViewControllerButton;

/**
 headerView
 */
@property (weak, nonatomic) IBOutlet UIView *tableViewHeaderView;

/**
 内容按钮数据源数组
 */
@property (nonatomic, strong) NSArray *contentButtonDataArray;

/**
 底部提示框
 */
@property (weak, nonatomic) IBOutlet UILabel *bottomTipsLabel;

@end

@implementation YXApprasisalReportContentTableViewController

#pragma mark - Zero.重用标志

static NSString * const kYXApprasisalReportCellCellReuseIdentifier = @"kYXApprasisalReportCellCellReuseIdentifier";

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 更新界面

 @param appraisaReportIdentifyModel appraisaReportIdentifyModel
 */
- (void)setAppraisaReportIdentifyModel:(YXAppraisaReportIdentifyModel *)appraisaReportIdentifyModel
{
    _appraisaReportIdentifyModel = appraisaReportIdentifyModel;
    
    //** 更新界面 */
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:appraisaReportIdentifyModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.identifyIdLabel.text = [NSString stringWithFormat:@"鉴 定 编 号：%lld", appraisaReportIdentifyModel.indentifyOrderId];
    self.identifyNameLabel.text = [NSString stringWithFormat:@"鉴 定 名 称：%@", appraisaReportIdentifyModel.prodName];
    self.gradeLabel.text = [NSString stringWithFormat:@"成 色 等 级：%@", appraisaReportIdentifyModel.prodCondition];
    self.goodDetailLabel.text = [NSString stringWithFormat:@"商 品 描 述：%@", appraisaReportIdentifyModel.orderContent];
    
    if (!self.isShowOtherFuncView) {
        if (self.appraisaReportIdentifyModel.identifyStatus == 3) {
            //** 鉴定失败 */
            self.contentButtonDataArray = nil;
            self.bottomTipsLabel.text = @"如您对商品鉴定结果有任何异议，请联系我们客服。";
        }else{
            self.bottomTipsLabel.text = @"如您对商品指导价格有任何异议，请联系我们客服。";
            if (!self.appraisaReportIdentifyModel.recycleMoney) {
                //** 未设置回收价 */
                self.contentButtonDataArray = @[@{@"title":@"建议一口价",
                                                  @"detailTitle":@"委托胤宝寄卖",
                                                  @"imageNamed":@"icon_fanhui1"}];
                self.contentButtonDataArray = [YXAppraisaReportViewDataModel mj_objectArrayWithKeyValuesArray:self.contentButtonDataArray];
            }
        }
    }else{
        //** 详情进入鉴定报告 */
        self.contentButtonDataArray = nil;
        self.checkDetailViewControllerButton.hidden = YES;
        
        if (self.appraisaReportIdentifyModel.identifyStatus == 3) {
            //** 鉴定失败 */
            self.bottomTipsLabel.text = @"如您对商品鉴定结果有任何异议，请联系我们客服。";
        }else{
            self.bottomTipsLabel.text = @"如您对商品指导价格有任何异议，请联系我们客服。";
        }
    }
    
    [self.contentButtonDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YXAppraisaReportViewDataModel *model = (YXAppraisaReportViewDataModel *)obj;
        //** 起拍价 */
//        if (idx == 0) {
//            model.money = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", appraisaReportIdentifyModel.startPrice / 100]];
//        }
        //** 一口价 */
        if (idx == 0) {
            model.money = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", appraisaReportIdentifyModel.suggestMoney / 100]];
        }
        //** 平台回收价格 */
        if (idx == 1) {
            model.money = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", appraisaReportIdentifyModel.recycleMoney / 100]];
        }
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Third.点击事件

/**
 查看鉴定详情按钮点击事件

 @param sender sender
 */
- (IBAction)checkDetailViewControllerButtonClick:(UIButton *)sender
{
    //** TODO:设置开关刷新界面 */
    YXSendAuctionInformationController *informationController = [YXSendAuctionInformationController new];
    informationController.sourceViewController = self;
    informationController.orderID = self.appraisaReportIdentifyModel.indentifyOrderId;
    [self.navigationController pushViewController:informationController animated:YES];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXPlatformRecoveryControllerDelegate>

/**
 监听用户操作，操作成功后，刷新列表

 @param platformRecoveryController platformRecoveryController
 @param isRestPage isRestPage
 */
- (void)platformRecoveryController:(YXPlatformRecoveryController *)platformRecoveryController changeRestPageON:(BOOL)isRestPage
{
    if ([self.delegate respondsToSelector:@selector(apprasisalReportContentTableViewController:changeRestPageON:)]) {
        [self.delegate apprasisalReportContentTableViewController:self changeRestPageON:isRestPage];
    }
}

#pragma mark <YXSendAuctionConsignmentPlatformControllerDelegate>

/**
 监听用户操作，操作成功后，刷新列表

 @param sendAuctionConsignmentPlatformController sendAuctionConsignmentPlatformController
 @param isRestPage isRestPage
 */
- (void)sendAuctionConsignmentPlatformController:(YXSendAuctionConsignmentPlatformController *)sendAuctionConsignmentPlatformController changeRestPageON:(BOOL)isRestPage
{
    if ([self.delegate respondsToSelector:@selector(apprasisalReportContentTableViewController:changeRestPageON:)]) {
        [self.delegate apprasisalReportContentTableViewController:self changeRestPageON:isRestPage];
    }
}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 @param tableView tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentButtonDataArray.count;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXApprasisalReportCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXApprasisalReportCellCellReuseIdentifier forIndexPath:indexPath];
    cell.viewDataModel = self.contentButtonDataArray[indexPath.row];
    return cell;
}

#pragma mark <UITableViewDelegate>

/**
 点击事件

 @param tableView tableView
 @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //** 建议一口价 */
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YXSendAuctionConsignmentPlatformController" bundle:nil];
        YXSendAuctionConsignmentPlatformController *consignmentPlatformController = [sb instantiateInitialViewController];
        consignmentPlatformController.appraisaReportIdentifyModel = self.appraisaReportIdentifyModel;
        consignmentPlatformController.type = kYXSendAuctionConsignmentPlatformControllerLoadConsignment;
        consignmentPlatformController.delegate = self;
        [self.navigationController pushViewController: consignmentPlatformController animated:YES];
        return;
    }
    
    //** 平台回收价格 */
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PlatformRecovery" bundle:nil];
        YXPlatformRecoveryController *platformRecoveryController = [sb instantiateInitialViewController];
        platformRecoveryController.appraisaReportIdentifyModel = self.appraisaReportIdentifyModel;
        platformRecoveryController.delegate = self;
        [self.navigationController pushViewController: platformRecoveryController animated:YES];
        return;
    }
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 界面样式配置 */
    self.tableView.rowHeight = 49;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = NO;
    [self.tableViewHeaderView.layer setBorderWidth:1.0];
    CGColorRef borderColor = [UIColor themGrayColor].CGColor;
    [self.tableViewHeaderView.layer setBorderColor:borderColor];
    [self.checkDetailViewControllerButton setTitleColor:[UIColor themBlueColor] forState:UIControlStateNormal];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //** 配置界面 */
//    _contentButtonDataArray = @[@{@"title":@"平台起拍价",
//                                  @"detailTitle":@"委托胤宝寄拍",
//                                  @"imageNamed":@"icon_fanhui1"},
//                                @{@"title":@"建议一口价",
//                                  @"detailTitle":@"委托胤宝寄卖",
//                                  @"imageNamed":@"icon_fanhui1"},
//                                @{@"title":@"平台回收价",
//                                  @"detailTitle":@"卖给胤宝平台",
//                                  @"imageNamed":@"icon_fanhui1"}];
    _contentButtonDataArray = @[@{@"title":@"建议一口价",
                                  @"detailTitle":@"委托胤宝寄卖",
                                  @"imageNamed":@"icon_fanhui1"},
                                @{@"title":@"平台回收价",
                                  @"detailTitle":@"卖给胤宝平台",
                                  @"imageNamed":@"icon_fanhui1"}];
    _contentButtonDataArray = [YXAppraisaReportViewDataModel mj_objectArrayWithKeyValuesArray:_contentButtonDataArray];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
