//
//  YXSearchTextFiledViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchTextFiledViewController.h"
#import "YXSearchNavTextFiledView.h"
#import "YXSearchTextFiledTableViewCell.h"

#import "YXSearchResultListViewController.h"


@interface YXSearchTextFiledViewController ()<UITableViewDelegate,UITableViewDataSource>

//导航栏的view
@property(strong,nonatomic) YXSearchNavTextFiledView  *searchNavTextfiledView;


@property(nonatomic,strong) UITableView * searchHistoryTableView;

@property(nonatomic,strong) UIView * searchtableHeaderview;

@property(nonatomic,strong) UIView * searchtableFooterview;

@property(strong,nonatomic) NSMutableArray*searchHistoryDataArr;


/*
 @brief 行数
 */
@property(nonatomic,assign) NSInteger  historyTableRows;


/*
 @brief 清楚历史记录的btn
 */
@property(nonatomic,strong) UIButton * qingchuhistoryBtn;

//**是否是从结果列表 pop回来的**/
@property(nonatomic,assign) BOOL  ISFromeResultBool;

@end

@implementation YXSearchTextFiledViewController

-(NSMutableArray*)searchHistoryDataArr
{
    if (!_searchHistoryDataArr) {
        _searchHistoryDataArr = [[NSMutableArray alloc]init];
    }
    return _searchHistoryDataArr;
}

-(YXSearchNavTextFiledView*)searchNavTextfiledView
{
    if (!_searchNavTextfiledView) {
        _searchNavTextfiledView = [[YXSearchNavTextFiledView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 59)];
        //        _searchHistoryTableView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return _searchNavTextfiledView;
}

-(UITableView*)searchHistoryTableView
{
    if (!_searchHistoryTableView) {
        
        _searchHistoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchNavTextfiledView.bottom, YXScreenW, YXScreenH-self.searchNavTextfiledView.height)];
        _searchHistoryTableView.dataSource = self;
        _searchHistoryTableView.delegate = self;
        _searchHistoryTableView.rowHeight = 40;
        _searchHistoryTableView.backgroundColor = [UIColor whiteColor];
        [_searchHistoryTableView setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        
        
    }
    
    return _searchHistoryTableView;
}

-(void)addsearchheadersubviews
{
    self.searchtableHeaderview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 50)];
    self.searchtableHeaderview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
  
    UIView *backview= [[UIView alloc]initWithFrame:CGRectMake(0, 10, YXScreenW, 30)];
    backview.backgroundColor = [UIColor whiteColor];
    backview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    backview.layer.borderWidth = 0.5;
    [self.searchtableHeaderview addSubview:backview];
    
    UIButton *headerbtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 80, 30)];
    [headerbtn setTitle:@"历史搜索" forState:UIControlStateNormal];
    [headerbtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    headerbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [headerbtn setImage:[UIImage imageNamed:@"ic_shepin"] forState:UIControlStateNormal];
    headerbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backview addSubview:headerbtn];
    
    _searchHistoryTableView.tableHeaderView = self.searchtableHeaderview;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    self.searchHistoryDataArr  = [NSMutableArray arrayWithArray:[YXUserDefaults objectForKey:@"SEARCHHISTORYDATA"]];
    
    if (self.searchHistoryDataArr.count) {
        self.searchtableFooterview.hidden = NO;
    }
    
    [self addNavView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    [YXUserDefaults setObject:self.searchHistoryDataArr forKey:@"SEARCHHISTORYDATA"];
    [YXUserDefaults synchronize];
}

-(void)addNavView
{
    __weak typeof(self)weakself = self;
    //**取消**/
    self.searchNavTextfiledView.clickcancleblock =^(NSString *str){
        
        if (weakself.ISFromeResultBool) {
            
            YXSearchResultListViewController *resultlist = [[YXSearchResultListViewController alloc]init];
            resultlist.textstr = str;
            [weakself.navigationController pushViewController:resultlist animated:NO];
            weakself.ISFromeResultBool = NO;
            return ;
        }
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
    };
    
    
    //**点击键盘上的搜索的回调**/
    self.searchNavTextfiledView.keysearchblock = ^(NSString *str){
        
        //**立森-需求改动**/
        if (str.length ==0) {
            
            [YXAlearMnager  ShowAlearViewWith:@"请输入搜索内容!" Type:2];
            return ;
        }
        
        YXSearchResultListViewController *resultlist = [[YXSearchResultListViewController alloc]init];
        resultlist.textstr = str;
        [weakself addAddHistoryToArr:str];
        [weakself.navigationController pushViewController:resultlist animated:NO];
        
    };
    [self.view addSubview:self.searchNavTextfiledView];
   
    [YXNotificationTool postNotificationName:@"becomeFirstResponderMethod" object:nil];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.searchHistoryTableView];
    [self addsearchheadersubviews];
    
    self.searchHistoryDataArr = [YXUserDefaults objectForKey:@"SEARCHHISTORYDATA"];
    
    [self addsearchtableviewfooterview];
    
    //**监听是不是 从结果列表pop回来的**/
    [YXNotificationTool addObserver:self selector:@selector(ISFromeResult:) name:@"ISFROMESEARCHRESULTVC" object:nil];
    
}
-(void)ISFromeResult:(NSNotification*)noti
{
    self.ISFromeResultBool = YES;
}

/*
 @brief 向数组中添加 搜索记录
 */
-(void)addAddHistoryToArr:(NSString *)textstr
{
    if(textstr.length==0)
    {
        return;
    }
    
    if ([self.searchHistoryDataArr containsObject:textstr]) {
        
        [(NSMutableArray *)self.searchHistoryDataArr removeObject:textstr];
        [(NSMutableArray *)self.searchHistoryDataArr insertObject:textstr atIndex:0];
        
    }else{
        
        [(NSMutableArray *)self.searchHistoryDataArr insertObject:textstr atIndex:0];
    }
    self.searchtableFooterview.hidden = NO;
    self.searchNavTextfiledView.searchTextFiled.text = textstr;
    
    [self.searchHistoryTableView reloadData];
    
    [YXUserDefaults setObject:self.searchHistoryDataArr forKey:@"SEARCHHISTORYDATA"];
    [YXUserDefaults synchronize];
}

/*
 @brief 添加清楚历史纪录的按钮
 */
-(void)addsearchtableviewfooterview
{
    self.searchtableFooterview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 40)];
    self.searchHistoryTableView.tableFooterView = self.searchtableFooterview;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [self.searchtableFooterview addSubview:line];
    
    self.qingchuhistoryBtn = [[UIButton alloc]initWithFrame:CGRectMake((YXScreenW-110)/2, 10, 110, 30)];
    [self.searchtableFooterview addSubview:self.qingchuhistoryBtn];
    [self.qingchuhistoryBtn setTitle:@"清除历史" forState:UIControlStateNormal];
    [self.qingchuhistoryBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [self.qingchuhistoryBtn addTarget:self action:@selector(clickqingchuBtn) forControlEvents:UIControlEventTouchUpInside];
    self.qingchuhistoryBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
    self.qingchuhistoryBtn.layer.borderWidth = 0.5;
    self.qingchuhistoryBtn.layer.cornerRadius = 3;
    self.qingchuhistoryBtn.layer.masksToBounds = YES;
    self.qingchuhistoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (self.searchHistoryDataArr.count==0) {
        
        self.searchtableFooterview.hidden = YES;
        
    }
}

/*
 @brief 清楚历史记录
 */
-(void)clickqingchuBtn
{
    
    NSMutableArray *arr = self.searchHistoryDataArr;
    [arr removeAllObjects];
    self.searchHistoryDataArr = arr;
    self.searchtableFooterview.hidden = YES;
    [self.searchHistoryTableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchHistoryDataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXSearchTextFiledTableViewCell *cell = [YXSearchTextFiledTableViewCell creatsearchtextfiledNotilistTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<=self.searchHistoryDataArr.count) {
        
        cell.texttitleLable.text = self.searchHistoryDataArr[indexPath.row];
    }
    
    __weak typeof(self) weakself = self;
    cell.removebalcok = ^(NSString *textstr){
        
        
        NSInteger  indexrows =  [self.searchHistoryDataArr indexOfObject:textstr];
        
        [(NSMutableArray*)self.searchHistoryDataArr removeObjectAtIndex:indexrows];
        
        
        [weakself.searchHistoryTableView reloadData];
        if (self.searchHistoryDataArr.count==0) {
            
            self.searchtableFooterview.hidden = YES;
        }
        return ;
    };
    if (self.searchHistoryDataArr.count==0) {
        
        self.searchtableFooterview.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexrow = indexPath.row;
    
    YXSearchResultListViewController *resultlist = [[YXSearchResultListViewController alloc]init];
    NSString *str = [self.searchHistoryDataArr objectAtIndex:indexrow];
    resultlist.textstr = str;
    [self.navigationController pushViewController:resultlist animated:NO];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.searchHistoryDataArr];
    
    [arr exchangeObjectAtIndex:indexrow withObjectAtIndex:0];
    
    self.searchHistoryDataArr = arr;
    
    self.searchNavTextfiledView.searchTextFiled.text = self.searchHistoryDataArr[0];
    
    [self.searchHistoryTableView reloadData];
    
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchNavTextfiledView.searchTextFiled resignFirstResponder];
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


@end
