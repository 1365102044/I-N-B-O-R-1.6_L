
#import <UIKit/UIKit.h>

/** 首页-轮播器切换图片间隔 */
CGFloat const kYXHomePagePictureCarouselViewChangePictureTime = 2.0;

/** 首页-轮播器高度 */
CGFloat const kYXHomePagePictureCarouselViewHeight = 210;

/** 首页-轮播器PageControl的右边距 */
CGFloat const kYXHomePagePictureCarouselPageControlRightMargin = -10;

/** 首页-轮播器PageControl的中心位置距离轮播器底部的间距 */
CGFloat const kYXHomePagePictureCarouselPageControlCenterY = -15;

/** 首页-轮播器描述label的高度 */
CGFloat const kYXHomePagePictureCarouselDetailLabelHeight = 34;

/** 首页-轮播器描述label的左边距 */
CGFloat const kYXHomePagePictureCarouselDetailLabelLeftInsets = 15;

/** 首页-商品类别选择器高度 */
CGFloat const kYXHomePageSectionHeaderHeight = 40;

/** 首页-商品类别选择器中指示器高度 */
CGFloat const kYXHomePageIndicatorViewHeight = 2;

/** 首页-商品类别选择器中添加分类按钮宽度 */
CGFloat const kYXHomePageAddCategoryButtonWidth = 37;

/** 首页-商品类别选择器中分割线宽度 */
CGFloat const kYXHomePageSeparationViewWidth = 1;

/** 首页-商品类别选择器中按钮宽度 */
CGFloat const kYXHomePageTitlesViewButtonWidth = 130;

/** 首页-商品列表图片下商品类\名\价格\计时器,视图高度 */
CGFloat const kYXHomePageGoodListGoodNameViewHeight = 40;

/** 首页-商品列表下拉刷新，通知名 */
NSString * const kYXHomePageDropUpLoadHomePageNewGoodListNotification = @"kYXHomePageDropUpLoadHomePageNewGoodListNotification";

/** 首页-商品列表下拉刷新，通知名 */
NSString * const kYXHomePageDropDownLoadHomePageOldGoodListNotification = @"kYXHomePageDropDownLoadHomePageOldGoodListNotification";

/** 首页-商品cell最大高度，通知名 */
NSString * const kYXHomePageMaxRowHeightNotification = @"kYXHomePageMaxRowHeightNotification";

/** 首页-切换layout，通知名 */
NSString * const kYXHomePageChangeLayoutNotification = @"kYXHomePageChangeLayoutNotification";


//** ------------------------- 我的 ------------------------- */

//** 我的寄拍--等待鉴定之重新鉴定跳转回寄拍界面的通知 */
NSString * const kYXMySendAuctionToSendAuctionModulNotification = @"kYXMySendAuctionToSendAuctionModulNotification";

//** 我的竞拍--正在竞拍之倒计时定时器通知 */
NSString * const kYXMyAuctionControllerCountDownTimerNotification = @"kYXMyAuctionControllerCountDownTimerNotification";

//** 我的竞拍--正在竞拍之cell开始倒计时，通知控制器添加定时器 */
NSString * const kYXMyAuctionCellCountDownTimeToControllerCreatTimerNotification = @"kYXMyAuctionCellCountDownTimeToControllerCreatTimerNotification";

//** ------------------------- 寄拍 ------------------------- */

//** 寄拍--图片查看器，点击删除 */
NSString * const kYXSendAuctionBrowserDelImageClickNotification = @"kYXSendAuctionBrowserDelImageClickNotification";

