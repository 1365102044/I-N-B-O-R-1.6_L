//
//  YXSendAuctionController.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionController.h"
#import "YXSendAuctionContentCollectionViewController.h"
#import "YXHelpViewController.h"
#import "YXSendAuctionFirstHeaderView.h"
#import "YXSendAuctionSecondOtherHeaderView.h"
#import "YXSendAuctionProgressModel.h"
#import "YXSendAuctionSecondFooterView.h"
#import "YXSendAuctionNetworkTool.h"
#import "YXSendAuctionDoneController.h"
#import "YXAlearFormMyView.h"
#import "YXSendAuctionImageManager.h"
#import "YXNavigationController.h"
#import "YXLoginViewController.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXAlertViewTool.h"

@interface YXSendAuctionController ()<YXSendAuctionDoneControllerDelegate>

/**
 寄拍内容视图
 */
@property (nonatomic, strong) YXSendAuctionContentCollectionViewController *contentCollectionViewController;

/*
 @brief 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

/**
 是否可以点击发布按钮 NO.第一次请求 YES.请求未返回-重复请求 NO.请求返回，可以再次请求
 */
@property (nonatomic, assign) BOOL canClickComposeButton;

@end

@implementation YXSendAuctionController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 帮助按钮点击
 
 @param sender 帮助按钮
 */
- (void)helpButtonClick:(UIButton *)sender
{
    YXHelpViewController *helpvc = [[YXHelpViewController alloc]init];
    helpvc.helpIndex = 13;
    [self.navigationController pushViewController:helpvc animated:YES];
}

/**
 发布按钮点击事件

 @param sender 发布按钮
 */
- (void)composeButtonClick:(UIButton *)sender
{
    //** 判断登录逻辑 */
//    if ([[YXUserDefaults objectForKey:@"TokenID"] isKindOfClass:[NSNull class]]
    //        || ![YXUserDefaults objectForKey:@"TokenID"]) {
    if ([[[YXLoginStatusTool sharedLoginStatus] getTokenId] isKindOfClass:[NSNull class]]
        || ![[YXLoginStatusTool sharedLoginStatus] getTokenId]) {
        YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
        YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    
    //** 描述文字 */
    if (self.contentCollectionViewController.firstHeaderView.detailTextView.text.length == 0 || [self.contentCollectionViewController.firstHeaderView.detailTextView.text isEqualToString:@""]) {
        //** 弹窗，未输入描述文字 */
        [self showAlertWithText:@"未输入描述文字"];
        return;
    }
    
    //** 图片url */
    if (self.contentCollectionViewController.selectedImageModelArray.count == 0 || !self.contentCollectionViewController.selectedImageModelArray) {
        //** 弹窗，未选择图片 */
        [self showAlertWithText:@"未选择图片"];
        return;
    }
    
    //** 品牌 */
    if ([self.contentCollectionViewController.secondHeaderView.showBranceLabel.text isEqualToString:@"点击选择品牌"]) {
        //** 弹窗，未选择品牌 */
        [self showAlertWithText:@"未选择品牌"];
        return;
    }
    
    __block BOOL isFinished = NO;
    [self.contentCollectionViewController.selectedImageModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YXSendAuctionProgressModel *model = (YXSendAuctionProgressModel *)obj;
        if (!model.successImageUrlString) {
            *stop = YES;
            if (*stop) {
                //** 弹窗，图片上传未完成 */
                [self showAlertWithText:@"图片未上传完毕"];
                isFinished = YES;
            }
        }
    }];
    
    if (isFinished) return;
    
    //** 协议 */
    if (!self.contentCollectionViewController.secondFooterView.isReadAndAgreeButton.selected) {
        //** 弹窗，未同意售卖协议 */
        [self showAlertWithText:@"未同意协议"];
        return;
    }
    
    //** 获取描述前15字作为名称 */
    NSString *goodDetailText = self.contentCollectionViewController.firstHeaderView.detailTextView.text;
    NSString *goodNameText = [goodDetailText substringToIndex:15 > goodDetailText.length ? goodDetailText.length : 15];
    
    //** 图片数组 */
    NSMutableArray *tempArray = [NSMutableArray array];
    for (YXSendAuctionProgressModel *model in self.contentCollectionViewController.selectedImageModelArray) {
        [tempArray addObject:model.successImageUrlString];
    }
    
    //** 防止重复请求 */
    if (self.canClickComposeButton) return;
    self.canClickComposeButton = YES;
    
    //** 发送请求 */
    [[YXSendAuctionNetworkTool sharedTool] addIdenifyOrderWithProdName:goodNameText orderContent:goodDetailText prodImages:tempArray.copy brand:self.contentCollectionViewController.secondHeaderView.showBranceLabel.text accessoryIds:self.contentCollectionViewController.selectedGoodPartArray success:^(id objc, id respodHeader) {
        
        //** 重置按钮点击条件 */
        self.canClickComposeButton = NO;
        
        /**
         *  判断用户无权限
         */
        @try {
            if ([respodHeader[@"Status"] isEqualToString:@"1"]
                && [objc[@"code"] isEqualToString:@"10001"]) {
                
                /**
                 *  提示用户暂无权限
                 */
                [YXAlertViewTool showAlertView:self
                                         title:@"提示"
                                       message:objc[@"msg"] confrimBlock:^{
                                           [self toHomePage];
                }];
                
                return;
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
        
        @try {
            if ([respodHeader[@"Status"] isEqualToString:@"3"]) return;
            
            //** 判断是否生成订单失败 */
            if ([objc isKindOfClass:[NSString class]]) {
                if ([objc isEqualToString:@"鉴定订单生成失败！"]) {
                    self.alearMyview.alearstr = @"请勿输入特殊字符";
                    return;
                }
            }
            
            if ([objc[@"successMsg"] isEqualToString:@"提交成功！"]
                && [respodHeader[@"Status"] isEqualToString:@"1"] ) {
                
                [YXSendAuctionImageManager defaultManager].orderId = objc[@"orderId"];
                
                //** 跳转关闭界面 */
                YXSendAuctionDoneController *doneController = [[YXSendAuctionDoneController alloc] init];
                doneController.delegate = self;
                //[self resetComposView];
                [self.navigationController pushViewController:doneController animated:YES];
                
            }else{
                //--提交未成功处理
            }
            
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
            //** 失败后处理 */
        }
        
    } failure:^(NSError *error) {
        //** 重置按钮点击条件 */
        self.canClickComposeButton = NO;
    }];
    
}

- (void)toHomePage
{
    UITabBarController *tabBarController = (UITabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarController.selectedIndex = 0;
}

/**
 展示提示框

 @param text 提示文字
 */
- (void)showAlertWithText:(NSString *)text
{
    //--弹窗
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = text;
    self.RemindGoodsView.frame = self.view.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wealself dimssview];
    });
}

/**
 取消弹窗
 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}

#pragma mark - Fourth.代理方法

#pragma mark <YXSendAuctionDoneControllerDelegate>

/**
 清空数据

 @param sendAuctionDoneController sendAuctionDoneController
 @param clearData                 clearData
 */
- (void)sendAuctionDoneController:(YXSendAuctionDoneController *)sendAuctionDoneController clearData:(BOOL)clearData
{
    if (clearData) {
        self.contentCollectionViewController.clearData = YES;
    }
}

#pragma mark - Fifth.控制器生命周期

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendAuctionAddSubViewsAndChildViewController];
    
    //** 界面样式配置 */
    self.navigationItem.title = @"发布商品";
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"ic_baozhengjinwenhao"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(helpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

/**
 视图即将离开界面

 @param animated animated
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.canClickComposeButton = NO;
}

#pragma mark - Sixth.界面配置

/**
 添加子控件
 */
- (void)sendAuctionAddSubViewsAndChildViewController
{
    [self.view addSubview:self.contentCollectionViewController.collectionView];
    [self addChildViewController:self.contentCollectionViewController];
}

- (void)sendAuctionLayoutSubViews
{
    [self.contentCollectionViewController.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Seventh.懒加载

- (YXSendAuctionContentCollectionViewController *)contentCollectionViewController
{
    if (!_contentCollectionViewController) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        _contentCollectionViewController = [[YXSendAuctionContentCollectionViewController alloc] initWithCollectionViewLayout:fl];
    }
    return _contentCollectionViewController;
}

- (YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        _alearMyview.frame = CGRectMake(YXScreenW*0.2, 60+64+50, YXScreenW*0.6, 30);
        _alearMyview.alpha = 0;
        _alearMyview.time = 10.0f;
    }
    return _alearMyview;
}


- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

@end
