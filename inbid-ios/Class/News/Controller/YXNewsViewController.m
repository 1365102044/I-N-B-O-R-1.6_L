//
//  YXNewsViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//
#import "YXNewsViewController.h"
#import "YXNewsSystemViewController.h"
#import "YXNewsDingdanNotiListViewController.h"
#import "YXNewsEnsureMoneyNotiListViewController.h"
#import "YXLoginViewController.h"
#import "MQChatViewManager.h"
#import  <MeiQiaSDK/MQManager.h>
#import "YXNavigationController.h"
#import "YXChatViewManger.h"
#import "YXLoginStatusTool.h"
#define CELLINDEFID @"newscell"

@interface YXNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;
/*
 @brief 消息未读数
 */
@property(nonatomic,strong) NSDictionary * NoReadNewsCountDict;

@property(nonatomic,strong) MQChatViewManager * chatViewManager;

@property(nonatomic,assign) NSInteger  KeFuNewsNotiCount;

/*
 @brief 1未登录
 */
@property(nonatomic,assign) NSInteger  loginStatus;


@end

@implementation YXNewsViewController
//- (void)setPushViewController:(NSInteger)pushViewController
//{
//    _pushViewController = pushViewController;
//    
//    /**
//     *  跳转我的鉴定列表
//     */
//    if (_pushViewController == 1) {
////            NSInteger row = [noti.userInfo[@"row"] integerValue];
////            NSInteger seaction = [noti.userInfo[@"seaction"] integerValue];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:0];
//            [self tableView:self.tableview didSelectRowAtIndexPath:indexPath];
//        
//    }
//}
-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 15)];
        headerview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.tableHeaderView = headerview;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.scrollEnabled = NO;
        
        
    }
    return _tableview;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestNewsNoti];
    
    [MQManager getUnreadMessagesWithCompletion:^(NSArray *messages, NSError *error) {
        
//        YXLog(@"---message-%@---error--%@",messages,error);
        self.KeFuNewsNotiCount = messages.count;
        [self.tableview reloadData];
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
     self.loginStatus = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.tableview];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {
        return 0;
    }
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLINDEFID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLINDEFID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    CGRect rect = CGRectMake(0, 0, YXScreenW, 65);
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row==0) {
        if (self.KeFuNewsNotiCount>=99) {
            self.KeFuNewsNotiCount=99;
        }
        [cell.contentView addSubview:[self setCellView:@"胤宝客服" desc:@"查看您与客服的沟通记录" leftimage:@"icon_newskefu" frame:rect notiNmuber:self.KeFuNewsNotiCount]];
        
    }else if (indexPath.row==1){
//        NSInteger margincount = [self.NoReadNewsCountDict[@"marginMsg"] integerValue];
//        if (margincount>=99) {
//            margincount=99;
//        }
//        [cell.contentView addSubview:[self setCellView:@"保证金" desc:@"查看您保证金信息" leftimage:@"icon_newsbaozhengjin" frame:rect notiNmuber:margincount]];
        
    }else if (indexPath.row==2)
    {
        NSInteger ordercount = [self.NoReadNewsCountDict[@"orderMsg"] integerValue];
        if (ordercount>=99) {
            ordercount=99;
        }
        [cell.contentView addSubview:[self setCellView:@"我的订单" desc:@"查看您的订单信息" leftimage:@"icon_newsdingdan" frame:rect notiNmuber:ordercount]];
        
    }else if (indexPath.row==3)
    {
        NSInteger ordercount = [self.NoReadNewsCountDict[@"identifyMsg"] integerValue];
        if (ordercount>=99) {
            ordercount=99;
        }
        [cell.contentView addSubview:[self setCellView:@"鉴定订单" desc:@"查看您的鉴定订单信息" leftimage:@"newsjiandingorder" frame:rect notiNmuber:ordercount]];
        
        
    }else if (indexPath.row ==4)
    {
        NSInteger systemcount = [self.NoReadNewsCountDict[@"sysMsg"] integerValue];
        if (systemcount>=99) {
            systemcount=99;
        }
        [cell.contentView addSubview:[self setCellView:@"系统通知" desc:@"查看您系统信息" leftimage:@"icon_newstongzhi" frame:rect notiNmuber:systemcount]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0){
        
        [self pushKeFuVC];
        
    }
    
    if (self.loginStatus==1) {
        
        if (indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4) {
            
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            YXLoginViewController *longin = [[YXLoginViewController alloc]init];
            YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        
    }
    
    
    if (indexPath.row == 1) {
        YXNewsEnsureMoneyNotiListViewController *ensuremoneyVC = [[YXNewsEnsureMoneyNotiListViewController alloc]init];
        [self.navigationController pushViewController:ensuremoneyVC animated:YES];
    }
    if (indexPath.row == 2) {
        YXNewsDingdanNotiListViewController *dingdanListVC = [[YXNewsDingdanNotiListViewController alloc]init];
        dingdanListVC.fromeVC = 1;
        [self.navigationController pushViewController:dingdanListVC animated:YES];
    }
    if (indexPath.row == 3) {
        YXNewsDingdanNotiListViewController *dingdanListVC = [[YXNewsDingdanNotiListViewController alloc]init];
        dingdanListVC.fromeVC = 2;
        [self.navigationController pushViewController:dingdanListVC animated:YES];
    }
    if (indexPath.row == 4) {
        YXNewsSystemViewController *systemVC = [[YXNewsSystemViewController alloc]init];
        [self.navigationController pushViewController:systemVC animated:YES];
    }
    
}

-(UIView*)setCellView:(NSString *)title desc:(NSString *)desctext  leftimage:(NSString *)image frame:(CGRect)frame notiNmuber:(NSInteger)NotiNumber
{
    UIView *cellview = [[UIView alloc]init];
    cellview.frame = frame;
    
    
    UIImageView *leftiamgeview = [[UIImageView alloc]init];
    leftiamgeview.image = [UIImage imageNamed:image];
    
    leftiamgeview.size = CGSizeMake(30, 30);
    leftiamgeview.x = 15;
    leftiamgeview.centerY = cellview.centerY;
    [cellview addSubview:leftiamgeview];
    
    if (NotiNumber) {
        
        UILabel *NumberLable = [[UILabel alloc]initWithFrame:CGRectMake(leftiamgeview.width-8, -7, 14, 14)];
        NumberLable.text = [NSString stringWithFormat:@"%ld",(long)NotiNumber];
        NumberLable.backgroundColor = UIColorFromRGB(0xb50307);
        NumberLable.textColor = [UIColor whiteColor];
        NumberLable.layer.cornerRadius = 7;
        NumberLable.layer.masksToBounds = YES;
        NumberLable.font = [UIFont systemFontOfSize:10];
        NumberLable.textAlignment = NSTextAlignmentCenter;
        [leftiamgeview addSubview:NumberLable];
    }
    
    
    UILabel *titlelable = [[UILabel alloc]init];
    titlelable.text = title;
    titlelable.textColor = UIColorFromRGB(0x050505);
    titlelable.font = YXRegularfont(15);
    titlelable.frame = CGRectMake(leftiamgeview.right+10, 14, YXScreenW-60, 20);
    [cellview addSubview:titlelable];
    
    UILabel *desclable = [[UILabel alloc]init];
    desclable.text = desctext;
    desclable.textColor = UIColorFromRGB(0x050505);
    desclable.alpha = 0.6;
    desclable.font = YXRegularfont(11);
    desclable.frame = CGRectMake(titlelable.x, titlelable.bottom, titlelable.width, 20);
    [cellview addSubview:desclable];
    
    UIImageView *jiantouimage = [[UIImageView alloc]init];
    jiantouimage.image = [UIImage imageNamed:@"icon_newsjiantou"];
    jiantouimage.size = CGSizeMake(10, 16);
    jiantouimage.x = YXScreenW-20;
    jiantouimage.centerY = cellview.centerY;
    [cellview addSubview:jiantouimage];
    
    
    return cellview;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //按照作者最后的意思还要加上下面这一段
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

/*
 @brief 跳转客服控制器
 */
-(void)pushKeFuVC
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];
}

/*
 @brief 请求消息未读数
 */
-(void)requestNewsNoti
{
    
    if (![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]) {
        
        self.loginStatus = 1;
        return;
    }
    
    [YXRequestTool requestDataWithType:POST url:@"/api/message/unreadCnt" params:nil success:^(id objc, id respodHeader) {
        
        if([respodHeader[@"Status"] isEqualToString:@"1"])
        {
            
            NSDictionary *dict = objc;
            
            if(dict.count){

                self.NoReadNewsCountDict = objc;
                
            }else{
                self.NoReadNewsCountDict = @{@"marginMsg":@"0",
                                             @"orderMsg":@"0",
                                             @"sysMsg":@"0",
                                             @"identifyMsg":@"0"};
            }
            self.loginStatus = 0;
            
            [self.tableview reloadData];
            
        }else if ([respodHeader[@"Status"] isEqualToString:@"6"])
        {
            self.loginStatus = 1;
        
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}
@end
