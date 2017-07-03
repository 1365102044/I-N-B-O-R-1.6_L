//
//  YXChoosePeiSongTypeViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2016/12/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChoosePeiSongTypeViewController.h"
#import "YXChoosePeiSongTypeBaseView.h"
@interface YXChoosePeiSongTypeViewController ()<UITableViewDelegate,UITableViewDataSource,baseviewheightDelegate>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) YXChoosePeiSongTypeBaseView * peisongbaseview;
@property(nonatomic,strong) NSString * wuliu;
@property(nonatomic,strong) NSString * paytype;

@property(nonatomic,assign) BOOL  wuliubool;
@property(nonatomic,assign) BOOL  paybool;
@end

@implementation YXChoosePeiSongTypeViewController




#pragma mark - First.通知
-(void)wuliunoti:(NSNotification*)noti
{
    self.wuliu = noti.userInfo[@"wuliu"];
    _wuliubool = YES;
}
-(void)paytypenoti:(NSNotification *)noti
{
    self.paytype = noti.userInfo[@"pay"];
    _paybool = YES;
}
#pragma mark - Second.赋值
-(void)setWuliupeisong:(NSString *)wuliupeisong
{
    _wuliupeisong = wuliupeisong;
    
    self.peisongbaseview.peisongtype = wuliupeisong;
}
#pragma mark - Third.点击事件
-(void)clickcommitbtn
{
    YXLog(@"-------点击了确定---");
    
    if (!self.wuliubool) {
        self.wuliu = [self.wuliupeisong componentsSeparatedByString:@"\n"][1];
    }
    if (!self.paybool) {
        self.paytype = [self.wuliupeisong componentsSeparatedByString:@"\n"][0];
    }
    if (self.peisongblock) {
        
        self.peisongblock(self.paytype,self.wuliu);
    }

    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - Fourth.代理方法

#pragma mark <UITableViewDataSource>


/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择付款配送方式";
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.tableview];
    
    self.peisongbaseview = [[YXChoosePeiSongTypeBaseView alloc]initWithFrame:self.view.bounds];
    self.peisongbaseview.baseheightdelegate = self;
    self.tableview.tableHeaderView = self.peisongbaseview;
//    self.peisongbaseview.orderAllPrice = self.orderAllPrice;
    [self.peisongbaseview setSubviewUIWithAllprice:self.orderAllPrice iscanDingjin:self.iscanDingjin];
    self.peisongbaseview.peisongtype  = self.wuliupeisong;
    [self setboomview];
    
    
    //** 拿到当前选中的 btn类型 */
    [YXNotificationTool addObserver:self selector:@selector(paytypenoti:) name:@"onepricepaystr" object:nil];
    [YXNotificationTool addObserver:self selector:@selector(wuliunoti:) name:@"onepricewuliustr" object:nil];
    
    
    
}
/*
 @brief baseview返回的高度代理
 */
-(void)baseviewheight:(CGFloat)baseviewheight
{
    self.peisongbaseview.height = baseviewheight;
    self.tableview.tableHeaderView = self.peisongbaseview;

}

#pragma mark - Sixth.界面配置
-(void)setboomview
{
    UIButton *boombtn = [[UIButton alloc]initWithFrame:CGRectMake(0, YXScreenH-50, YXScreenW, 50)];
    [boombtn setTitle:@"确定" forState:UIControlStateNormal];
    [boombtn addTarget:self action:@selector(clickcommitbtn) forControlEvents:UIControlEventTouchUpInside];
    [boombtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    boombtn.titleLabel.font = YXSFont(15);
    boombtn.backgroundColor = [UIColor mainThemColor];
    [self.view addSubview:boombtn];
    
}
#pragma mark - Seventh.懒加载
-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, YXScreenW, YXScreenH-10)];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
//-(YXChoosePeiSongTypeBaseView*)peisongbaseview
//{
//    if (!_peisongbaseview) {
//        YXChoosePeiSongTypeBaseView *tempView = [[YXChoosePeiSongTypeBaseView alloc]initWithFrame:self.view.bounds];
//        tempView.baseheightdelegate = self;
//        _peisongbaseview = tempView;
//    }
//    return _peisongbaseview;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [YXNotificationTool removeObserver:self];
}
@end
