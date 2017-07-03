//
//  YXSearchResultShaixuanTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchResultShaixuanTableViewCell.h"

@interface YXSearchResultShaixuanTableViewCell ()

{
    UILabel *titleLable;
    
    UIImageView *selectImage;
    
}

@end

@implementation YXSearchResultShaixuanTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath
{
    
    NSString *ID = [NSString stringWithFormat:@"HomeDeatiladdPriceList%ld",(long)[indexPath row]];
    YXSearchResultShaixuanTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[YXSearchResultShaixuanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, self.height)];
        titleLable.textColor = UIColorFromRGB(0x535353);
        titleLable.font = YXSFont(13);
        [self addSubview:titleLable];
        
        selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(YXScreenW-10-13, (self.height-10)/2, 13, 10)];
        selectImage.image = [UIImage imageNamed:@"ic_homePageScreenViewSelected"];
        [self addSubview:selectImage];
        selectImage.hidden = YES;
    
    }
    return self;
}
-(void)setTextstr:(NSString *)textstr
{
    _textstr = textstr;
    if (self.selected) {
        selectImage.hidden = NO;
    }
    
    titleLable.text = textstr;
    
}

-(void)setModle:(YXSearchModle *)modle
{
    _modle = modle;
    if (self.selected) {
        selectImage.hidden = NO;
    }
    titleLable.text = modle.catName;
}


@end
