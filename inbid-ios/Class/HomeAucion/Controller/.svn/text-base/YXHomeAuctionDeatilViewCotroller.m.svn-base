//
//  YXHomeAuctionDeatilViewCotroller.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilViewCotroller.h"
#import "YXPictureCarouselView.h"
#import "YXHomeAuctionDeatilHeaderView.h"
#import "YXHomeAuctionDeatilSeactionView.h"
#import "YXHomeAuctionDeatilCellIndexPathThree.h"
#import "YXHomeAuctionDeatilCellIndexPathFour.h"
#import "YXHomeAuctionDeatilTableViewCell.h"
#import "YXHomeDeatilModle.h"
#import "YXHomeDeatilBidRecordVosListModle.h"
#import "YXMyAuctionPostBondsView.h"
#import "YXLoginViewController.h"
#import "YXGotoJionAuctionAddPriceView.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXHomePageURLMacros.h"
#import "YXAddpriceSuccessOrFailView.h"
#import "NSDate+YXExtension.h"
#import "NSDate+Utils.h"
#import "MQChatViewManager.h"
#import "YXTimeCountDownManger.h"
#import "YXNavigationController.h"
#import "YXMyAccountRealNameViewController.h"
#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAucctionRealnameAndBindbankCardViewController.h"
#import "YXHelpViewController.h"
#import "PBViewController.h"
#import "BaiduMobStat.h"
#import "YXPaymentHomePageController.h"
#import "YXChatViewManger.h"
#define widthScreen [UIScreen mainScreen].bounds.size.width
#define heightScreen [UIScreen mainScreen].bounds.size.height

@interface YXHomeAuctionDeatilViewCotroller ()<UITableViewDelegate,UITableViewDataSource,YXMyAuctionPostBondsViewDelegate,YXGotoJionAuctionAddPriceViewDelegate,YXAddpriceSuccessOrFailViewdelegate, PBViewControllerDataSource, PBViewControllerDelegate>

//@property (nonatomic, strong)YXPictureCarouselView *adPictureCarouseView;

@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) YXHomeAuctionDeatilHeaderView * tableviewHeaderview;

@property(nonatomic,assign) CGFloat fourheight;

//**  modle  **/
@property(nonatomic,strong) YXHomeDeatilModle * deatilDataModle;
@property(nonatomic,strong) YXHomeDeatilModle * loopdeatildataModle;
@property(assign,nonatomic) BOOL  rowNumbool;
@property(assign,nonatomic) NSInteger rowNum;

@property(strong,nonatomic) NSMutableArray * addpricelistdata;

@property(nonatomic,strong) UIButton * footbtn;
@property(nonatomic,strong) UIButton * boomBtn;
/*
 @brief 我要报名情况中
 */
@property(nonatomic,strong) UIButton * baomingbtn;
@property(nonatomic,strong) UIButton * marginpricebtn;
@property(nonatomic,strong) UILabel * tipslable;
/*
 @brief 1 未开拍
 */
@property(nonatomic,assign) NSInteger  kaipaistatus;
/*
 @brief 下架商品状态  1 下架
 */
@property(nonatomic,assign) NSInteger  xiajiaStatus;



//** 温馨提示， 参与竞拍界面 */
@property (nonatomic, strong)YXMyAuctionPostBondsView *postBondsView;


//**  加价  **/
@property(nonatomic,strong) YXGotoJionAuctionAddPriceView * gotoAddPriceView;

/*
 @brief 保证金 和 已付金额
 */
@property(nonatomic,assign) NSInteger EnsureMoney;
@property(nonatomic,assign) NSInteger  alreadyPayAmount;
@property(nonatomic,assign) NSInteger  isPartPay;



/*
 @brief 未开拍 关注 弹出的视图
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

/*
 @brief 加价的队列号
 */
@property(nonatomic,strong) NSString * msgId;
/*
 @brief 加价请求后的状态提示框
 */
@property(nonatomic,strong) YXAddpriceSuccessOrFailView * addpricesuccessorfailview;

/*
 @brief 加价的金额
 */
@property(nonatomic,strong) NSString * addpricestr;

/*
 @brief 点击更多的次数，确定显示多少10的倍数
 */
@property(nonatomic,assign) NSInteger clickFooterBtnNmuber;

/*
 @brief 交保证金的状态 1 已交保证金  2未交保证金  3 未登陆
 */
@property(nonatomic,assign) NSInteger  ensuremoneystatus;

/*
 @brief loop 详情接口  1请求  2 停止
 */
@property(nonatomic,assign) NSInteger  requestbool;
/*
 @brief 加价接口
 */
@property(nonatomic,assign) BOOL  addpricebool;

/*
 @brief 加价的数据
 */
@property(nonatomic,strong) NSDictionary * addpricedict;


/*
 @brief 竞拍结束后，再刷新30s
 */
@property(nonatomic,assign) NSInteger  TimeNumber;
@property(nonatomic,strong) NSTimer * timer;


@property(nonatomic,strong) UIButton * SeactionNumberBtn;
@property(nonatomic,strong) NSAttributedString * btnstr1;

/*
 @brief 是否 现在是 展开 状态  1 展开状态
 */
@property(nonatomic,assign) BOOL  isShow;


/**
 轮播器图片url数组
 */
@property (nonatomic, strong) NSArray *imageUrlStringArray;

@end

@implementation YXHomeAuctionDeatilViewCotroller

-(YXMyOrderSuccessAlerview*)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

- (YXMyAuctionPostBondsView *)postBondsView
{
    if (!_postBondsView) {
        _postBondsView = [[YXMyAuctionPostBondsView alloc] init];
        _postBondsView.delegate = self;
    }
    return _postBondsView;
}
/*
 @brief 加价视图
 */
-(YXGotoJionAuctionAddPriceView*)gotoAddPriceView
{
    if (!_gotoAddPriceView) {
        _gotoAddPriceView = [[YXGotoJionAuctionAddPriceView alloc]init];
        _gotoAddPriceView.delegate = self;
    }
    return  _gotoAddPriceView;
}
-(YXAddpriceSuccessOrFailView*)addpricesuccessorfailview
{
    if (!_addpricesuccessorfailview) {
        _addpricesuccessorfailview = [[YXAddpriceSuccessOrFailView alloc]init];
        _addpricesuccessorfailview.delegate = self;
    }
    return _addpricesuccessorfailview;
}


/**
 接收到轮播器图片点击事件通知

 @param no no 通知参数
 */
- (void)pictureCarousrClick:(NSNotification *)no
{
    NSIndexPath *indexPath = no.userInfo[@"indexPath"];
    self.imageUrlStringArray = no.userInfo[@"imageUrlStringArray"];
    
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = indexPath.row;
    [self presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.deatilDataModle.prodImgs.count;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {

//    NSString *imageUrl = self.imageUrlStringArray[index];
//    imageUrl = [NSString stringWithFormat:@"%@",[imageUrl componentsSeparatedByString:@"?"].firstObject];

//    [imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl]
//                 placeholderImage:nil
//                          options:0
//                         progress:progressHandler
//                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                        }];
}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
//        NSArray *familyNames = [UIFont familyNames];
//        for(NSString *familyName in familyNames)
//        {
//            YXLog(@"=====系统字体====%@", familyName);
//            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//            for(NSString *fontName in fontNames)
//            {
//                YXLog(@" ----系统字体子 元素--\t%@", fontName);
//            }
//        }

    
    /*
     @brief 倒计时为0的时候 及时隐藏boomBtn
     */
    [YXNotificationTool addObserver:self selector:@selector(ChangedaojishiBoomBtn) name:@"JISHUDAOJISHI" object:nil];
    [YXNotificationTool addObserver:self selector:@selector(pictureCarousrClick:) name:@"goodDetailViewControllerPictureCarouselClick" object:nil];
    
    _clickFooterBtnNmuber = 0;
    _rowNum = 1;
    _rowNumbool= YES;
    
    
    [YXNetworkTool cancelAllNetworkRequest];
    
    [self addNavTitle];
    
    [self addTableview];
    [self addBoomview];
    
    
}
-(void)ChangedaojishiBoomBtn
{
    self.boomBtn.hidden = YES;
    self.baomingbtn.hidden = YES;
    self.marginpricebtn.hidden = YES;
    self.tipslable.hidden = YES;
}
-(void)addNavTitle
{
    self.title = @"拍品详情";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.requestbool = 1;
    self.addpricebool = NO;
    
    self.TimeNumber = 4;
    
    [self requestDeatildata];
    
    // 启动倒计时管理
    [kCountDownManager start];
    
//     [self registerForKeyboardNotifications];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [YXNetworkHUD dismiss];
    [kCountDownManager stopTime];
    [SVProgressHUD dismiss];
    /*
     @brief 关闭倒计时
     */
    [YXNotificationTool postNotificationName:@"SOPTTIMEDAOJISHI" object:nil];
    
    //    self.tabBarController.tabBar.hidden = NO;
    
    
    self.requestbool = 2;
    [[YXNetworkTool sharedTool].operationQueue cancelAllOperations];
    self.addpricebool = YES;
    
    [self dimssMyAllSmallview];
    
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
/*
 @brief 消失的时候 移除所有的弹出视图
 */
-(void)dimssMyAllSmallview
{
    
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
    
    [self.addpricesuccessorfailview removeFromSuperview];
    self.addpricesuccessorfailview = nil;
    
    [self.gotoAddPriceView removeFromSuperview];
    self.gotoAddPriceView = nil;
    
    [self.postBondsView removeFromSuperview];
    self.postBondsView = nil;
    
}

//**  添加TableVeiw  **/
-(void)addTableview
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH-50) style:UITableViewStyleGrouped];
    
    self.tableview.delegate  = self;
    self.tableview.dataSource = self;
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDeatildata)];
    
    
    /*------tableviewHeaderview--*/
    self.tableviewHeaderview = [[YXHomeAuctionDeatilHeaderView  alloc]initWithFrame:CGRectMake(0, 0,widthScreen , 0)];
    __weak typeof(self)weakself = self;
    self.tableviewHeaderview.backgroundColor = [UIColor whiteColor];
    self.tableviewHeaderview.HeaderHeightblock = ^(CGFloat height){
        
        weakself.tableviewHeaderview.frame = CGRectMake(0, 0, YXScreenW, height+0);
        weakself.tableview.tableHeaderView = weakself.tableviewHeaderview;
        
    };
    
    self.tableviewHeaderview.seactionBlock = ^(NSInteger tag ,NSInteger attentstatus){
        switch (tag) {
            case 0:
                //** 关注 0未关注  1 已关注**/
                if (attentstatus == 1)
                {
                    [weakself cancleAttentionGoods];
                }else{
                    [weakself attentionGoods];
                }
                break;
            case 1:
                
                break;
                // 参与
                
            case 2:
                [weakself pushKeFuVC];
                break;
            default:
                break;
        }
        
        
    };
    self.tableviewHeaderview.taponeviewblock = ^(){
//        跳转到竞拍规则
        YXHelpViewController *helpvc = [[YXHelpViewController alloc]init];
        helpvc.helpIndex = 0;
        [weakself.navigationController pushViewController:helpvc animated:YES];
    };
    
    self.tableview.tableHeaderView = self.tableviewHeaderview;
    
    
    [self addfootBtnview];
    
    
    
    
}
//**  添加更多按钮  **/
-(void)addfootBtnview
{
    //**  组尾  **/
    
    UIView *tableviewFootview  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 40)];
    self.tableview.tableFooterView = tableviewFootview;
    
    UIButton *FootBtn = [[UIButton alloc]initWithFrame:CGRectMake((YXScreenW-85)/2, 0, 85, 26)];
    [FootBtn setImage:[UIImage imageNamed:@"icon_gengduo"] forState:UIControlStateNormal];
    [FootBtn addTarget:self action:@selector(Clickfootbtn) forControlEvents:UIControlEventTouchUpInside];
    [FootBtn setTitle:@"  查看更多" forState:UIControlStateNormal];
    [FootBtn setTitleColor:UIColorFromRGB(0x6969696) forState:UIControlStateNormal];
    FootBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    FootBtn.layer.borderWidth = 1;
    FootBtn.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
    FootBtn.layer.cornerRadius = 3;
    
    [tableviewFootview addSubview:FootBtn];
    
    self.footbtn = FootBtn;
    
    
}
//**  点击footview  **/
-(void)Clickfootbtn
{
    
    if (_rowNumbool) {
        
        _clickFooterBtnNmuber ++;
        
        if (self.addpricelistdata.count-_rowNum>10) {
            
            _rowNum = _clickFooterBtnNmuber*10+1;
            
        }else{
            
            _rowNum = self.addpricelistdata.count;
        }
        
        
        /*
         @brief 全部显示后 才能折叠
         */
        if (_rowNum == self.addpricelistdata.count) {
            
            [self.footbtn setTitle:@"  收起" forState:UIControlStateNormal];
            
            [self.footbtn setImage:[UIImage imageNamed:@"ic_jianhao_1"] forState:UIControlStateNormal];
            
            _rowNumbool = NO;
        }
        
        
    }else{
        
        if(self.addpricelistdata.count==0)
        {
            _rowNum = 0;
        }else{
            _rowNum = 1;
        }
        _rowNumbool = YES;
        
        [self.footbtn setTitle:@"  查看更多" forState:UIControlStateNormal];
        [self.footbtn setImage:[UIImage imageNamed:@"icon_gengduo"] forState:UIControlStateNormal];
        
        _clickFooterBtnNmuber = 0;
    }
    
    [self.tableview reloadData];
}

//**  添加底部视图  **/
-(void)addBoomview
{
    UIButton *boomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, heightScreen-50, widthScreen, 50)];
    [boomBtn setTitle:@"数据加载中..." forState:UIControlStateNormal];
    [boomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    boomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20];
    [boomBtn addTarget:self action:@selector(ClickCommitbtn) forControlEvents:UIControlEventTouchUpInside];
    boomBtn.backgroundColor = [UIColor mainThemColor];
    self.boomBtn = boomBtn;
    [self.view addSubview:boomBtn];
    
    self.baomingbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, YXScreenW-0, 30)];
    [self.baomingbtn setTitle:@"我要报名" forState:UIControlStateNormal];
    [self.baomingbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.baomingbtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20];
    [self.baomingbtn addTarget:self action:@selector(ClickCommitbtn) forControlEvents:UIControlEventTouchUpInside];
    self.baomingbtn.backgroundColor = [UIColor mainThemColor];
    [self.boomBtn addSubview:self.baomingbtn];
    
    self.marginpricebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 28, YXScreenW-0, 20)];
    [self.marginpricebtn setTitle:@"（保证金金额：￥500）" forState:UIControlStateNormal];
    [self.marginpricebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.marginpricebtn.titleLabel.font = YXRegularfont(12);
    [self.marginpricebtn addTarget:self action:@selector(ClickCommitbtn) forControlEvents:UIControlEventTouchUpInside];
    self.marginpricebtn.backgroundColor = [UIColor mainThemColor];
    [self.boomBtn addSubview:self.marginpricebtn];
    
    
    UILabel *tipslable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, YXScreenW, 30)];
    tipslable.text = @"距离结束进入倒计时，无法参与报名";
    tipslable.textAlignment = NSTextAlignmentCenter;
    tipslable.font = YXRegularfont(14);
    tipslable.textColor = [UIColor redColor];
    tipslable.backgroundColor = [UIColor whiteColor];
    tipslable.alpha = 1;
    [self.boomBtn addSubview:tipslable];
    self.tipslable = tipslable;
    
    self.tipslable.hidden = YES;
    self.baomingbtn.hidden = YES;
    self.marginpricebtn.hidden = YES;
}

-(void)ClickCommitbtn
{
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(goToJoinAuction) object:nil];
    [self performSelector:@selector(goToJoinAuction)withObject:nil afterDelay:0.2f];
    
}
//**  点击参与竞拍按钮  **/
-(void)goToJoinAuction
{
    
    
    [self checkEsuserMoney:0];
    
    if (self.kaipaistatus==1) {
        
        if ([self.boomBtn.titleLabel.text isEqualToString:@"关注"]) {
            
            [self attentionGoods];
            
        }else if([self.boomBtn.titleLabel.text isEqualToString:@"已关注"]){
            
            [self cancleAttentionGoods];
            
        }
        
    }else{
        
        if(self.ensuremoneystatus == 2)
        {
            [self requestComitEsureMoney];
        }else if (self.ensuremoneystatus == 1)
        {
            [self addAddPriceView];
            
        }else if (self.ensuremoneystatus == 3)
        {
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            YXLoginViewController *longin = [[YXLoginViewController alloc]init];
            YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
            [self presentViewController:nav animated:YES completion:nil];
            
        }
    }
    
}
/*
 @brief 点击关注
 */
-(void)attentiontype:(NSString*)type
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = type;
    self.RemindGoodsView.frame = self.view.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [wealself dimssview];
    });
    
}


-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
    
}



/*
 @brief 判断是否结束竞拍
 */
-(void)CompareTime:(NSInteger)marginprice
{
    
    NSString * marginpricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",marginprice/100]];
    long long   endtime = [self.deatilDataModle.endTime longLongValue]/1000;
    long long  startime = [self.deatilDataModle.startTime longLongValue]/1000;
    
    NSDate *currentDate =  [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSString *currentTimeStr = [NSString stringWithFormat:@"%lld", (long long)[currentDate timeIntervalSince1970]];
    
    long long  nowtimeint = [currentTimeStr longLongValue];
    
    //**未开拍**/
    if (startime > nowtimeint) {
        
        self.kaipaistatus = 1;
        
        if(self.deatilDataModle.isCollect ==0)
        {
            [self.boomBtn setTitle:@"关注" forState:UIControlStateNormal];
        }else{
            [self.boomBtn setTitle:@"已关注" forState:UIControlStateNormal];
        }
    }else
    {
        //开拍
        self.kaipaistatus =0;
        [self.boomBtn setTitle:@"" forState:UIControlStateNormal];

        //**结束**/
        if (nowtimeint > endtime) {
            
            self.kaipaistatus = 1;
            self.xiajiaStatus = 1;
            
            self.boomBtn.hidden = YES;
            self.tableview.frame = self.view.bounds;
            
            self.requestbool = 2;
            
            /*
             @brief 倒计时结束后 再刷新30s
             */
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            self.timer = timer;
            [timer fire];
            
        }else{
            
            self.boomBtn.hidden = NO;
            
            if (self.ensuremoneystatus ==0) {
                
                self.tipslable.hidden = YES;
                self.boomBtn.userInteractionEnabled = YES;
                self.baomingbtn.hidden = NO;
                self.marginpricebtn.hidden =NO;
                [self.baomingbtn setTitle:@"我要报名" forState:UIControlStateNormal];
                self.boomBtn.backgroundColor = [UIColor mainThemColor];
                
                [self.marginpricebtn setTitle:[NSString stringWithFormat:@"（保证金金额：￥%@）",marginpricestr] forState:UIControlStateNormal];
                
            }
            
            if (self.ensuremoneystatus ==1) {
                
                self.tipslable.hidden = YES;
                self.boomBtn.userInteractionEnabled = YES;
                self.baomingbtn.hidden = YES;
                self.marginpricebtn.hidden =YES;
                [self.boomBtn setTitle:@"我要加价" forState:UIControlStateNormal];
                self.boomBtn.backgroundColor = [UIColor mainThemColor];
                
            }else if(self.ensuremoneystatus==2||self.ensuremoneystatus==3||self.ensuremoneystatus==0)
            {
                
//                [self.boomBtn setTitle:@"" forState:UIControlStateNormal];
                /*
                 @brief 报名情况下
                 */
                //**剩余时间差**/
                
                //                YXLog(@"-----%ld",[self.deatilDataModle.endTime longLongValue]/1000-nowtimeint);
                
                long long  timeCha = [self.deatilDataModle.endTime longLongValue]/1000 - nowtimeint;
                if (timeCha > 5*60) {
                    
                    //**不进入倒计时**/
                    
                    self.tipslable.hidden = YES;
                    self.boomBtn.userInteractionEnabled = YES;
                    self.baomingbtn.hidden = NO;
                    self.marginpricebtn.hidden =NO;
                    [self.baomingbtn setTitle:@"我要报名" forState:UIControlStateNormal];
                    self.baomingbtn.backgroundColor = [UIColor clearColor];
                    self.boomBtn.backgroundColor = [UIColor mainThemColor];
                    self.marginpricebtn.backgroundColor = [UIColor clearColor];
                    [self.marginpricebtn setTitle:[NSString stringWithFormat:@"（保证金金额：￥%@）",marginpricestr] forState:UIControlStateNormal];
                    
                }else{
                    //**进入倒计时**/
                    
                    self.tipslable.hidden = NO;
                    self.boomBtn.backgroundColor = YXColor(173, 173, 173);
                    self.baomingbtn.backgroundColor =YXColor(173, 173, 173);
                    self.marginpricebtn.backgroundColor = YXColor(173, 173, 173);
                    self.boomBtn.userInteractionEnabled = NO;
                    self.baomingbtn.userInteractionEnabled = NO;
                    self.marginpricebtn.userInteractionEnabled = NO;
                }
                
            }
            
        }
    }
    
    
}


-(void)updateTime
{
    
    if (self.TimeNumber<=0) {
        [self.timer invalidate];
        return;
    }else{
        [self LoopRequestDeatildata];
    }
    self.TimeNumber --;
    
}

#pragma mark  ******************* 弹出 视图**********************

/*
 @brief 弹出 --提交保证金－－－－的视图
 */
-(void)addsmallview
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.postBondsView];
    self.postBondsView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.postBondsView.frame = self.view.bounds;
    
    /*
     @brief 点击提交保证金
     */
    __weak typeof(self) weakself = self;
    /*
     @brief 跳转帮助页面
     */
    self.postBondsView.pushhelpblock = ^(){
        [weakself.postBondsView removeFromSuperview];
        weakself.postBondsView = nil;
        
        
        YXHelpViewController *helpdeatilvc = [[YXHelpViewController alloc]init];
        helpdeatilvc.helpIndex = 0;
        [weakself.navigationController pushViewController:helpdeatilvc animated:YES];
        
    };
    
    self.postBondsView.commitblock = ^(){
        
        [weakself.postBondsView removeFromSuperview];
        weakself.postBondsView = nil;
        
        [weakself creatMarginPrice];
        
    };
}
/*
 @brief 跳转支付界面
 */
-(void)pushWaitPaymentVC:(NSString *)marginID
{

    YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:[marginID longLongValue] andType:YXPaymentHomePageControllerBond];
    [self.navigationController pushViewController:paymentController animated:YES];

}

/*
 @brief 弹出－－－－－加价－－－－视图
 */
-(void)addAddPriceView
{
    
    self.gotoAddPriceView.dataDict = self.addpricedict;
    [[UIApplication sharedApplication].keyWindow addSubview:self.gotoAddPriceView];
    self.gotoAddPriceView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.gotoAddPriceView.frame = self.view.bounds;
    
    __weak typeof (self)weakself = self;
    self.gotoAddPriceView.pushhelpblock=^(){
        
        [weakself.gotoAddPriceView removeFromSuperview];
        weakself.gotoAddPriceView = nil;
        
        //        YXHelpViewController *helpvc =[[YXHelpViewController alloc]init];
        //        [weakself.navigationController pushViewController:helpvc animated:YES];
        
        YXHelpViewController *helpvc = [[YXHelpViewController alloc]init];
        helpvc.helpIndex = 0;
        [weakself.navigationController pushViewController:helpvc animated:YES];
        
        
    };
    
    self.gotoAddPriceView.CommitBlock = ^(NSString * prices){
        
        weakself.addpricestr = prices;
        [weakself requestJionAddpriceList:prices];
        
    };
    
}

-(void)addpricestatusview:(NSString*)status andAddpricestr:(NSString*)addpricestr andcurrenpricestr:(NSString*)currenpricestr
{
    [self.gotoAddPriceView removeFromSuperview];
    self.gotoAddPriceView = nil;
    
    self.addpricesuccessorfailview.addpricestr = addpricestr;
    self.addpricesuccessorfailview.currentpricestr = currenpricestr;
    self.addpricesuccessorfailview.status = status;
    [[UIApplication sharedApplication].keyWindow addSubview:self.addpricesuccessorfailview];
    self.addpricesuccessorfailview.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.addpricesuccessorfailview.frame = self.view.bounds;
    
}


#pragma mark  ******************* 移除弹出的视图代理方法**********************

#pragma mark --YXMyAuctionPostBondsViewDelegate
//** 移除提交保证金界面 */
- (void)myAuctionPostBondsDelegate:(YXMyAuctionPostBondsView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender
{
    [YXNetworkHUD dismiss];
    [self.postBondsView removeFromSuperview];
    self.postBondsView = nil;
}

- (void)GotoJionAuctionAddPriceDelegate:(YXGotoJionAuctionAddPriceView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender
{
    [YXNetworkTool cancelHttpRequestWithType:@"post" WithPath:[NSString stringWithFormat:@"%@%@",kOuternet,CHECKAPPRICESUCCESSORFIAL_URL]];
    [YXNetworkHUD dismiss];
    [self.gotoAddPriceView removeFromSuperview];
    self.gotoAddPriceView = nil;
}

-(void)AddPriceStatusviewDelegate:(YXAddpriceSuccessOrFailView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender
{
    [YXNetworkHUD dismiss];
    self.addpricebool = YES;
    [self.addpricesuccessorfailview removeFromSuperview];
    self.addpricesuccessorfailview = nil;
    
}



#pragma mark  ------ TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _rowNum;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YXHomeAuctionDeatilTableViewCell *cell =  [YXHomeAuctionDeatilTableViewCell cellWithTableView:tableView indexPath:indexPath];
    if (self.addpricelistdata.count) {
        
        cell.modle = self.addpricelistdata[indexPath.row];
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  74;
}

/**  组头视图  **/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 30)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 29, YXScreenW, 1)];
    line.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [view addSubview:line];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    [btn setImage:[UIImage imageNamed:@"icon_chujia"] forState:UIControlStateNormal];
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -42, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -38, 0, 0);
    [view addSubview:btn];
    
    self.SeactionNumberBtn = btn;
    
    [self.SeactionNumberBtn setAttributedTitle:[self setSeactionNumberBtnTitle:self.addpricelistdata.count] forState:UIControlStateNormal];
    
    return view;
    
}

-(NSAttributedString*)setSeactionNumberBtnTitle:(NSInteger)counts
{
    NSString *btntitleStr = [NSString stringWithFormat:@" 出价记录(出价次数：%ld次)",(long)counts];
    NSMutableAttributedString * btnstr1 = [[NSMutableAttributedString alloc] initWithString:btntitleStr];
    [btnstr1 addAttribute:NSForegroundColorAttributeName value:YXHomeDeatilcolor range:NSMakeRange(0, btnstr1.length-5)];
    [btnstr1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x7e7e7e) range:NSMakeRange(5, btnstr1.length-5)];
    [btnstr1 addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(0, 5)];
    [btnstr1 addAttribute:NSFontAttributeName value:YXRegularfont(11) range:NSMakeRange(5, btnstr1.length-5)];
    return btnstr1;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


-(UIButton *)addBtnToCell:(NSString *)titlestr
{
    UIButton *btn = [[UIButton alloc]init];
    NSMutableAttributedString* btnstr = [[NSMutableAttributedString alloc] initWithString:titlestr];
    [btnstr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, btnstr.length)];
    [btnstr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, btnstr.length-4)];
    [btnstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 4)];
    [btnstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, btnstr.length-4)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setAttributedTitle:btnstr forState:UIControlStateNormal];
    
    return btn;
}


#pragma mark  ------ **********************网路请求*********************

-(void)requestDeatildata
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    parm[@"prodBidId"] = @(self.ProBidId);
    if (self.prodId) {
        
//        parm[@"prodId"] = [NSString stringWithFormat:@"%ld",(long)self.prodId];
        parm[@"prodId"] = @(self.prodId);
    }
    
    
    [YXRequestTool requestDataWithType:POST url:REQUESTDEATILDATA_URL params:parm success:^(id objc, id respodHeader) {
        
            YXLog(@"===拍品详情的数据==%@====",objc);
        
        if(![respodHeader[@"Status"] isEqualToString:@"1"]){
            
            [SVProgressHUD showInfoWithStatus:objc];
            
        }else{
            
            NSInteger suremoney = [objc[@"marginPrice"] integerValue]/100;
            NSString  *suremoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)suremoney] ];
            NSString *pricestr = [NSString stringWithFormat:@"(保证金金额：￥%@)",suremoneypricestr];
            [self.marginpricebtn setTitle:pricestr forState:UIControlStateNormal];
            
            self.deatilDataModle = [YXHomeDeatilModle mj_objectWithKeyValues:objc];
            
            self.tableviewHeaderview.deatilmodle = self.deatilDataModle;
            
            self.addpricelistdata = [YXHomeDeatilBidRecordVosListModle mj_objectArrayWithKeyValuesArray:self.deatilDataModle.bidRecordVos];
            
            if (self.addpricelistdata.count==0) {
                _rowNum = 0;
                self.footbtn.hidden = YES;
            }else if (self.addpricelistdata.count ==1) {
                
                self.footbtn.hidden = YES;
                _rowNum = 1;
            }else{
                if([self.footbtn.titleLabel.text isEqualToString:@"  查看更多"])
                {
                    _rowNum = 1;
                }
                self.footbtn.hidden = NO;
            }
            
            [self.tableview reloadData];
            
            self.tipslable.hidden = YES;
            self.baomingbtn.hidden = YES;
            self.marginpricebtn.hidden = YES;
            
            
            [self CompareTime:self.deatilDataModle.marginPrice];
            
            [self checkEsuserMoney:0];
            
            
            self.prodId = [objc[@"prodId"] longLongValue];
            self.ProBidId = [objc[@"prodBidId"] longLongValue];
            
        }
        
        [self.tableview.mj_header endRefreshing];
        
        if (self.xiajiaStatus==1) {
            
            //            /*
            //             @brief 循环请求
            //             */
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            //                if (!self.xiajiaStatus) {
            //
            //                    [self LoopRequestDeatildata];
            //                }
            //            });
            
        }else
        {
            
            [self LoopRequestDeatildata];
        }
        
    } failure:^(NSError *error) {
        
        
        [self.tableview.mj_header endRefreshing];
    }];
    
}

#pragma mark  ******************* 循环网络请求**********************
-(void)LoopRequestDeatildata
{
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    parm[@"prodBidId"] = @(self.ProBidId);
    if (self.prodId) {
        

         parm[@"prodId"] = @(self.prodId);
    }
    
    [YXRequestTool LoopRequestDataWithType:POST url:REQUESTDEATILLOOP_URL params:parm success:^(id objc, id respodHeader) {
        

        self.loopdeatildataModle = [YXHomeDeatilModle mj_objectWithKeyValues:objc];
        
        self.tableviewHeaderview.loopmodle = self.loopdeatildataModle;
        
        self.tableviewHeaderview.guanzhuNum = self.loopdeatildataModle.collectNum;
        //        参与竞拍人数
        self.tableviewHeaderview.actorNum = self.loopdeatildataModle.actorNum;
        
        self.addpricelistdata = [YXHomeDeatilBidRecordVosListModle mj_objectArrayWithKeyValuesArray:self.loopdeatildataModle.bidRecordVos];
        
        if (self.addpricelistdata.count==0) {
            _rowNum = 0;
            self.footbtn.hidden = YES;
        }else if (self.addpricelistdata.count==1) {
            
            self.footbtn.hidden = YES;
            
        }else if (self.addpricelistdata.count >1)
        {
            
            self.footbtn.hidden = NO;
            
            
            if (!_clickFooterBtnNmuber) {
                
                _rowNum = 1;
                
            }else{
                
                if (_rowNumbool) {
                    
                    _rowNum = _clickFooterBtnNmuber*10+1;
                    
                }else{
                    
                    _rowNum = self.addpricelistdata.count;
                }
            }
            
        }
        
        [self.SeactionNumberBtn setAttributedTitle:[self setSeactionNumberBtnTitle:self.addpricelistdata.count] forState:UIControlStateNormal];
        
        [self.tableview reloadData];
        /*
         @brief 判读是否结束竞拍
         */
        [self CompareTime:self.deatilDataModle.marginPrice];
        
        
    } failure:^(NSError *error) {
        
    }];
    /*
     @brief 没有下架
     */
    if (_xiajiaStatus!=1) {
        
        /*
         @brief 循环请求
         */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.requestbool==1) {
                
                [self LoopRequestDeatildata];
            }
        });
    }
}

/*
 @brief 判断是否支付保证金 Status == 2 未交保证金或保证金不够 -> 交保证金页面
 */

-(void)checkEsuserMoney:(NSInteger)type
{
    
    if(self.kaipaistatus==1)
    {
        
    }else{
        NSMutableDictionary *parm = [NSMutableDictionary dictionary];
        
        parm[@"bidId"] = self.deatilDataModle.prodBidId;
        
        [YXRequestTool requestDataWithType:POST url:CHECKENSUREMONEY_URL params:parm success:^(id objc, id respodHeader) {
            
            /*
             @brief 1 加价失败后的请求 刷新加价界面的数据
             */
            if (type ==1) {
                if([respodHeader[@"Status"] isEqualToString:@"1"])
                {
                    self.addpricedict = objc;
                    self.gotoAddPriceView.dataDict = self.addpricedict;
                    self.gotoAddPriceView.addpricStatus = 1;
                }
            }else{
                
                //**  去交保证金  **/
                if ([respodHeader[@"Status"] isEqualToString:@"2"]) {
                    self.ensuremoneystatus = 2;
                    [self.boomBtn setTitle:@"" forState:UIControlStateNormal];
                    [self.baomingbtn setTitle:@"我要报名" forState:UIControlStateNormal];
                    self.baomingbtn.hidden = NO;
                    self.marginpricebtn.hidden = NO;
                    
                }else if([respodHeader[@"Status"] isEqualToString:@"1"]) {
                    self.ensuremoneystatus = 1;
                    [self.boomBtn setTitle:@"我要加价" forState:UIControlStateNormal];
                    self.tipslable.hidden = YES;
                    self.baomingbtn.hidden = YES;
                    self.marginpricebtn.hidden = YES;
                    self.addpricedict = objc;
                    self.gotoAddPriceView.dataDict = self.addpricedict;
                    
                }else if([respodHeader[@"Status"] isEqualToString:@"3"]||[respodHeader[@"Status"] isEqualToString:@"6"]){
                    
                    self.ensuremoneystatus = 3;
                    [self.boomBtn setTitle:@"" forState:UIControlStateNormal];
                    [self.baomingbtn setTitle:@"我要报名" forState:UIControlStateNormal];
                    self.baomingbtn.hidden = NO;
                    self.marginpricebtn.hidden = NO;
                    
                }else{
                    
                    
                }
                
            }
            
            /*
             @brief 判读是否结束竞拍
             */
            [self CompareTime:self.deatilDataModle.marginPrice];
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
}

/*
 @brief 请求提交保证金接口
 */
-(void)requestComitEsureMoney
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"bidId"] = self.deatilDataModle.prodBidId;
    
    [YXRequestTool requestDataWithType:POST url:COMMITESUREMONEY_URL params:parm success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.EnsureMoney = [objc[@"marginPrice"] longLongValue];
            NSString *alreadyPayAmountstr = objc[@"alreadyPayAmount"];
            self.alreadyPayAmount = [alreadyPayAmountstr longLongValue];
            self.isPartPay = [objc[@"isPartPay"] longLongValue];
            self.postBondsView.esureMoney= objc[@"marginPrice"];
            /*
             @brief 保证金部分支付
             */
            if(self.isPartPay ==1)
            {
                [self creatMarginPrice];
                
            }else{
                
                //                /*
                //                 @brief 实名认证 和 绑定银行卡的 才能弹出保证金的 页面
                //                 */
                //               NSInteger shimingrenzheng =  [[YXUserDefaults objectForKey:@"validateStatus"] longLongValue];
                //               NSInteger yinhangka = [[YXUserDefaults  objectForKey:@"cardStatus"] longLongValue];
                //
                //                //--跳转到身份验证模块
                //                /**
                //                 * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
                //                 */
                //                if (shimingrenzheng ==2 && yinhangka ==1) {
                //
                [self addsmallview];
                //                    return ;
                //                }
                //
                //                if (shimingrenzheng ==2 && yinhangka !=1 ) {
                //
                //                    YXMyAccoutBindBankCardViewController * bindbankcardVC = [[YXMyAccoutBindBankCardViewController alloc]init];
                //
                //                    [self.navigationController pushViewController:bindbankcardVC animated:YES];
                //
                //                }else if(shimingrenzheng !=2  && yinhangka !=1){
                //
                //                    YXMyAucctionRealnameAndBindbankCardViewController *allrealnameAndbindbankcardVC = [[YXMyAucctionRealnameAndBindbankCardViewController alloc]init];
                //                    [self.navigationController pushViewController:allrealnameAndbindbankcardVC animated:YES];
                //
                //                }
                
                
                
                
                
            }
            
            
        }else
        {
            //            [SVProgressHUD showInfoWithStatus:objc];
        }
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark  ******************* 关注 和 取消关注**********************
/*
 @brief 关注
 */

-(void)attentionGoods
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    parm[@"prodId"] = [NSString stringWithFormat:@"%lld",self.prodId];
    
    [YXRequestTool requestDataWithType:POST url:ATTENTIONGOODS_URL params:parm success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.RemindGoodsView.Type = @"GoodsDeatilAtten";
            [self attentiontype:@"GoodsDeatilAtten"];
            
            if (!self.ensuremoneystatus) {
                
                [self.boomBtn setTitle:@"已关注" forState:UIControlStateNormal];
            }
            
            self.tableviewHeaderview.guanzhuSTR = @"1";
            
            
        }else if([respodHeader[@"Status"] isEqualToString:@"3"]||[respodHeader[@"Status"] isEqualToString:@"6"])
        {
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            YXLoginViewController *longin = [[YXLoginViewController alloc]init];
            YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
            [self presentViewController:nav animated:YES completion:nil];
        }
        else{
            self.RemindGoodsView.Type = @"attentionNOT";
            [self attentiontype:@"attentionNOT"];
            
        }
        
    } failure:^(NSError *error) {
        
        
    } ];
}
/*
 @brief  取消关注
 */
-(void)cancleAttentionGoods
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    parm[@"prodId"] = [NSString stringWithFormat:@"%lld",self.prodId];
    
    [YXRequestTool requestDataWithType:POST url:CANCLEATTENTIONGOODS_URL params:parm success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.RemindGoodsView.Type = @"GoodsDeatilAlreadyAtten";
            [self attentiontype:@"GoodsDeatilAlreadyAtten"];
            if (!self.ensuremoneystatus) {
                
                [self.boomBtn setTitle:@"关注" forState:UIControlStateNormal];
                
            }
            self.tableviewHeaderview.guanzhuSTR = @"2";
            
        }else if([respodHeader[@"Status"] isEqualToString:@"3"]||[respodHeader[@"Status"] isEqualToString:@"6"])
        {
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            YXLoginViewController *longin = [[YXLoginViewController alloc]init];
            YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
            [self presentViewController:nav animated:YES completion:nil];
        }
        else{
            
            self.RemindGoodsView.Type = @"attentionNOT";
            [self attentiontype:@"attentionNOT"];
            
        }
        
    } failure:^(NSError *error) {
        
        
    } ];
}

#pragma mark  ******************* 加价请求**********************

/*
 @brief 在加价的时候 点击提交的时候 加入加价队列，拿到队列号
 */
-(void)requestJionAddpriceList:(NSString *)prices
{
    [YXNetworkHUD show];
    
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"bidId"] = self.deatilDataModle.prodBidId;
    parma[@"price"] =  [NSString stringWithFormat:@"%lld",[prices longLongValue]*100];
    
    [YXRequestTool requestDataWithType:POST url:JIONADDPRICELIST_URL params:parma success:^(id objc, id respodHeader) {
        
    if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.msgId = objc[@"msgId"];
            [self requestCheckAddPriceSuccessOrFial:objc[@"msgId"]];
            self.gotoAddPriceView.AddPriceTextfile.enabled = NO;
            self.gotoAddPriceView.CommitBtn.enabled = NO;
            
        }else if([respodHeader[@"Status"] isEqualToString:@"2"]){
            [YXNetworkHUD dismiss];
            //**加价失败**/
            self.gotoAddPriceView.addpricStatus = 1;
            [self checkEsuserMoney:1];
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

/*
 @brief 在加价的时候 点击提交的时候 加入加价队列，拿到队列号   循环请求知道成功或失败
 */
-(void)requestCheckAddPriceSuccessOrFial:(NSString *)msgId
{
    
    self.gotoAddPriceView.addpricStatus = 2;
    
    self.addpricebool = NO;
    
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"msgId"] = msgId;
    
    [YXRequestTool requestDataWithType:POST url:CHECKAPPRICESUCCESSORFIAL_URL params:parma success:^(id objc, id respodHeader) {
        
        
        if([respodHeader[@"Status"] isEqualToString:@"1"])
        {
            [YXNetworkHUD dismiss];
            
            
            self.gotoAddPriceView.AddPriceTextfile.enabled = NO;
            self.gotoAddPriceView.CommitBtn.enabled = NO;
            
            self.addpricebool = YES;
            
            if ([[NSString stringWithFormat:@"%@",objc[@"bidStatus"]] isEqualToString:@"1"]) {
                
                NSString* currentpicestr =  [NSString stringWithFormat:@"%lld", [objc[@"price"] longLongValue] /100];
                
                [self addpricestatusview:@"success" andAddpricestr:self.addpricestr andcurrenpricestr:currentpicestr];
                
                
                [self requestDeatildata];
                if([self.footbtn.titleLabel.text isEqualToString:@"  收起"])
                {
                    _rowNum++;
                }
                
            }else if ([[NSString stringWithFormat:@"%@",objc[@"bidStatus"]] isEqualToString:@"0"])
            {
                
                [YXNetworkHUD dismiss];
                //**加价失败**/
                self.gotoAddPriceView.addpricStatus = 1;
                [self checkEsuserMoney:1];
            }
            
            
        }else{
            
            __weak typeof(self)weakself = self;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (!self.addpricebool) {
                    
                    [self requestCheckAddPriceSuccessOrFial:weakself.msgId];
                    
                }
                
            });
            
        }
    } failure:^(NSError *error) {
        
        __weak typeof(self)weakself = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!self.addpricebool) {
                
                [self requestCheckAddPriceSuccessOrFial:weakself.msgId];
            }
            
        });
    }];
    
    
}


#pragma mark  ******************* 生成保证金接口**********************
-(void)creatMarginPrice
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"prodBidId"] = @(self.ProBidId);
    
    if (self.prodId) {
        
        param[@"prodId"] = @(self.prodId);
    }
    param[@"marginPrice"] = @(self.EnsureMoney);
    
    [YXRequestTool requestDataWithType:POST url:CREACTMARGIN_URL params:param success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            NSString *marginID = objc[@"marginId"];
            
            [self pushWaitPaymentVC:marginID];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


/*
 @brief 跳转客服控制器
 */
-(void)pushKeFuVC
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];

}
@end
