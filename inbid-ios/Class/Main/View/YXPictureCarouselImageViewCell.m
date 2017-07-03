//
//  YXPictureCarouselImageViewCell.m
//  图片轮播器 PictureCarousel
//
//  Created by 郑键 on 16/8/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPictureCarouselImageViewCell.h"
#import "YXContentLabel.h"
//#import "YXHomePageAdverts.h"
#import "YXHomeDeatilImgesModle.h"
#import "YXProjectImageConfigManager.h"

@interface YXPictureCarouselImageViewCell()
//** 描述label */
@property (nonatomic, strong)YXContentLabel *detailLabel;

@property(nonatomic,strong) UILabel  * desclable;

@property(nonatomic,assign)  CGFloat HeiGht;
@property(nonatomic,assign) CGFloat  WiTdh;

@property(nonatomic,assign) NSInteger  imagelocationStatus;


@end

@implementation YXPictureCarouselImageViewCell


#pragma mark - 赋值

////** 重写模型setter方法 */
//- (void)setAdvertsModel:(YXHomePageAdverts *)advertsModel
//{
//    _advertsModel = advertsModel;
//    
////    [self.imageView sd_setImageWithURL:[NSURL URLWithString:advertsModel.imgUrl]];
////    self.detailLabel.text = advertsModel.imgDesc;
//}
//


-(void)setImagedesc:(NSString *)imagedesc
{
    _imagedesc = imagedesc;
    self.desclable.hidden = NO;
    if (imagedesc) {
       self.desclable.text = imagedesc;
    }else{
        self.desclable.hidden = YES;
    }

}

//** -------重写模型setter方法--非模型数据 -----------**/
- (void)setImageUrl:(NSString *)imageUrl
{
    
//    NSRange widthStartRange = [imageUrl rangeOfString:@"w="];
//    NSRange endRange = [imageUrl rangeOfString:@"&"];
//    NSRange widthRange = NSMakeRange(widthStartRange.location + widthStartRange.length, endRange.location - widthStartRange.location - widthStartRange.length);
//    NSString *width = [imageUrl substringWithRange:widthRange];
//    double wid = [width doubleValue];
//    
//    //342
//    
//    NSRange heightStartRange = [imageUrl rangeOfString:@"h="];
//    NSRange heightEndRange = [imageUrl rangeOfString:@"&s"];
//    NSRange heightRange = NSMakeRange(heightStartRange.location + heightStartRange.length, heightEndRange.location - heightStartRange.location - heightStartRange.length);
//    NSString *height = [imageUrl substringWithRange:heightRange];
//    double heig = [height doubleValue];
    
    // 563
    
//    double whScanle = wid/heig;
//    
//    double WI = whScanle*342;
//    double HE = YXScreenW/whScanle;
//    
//    if (WI <= YXScreenW) {
//        self.WiTdh = WI;
//        self.HeiGht = 342;
//        
//    }else
//    {
//        self.WiTdh = YXScreenW;
//        self.HeiGht = HE;
//        self.imagelocationStatus = 1;
//    }
    
    self.WiTdh = YXScreenW;
    if (iPHone6Plus) {
        self.HeiGht = 378;
    }else if (iPHone6)
    {
        self.HeiGht=342;
        
    }else if (iPHone5)
    {
        self.HeiGht = 292;
    }else{
        self.HeiGht = 342;
    }
    
    
    _imageUrl = [NSString stringWithFormat:@"%@",[imageUrl componentsSeparatedByString:@"?"].firstObject];
    _imageUrl = [YXProjectImageConfigManager projectImageConfigManagerWithImageUrlString:_imageUrl configType:YXProjectImageConfigMidSS];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
    
    [self layoutSubviews];
    
    
}


#pragma mark - 初始化

//** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupPictureCarouselImageViewCellUI];
    }
    return self;
}

//** 布局界面 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
  

    self.imageView.frame = CGRectMake((YXScreenW-self.WiTdh)/2, (self.height-self.HeiGht)/2, self.WiTdh, self.HeiGht);
    
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kYXHomePagePictureCarouselDetailLabelHeight);

    }];
    
    [self.desclable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.mas_equalTo(self.contentView);
        make.left.equalTo(self.detailLabel).with.offset(10);
        make.top.equalTo(self.detailLabel).with.offset(0);

        make.width.offset(YXScreenW-160);
        make.height.mas_equalTo(kYXHomePagePictureCarouselDetailLabelHeight);
    }];
    
}

#pragma mark - 配置界面

//** 配置界面 */
- (void) setupPictureCarouselImageViewCellUI
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.desclable];
}



#pragma mark - 懒加载

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"ic_zhanwf"];
//        [_imageView sizeToFit];
    }
    return _imageView;
}

- (YXContentLabel *)detailLabel
{
    if (!_detailLabel) {
        
        _detailLabel = [[YXContentLabel alloc] init];
        _detailLabel.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        _detailLabel.textInsets = UIEdgeInsetsMake(0, kYXHomePagePictureCarouselDetailLabelLeftInsets, 0, 0);
        _detailLabel.hidden = YES;
    }
    return _detailLabel;
}

-(UILabel *)desclable
{
    if (!_desclable) {
    
        _desclable = [[UILabel alloc]init];
        _desclable.font = YXRegularfont(15);
        _desclable.textColor = [UIColor whiteColor];
//        _desclable.backgroundColor = [UIColor redColor];
        _desclable.hidden = YES;
        
    }

    return _desclable;
}


@end
