//
//  YXUploadIDPhotoViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXUploadIDPhotoViewController.h"
#import "YXMyWalletUploadPhotoView.h"
#import "ImagePicker.h"
#import "twlt_uuid_util.h"
#import "YXWalletResultController.h"
#import "YXAlertViewTool.h"
#import "YXWalletAccountSecurityViewController.h"
#import "ZJCameraController.h"
@interface YXUploadIDPhotoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSArray * dataArr;
@property(nonatomic,strong) UIView * photoview;
@property(nonatomic,strong) UIImageView * justImageview;
@property(nonatomic,strong) UIImageView * backImageview;
@property(nonatomic,strong) NSData * justimagedata;
@property(nonatomic,strong) NSData * backimagedata;
@property(nonatomic,strong) UIButton * nextBtn;
@end

@implementation YXUploadIDPhotoViewController

/**
 点击方法
 */

-(void)UploadPhotoSelection:(NSString *)titleName{

    YXLog(@"----%@---",titleName);
    
    ZJCameraController *cameraController = [ZJCameraController cameraControllerCompliteBlock:^(UIImage *original, UIImage *currentImage) {
        
        if ([titleName isEqualToString:@"拍摄正面"]) {
            self.justimagedata = [self CompressImageWith:currentImage];
            self.justImageview.image = currentImage;
            
            [self checkparam];
            
        }else if([titleName isEqualToString:@"拍摄反面"]){
            self.backimagedata = [self CompressImageWith:currentImage];
            self.backImageview.image = currentImage;
            
            YXLog(@"=====beimian---%lu-",self.backimagedata.length/1024);
            [self checkparam];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationController pushViewController:cameraController animated:YES];
    
    
//    //设置主要参数
//    [[ImagePicker sharedManager] dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:1 allowsEditing:NO];
//
//    //回调
//    [[ImagePicker sharedManager] dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
//        
//    } pickerImagePic:^(UIImage *pickerImagePic) {
//
//        if ([titleName isEqualToString:@"拍摄正面"]) {
//            self.justimagedata = [self CompressImageWith:pickerImagePic];
//            if (self.justimagedata) {
//                self.justImageview.image = pickerImagePic;
//            }
//            [self checkparam];
//            YXLog(@"=====zhengmian---%lu-",self.justimagedata.length/1024);
//        }else if([titleName isEqualToString:@"拍摄反面"]){
//            self.backimagedata = [self CompressImageWith:pickerImagePic];
//            if (self.backimagedata) {
//                self.backImageview.image = pickerImagePic;
//            }
//            YXLog(@"=====beimian---%lu-",self.backimagedata.length/1024);
//            [self checkparam];
//        }
//    }];
}
/**
 是否选择图片
 */
-(void)checkparam{
    
    if (self.justimagedata ==nil||self.backimagedata==nil) {
        self.nextBtn.backgroundColor = UIColorFromRGB(0xcccccc);
        self.nextBtn.userInteractionEnabled = NO;
    }else{
        
        self.nextBtn.backgroundColor = [UIColor mainThemColor];
        self.nextBtn.userInteractionEnabled = YES;
    }
}
/**
 检查图片大小
 */
-(NSData *)CompressImageWith:(UIImage *)image{
    NSData *nowData =UIImagePNGRepresentation(image);
    if (nowData.length/1024/1024<4) return nowData;
    else {
        for (int i=10; i>=2; i=i-2) {
            nowData = UIImageJPEGRepresentation(image, i/10);
            if (i==2&&(nowData.length/1024/1024 >4))  {
                [YXAlertViewTool showAlertView:self title:@"提示" message:@"图片过大，请重选图片" confrimBlock:nil];
                return nil;
            }
            if (nowData.length/1024/1024<4)  i=1;
        }
        return nowData;
    }
}

#pragma mark  ******************* 上传头像的图片**********************

-(void)uploadPhotoRequest
{
    if (self.justimagedata ==nil||self.backimagedata==nil) {
        
        [YXAlearMnager ShowAlearViewWith:@"请选择照片" Type:2];
        return;
    }
    
    [YXNetworkHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    
    NSString *token = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
    
    NSString *uuid = twlt_uuid_create();
    
    if (token) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"id"];
    }else{
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"id"];
    }
    [manager.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    
    
    NSString *URLSTR = [NSString stringWithFormat:@"%@/api/wallet/uploadcardphoto",kOuternet];
    
    [manager POST:URLSTR parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //按照表单格式把二进制文件写入formData表单
        [formData appendPartWithFileData:self.justimagedata name:@"front_card" fileName:@"front_card" mimeType:@"image/png"];
    
        [formData appendPartWithFileData:self.backimagedata name:@"back_card" fileName:@"back_card" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
//        YXLog(@"++++%@+++",uploadProgress);
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
    
          YXLog(@"responseObject == %@--++--%@----", [self getResponseObjcWithTask:responseObject],[self getRespodHeaderWithTask:task]);
        
        if ([[self getRespodHeaderWithTask:task][@"Status"] isEqualToString:@"1"]) {
           
            //成功
            YXWalletResultController *walletResult = [YXWalletResultController walletResultControllerWithType:YXWalletResultControllerDefault extend:@{@"titleString":@"开通成功!",@"imageNamed":@"icon_openwalletsuccess",@"buttonTitle":@"返回",@"sourVcType":@"openwalletSuccess"}];
            [self.navigationController pushViewController:walletResult animated:YES];
        }else{
            
            [YXAlearMnager ShowAlearViewWith:[self getResponseObjcWithTask:responseObject][@"errorMsg"] Type:2];
        }
        [YXNetworkHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [YXNetworkHUD dismiss];
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =  @"上传证件照片";
    self.view.backgroundColor = YXBackMainColor;
    
    self.dataArr = @[@"拍摄正面",@"拍摄反面"];
    
    [self.view addSubview:self.tableview];
    
    self.tableview.tableFooterView = [self addupdatefooterview];
    
}
-(void)clicknexttoBtn:(UIButton *)sender{
    [self uploadPhotoRequest];
}

-(UIView *)addupdatefooterview{
    
    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 100)];
    
    UIButton *nextbtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, YXScreenW-30, 50)];
    [nextbtn addTarget:self action:@selector(clicknexttoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
//    nextbtn.backgroundColor = [UIColor mainThemColor];
    nextbtn.backgroundColor = UIColorFromRGB(0xcccccc);
    nextbtn.userInteractionEnabled = NO;
    [nextbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextbtn.titleLabel.font = YXSFont(15);
    nextbtn.layer.masksToBounds = YES;
    nextbtn.layer.cornerRadius  =4;
    [footerview addSubview:nextbtn];
    self.nextBtn = nextbtn;
    return footerview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 50;
    }
    return 215;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *str;
    str = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    if (indexPath.row==0) {
        
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, YXScreenW-20, 50)];
        titlelable.text = @"拍摄您的二代身份证原件，请保证网络良好";
        titlelable.font = YXSFont(14);
        titlelable.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titlelable];
        
    }else if (indexPath.row>0){
    
        YXMyWalletUploadPhotoView *photoview = [[YXMyWalletUploadPhotoView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 190)];
        photoview.nameStr = self.dataArr[indexPath.row-1];
        self.photoview = photoview;
        photoview.clickImageBlock = ^(NSString *titStr){
            [self UploadPhotoSelection:titStr];
        };
        if (indexPath.row==1) self.justImageview = photoview.photoimage;
        else if (indexPath.row==2) self.backImageview = photoview.photoimage;
        [cell.contentView addSubview:photoview];
        if (indexPath.row==1) {
            photoview.linetop.hidden = NO;
            photoview.lineboom.hidden = NO;
        }
    }
    
    return cell;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return _tableview;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}
//** 获取响应头 */
- (id)getRespodHeaderWithTask:(NSURLSessionTask *)task
{
    NSHTTPURLResponse *respond = (NSHTTPURLResponse *)task.response;
    return respond.allHeaderFields;
}
-(id)getResponseObjcWithTask:(id )responseObect{
    id json;
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:responseObect options:0 error:&error];
    if (error) {
        json = [[NSString alloc] initWithData:responseObect encoding:NSUTF8StringEncoding];
    }
    return json;
}
@end
