//
//  YXMyWalletSetPassWordViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletSetPassWordViewController.h"
#import "UILabel+Extension.h"
#import "YXPerfectAccountInformationViewController.h"

@interface YXMyWalletSetPassWordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) UITextField * newtextfield;
@property(nonatomic,strong) UITextField * comfirTextfiled;

@end

@implementation YXMyWalletSetPassWordViewController

-(void)clickpassNextBtn:(UIButton *)sender{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if (![self checkParam]) {
        return;
    }
    
    YXPerfectAccountInformationViewController *perfectVC = [[YXPerfectAccountInformationViewController alloc]init];
    perfectVC.passwordStr = [YXStringFilterTool getSha1String:self.newtextfield.text];
    [self.navigationController pushViewController:perfectVC animated:YES];

}

-(BOOL)checkParam{
    if(self.newtextfield.text.length ==0){
        [YXAlearMnager ShowAlearViewWith:@"密码不能为空！" Type:2];
        return NO;
    }
    if(![YXStringFilterTool CheckPaymentPassword:self.newtextfield.text]){
        [YXAlearMnager ShowAlearViewWith:@"密码格式不对！" Type:2];
        return NO;
    }
    
    if (![self.newtextfield.text isEqualToString:self.comfirTextfiled.text]) {
        
        [YXAlearMnager ShowAlearViewWith:@"两次密码不一致！" Type:2];
        return NO;
    }

    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置钱包支付密码";
    self.view.backgroundColor = YXBackMainColor;
    [self.view addSubview:self.tableview];
    UIView *headerview  =  [self setUI];
    self.tableview.tableHeaderView = headerview;
    

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(UIView *)setUI{
    
    UIView *bigview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, self.view.height)];
    bigview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    UILabel *titletoplable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, YXScreenW-30, 30)];
    titletoplable.textColor = UIColorFromRGB(0x999999);
    titletoplable.text = @"设置支付密码";
    titletoplable.font = YXSFont(13);
    [bigview addSubview:titletoplable];
    
    UIView *contenview = [[UIView alloc]initWithFrame:CGRectMake(0, titletoplable.bottom+5, YXScreenW, 100)];
    contenview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    contenview.layer.borderWidth = .5;
    contenview.backgroundColor = [UIColor whiteColor];
    [bigview addSubview:contenview];
    
    UILabel *leftlable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 50)];
    leftlable.text = @"支付密码";
    leftlable.font = YXSFont(16);
    leftlable.textColor = UIColorFromRGB(0x333333);
    [contenview addSubview:leftlable];
    
    UILabel *leftlable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, leftlable.bottom, 100, 50)];
    leftlable2.text = @"确认支付密码";
    leftlable2.font = YXSFont(16);
    leftlable2.textColor = UIColorFromRGB(0x333333);
    [contenview addSubview:leftlable2];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, YXScreenW, 0.5)];
    line.backgroundColor= UIColorFromRGB(0xe5e5e5);
    [contenview addSubview:line];
    
    UITextField *righttextfield = [[UITextField alloc]initWithFrame:CGRectMake(leftlable.right, 0, YXScreenW-leftlable.width-20, 50)];
    righttextfield.placeholder = @"请输入8-20位支付密码";
    righttextfield.font = YXSFont(16);
    righttextfield.textAlignment = NSTextAlignmentRight;
    [contenview addSubview:righttextfield];
    righttextfield.secureTextEntry = YES;
    self.newtextfield = righttextfield;
    
    UITextField *righttextfield2 = [[UITextField alloc]initWithFrame:CGRectMake(leftlable.right, righttextfield.bottom, YXScreenW-leftlable.width-20, 50)];
    righttextfield2.placeholder = @"请确认您的密码";
    righttextfield2.font = YXSFont(16);
    righttextfield2.textAlignment = NSTextAlignmentRight;
    righttextfield2.secureTextEntry = YES;
    [contenview addSubview:righttextfield2];
    self.comfirTextfiled = righttextfield2;

    UILabel *desclable = [[UILabel alloc]initWithFrame:CGRectMake(10, contenview.bottom+10, YXScreenW-20, 40)];
    desclable.text = @"支持8～20个字符，至少包括字母，数字和符号中的两种及以上的组合，要牢记密码哦";
    desclable.numberOfLines = 2;
    desclable.font = YXSFont(12);
    desclable.textColor = UIColorFromRGB(0x999999);
    [bigview addSubview:desclable];
    [desclable setRowSpace:10];
    
    UIButton *NextBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, desclable.bottom +20, YXScreenW-30, 50)];
    [NextBtn addTarget:self action:@selector(clickpassNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [NextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [NextBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NextBtn.titleLabel.font  = YXSFont(15);
    NextBtn.backgroundColor = [UIColor mainThemColor];
    NextBtn.layer.masksToBounds = YES;
    NextBtn.layer.cornerRadius = 4;
    [bigview addSubview:NextBtn];
    
    return bigview;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return cell;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 0;
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return _tableview;
}
@end
