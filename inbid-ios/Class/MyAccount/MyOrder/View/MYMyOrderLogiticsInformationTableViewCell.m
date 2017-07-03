//
//  MYMyOrderLogiticsInformationTableViewCell.m
//  inbid-ios
//
//  Created by 1 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "MYMyOrderLogiticsInformationTableViewCell.h"

@interface  MYMyOrderLogiticsInformationTableViewCell()

{
    
    UILabel *wuliutitlelable;
    
    UIImageView *imageview;
    UILabel*contentLable;
    UILabel*timeLable;
    NSIndexPath *Index;
    NSInteger  dataCount;
    
}


@end
@implementation MYMyOrderLogiticsInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath dataCount:(NSInteger )dataCount{
    
    NSString *ID = [NSString stringWithFormat:@"logictsInformationList%ld",(long)[indexPath row]];
    MYMyOrderLogiticsInformationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[MYMyOrderLogiticsInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID indexpath:indexPath dataCount:dataCount];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSIndexPath*)indexpath dataCount:(NSInteger)datacount
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
        Index = indexpath;
        dataCount = datacount;
        
        imageview = [[UIImageView alloc]init];
        imageview.layer.cornerRadius = 7;
        imageview.layer.masksToBounds = 7;

        contentLable = [[UILabel alloc]init];
        contentLable.numberOfLines = 0;

        timeLable = [[UILabel alloc]init];
        timeLable.font = YXRegularfont(9);
        timeLable.textColor = UIColorFromRGB(0x050505);
        timeLable.alpha = 0.8;

        wuliutitlelable = [[UILabel alloc]init];
        wuliutitlelable.font = YXRegularfont(13);
        wuliutitlelable.textColor = UIColorFromRGB(0x1a1a1a);
        wuliutitlelable.text = @"物流进度";
        
        if (indexpath.row==0) {
            
        [self addSubview:wuliutitlelable];
            
        }else if (indexpath.row==1) {
            
            imageview.image = [UIImage imageNamed:@"WuliuRows1"];
            [self.contentView addSubview:timeLable];
            [self.contentView addSubview:contentLable];
           [self.contentView addSubview:imageview];
        }else if(indexpath.row>1){
            
            imageview.image = [UIImage imageNamed:@"WuliuRowsOther"];
            [self.contentView addSubview:timeLable];
            [self.contentView addSubview:contentLable];
           [self.contentView addSubview:imageview];
        }
        
        
    }
    return self;
}

-(void)setListmodle:(YXMyOrderLoginticsInformationListModle *)listmodle{

    _listmodle = listmodle;
    
    
    
    NSString *realroutstr = [NSString stringWithFormat:@"[%@]%@",listmodle.address,listmodle.remark];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithData:[realroutstr  dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:2.0];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
  [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(12) range:NSMakeRange(0, attrStr.length)];
    contentLable.attributedText = attrStr;
    [contentLable sizeToFit];
    
    
    timeLable.text = listmodle.time;
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    wuliutitlelable.frame = CGRectMake(10, 0, YXScreenW-20, 40);
    
    CGFloat igW=0 ;
    CGFloat igX ;
    CGFloat igY ;
    if (Index.row==1) {
        igW = 13;
        igX = 15;
        igY = 15;
    }else if (Index.row>1)
    {
        igW = 6;
        igX = 18.5;
        
    }
    imageview.frame = CGRectMake(igX, 15, igW, igW);
    
    CGFloat heig = [self getSpaceLabelHeight:contentLable.text withFont:YXRegularfont(12) withWidth:YXScreenW-50];
    
    contentLable.frame = CGRectMake(imageview.right+15, imageview.y-3, YXScreenW-50-10, heig);
    
    timeLable.frame = CGRectMake(contentLable.x, contentLable.bottom+5, contentLable.width, 15);

    
}

-(void)drawRect:(CGRect)rect
{

    if (Index.row==0) {
        return;
    }
    //    线条颜色
    UIColor *color = UIColorFromRGB(0xbab9b9);
    
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    
    
    CGFloat igW ;
    CGFloat igX ;
    if (Index.row==1) {
        igW = 13;
        igX = 15;
    }else if (Index.row>1)
    {
        igW = 6;
        igX = 18.5;
    }
    CGFloat PathX = igX+igW/2;
    
    CGFloat OrginY= 0;
    if (Index.row==1) {
        
        OrginY = imageview.bottom;
    }
    
    [path moveToPoint:CGPointMake(PathX, OrginY)];
    [path addLineToPoint:CGPointMake(PathX, igX)];
    [path stroke];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    CGFloat boomH = self.height;
    
    if (Index.row==dataCount) {
        boomH = self.height-10;
    }
    CGFloat imageBoomY;
    if (Index.row==1) {
        imageBoomY = igW+3.5;
    }else if (Index.row>1)
    {
        imageBoomY = igW;
    }
    path1.lineWidth = 1;
    [path1 moveToPoint:CGPointMake(PathX, imageBoomY)];
    [path1 addLineToPoint:CGPointMake(PathX,boomH)];
    [path1 stroke];
    
    
}
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineSpacing = 5;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
