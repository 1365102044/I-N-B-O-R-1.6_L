//
//  YXMyAddressListController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAddressListController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXAddNewAddressViewController.h"
#import "YXAddNewAddressTableViewController.h"
#import "YXMyAddressList.h"
#import "YXMyAddressCell.h"
#import "YXTempView.h"
#import "YXReturnGoodsViewController.h"
#import "YXMyAccountGOPaymentConfirmAddressViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"

static NSString * const kYXMyAddressCellReuseIdentifier = @"kYXMyAddressCellReuseIdentifier";

@interface YXMyAddressListController ()<YXMyAddressCellDelegate,UITableViewDelegate>

//** 添加新地址按钮 */
@property (nonatomic, strong) UIButton *addNewAddressButton;
//** 当前选中默认地址 */
@property (nonatomic, strong) UIButton *currentButton;
//** 地址列表 */
@property (nonatomic, strong) NSArray *addressListArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//** 空页面 */
@property (nonatomic, strong) YXTempView *tempView;

@end

@implementation YXMyAddressListController



#pragma mark - 赋值

- (void)setAddressListArray:(NSArray *)addressListArray
{
    _addressListArray = addressListArray;
    
    [self.tableView reloadData];
}


#pragma mark - 点击事件

/**
 返回事件
 
 @param sender 点击按钮
 */
- (void)addressbackButtonClick:(UIButton *)sender
{
    if ([self.sourceController isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]) {
        //** 点击返回时需要做的操作 */
        
        [self.navigationController popViewControllerAnimated: YES];
        return;
    }
    
    
    //确认订单页面的返回
    if ([self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
        YXMyAddressList *modle = [[YXMyAddressList alloc]init];
        if (self.addressListArray.count==0) {
            
            modle.IsHaveData = NO;
        }else{
            
            modle = self.addressListArray[0];
            modle.IsHaveData = YES;
        }
        if (self.modleblock) {
            self.modleblock(modle);
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([self.sourceController isKindOfClass:[YXReturnGoodsViewController class]]) {
        YXReturnGoodsViewController *returnGoodsViewController = (YXReturnGoodsViewController *)self.sourceController;
        //** 判断当前地址列表是否有值，如果没有，将前面来源控制器的值清空 */
        if (self.addressListArray.count == 0) {
            returnGoodsViewController.addressList = nil;
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)addNewAddressButtonClick:(UIButton *)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"addNewAddress" bundle:[NSBundle mainBundle]];
    
    //--添加新地址控制器
    YXAddNewAddressViewController *toTableViewController = [sb instantiateInitialViewController];
    toTableViewController.sourceController = self.sourceController;
    [self.navigationController pushViewController: toTableViewController animated:YES];
    
}



#pragma mark --YXMyAddressCellDelegate
- (void)myAddressCell:(YXMyAddressCell *)myAddressCell withCurrentButton:(UIButton *)currentButton withDefaultAddressId:(NSInteger)defaultAddressId
{
    self.currentButton.enabled = YES;
    currentButton.enabled = NO;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:myAddressCell];
    YXMyAddressList *addressListModel = self.addressListArray[indexPath.row];
    
    YXLog(@"%zd", indexPath.row);
    
    if (!addressListModel.isDefault) {
        [[YXMyAccountNetRequestTool sharedTool] setDefaultAddressWithAddressId:defaultAddressId success:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"切换成功"]) {
                /**
                 * 收货人姓名
                 */
                //[YXUserDefaults setObject:addressListModel.consigneeName forKey:@"consigneeName"];
                /**
                 * 收货人手机
                 */
                [YXUserDefaults setObject:addressListModel.consigneeMobile forKey:@"consigneeMobile"];
                /**
                 * 收货人省份
                 */
                [YXUserDefaults setObject:addressListModel.consigneeProvince forKey:@"consigneeProvince"];
                /**
                 * 收货人城市
                 */
                [YXUserDefaults setObject:addressListModel.consigneeCity forKey:@"consigneeCity"];
                /**
                 * 收货人详细地址
                 */
                [YXUserDefaults setObject:addressListModel.consigneeAddressDetail forKey:@"consigneeAddressDetail"];
                
                [self loadAddressList];
            }
                
        } failure:^(NSError *error) {
            
        }];
    }
    self.currentButton = currentButton;
}

- (void)myAddressCell:(YXMyAddressCell *)myAddressCell withDeleteAddressId:(NSInteger)addressId
{
    //--alert
    [self showAlertWithCell:myAddressCell addressId:addressId];
    
}

- (void)myAddressCell:(YXMyAddressCell *)myAddressCell withEditAddressModel:(YXMyAddressList *)addressListModel
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"addNewAddress" bundle:nil];
    
    //--添加新地址控制器
    YXAddNewAddressViewController *toTableViewController = [sb instantiateInitialViewController];
    
    toTableViewController.addressListModel = addressListModel;
    toTableViewController.titleText = @"编辑地址";
    [self.navigationController pushViewController: toTableViewController animated:YES];
}


#pragma mark - 加载数据

- (void)loadAddressList
{
    [[YXMyAccountNetRequestTool sharedTool] loadMyAddressWithCurPage:1 andPageSize:10 success:^(id objc, id respodHeader) {
        YXLog(@"-----%@",objc);
        NSArray *dataArray = objc[@"data"];
        self.addressListArray = [YXMyAddressList mj_objectArrayWithKeyValuesArray:dataArray];
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"地址管理";
    
    if ([self.sourceController isKindOfClass:[YXReturnGoodsViewController class]] || [self.sourceController isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]||[self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]){
        [self setupNavigationController:self.navigationController];
    }
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXMyAddressCell class]) bundle:nil] forCellReuseIdentifier:kYXMyAddressCellReuseIdentifier];
    self.tableView.rowHeight = 160.0f;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    [self.view addSubview:self.tempView];
    [self.view addSubview:self.addNewAddressButton];
    

    [YXNotificationTool addObserver:self selector:@selector(formecomforOrderVCAddNewaddressNoti:) name:@"formecomforOrderVCAddNewaddressNoti" object:nil];
    
    
}
//**确认订单 新增完地址后直接返回**/
-(void)formecomforOrderVCAddNewaddressNoti:(NSNotification *)noti{
    
    YXMyAddressList* listmodle =  [YXMyAddressList mj_objectWithKeyValues:noti.userInfo];
    listmodle.IsHaveData = YES;
    if (self.modleblock) {
        self.modleblock(listmodle);
    }

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadAddressList];
}

//** 子控件布局完毕 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    self.addNewAddressButton.frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
}

//** 视图即将离开 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



/**
 配置navigationController
 
 @param navigationController navigationController
 */
- (void)setupNavigationController:(UINavigationController *)navigationController
{
    
    UIBarButtonItem *leftBarButtonItem          = [UIBarButtonItem itemWithTarget:self
                                                                           action:@selector(addressbackButtonClick:)
                                                                            image:@"icon_fanhui"
                                                                        highImage:@"icon_fanhui"];
    self.navigationItem.leftBarButtonItem       = leftBarButtonItem;
}


//** 弹出登录或未登录alert */
- (void)showAlertWithCell:(YXMyAddressCell *)myAddressCell addressId:(NSInteger)addressId
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认删除地址？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){
    }];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *actoin){
        
        [[YXMyAccountNetRequestTool sharedTool] deleteAddressWithAddressId:addressId success:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"删除成功"]) {
                //--获取当前cell的indexPath
                NSIndexPath *indexPath = [self.tableView indexPathForCell:myAddressCell];
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.addressListArray];
                [tempArray removeObjectAtIndex:indexPath.row];
                self.addressListArray = tempArray.copy;
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }];
    [alert addAction:defaultAction];
    [alert addAction:sureAction];//代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}


#pragma mark - Table view data source

//** 数据源_返回对应组 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

//** 数据源_返回对应行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.addressListArray.count != 0) {
        self.tempView.hidden = YES;
    }else{
        self.tempView.hidden = NO;
    }
    
    return self.addressListArray.count;
}

//** 数据源_返回cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXMyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXMyAddressCellReuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.addressListModel = self.addressListArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YXMyAddressList *modle = self.addressListArray[indexPath.row];

    if ([self.sourceController isKindOfClass:[YXReturnGoodsViewController class]]) {
        YXReturnGoodsViewController *returnGoodsViewController = (YXReturnGoodsViewController *)self.sourceController;
        returnGoodsViewController.addressList = modle;
        returnGoodsViewController.addressId = modle.addressId;
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    
    }
    
    if ([self.sourceController isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]) {
        
        NSString *addressId  = [NSString stringWithFormat:@"%lld",modle.addressId];
        [[NSNotificationCenter defaultCenter]  postNotificationName:@"CHOOSECURRENADDRESS" object:nil userInfo:@{@"consigneeName":modle.consigneeName,@"consigneeMobile":modle.consigneeMobile,@"consigneeProvince":modle.consigneeProvince,@"consigneeCity":modle.consigneeCity,@"consigneeAddressDetail":modle.consigneeAddressDetail,@"id":addressId}];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
        
        modle.IsHaveData = YES;
        if (self.modleblock) {
            self.modleblock(modle);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    
}


#pragma mark - 懒加载

- (UIButton *)addNewAddressButton
{
    if (!_addNewAddressButton) {
        _addNewAddressButton = [[UIButton alloc] init];
        [_addNewAddressButton setTitle:@"新增地址" forState:UIControlStateNormal];
        _addNewAddressButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addNewAddressButton setBackgroundColor:[UIColor mainThemColor]];
        [_addNewAddressButton addTarget:self action:@selector(addNewAddressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewAddressButton;
}

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.tipsText = @"还没有添加的地址";
    }
    return _tempView;
}

-(void)dealloc
{
    [YXNotificationTool removeObserver:self name:@"formecomforOrderVCAddNewaddressNoti" object:nil];
}
@end
