//
//  YXLineTransferController.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXLineTransferController.h"
#import "YXPaymentDetailCell.h"
#import "YXLineTransferPayeeInformationCell.h"
#import "YXLineTransferCertificatesCell.h"
#import "YXPaymentTypeHeaderView.h"
#import "YXPayMentNetRequestTool.h"
#import "YXLineInformationCommitSuccessViewController.h"
#import "YXAlertViewTool.h"
#import "YXChatViewManger.h"
#import "YXNavigationController.h"
#import "YXSendAuctionProgressModel.h"
#import "UIImage+fixOrientation.h"
#import "YXPaymentHomePageController.h"
#import "YXLineTransferCertificatesFooterView.h"
#import "YXOrderDetailViewController.h"

/**
 上传图片的状态

 - YXLineTransferControllerUploadImageNone:             没有图片
 - YXLineTransferControllerUploadImageLoding:           上传中
 - YXLineTransferControllerUploadImageSuccessed:        成功
 - YXLineTransferControllerUploadImageFaild:            失败
 */
typedef NS_ENUM(NSUInteger, YXLineTransferControllerUploadImageStatus) {
    YXLineTransferControllerUploadImageNone,
    YXLineTransferControllerUploadImageLoding,
    YXLineTransferControllerUploadImageSuccessed,
    YXLineTransferControllerUploadImageFaild,
};

@interface YXLineTransferController () <UITableViewDataSource, UITableViewDelegate, YXLineTransferCertificatesCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, YXLineTransferCertificatesFooterViewDelegate>
{
    YXSendAuctionProgressModel *_currentUploadImageProgressModel;
}

/**
 内容视图
 */
@property (nonatomic, strong) UITableView *contentTableView;

/**
 相机&相册控制器
 */
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

/**
 凭证来源类型 1.相机 2.相册
 */
@property (nonatomic, assign) NSInteger type;

/**
 选中的凭证图片
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 确认提交按钮
 */
@property (nonatomic, strong) UIButton *sureButton;

/**
 是否上传图片
 */
@property (nonatomic, assign) YXLineTransferControllerUploadImageStatus isUploadImage;

/**
 是否有凭证照片url
 */
@property (nonatomic, copy) NSString *offlineCertificatesImageUrlString;

/**
 数据模型
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *paymentHomePageViewDataModel;

@end

@implementation YXLineTransferController

//** 重用标志 */
static NSString * const kYXPaymentHomePageControllerDetailCellReusableIdentifier = @"kYXPaymentHomePageControllerDetailCellReusableIdentifier";
static NSString * const kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier = @"kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier";
static NSString * const kYXPaymentLineTransferControllerPayeeInformationReusableIdentifier = @"kYXPaymentLineTransferControllerPayeeInformationReusableIdentifier";
static NSString * const kYXPaymentLineTransferControllerCertificatesReusableIdentifier = @"kYXPaymentLineTransferControllerCertificatesReusableIdentifier";
static NSString * const kYXPaymentLineTransferControllerCertificatesFooterViewReusableIdentifier = @"kYXPaymentLineTransferControllerCertificatesFooterViewReusableIdentifier";


//** 重绘图片的宽度尺寸 */
CGFloat lineTransferMaxImageWidth = 414.f;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 获取网络参数

 @param paymentHomePageViewDataModel paymentHomePageViewDataModel
 */
- (void)setPaymentHomePageViewDataModel:(YXPaymentHomepageViewDataModel *)paymentHomePageViewDataModel
{
    _paymentHomePageViewDataModel = paymentHomePageViewDataModel;
    
    [self.contentTableView reloadData];
}

/**
 刷新当前界面

 @param currentUploadImageProgressModel currentUploadImageProgressModel 
 */
- (void)setCurrentUploadImageProgressModel:(YXSendAuctionProgressModel *)currentUploadImageProgressModel
{
    _currentUploadImageProgressModel = currentUploadImageProgressModel;
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.contentTableView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Third.点击事件

/**
 确认按钮点击事件

 @param sender sender 确认按钮
 */
- (void)sureButtonClick:(UIButton *)sender
{
    
}

/**
 配置成功跳转界面

 @return 成功界面
 */
- (UIViewController *)setupSuccessViewController
{
    YXLineInformationCommitSuccessViewController *successViewController = [[YXLineInformationCommitSuccessViewController alloc] init];
    successViewController.orderId = self.orderId;
    return successViewController;
}

#pragma mark - Fourth.代理方法

#pragma mark <YXLineTransferCertificatesFooterViewDelegate>

/**
 footer功能按钮点击事件

 @param lineTransferCertificatesFooterView lineTransferCertificatesFooterView
 @param sender 点击的按钮 1001.提交 1002.下一步
 */
- (void)lineTransferCertificatesFooterView:(YXLineTransferCertificatesFooterView *)lineTransferCertificatesFooterView
                            andClickBUtton:(UIButton *)sender
{
    if (sender.tag == 1001) {
        if (self.isUploadImage == YXLineTransferControllerUploadImageNone) {
            //** 未选择图片 */
            [YXAlertViewTool showAlertView:self title:@"提示信息" message:@"请选择汇款凭证图片" confrimBlock:^{
                
            }];
            return;
        }
        
        if (self.isUploadImage == YXLineTransferControllerUploadImageLoding) {
            //** 图片上传中 */
            [YXAlertViewTool showAlertView:self title:@"提示信息" message:@"图片上传中，请稍后" confrimBlock:^{
                
            }];
            return;
        }
        
        if (self.isUploadImage == YXLineTransferControllerUploadImageFaild) {
            //** 上传图片失败 */
            [YXAlertViewTool showAlertView:self title:@"提示信息" message:@"图片上传失败，请重新上传" confrimBlock:^{
                
            }];
            return;
        }
        
        [[YXPayMentNetRequestTool sharedTool] offLineAddPayWithOrderId:[NSString stringWithFormat:@"%lld", self.orderId]
                                                           andProdName:self.paymentHomePageViewDataModel.prodName
                                                     andOrderPayAmount:self.paymentHomePageViewDataModel.payAmount
                                                         andPaymentUrl:self.currentUploadImageProgressModel.successImageUrlString
                                                          andOrderType:self.paymentHomePageViewDataModel.transType
                                                               success:^(id objc, id respodHeader) {
                                                                   
                                                                   if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                       //** 成功，跳转成功页面 */
                                                                       [self.navigationController pushViewController:[self setupSuccessViewController] animated:YES];
                                                                   }else{
                                                                       
                                                                   }
                                                                   
                                                               } failure:^(NSError *error) {
                                                                   
                                                               }];
        return;
    }
    
    if (sender.tag == 1002) {
        if (self.navigationController.viewControllers.count == 4) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        if (self.navigationController.viewControllers.count == 3) {
            YXOrderDetailViewController *detailController = [YXOrderDetailViewController orderDetailViewControllerWithOrderId:self.orderId andExtend:self];
            [self.navigationController pushViewController:detailController animated:YES];
        }
        return;
    }
}

#pragma mark <UIImagePickerControllerDelegate>

/**
 多媒体设备调用回调

 @param picker picker
 @param info 获取内容
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [UIImage new];
    if (self.type == 1) {
        //** 相机 */
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else if (self.type == 2) {
        //** 相册 */
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }

    CGSize imageSize = CGSizeMake(lineTransferMaxImageWidth, image.size.height / image.size.width * lineTransferMaxImageWidth);
    [self currentUploadImageProgressModel].compressImage = [UIImage OriginImage:image scaleToSize:imageSize];
    [self currentUploadImageProgressModel].selectedImage = image;
    [self currentUploadImageProgressModel].progress = 0;
    self.currentUploadImageProgressModel = [self currentUploadImageProgressModel];
    
    [self uploadImageWithProgressModel:[self currentUploadImageProgressModel]];
}

/**
 上传图片

 @param model model
 */
- (void)uploadImageWithProgressModel:(YXSendAuctionProgressModel *)model
{
    self.sureButton.enabled = YES;
    [[YXPayMentNetRequestTool sharedTool] upLoadImageWithUrlString:LINETRANSFERUPLOADIMAGE_URL andImage:_currentUploadImageProgressModel andImageNamed:@"offlinePayPic" success:^(id objc, id respodHeader) {
        
        self.isUploadImage = YXLineTransferControllerUploadImageSuccessed;
        //** 成功回调后，给模型赋值 */
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            //** 成功 */
            _currentUploadImageProgressModel.successImageUrlString = (NSString *)objc;
            _currentUploadImageProgressModel.progress = 1;
        }else{
            YXLog(@"凭证上传失败：%@", objc);
            self.isUploadImage = YXLineTransferControllerUploadImageFaild;
        }
        
    } failure:^(NSError *error) {
        self.isUploadImage = YXLineTransferControllerUploadImageFaild;
    }];
    
    self.isUploadImage = YXLineTransferControllerUploadImageLoding;
}

/**
 点击dismiss

 @param picker picker
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)PopToRootVC
{
//    YXMyOrderDeatilViewController *myOrderDeatilViewController = [[YXMyOrderDeatilViewController alloc] init];
//    myOrderDeatilViewController.orderId = self.dataModel.orderId;
//    myOrderDeatilViewController.hasAddress = 1;
//    myOrderDeatilViewController.sourceViewController = [[YXPaymentHomePageController alloc]init];
//    [self.navigationController pushViewController:myOrderDeatilViewController animated:NO];

}
#pragma mark <YXLineTransferCertificatesCellDelegate>

/**
 图片上传失败后，点击重新上传

 @param lineTransferCertificatesCell    cell
 @param sender                          参数
 */
- (void)lineTransferCertificatesCell:(YXLineTransferCertificatesCell *)lineTransferCertificatesCell reUploadImage:(id)sender
{
    [self uploadImageWithProgressModel:self.currentUploadImageProgressModel];
}

/**
 提交和选择凭证按钮点击事件

 @param lineTransferCertificatesCell    cell
 @param clickButton                     点击的按钮
 */
- (void)lineTransferCertificatesCell:(YXLineTransferCertificatesCell *)lineTransferCertificatesCell clickButton:(UIButton *)clickButton
{
    if (self.isUploadImage == YXLineTransferControllerUploadImageLoding) {
        //** 图片上传中 */
        [YXAlertViewTool showAlertView:self title:@"提示信息" message:@"图片处理中，请稍后" confrimBlock:^{
            
        }];
        return;
    }
    
    if ([clickButton.titleLabel.text isEqualToString:@"删除"]) {
        self.sureButton.enabled = YES;
        self.isUploadImage = YXLineTransferControllerUploadImageNone;
        self.paymentHomePageViewDataModel.offlineCertificatesImageUrlString = @"";
        self.currentUploadImageProgressModel = nil;
        return;
    }
    
    if (!clickButton) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
       
        UIAlertAction *camerAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openCamerController];
        }];
        
        UIAlertAction *photoLibryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openPhotoLibaryController];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:camerAction];
        [alertController addAction:photoLibryAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
}

/**
 打开相机
 */
- (void)openCamerController
{
    self.type = 1;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }else{
        YXLog(@"没有摄像头");
    }
}

/**
 打开相册
 */
- (void)openPhotoLibaryController
{
    self.type = 2;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:^{
            YXLog(@"打开相册");
        }];
    }else{
        YXLog(@"不能打开相册");
    }
}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 @param tableView tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        YXPaymentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentHomePageControllerDetailCellReusableIdentifier forIndexPath:indexPath];
        cell.deatilmodle = self.paymentHomePageViewDataModel;
        return cell;
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        YXLineTransferPayeeInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentLineTransferControllerPayeeInformationReusableIdentifier forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        YXLineTransferCertificatesCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentLineTransferControllerCertificatesReusableIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        cell.progressModel = _currentUploadImageProgressModel;
        cell.dataModel = self.paymentHomePageViewDataModel;
        return cell;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YXPaymentTypeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    if (!headerView) {
        headerView = [[YXPaymentTypeHeaderView alloc] initWithReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    }
    //headerView.dingdanNumber = self.paymentHomePageViewDataModel.orderId;
    if (section == 0) headerView.type = YXPaymentTypeHeaderViewDetailHeader;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    YXLineTransferCertificatesFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXPaymentLineTransferControllerCertificatesFooterViewReusableIdentifier];
    if (!footerView) {
        footerView = [[YXLineTransferCertificatesFooterView alloc] initWithReuseIdentifier:kYXPaymentLineTransferControllerCertificatesFooterViewReusableIdentifier];
    }
    footerView.delegate = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90.f;
}

#pragma mark <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 121.f;
    if (indexPath.row == 1) return 121.f;
    return 181.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 配置界面 */
    [self setupCustomUI];
    //** 注册控件 */
    [self registerSubViews];
    //** 加载网络数据 */
    [self queryPayData];
    
    [self setNavRightItems];
    
}

#pragma mark - Sixth.界面配置
/**
 添加消息item
 */
-(void)setNavRightItems
{
    UIButton *Rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Rightbtn setImage:[UIImage imageNamed:@"ico_payNews"] forState:UIControlStateNormal];
    [Rightbtn addTarget:self action:@selector(ClickNews) forControlEvents:UIControlEventTouchUpInside];
    Rightbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}
-(void)ClickNews
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];
}
/**
 配置自定义UI界面
 */
- (void)setupCustomUI
{
    [self.view addSubview:self.contentTableView];
    //[self.view addSubview:self.sureButton];
    self.contentTableView.backgroundColor = [UIColor themLightGrayColor];
    self.title = @"网银转账汇款";
}

/**
 注册子控件
 */
- (void)registerSubViews
{
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXPaymentDetailCell class]) bundle:nil] forCellReuseIdentifier:kYXPaymentHomePageControllerDetailCellReusableIdentifier];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXLineTransferPayeeInformationCell class]) bundle:nil] forCellReuseIdentifier:kYXPaymentLineTransferControllerPayeeInformationReusableIdentifier];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXLineTransferCertificatesCell class]) bundle:nil] forCellReuseIdentifier:kYXPaymentLineTransferControllerCertificatesReusableIdentifier];
    [self.contentTableView registerClass:[YXPaymentTypeHeaderView class] forHeaderFooterViewReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
}

#pragma mark - Seventh.懒加载

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    }
    return _contentTableView;
}

- (UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO; //可编辑
    }
    return _imagePickerController;
}

- (UIButton *)sureButton
{
    if (!_sureButton) {
        CGFloat sureButtonHeight = 44.f;
        _sureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - sureButtonHeight, self.view.bounds.size.width, sureButtonHeight)];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitle:@"提交" forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageNamed:@"ic_sendAuction_compose_dis"] forState:UIControlStateDisabled];
    }
    return _sureButton;
}

- (YXSendAuctionProgressModel *)currentUploadImageProgressModel
{
    if (!_currentUploadImageProgressModel) {
        _currentUploadImageProgressModel = [YXSendAuctionProgressModel new];
    }
    return _currentUploadImageProgressModel;
}

#pragma mark Eighth.加载网络数据

/**
 获取网络数据
 */
- (void)queryPayData
{
    __weak YXLineTransferController *weakSelf = self;
    [[YXPayMentNetRequestTool sharedTool] queryPayWithOrderId:[NSString stringWithFormat:@"%lld",self.orderId] success:^(id objc, id respodHeader) {
        @try {
            self.paymentHomePageViewDataModel = [YXPaymentHomepageViewDataModel mj_objectWithKeyValues:objc];
//            self.offlineCertificatesImageUrlString = objc[@"offlineCertificatesImageUrlString"];
//            self.sureButton.enabled = self.offlineCertificatesImageUrlString ?  NO : YES;
        } @catch (NSException *exception) {
        } @finally {
            //** 刷新界面 */
            NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            [weakSelf.contentTableView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
}

/**
 查看是否含有原凭证图片url

 @return YES有 NO没有
 */
- (BOOL)checkIsHaveOffLineSuccessedImageUrlString
{
    if (self.paymentHomePageViewDataModel.offlineCertificatesImageUrlString
        && self.paymentHomePageViewDataModel.offlineCertificatesImageUrlString.length != 0
        && ![self.paymentHomePageViewDataModel.offlineCertificatesImageUrlString isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // [YXNotificationTool addObserver:self selector:@selector(PopToRootVC) name:@"POPTOROOTVC" object:nil];
    self.tabBarController.tabBar.hidden = YES;
}
@end
