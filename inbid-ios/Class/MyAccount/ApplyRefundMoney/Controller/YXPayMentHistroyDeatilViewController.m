//
//  YXPayMentHistroyDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayMentHistroyDeatilViewController.h"
#import "YXPayMentHistroyDeatilView.h"
@interface YXPayMentHistroyDeatilViewController ()
@property(nonatomic,strong) YXPayMentHistroyDeatilView * HistroyDeatilView;
@end

@implementation YXPayMentHistroyDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  =@"收支详情";
    
    __weak typeof(self)weakself = self;
    self.HistroyDeatilView.Heightblock = ^(CGFloat height){
        weakself.HistroyDeatilView.height = height;
        weakself.tableview.tableHeaderView = weakself.HistroyDeatilView;
        
    };
    self.tableview.tableHeaderView = self.HistroyDeatilView;
    
    if (self.detailModel) {
        self.HistroyDeatilView.payAndIncomeDetailModel= self.detailModel;
    }else{
        self.HistroyDeatilView.DeatilModle= self.DeatilModle;
    }
    
}



/**
 懒加载
 */
-(YXPayMentHistroyDeatilView *)HistroyDeatilView
{
    if (!_HistroyDeatilView) {
        
        _HistroyDeatilView =   [[YXPayMentHistroyDeatilView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 365)];
  
    }
    return  _HistroyDeatilView;
}

@end
