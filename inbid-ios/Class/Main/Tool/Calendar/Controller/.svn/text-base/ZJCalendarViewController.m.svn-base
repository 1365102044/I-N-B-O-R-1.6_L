//
//  ZJCalendarViewController.m
//  Calendar
//
//  Created by 郑键 on 2017/2/26.
//  Copyright © 2017年 郑键. All rights reserved.
//

#import "ZJCalendarViewController.h"
#import "ZJCalendarMonthModel.h"
#import "ZJCalendarDayModel.h"
#import "ZJCalendarViewDayCell.h"
#import "ZJCalendarViewReusableHeaderView.h"
#import "ZJCalendarManager.h"
#import "ZJCalendarHeaderView.h"
#import "YXAlertViewTool.h"

static NSString * const kZJCalendarViewControllerItemReuseIdentifyId = @"kZJCalendarViewControllerItemReuseIdentifyId";

static NSString * const kZJCalendarViewControllerHeaderReuseIdentifyId = @"kZJCalendarViewControllerHeaderReuseIdentifyId";

@interface ZJCalendarViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

/**
 *  内容视图
 */
@property (nonatomic, strong) UICollectionView *contentCollectionView;

/**
 *  数据数组
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 *  选中的开始时间
 */
@property (nonatomic, assign) NSInteger startDate;

/**
 *  选中的结束时间
 */
@property (nonatomic, assign) NSInteger endTimeDate;

/**
 *  headerView
 */
@property (nonatomic, strong) ZJCalendarHeaderView *calendarHeaderView;

/**
 *  底部确定按钮视图
 */
@property (nonatomic, strong) UIView *bottomButtonView;

@end

@implementation ZJCalendarViewController

#pragma mark - Event

- (void)sureButtonClick:(UIButton *)sender
{
    /**
     *  判断时间是否超出指定范围，并弹窗提示
     */
    if ([self getDifferenceByDate:self.startDate otherDate:self.endTimeDate] + 1 > 30) {
        
        [self showTipsWithObjc:@{@"errorMsg":@"请选择30天以内"}];
        
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarViewController:userSelectedStartTime:userSelectedEndTime:)]) {
        [self.delegate calendarViewController:self userSelectedStartTime:self.startDate userSelectedEndTime:self.endTimeDate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 计算时间差
 
 @param date        date
 @return            时间差的天数
 */
- (NSInteger)getDifferenceByDate:(NSInteger)date otherDate:(NSInteger)otherDate
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:otherDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags
                                           fromDate:startDate
                                             toDate:endDate
                                            options:0];
    return [comps day];
}

#pragma mark - Setter

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.contentCollectionView reloadData];
}

#pragma mark - Delegate

#pragma mark <DataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZJCalendarMonthModel *monthModel = self.dataArray[section];
    return monthModel.daysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJCalendarViewDayCell *dayCell = [collectionView dequeueReusableCellWithReuseIdentifier:kZJCalendarViewControllerItemReuseIdentifyId forIndexPath:indexPath];
    ZJCalendarMonthModel *monthModel = self.dataArray[indexPath.section];
    ZJCalendarDayModel *dayModel = monthModel.daysArray[indexPath.item];
    
    dayModel.dayStatus = 0;
    if (dayModel.dateInterval == self.startDate) {
        dayModel.dayStatus = 1;
    }
    
    if (dayModel.dateInterval == self.endTimeDate) {
        dayModel.dayStatus = 3;
    }
    
    if (dayModel.dateInterval > self.startDate
        && dayModel.dateInterval < self.endTimeDate) {
        dayModel.dayStatus = 2;
    }
    
    dayCell.dayModel = dayModel;
    return dayCell;
}

#pragma mark <Delegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZJCalendarViewReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                          withReuseIdentifier:kZJCalendarViewControllerHeaderReuseIdentifyId forIndexPath:indexPath];
        headerView.monthModel = self.dataArray[indexPath.section];
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJCalendarMonthModel *monthModel        = self.dataArray[indexPath.section];
    ZJCalendarDayModel *dayModel            = monthModel.daysArray[indexPath.row];
    
    if (dayModel.day <= 0) return;
    
    /**
     *  确定开始时间
     */
    if (self.startDate == 0) {
        
        self.startDate = dayModel.dateInterval;
        self.calendarHeaderView.startTime = dayModel.dateInterval;
        
    } else if (self.startDate > 0
               && self.endTimeDate > 0) {
        
        self.startDate = dayModel.dateInterval;
        self.endTimeDate = 0;
        self.calendarHeaderView.startTime = dayModel.dateInterval;
        
    } else {
        
        if (self.startDate < dayModel.dateInterval) {
            
            /**
             *  选择结束时间成功
             */
            self.endTimeDate = dayModel.dateInterval;
            self.calendarHeaderView.endTime = dayModel.dateInterval;
            
        } else {
            
            self.startDate = dayModel.dateInterval;
            self.calendarHeaderView.startTime = dayModel.dateInterval;
        }
        
    }
    
    /**
     *  刷新列表
     */
    [self.contentCollectionView reloadData];
}

/**
 *  返回itemSize
 */
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.contentCollectionView.bounds.size.width / 7,
                      self.contentCollectionView.bounds.size.width / 7);
}

/**
 *  最小垂直间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

/**
 *  最小水平间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

/**
 *  四周间距
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(ADJUST_PERCENT_FLOAT(0.f), ADJUST_PERCENT_FLOAT(0.f), ADJUST_PERCENT_FLOAT(0.f), ADJUST_PERCENT_FLOAT(0.f));
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupCustomUI];
    [self registerSubView];
}

#pragma mark - UI

- (void)setupCustomUI
{
    [self.view addSubview:self.calendarHeaderView];
    [self.view addSubview:self.contentCollectionView];
    [self.view addSubview:self.bottomButtonView];
    self.title = @"选择查询日期";
}

- (void)registerSubView
{
    [self.contentCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJCalendarViewDayCell class])
                                                           bundle:nil]
                 forCellWithReuseIdentifier:kZJCalendarViewControllerItemReuseIdentifyId];
    [self.contentCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJCalendarViewReusableHeaderView class])
                                                           bundle:nil]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:kZJCalendarViewControllerHeaderReuseIdentifyId];
}

#pragma mark - LazyLoad

- (UIView *)bottomButtonView
{
    if (!_bottomButtonView) {
        
        _bottomButtonView                                   = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                                       self.view.bounds.size.height - 80,
                                                                                                       self.view.bounds.size.width,
                                                                                                       80)];
        _bottomButtonView.backgroundColor                   = [UIColor whiteColor];
        
        CAShapeLayer *layer                                 = [[CAShapeLayer alloc] init];
        UIBezierPath *path                                  = [UIBezierPath bezierPathWithRect: CGRectMake(0,
                                                                                                           0,
                                                                                                           _bottomButtonView.bounds.size.width,
                                                                                                           1)];
        layer.path                                          = path.CGPath;
        layer.fillColor                                     = [UIColor themGrayColor].CGColor;
        [_bottomButtonView.layer addSublayer:layer];
        
        UIButton *sureButton = [[UIButton alloc] init];
        [_bottomButtonView addSubview:sureButton];
        
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureButton setBackgroundColor:[UIColor mainThemColor]];
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomButtonView);
            make.left.mas_equalTo(_bottomButtonView).mas_offset(15);
            make.right.mas_equalTo(_bottomButtonView).mas_offset(-15);
            make.height.mas_equalTo(44);
        }];
    }
    return _bottomButtonView;
}

- (ZJCalendarHeaderView *)calendarHeaderView
{
    if (!_calendarHeaderView) {
        _calendarHeaderView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZJCalendarHeaderView class]) owner:nil options:nil].lastObject;
        _calendarHeaderView.frame = CGRectMake(0,
                                               64,
                                               self.view.bounds.size.width,
                                               150);
    }
    return _calendarHeaderView;
}

- (UICollectionView *)contentCollectionView
{
    if (!_contentCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset                 = UIEdgeInsetsMake(0, 0, 0, 0);
//        flowLayout.minimumLineSpacing           = 0;
//        flowLayout.minimumInteritemSpacing      = 0;
//        flowLayout.itemSize                     = CGSizeMake(YXScreenW / 7.f,
//                                                             YXScreenW / 7.f);
        flowLayout.headerReferenceSize          = CGSizeMake(YXScreenW,
                                                             50);
        
        /**
         *  解决item无法满屏有间隙问题
         */
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat offsetWidth = (NSInteger)width % 7;
        CGFloat pointX = offsetWidth == 0 ? 0 : (7-offsetWidth)/2;
        
        _contentCollectionView                  = [[UICollectionView alloc] initWithFrame:CGRectMake(-pointX,
                                                                                                     CGRectGetMaxY(self.calendarHeaderView.frame),
                                                                                                     self.view.bounds.size.width + pointX * 2,
                                                                                                     self.view.bounds.size.height - 150) collectionViewLayout:flowLayout];
        _contentCollectionView.delegate         = self;
        _contentCollectionView.dataSource       = self;
        _contentCollectionView.backgroundColor  = [UIColor whiteColor];
        _contentCollectionView.contentInset     = UIEdgeInsetsMake(0,
                                                                   0,
                                                                   124,
                                                                   0);
        
    }
    return _contentCollectionView;
}

#pragma mark - LoadData

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZJCalendarManager *manager = [[ZJCalendarManager alloc]initWithShowChineseHoliday:NO showChineseCalendar:NO startDate:self.startDate];
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:12 type:ZJCalendaerViewControllerNone];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataArray = tempDataArray.copy;
        });
    });
}

#pragma mark - Other

/**
 显示提示
 
 @param objc objc
 */
- (void)showTipsWithObjc:(id)objc
{
    if ([objc[@"errorMsg"] isKindOfClass:[NSString class]]) {
        NSString *errorTips;
        @try {
            errorTips = objc[@"errorMsg"];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        [YXAlertViewTool showAlertView:self title:@"提示" message:errorTips confrimBlock:^{
            
        }];
        return;
    }
    
    NSDictionary *errorMsg;
    NSString *ret_msg;
    @try {
        errorMsg = objc[@"errorMsg"];
        ret_msg = objc[@"ret_msg"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [YXAlertViewTool showAlertView:self title:@"提示" message:ret_msg confrimBlock:^{
        
    }];
}

@end
