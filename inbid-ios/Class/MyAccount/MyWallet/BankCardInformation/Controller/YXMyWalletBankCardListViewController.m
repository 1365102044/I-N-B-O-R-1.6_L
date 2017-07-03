//
//  YXMyWalletBankCardListViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletBankCardListViewController.h"
#import "YXMywalletBandcardListTableViewCell.h"
#import "UIBarButtonItem+Extension.h"
#import "YXInputPaymentPasswordView.h"
#import "YXWalletResultController.h"
#import "YXMyWalletRequestTool.h"
#import "YXBankCardInformationController.h"
#import "YXMyWalletPassWordViewController.h"
#import "YXResetPassWordViewController.h"
#import "YXTempView.h"
#import "YXSaveLoginDataTool.h"
#import "YXBankCardDetailInformationModel.h"
#import "YXBankCardListModle.h"
static NSString *mywalletcellidentifier = @"mywalletcellidentifier";
@interface YXMyWalletBankCardListViewController ()<UITableViewDelegate,UITableViewDataSource,YXInputPaymentPasswordViewDelegate>
@property(nonatomic,strong) YXTempView * tempView;
@property(strong ,nonatomic) UITableView *tableview;
@property(nonatomic,strong) NSIndexPath*  currenIndexPath;
@property(nonatomic,strong) YXInputPaymentPasswordView * paymentpasswordview;
@property(nonatomic,strong) YXBankCardListModle * listModle;
@end

@implementation YXMyWalletBankCardListViewController

/**
 点击 右Itembtn
 */
-(void)clickRightItem{
    YXBankCardInformationController *addcardVC = [YXBankCardInformationController bankCardInformationControllerWithType:YXBankCardInformationControllerAddBankCard cardholderName:[[YXSaveLoginDataTool shared] getRealName] cardNumber:nil extend:@1];
    [self.navigationController pushViewController:addcardVC animated:YES];
}
/**
 拦截返回方法 ->钱包主页
 */
-(void)clickpopBtnItem{
    
    if (self.PushFormeVCIdentifier==2) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [YXNotificationTool postNotificationName:@"pushMywalletMianVC" object:nil ];
        return;
    }else if (self.PushFormeVCIdentifier ==1
              || self.PushFormeVCIdentifier == 3
              || self.PushFormeVCIdentifier == 4) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/**
 请求数据
 */
-(void)RequestListData{

    [[YXMyWalletRequestTool sharedTool] RequestMyBundingBrandListSuccess:^(id objc, id respodHeader) {
        YXLog(@"--req-%@---",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
         
            self.listModle = [YXBankCardListModle mj_objectWithKeyValues:objc[@"data"]];
            YXLog(@"%@", self.listModle.locAgreement_list);
            if (self.listModle.locAgreement_list.count) {
                
                [self.tempView removeFromSuperview];
                self.tableview.tableHeaderView = [self creatHeaderView];
                
            }else{
                self.tableview.tableHeaderView = self.tempView;
            }
        }else{
        
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
}
/**
 //        解除绑定
 * @param noAgree  银通协议编号
 * @param payType  支付方式
 * @param pwdPay  支付密码，需要用SHA1加密
 */
-(void)RequestUnbindBrank:(NSString *)pwd{

    YXBankCardDetailInformationModel *model = self.listModle.locAgreement_list[self.currenIndexPath.row];
    
    [[YXMyWalletRequestTool sharedTool] RequestUnbindBrankListWithPassword:pwd payType:model.card_type noAgree:model.no_agree Success:^(id objc, id respodHeader) {
        YXLog(@"-jiebang--%@---",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            /**
             解绑成功
             */
            YXWalletResultController *walletResultController = [YXWalletResultController walletResultControllerWithType:YXWalletResultControllerDefault   extend:@{@"titleString":@"解绑成功!",@"imageNamed":@"icon_openwalletsuccess",@"buttonTitle":@"返回",@"sourVcType":@"unbindbankSuccess"}];
            [self.navigationController pushViewController:walletResultController animated:YES];

        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
    } failure:^(NSError *error) {
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.currenIndexPath = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableview];
    [self RequestListData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"银行卡";
    self.view.backgroundColor = YXBackMainColor;
    
    [self addNavTitle];
    self.tableview.tableHeaderView = [self creatHeaderView];    
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(RequestListData)];
     
}


-(UIView *)creatHeaderView{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 10)];
    headerview.backgroundColor = YXBackMainColor;
    return headerview;
}

/**
 初始化控制器
 */
+(instancetype)CreatBrankListControllerWithExtend:(id)extend{
    YXMyWalletBankCardListViewController *branklistvc = [[YXMyWalletBankCardListViewController alloc]init];
    branklistvc.PushFormeVCIdentifier = (NSInteger)extend;
    return branklistvc;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listModle.locAgreement_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YXMywalletBandcardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mywalletcellidentifier];
    if (!cell) {
        
        cell = [[YXMywalletBandcardListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mywalletcellidentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.listModle = self.listModle.locAgreement_list[indexPath.row];
    
    return cell;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"解绑"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        self.currenIndexPath = indexPath;
        [self AlearPasswordView];
    }];
    deleteRowAction.backgroundColor = UIColorFromRGB(0xa90311);
    return  @[deleteRowAction];
    
}

/**
 点击事件，回调给提现控制器

 @param tableView tableView
 @param indexPath indexPath 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  储蓄卡的时候点击有效
     */
    YXBankCardDetailInformationModel *bankCardDetail = self.listModle.locAgreement_list[indexPath.row];
    if (self.PushFormeVCIdentifier == 4
        && [bankCardDetail.card_type isEqualToString:@"储蓄卡"]) {
        YXBankCardDetailInformationModel *cardInformationModel = self.listModle.locAgreement_list[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(myWalletBankCardListViewController:bankCardModel:)]) {
            [self.delegate myWalletBankCardListViewController:self bankCardModel:cardInformationModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 输入 密码的view
 */
-(void)AlearPasswordView{
    YXInputPaymentPasswordView *paymentpasswordview = [YXInputPaymentPasswordView inputPaymentPasswordViewPresentWithExtend:nil];
    paymentpasswordview.delegate = self;
    self.paymentpasswordview = paymentpasswordview;
}
/**
 按钮点击事件
 
 @param inputPaymentPasswordView            inputPaymentPasswordView
 @param button                              button
 */
- (void)inputPaymentPasswordView:(YXInputPaymentPasswordView *)inputPaymentPasswordView
                             pwd:(NSString *)pwd
                     otherButton:(UIButton *)button{
    
    /**
     *  动画
     */
    [UIView animateWithDuration:0.25 animations:^{
        self.paymentpasswordview.alpha                                                          = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.paymentpasswordview removeFromSuperview];
        }
    }];

    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.currenIndexPath.row inSection:self.currenIndexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
    
    /**
     *  关闭
     */
    if (button.tag == 1001) {
        
    }
    
    /**
     *  忘记密码
     */
    if (button.tag == 1002) {
     
        YXResetPassWordViewController *forgetVC = [[YXResetPassWordViewController alloc]init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    }
    
    /**
     *  确认发送网络请求
     */
    if (button.tag == 1003) {
        
//        解除绑定
        [self RequestUnbindBrank:pwd];
    }
}


//先要设Cell可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)addNavTitle
{
    UIButton *leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(clickpopBtnItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftitem;
    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -39, 0, 0);
    leftbtn.backgroundColor = [UIColor clearColor];
    
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addbtn setImage:[UIImage imageNamed:@"icon_brandcardrightitem"] forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(clickRightItem) forControlEvents:UIControlEventTouchUpInside];
    addbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    addbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -15);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:addbtn];
    self.navigationItem.rightBarButtonItem = right;
    
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 80;
        _tableview.backgroundColor = YXBackMainColor;
    }
    return _tableview;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.tableview.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
    }
    return _tempView;
}

@end