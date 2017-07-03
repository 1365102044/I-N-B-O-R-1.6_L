//
//  YXPayMentOrderDeatilViewController.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentOrderDeatilViewController.h"
#import "YXPayMentOrderBaseView.h"
#warning +++++test
#import "YXLineInformationCommitSuccessViewController.h"
#import "YXPayMentResultViewController.h"
#import "YXPCUniconPayZabrViewController.h"

@interface YXPayMentOrderDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) YXPayMentOrderBaseView * deatilbaseview;
@property(nonatomic,strong) UIView * boomview;
@end
@implementation YXPayMentOrderDeatilViewController
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH-55)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.rowHeight = 0;
    }
    return _tableview;
}
-(YXPayMentOrderBaseView *)deatilbaseview
{
    if (!_deatilbaseview) {
        _deatilbaseview = [[YXPayMentOrderBaseView alloc]initWithFrame:self.view.bounds];
        _deatilbaseview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return _deatilbaseview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
   
}
-(void)setUI
{
    
    [self.view addSubview:self.tableview];
    
    __weak typeof(self)weakself = self;
    self.deatilbaseview.heightblock =^(CGFloat height){
        weakself.deatilbaseview.height = height;
        weakself.tableview.tableHeaderView = weakself.deatilbaseview;
    };
    self.tableview.tableHeaderView = self.deatilbaseview;
    
    [self addboomview];
    
}
-(void)addboomview
{
    UIView *boomview = [[UIView alloc]init];
    boomview.frame = CGRectMake(0, YXScreenH-55, YXScreenW, 55);
    boomview.backgroundColor = [UIColor whiteColor];
    boomview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    boomview.layer.borderWidth = 0.5;
    [self.view addSubview:boomview];
    
    NSArray *arr =@[@"继续支付",@"联系客服",@"编辑凭证"];
    CGFloat btnW = 80;
    CGFloat btnH = 30;
    for (int i=1; i<arr.count+1; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(YXScreenW-10*i-i*btnW, 12.5, btnW, btnH);
        btn.tag = i;
        [btn setTitle:arr[i-1] forState:UIControlStateNormal];
        btn.titleLabel.font = YXSFont(11);
        [btn addTarget:self action:@selector(clickboomBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2;
        btn.layer.borderWidth = 1;
        [boomview addSubview:btn];
        
        if(i==1)
        {
         
            btn.layer.borderColor = UIColorFromRGB(0xf3ac53).CGColor;
            [btn setTitleColor:UIColorFromRGB(0xf3ac53) forState:UIControlStateNormal];
        }else
        {
            btn.layer.borderColor = UIColorFromRGB(0x050505).CGColor;
            [btn setTitleColor:UIColorFromRGB(0x050505) forState:UIControlStateNormal];
        }
    }
}

-(void)clickboomBtn:(UIButton *)sender
{
    if (sender.tag ==1) {
        YXLog(@"-------点击了继续支付---");
        YXLineInformationCommitSuccessViewController *vc =[[YXLineInformationCommitSuccessViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag ==2)
    {
        YXLog(@"-------点击了联系客服---");
        YXPayMentResultViewController *vc = [[YXPayMentResultViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag ==3)
    {
        YXLog(@"-------点击了编辑凭证---");
        YXPCUniconPayZabrViewController *vc =[[YXPCUniconPayZabrViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark  ******************* tableview代理**********************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}


@end
