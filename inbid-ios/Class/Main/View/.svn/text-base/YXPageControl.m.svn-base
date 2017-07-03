//
//  YXPageControl.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/7.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPageControl.h"

@interface YXPageControl()

@property (nonatomic, strong) UIImage* activeImage;
@property (nonatomic, strong) UIImage* inactiveImage;

@end

@implementation YXPageControl


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.activeImage = [UIImage imageNamed:@"ic_lunbog"];
    self.inactiveImage = [UIImage imageNamed:@"ic_lunbow"] ;
    
    return self;
}

-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView * dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage){
            [dot addSubview:[[UIImageView alloc] initWithImage:self.inactiveImage]];
        }else{
            [dot addSubview:[[UIImageView alloc] initWithImage:self.activeImage]];
        }
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    //修改图标大小
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 5;
        
        size.width = 5;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
    }
    
    
    [self updateDots];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    
    //修改图标大小
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 5;
        
        size.width = 5;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
    }
        [self updateDots];
}

@end
