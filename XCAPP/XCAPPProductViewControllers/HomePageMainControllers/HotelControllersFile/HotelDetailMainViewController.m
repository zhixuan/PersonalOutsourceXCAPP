//
//  HotelDetailMainViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/30.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelDetailMainViewController.h"
#import "HotelMapAddressController.h"
#import "HotelCommentController.h"
#import "HotelIntroduceController.h"
#import "UserReserveHotelViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"

#import "HotelDetailHeaderView.h"
#import "HotelDetailTableViewCell.h"
#import "HotelRoomDetailView.h"
#import "ReviseMoveIntoDateView.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"

#import "UITableViewHotelRoomHeaderView.h"


#define KDetailHeaderViewHeight         (KHotelDetailHeaderViewHeight/3)

#define KBtnForCommentButtonTag         (1870711)
#define KBtnForHotelDetailBtnTag        (1870712)
#define KBtnForHotelMapInfoBtnTag       (1870713)

@interface HotelDetailMainViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,HotelDetailHeaderDelegate,HotelDetailTableViewCellDelegate,ReviseMoveIntoDateDelegate,UITableViewHotelRoomHeaderViewDelegate>

///头部标题
@property (nonatomic , weak)        UIView          *viewNavigationBar;
///左侧标题
@property (nonatomic , weak)        UIButton        *leftBarButton;
///右侧标题
@property (nonatomic , weak)        UIButton        *rightBarButton;

///中央可变动的文本内容
@property (nonatomic , weak)        UILabel         *titleContentLabel;

/*!
 * @breif 头部信息高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                         navigationBarHeight;
/*!
 * @breif 酒店信息
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation                *hotelDetailInformation;

#pragma mark - 酒店信息显示图
/*!
 * @breif 右侧推荐信息显示图
 * @See
 */
@property (nonatomic , weak)        UITableView             *mainTableView;


#pragma mark - 加载更多Cell
/*!
 * @breif 加载更多Cell
 * @See
 */
@property (nonatomic , weak)            HUILoadMoreCell             *loadMoreCell;

#pragma mark - 界面数据源
/*!
 * @breif 左侧界面数据源
 * @See
 */
@property (nonatomic , strong)          DataPage                    *dataSourceForIndexCell;


#pragma mark - 界面数据源
/*!
 * @breif 左侧界面数据源
 * @See
 */
@property (nonatomic , strong)          DataPage                    *dataSourceForHeaderCell;

#pragma mark - 网络请求链接
/*!
 * @breif 网络请求链接
 * @See
 */
@property (nonatomic , strong)          AFHTTPRequestOperation      *requestDataOperation;


/*!
 * @breif 头部酒店视图信息
 * @See
 */
@property (nonatomic , weak)            HotelDetailHeaderView       *hotelDetailTableHeaderView;


/*!
 * @breif 用户修改入住信息
 * @See
 */
@property (nonatomic , weak)      ReviseMoveIntoDateView           *userReviseMoveIntoDateView;

/*!
 * @breif 用户修改的数据内容
 * @See
 */
@property (nonatomic , strong)         NSString                     *userSelectedBeginDateStr;

/*!
 * @breif 用户修改的数据内容
 * @See
 */
@property (nonatomic , strong)         NSString                     *userSelectedEndDateStr;

/*!
 * @breif 用户修改的数据内容
 * @See
 */
@property (nonatomic , assign)         NSInteger                     userSelectedIntervalDay;

/*!
 * @breif 酒店房间详情信息
 * @See
 */
@property (nonatomic , assign)      HotelRoomDetailView             *hotelRoomDetailView;

/*!
 * @breif 标示数据数组
 * @See
 */

@property (nonatomic , strong)          NSMutableArray              *isCloseMutArray;


/*!
 * @breif 用户展开数据信息
 * @See
 */
@property (nonatomic , assign)      NSInteger                       userShowRoomDetailIndex;


@end


@implementation HotelDetailMainViewController
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE;
    }
    return self;
}

- (id)initWithHotelInfor:(UserHotelOrderInformation *)hotelInfor{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE;
        self.hotelDetailInformation = hotelInfor;
        self.dataSourceForIndexCell = [DataPage page];
        self.dataSourceForHeaderCell = [DataPage page];
        self.userSelectedIntervalDay = self.hotelDetailInformation.orderStayDayesQuantityInteger;
        self.userSelectedEndDateStr = [[NSString alloc]initWithString:self.hotelDetailInformation.orderForHotelEndDate];
        self.userSelectedBeginDateStr =[[NSString alloc]initWithString:self.hotelDetailInformation.orderForHotelBeginDate];
    }
    return self;
}


#pragma mark -
#pragma mark -  系统方法
- (void)viewWillAppear:(BOOL)animated
{
    [self viewdidNavigationControllerNavigationBarColorAlpha:0.0f];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    
    [self viewdidNavigationControllerNavigationBarColorAlpha:1.0f];
    [super viewWillDisappear:animated];
}
 


#pragma mark -
#pragma mark -  实时更改头部颜色
///实时更改头部颜色
- (void)viewdidNavigationControllerNavigationBarColorAlpha:(CGFloat)alpha{
    
    if (alpha < 0.5) {
        //去掉底部阴影条
        if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
            [self.navigationController.navigationBar setShadowImage:createImageWithColor([UIColor clearColor])];
        }
    }else{
        //去掉底部阴影条
        if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
            [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"TabItem_SelectionIndicatorImage"]];
            
        }
    }
    
    //设置背景
    UIImage* img = createImageWithColor(HUIRGBColor(5.0f, 54.0f, 126.0f,1.0f*alpha));
    if(img){
        if(HUISystemVersionBelow(kHUISystemVersion_7_0)){
            [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        }else{
            [self.navigationController.navigationBar setBackgroundImage:img
                                                         forBarPosition:UIBarPositionTopAttached
                                                             barMetrics:UIBarMetricsDefault];
            
        }
        //        [UIColor whiteColor];
    }else{
        UIColor* color = HUIRGBColor(5.0f, 54.0f, 126.0f,1.0f*alpha);
        if (color) {
            if(HUISystemVersionBelow(kHUISystemVersion_7_0)){
                self.navigationController.navigationBar.tintColor = color;
            }else{
                self.navigationController.navigationBar.barTintColor = color;
            }
        }
    }
    
    if(alpha > 0.7f){
//        NSLog(@"alpha is %lf",alpha);
        [self.titleContentLabel setText:self.hotelDetailInformation.orderHotelInforation.hotelNameContentStr];
    }else{
        [self.titleContentLabel setText:@""];
    }
    UIColor* withcolor = HUIRGBColor(5.0f, 54.0f, 126.0f,1.0f*alpha);
    //设置返回按钮颜色
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){
        [self.navigationController.navigationBar setTintColor:withcolor];
    }
}


- (void)setleftButtonEvent{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - 设置头部标题
///设置头部标题
- (void) settingNavTitle:(NSString *)title
{
    CGRect rcTileView = CGRectMake(KXCUIControlSizeWidth(90.0f), 0, (KProjectScreenWidth - KXCUIControlSizeWidth(180.0f)), 44);
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame: rcTileView];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    [titleTextLabel setTextAlignment:NSTextAlignmentCenter];
    titleTextLabel.textColor = [UIColor whiteColor];
    [titleTextLabel setFont:KXCAPPUIContentFontSize(20.0f)];
    [titleTextLabel setText:title];
    self.titleContentLabel = titleTextLabel;
    self.navigationItem.titleView = titleTextLabel;
}

#pragma mark -
#pragma mark - 设置左右BarButton信息
- (void)setRightNavButtonFA:(NSInteger)buttonType withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [navButton simpleButtonWithImageColor:[UIColor whiteColor]];
    [navButton addAwesomeIcon:buttonType beforeTitle:YES];
    
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    }
    self.rightBarButton = navButton;
    self.navigationItem.rightBarButtonItem = navItem;
}

- (void) setLeftNavButtonFA:(NSInteger)buttonType withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
//    [navButton setBackgroundColor:KDefaultNavigationWhiteBackGroundColor];
    
    navButton.titleLabel.font = [UIFont systemFontOfSize:self.navButtonSize];
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [navButton simpleButtonWithImageColor:[UIColor whiteColor]];
    [navButton setAwesomeIcon:buttonType];
    [navButton.layer setCornerRadius:22.0f];
    [navButton.layer setMasksToBounds:YES];
    
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    self.leftBarButton = navButton;

    self.navigationItem.leftBarButtonItem = navItem;
    [self.leftBarButton .layer setCornerRadius:20.0f];
    [self.leftBarButton .layer setMasksToBounds:YES];
    [self.leftBarButton setBackgroundColor:KDefaultNavigationWhiteBackGroundColor];
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}


- (HotelDetailHeaderView *)setupTableViewHeaderView{

    CGRect headerRect = CGRectMake(0.0f,0.0f, KProjectScreenWidth, KHotelDetailHeaderViewHeight);
    HotelDetailHeaderView * headerView = [[HotelDetailHeaderView alloc]initWithFrame:headerRect withOderInfor:nil];
    [headerView setDelegate:self];
    self.hotelDetailTableHeaderView = headerView;
    
    
    UILabel *hotelShowLabel = [[UILabel alloc]init];
    [hotelShowLabel setText:@"2015年开业......"];
    [hotelShowLabel setTextColor:KContentTextColor];
    [hotelShowLabel setTextAlignment:NSTextAlignmentLeft];
    [hotelShowLabel setFont:KXCAPPUIContentFontSize(15.0f)];
    [hotelShowLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(8.0f),
                                        KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    [self.hotelDetailTableHeaderView.hotelDetailBGView addSubview:hotelShowLabel];
    
    
    NSString *parkStr = @"";
    NSString *wifiStr = @"";
    NSInteger serviceCount = self.hotelDetailInformation.orderHotelInforation.hotelServiceContentArray.count;
    if ( serviceCount > 0) {
        NSString *parkImagePathStr = (NSString *)[self.hotelDetailInformation.orderHotelInforation.hotelServiceContentArray firstObject];
        if (!IsStringEmptyOrNull(parkImagePathStr)) {
            parkStr = @"免费停车场";
        }else{
            parkStr = @"收费停车场";
        }
        if (serviceCount > 1) {
            NSString *wifiImagePathStr = (NSString *)[self.hotelDetailInformation.orderHotelInforation.hotelServiceContentArray lastObject];
            if (!IsStringEmptyOrNull(wifiImagePathStr)) {
                wifiStr = @"免费WiFi";
            }
        }
    }
    
    UILabel *hotelRoomLabel = [[UILabel alloc]init];
    [hotelRoomLabel setText:[NSString stringWithFormat: @"%@\t%@\t%@",self.hotelDetailInformation.orderHotelInforation.hotelRankContentStr,parkStr,wifiStr]];
    [hotelRoomLabel setTextColor:KSubTitleTextColor];
    [hotelRoomLabel setTextAlignment:NSTextAlignmentLeft];
    [hotelRoomLabel setFont:KXCAPPUIContentFontSize(13.0f)];
    [hotelRoomLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                        (hotelShowLabel.bottom + KXCUIControlSizeWidth(3.0f)),
                                        KXCUIControlSizeWidth(260.0f), KXCUIControlSizeWidth(20.0f))];
    [self.hotelDetailTableHeaderView.hotelDetailBGView addSubview:hotelRoomLabel];
    
    [self.hotelDetailTableHeaderView.hotelAddressAtImageLabel setText:self.hotelDetailInformation.orderHotelInforation.hotelAddressRoughStr];

    [self.hotelDetailTableHeaderView.hotelAddressLabel setText:self.hotelDetailInformation.orderHotelInforation.hotelAddressRoughStr];
    
    NSDictionary *beginDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelBeginDate);
    NSDictionary *endDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelEndDate);
    
    NSString *titleInfor = [NSString stringWithFormat:@"%@ - %@   %zi晚",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),
                            StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),
                            self.hotelDetailInformation.orderStayDayesQuantityInteger];
    [self.hotelDetailTableHeaderView.hotelStayDayInforLabel setText:titleInfor];
    
    return headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNavTitle:@""];
    self.userShowRoomDetailIndex = NSIntegerMax;
    [self setLeftNavButtonFA:FMIconLeftReturn withFrame:CGRectMake(-5, 0.0f, 40, 40.0f) actionTarget:self action:@selector(setleftButtonEvent)];
    
      self.navigationBarHeight = self.navigationController.navigationBar.height + 20.0f;

    CGRect mainWebViewRect = CGRectMake(0.0f, -self.navigationBarHeight, KProjectScreenWidth, (self.view.height + self.navigationBarHeight));
    self.isCloseMutArray = [[NSMutableArray alloc]init];
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:mainWebViewRect
                                                      style:UITableViewStylePlain];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview setTableHeaderView:[self setupTableViewHeaderView]];
    
    tbview.backgroundColor =  KDefaultViewBackGroundColor;
    tbview.dataSource = self;
    tbview.delegate = self;
    [self.view addSubview:tbview];
    self.mainTableView = tbview;
//    __weak __typeof(&*self)weakSelf = self;
//    [self.mainTableView addPullToRefreshWithActionHandler:^(void){
//        [weakSelf refreshListData];
//    }];
//    ConfiguratePullToRefreshViewAppearanceForScrollView(tbview);
//    [tbview triggerPullToRefresh];
//
    
    
    CGRect frame = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    ReviseMoveIntoDateView *moveintoDateView = [[ReviseMoveIntoDateView alloc]initWithFrame:frame];
    [moveintoDateView setDelegate:self];
    self.userReviseMoveIntoDateView = moveintoDateView;
    [self.navigationController.view addSubview:self.userReviseMoveIntoDateView];
    
    NSDictionary *beginDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelBeginDate);
    NSDictionary *endDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelEndDate);
    
    [self.userReviseMoveIntoDateView setTextMoveInto:[NSString stringWithFormat:@"%@（%@）",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),StringForKeyInUnserializedJSONDic(beginDictionary, @"week")]];
    
    [self.userReviseMoveIntoDateView setTextLeaveDate:[NSString stringWithFormat:@"%@（%@）",StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),StringForKeyInUnserializedJSONDic(endDictionary, @"week")]];
    [self.userReviseMoveIntoDateView setTextStayRoomDay:[NSString stringWithFormat:@"%zi",self.hotelDetailInformation.orderStayDayesQuantityInteger]];
    
    [self refreshListData];
    
    HotelRoomDetailView *roomDetailView = [[HotelRoomDetailView alloc]initWithFrame:frame];
    self.hotelRoomDetailView = roomDetailView;
    [self.navigationController.view addSubview:self.hotelRoomDetailView];
    
    
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userRequestHotelDetailInforWithHotelID:self.hotelDetailInformation.orderHotelInforation.hotelIdStr completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list")  isKindOfClass:[NSArray class]]) {
                        
                        NSArray *hotelRoomArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        if (hotelRoomArray.count > 0) {
                            
                            NSMutableArray *dataInforArray = [NSMutableArray array];

                            for (NSDictionary *rommDic in hotelRoomArray) {
                                
                                [weakSelf.isCloseMutArray addObject:[NSNumber numberWithBool:NO]];

                                HotelInformation *itemTicket = [HotelInformation initializaionWithItemHotelRoomInformationForPolymerizeHeaderCellWithUnserializedJSONDic:rommDic];
                                [dataInforArray addObject:itemTicket];
                            }
                            
                            [weakSelf.dataSourceForHeaderCell appendPage:dataInforArray];
//                            [self.dataSourceForIndexCell appendPage:dataInforArray];
//                            [self.dataSourceForIndexCell setPageCount:1];
                            [weakSelf.mainTableView reloadData];
                        }
                        
                    }
                }
            }
        });
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshListData{
    
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有·数据
    [self.dataSourceForIndexCell cleanAllData];
    [self.mainTableView reloadData];
//    [self.isCloseMutArray removeAllObjects];
//    [self loadMoreListData];
}

- (void)loadMoreListData{
    [self setupHomeHotTopicInforControllerDataSource];
}

///设置热门信息信息内容(活动/装备/线路)
- (void)setupHomeHotTopicInforControllerDataSource{
    

    
    /*
     
     
     __weak __typeof(&*self)weakSelf = self;
     self.requestDataOperation =  [FMHTTPClient userPersonalTravelEquipmentResponseListInforWithPageNumber:self.dataSource.nextPageIndex rows:self.dataSource.pageSize userid:KLvYeCurrentUserInformation.userPerId  completion:^(WebAPIResponse *response) {
     
     dispatch_async(dispatch_get_main_queue(), ^(void){
     
     //关掉PullToRefreshView
     if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
     {
     UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
     [weakSelf.mainTableView.pullToRefreshView stopAnimating];
     }
     
     
     if (response.code == WebAPIResponseCodeSuccess) {
     NSLog(@"response.responseObject is %@",response.responseObject);
     
     
     if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
     NSDictionary  *dataDictionary = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
     
     
     if ([ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyList) isKindOfClass:[NSArray class]]) {
     NSArray *dataListArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyList);
     
     NSMutableArray *itemsArray = [NSMutableArray array];
     for (NSDictionary *itemDictionary in dataListArray) {
     
     LYTravelEquipmentInformation *itemClass = [LYTravelEquipmentInformation initializaionWithLYTravelEquipmentInformationWithUnserializedJSONDic:itemDictionary];
     [itemsArray addObject:itemClass];
     }
     [weakSelf.dataSource appendPage:itemsArray];
     }
     
     NSInteger totalPage = IntForKeyInUnserializedJSONDic(dataDictionary, KDataKeyPageTotal);
     [weakSelf.dataSource setPageCount:totalPage];
     [weakSelf.mainTableView reloadData];
     }else{
     if (self.loadMoreCell) {
     [self.loadMoreCell stopLoadingAnimation];
     if (response.code == WebAPIResponseCodeNetError) {
     self.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
     }else{
     self.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
     }
     }
     }
     }
     
     else if (response.code == WebAPIResponseCodeTokenError){
     if (self.loadMoreCell) {
     [self.loadMoreCell stopLoadingAnimation];
     self.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
     }
     RegisterBasicInforViewController *viewController = [[RegisterBasicInforViewController alloc]initWithPersonalLogin];
     [self.navigationController presentViewController:viewController animated:YES completion:^{
     }];
     
     }
     
     else{
     if (self.loadMoreCell) {
     [self.loadMoreCell stopLoadingAnimation];
     if (response.code == WebAPIResponseCodeNetError) {
     self.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
     }else{
     self.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
     }
     }
     }
     });
     }];
     */

//    __weak __typeof(&*self)weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^(void){
//        
//        //关掉PullToRefreshView
//        if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
//        {
//            UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
//            [weakSelf.mainTableView.pullToRefreshView stopAnimating];
//        }
//        
//        NSMutableArray *dataInforArray = [NSMutableArray array];
//        for (int index = 0; index < 18; index ++) {
//            
//            HotelInformation *itemHotel = [[HotelInformation alloc]init];
//            [itemHotel setHotelIdStr:@"001"];
//            [itemHotel setHotelNameContentStr:@"京都尚水商务会馆"];
//            [itemHotel setHotelRankContentStr:@"七星级"];
//            [itemHotel setHotelRealityUnitPriceFloat:458];
//            [itemHotel setHotelMorningMealContent:@"无早"];
//            [itemHotel setHotelRoomBerthContent:@"大床"];
//            [itemHotel setHotelAddressRoughStr:@"中关村、五道口"];
//            [itemHotel setHotelAllowCancelBool:NO];
//            [itemHotel setHotelRoomStyleExplanationContent:@"华滨景观房"];
//            [itemHotel setHotelRoomResidueCountInteger:index];
//            if (index%5==0) {
//                [itemHotel setHotelRoomResidueCountInteger:0];
//            }
//
//            [itemHotel setHotelCoordinate:CLLocationCoordinate2DMake(40.03481674194336, 116.3718872070312)];
//            [dataInforArray addObject:itemHotel];
//        }
//        
//        [self.dataSourceForIndexCell appendPage:dataInforArray];
//        [self.dataSourceForIndexCell setPageCount:1];
//        [self.mainTableView reloadData];
//    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;
    
    
    
    if (indexPath.row < [self.dataSourceForIndexCell.data count]) {
        return KHotelDetailTableViewCellHeight;
    }
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat heightForRow = 0.0f;
    
    if (section < [self.dataSourceForHeaderCell.data count]) {
        heightForRow = KUITableViewHotelRoomHeaderCellHeight;
    }
    return heightForRow;
}


#pragma mark - UITableViewDataSource


- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [self.dataSourceForIndexCell count]);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSourceForHeaderCell count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return  ([self.dataSourceForIndexCell count]);
    
    NSInteger numberOfRows = 0;
    if (section < self.isCloseMutArray.count) {
        
        NSNumber *boolNumber = (NSNumber *)[self.isCloseMutArray objectAtIndex:section];
        if ([boolNumber boolValue]) {
            numberOfRows = [self.self.dataSourceForIndexCell count];
        }
        
    }
    return  numberOfRows;
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
    {
        return CreateLoadMoreCell();
        
    }
    HotelDetailTableViewCell* cell = [[HotelDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                     reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSourceForIndexCell.data count]) {
        return;
    }
    
    HotelInformation *itemData = (HotelInformation *)[self.dataSourceForIndexCell.data objectAtIndex:(indexPath.row)];
    HotelDetailTableViewCell *hotelCell = (HotelDetailTableViewCell* )cell;
    [hotelCell setDelegate:self];
    [hotelCell setupDataSourceForIndexCell:itemData indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"TravelActiviesItemTableViewCell";
    BOOL isLoadMoreCell = [self _isLoadMoreCellAtIndexPath:indexPath];
    cellIdentifier = isLoadMoreCell? kHUILoadMoreCellIdentifier: cellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self createCellWithIdentifier:cellIdentifier];
    }
//    
    if (!isLoadMoreCell)
    {
        [self _configureCell:cell forRowAtIndexPath:indexPath];
    }
    
    else
    {
        self.loadMoreCell = (HUILoadMoreCell*)cell;
        if ([self.dataSourceForIndexCell canLoadMore])
        {
            __weak __typeof(&*self)weakSelf = self;
            [(HUILoadMoreCell*)cell setLoadMoreOperationDidStartedBlock:^{
                [weakSelf loadMoreListData];
            }];
            [(HUILoadMoreCell*)cell startLoadMore];
        }
        else
        {
            if (self.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading) {
                cell.textLabel.text = LOADMORE_LOADING;
            }else{
                cell.textLabel.text = LOADMORE_LOADOVER;
            }
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self _isLoadMoreCellAtIndexPath:indexPath]){
        return;
    }
    
    if (indexPath.row >= [self.dataSourceForIndexCell.data count]) {
        return;
    }
    
     HotelInformation *itemData = (HotelInformation *)[self.dataSourceForIndexCell.data objectAtIndex:(indexPath.row)];
    [self.hotelRoomDetailView setRoomTitle:itemData.hotelRoomStyleExplanationContent];
    
    
    
    NSString *detailContentStr = [NSString stringWithFormat:@"床型：\t%@\n宽带：\t%@\n面积：\t%@",itemData.hotelRoomBerthContent,itemData.hotelHasWiFiStr,itemData.hotelRoomAreaStr];
    
//    [self.hotelRoomDetailView setRoomDetailContent:@"床型：\t大床\n宽带：\t宽带Wi-Fi\n面积：\t50㎡\n楼层：\t8F\n床宽：\t1.80m\n无烟房：\t是" attribute:@[@"大床：",
//                                                                                                                                @"宽带：",@"面积：",
//                                                                                                                                @"宽带：",@"楼层：",
//                                                                                                                                @"床宽：",@"无烟房："]];
    [self.hotelRoomDetailView setRoomDetailContent:detailContentStr attribute:@[itemData.hotelRoomBerthContent,itemData.hotelHasWiFiStr,itemData.hotelRoomAreaStr]];
    CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self.hotelRoomDetailView setFrame:layerViewRect];
    }];
//    
//    
//    
//    
//    : ͉̣͉̣͇͖̪͖̲͚s̵͖̺̥͔͇̰̹̮͙͉̻̼̭̻͕̮͇ͨͬͪ͗̇̑̽͋̀j̶̋̊͌ͧͨͭ̓̅͐ͥ̂̔̊ͧ͊҉̶̵̞̩̦̳̺̳̬a̷̬̩̣̫͇̯̥ͯ̽͌̔ͪͯ́́͠l͖͍͕̠̦̼̗͋̍ͨ̿̿̎͒ͤ̓̅̀͂ͧ͋̏ͫͣ̔͘͜͏̶̥̺͓̘̺͘ḑ̵͎̜̥͕͈̝̫͎̺̮̱̤̠̠͖̳ͮͧͫ͂͒ͤͣ̌̽ͨͪ͒̚͘͘͟j̸̧̻̥̣̪͍͕͇̮͙̹̪̠̝͚͎͉̄̄̉̒̊ͩ̅͆ͭ͑ͫ̆̉̓;̷̸̸̨̡̡̮̪͉̣͉̣͇͖̪͖̲͚̀͒̏̃ͦ̈l͌̎̑ͣͣ̏̀̈́̄͏̶̷̧͇̻̱̰́k̛̯̝͔̰̬̱͔̲̠̤̠̝͚͎͉ͭ͑ͫ̆̉̓;̷̸̨̀͒̏̃ͦ̈́̾̀́̎͢҉͚̼͉s̵。ḻ͔̦͎̯͍̦͕̊̅ͦ͛͂̍͐̑̔͛̚̕͘k̨͎̳͈̫̫̤̙̪̞̦̳͙̭͓̜... ͕͇̮͙̹̪̠̝͚͎͉̄̄̉̒̊ͩ̅͆ͭ͑ͫ̆̉̓     l͌̎̑ͣͣ̏̀̈́̄͏̶̷̧͇̻̱̰́k̛̯̝͔̰̬̱͔̲̠̤̠̝͚͎͉ͭ͑ͫ̆̉̓;̷̸̨̀͒̏̃ͦ̈́̾̀́̎͢҉͚̼͉s̵͖̺̥͔͇̰̹̮͙͉̻̼̭̻͕̮͇ͨͬͪ͗̇̑̽͋̀j̶̋̊͌ͧͨͭ̓̅͐ͥ̂̔̊ͧ͊҉̶̵̞̩̦̳̺̳̬a̷̬̩̣̫͇̯̥ͯ̽͌̔ͪͯ́́͠l͖͍͕̠̦̼̗͋̍ͨ̿̿̎͒ͤ̓̅̀͂ͧ͋̏ͫͣ̔͘͜͏̶̥̺͓̘̺͘ḑ̵͎̜̥͕͈̝̫͎̺̮̱̤̠̠͖̳ͮͧͫ͂͒ͤͣ̌̽ͨͪ͒̚͘͘͟j̸̧̻̥̣̪͍͕͇̮͙̹̪̠̝͚͎͉̄̄̉̒̊ͩ̅͆ͭ͑ͫ̆̉̓;̷̸̸̨̡̡̮̪͉̣͉̣͇͖̪͖̲͚̀͒̏̃ͦ̈l͌̎̑ͣͣ̏̀̈́̄͏̶̷̧͇̻̱̰́k̛̯̝͔̰̬̱͔̲̠̤̠̝͚͎͉ͭ͑ͫ̆̉̓;̷̸̨
//    
//   
//    
//    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    NSString *cellIdentifier = @"UITableViewFlightHeaderView";
    
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (!headerView) {
        headerView = [[UITableViewHotelRoomHeaderView alloc]initWithReuseIdentifier:cellIdentifier];
        
    }
    
    if (section < [self.dataSourceForHeaderCell count]) {
        HotelInformation *itemData = (HotelInformation *)[self.dataSourceForHeaderCell.data objectAtIndex:(section)];
        
        UITableViewHotelRoomHeaderView *fliHeader = (UITableViewHotelRoomHeaderView* )headerView;
        [fliHeader setDelegate:self];
        [fliHeader setupDataSouceForHeaerCell:itemData indexPath:section];
    }
    
    return headerView;
    
}



- (void)userPersonalReserveRoomOperationWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= [self.dataSourceForIndexCell.data count]) {
        return;
    }
    HotelInformation *itemData = (HotelInformation *)[self.dataSourceForIndexCell.data objectAtIndex:(indexPath.row)];
    [self.hotelDetailInformation setOrderHotelRoomInforation:itemData];
    UserReserveHotelViewController *viewController = [[UserReserveHotelViewController alloc]initWithUserOrderInfor:self.hotelDetailInformation];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)setupHotelDetailMainViewControllerFrame{

}

#pragma mark -
#pragma mark -UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    CGFloat alpha = MIN(1,  contentOffsetY/(KDetailHeaderViewHeight));

    
//    NSLog(@"alpha is %lf \nKDetailHeaderViewHeight is %lf",alpha,KDetailHeaderViewHeight);
    [self viewdidNavigationControllerNavigationBarColorAlpha:(alpha)];
}

#pragma mark -
#pragma mark -  用户操作头部视图控制协议事件（详情、地图、修改入住信息）
- (void)userCheckHotelAtMapButtonClickedEvent{
    HotelMapAddressController *viewController = [[HotelMapAddressController alloc]initWithHotelInfor:self.hotelDetailInformation.orderHotelInforation];
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}

- (void)userCheckHotelDetailButtonClickedEvent{
    HotelIntroduceController *viewController = [[HotelIntroduceController alloc]initWithHotelInfor:self.hotelDetailInformation.orderHotelInforation];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)userUpdateStayDayesInforButtonClickedEvent{
    
    CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self.userReviseMoveIntoDateView setFrame:layerViewRect];
    }];
}


#pragma mark -
#pragma mark -  用户更改入店时间操作控制协议事件
///用户更改入店时间操作控制协议事件
- (void)userReviseMoveIntoDateOperationButtonEvent:(UIButton *)button{

    if (KBtnForMoveIntoButtonTag == button.tag) {
        
        
        
//        if (!self.chvc) {
        
            CalendarHomeViewController *chvc = [[CalendarHomeViewController alloc]init];
            
            chvc.calendartitle = @"入店日期";
            
            [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
            
//        }
        
        __weak __typeof(&*self)weakSelf = self;
        chvc.calendarblock = ^(CalendarDayModel *model){
            
            NSInteger days = [self intervalFromLastDate:[model toString]
                                              toTheDate:self.userSelectedEndDateStr];

            self.userSelectedIntervalDay = days;
            self.userSelectedBeginDateStr =[[NSString alloc]initWithString:[model toString]];
            
            
            [weakSelf updateDateInfor];
        };
        
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:chvc];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
    }
    
    else if (KBtnForLeaveRoomButtonTag == button.tag){
    
        CalendarHomeViewController *chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"离店日期";
        
        [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
        
        __weak __typeof(&*self)weakSelf = self;
        chvc.calendarblock = ^(CalendarDayModel *model){
            
            
            NSInteger days = [self intervalFromLastDate:self.userSelectedBeginDateStr
                                              toTheDate:[model toString]];
            self.userSelectedIntervalDay = days;
            self.userSelectedEndDateStr = [[NSString alloc]initWithString:[model toString]];

            [weakSelf updateDateInfor];
            
        };
        
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:chvc];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
    }
    
    
    ///还原原先数据
    else if (KBtnForClearInforButtonTag == button.tag){
        NSDictionary *beginDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelBeginDate);
        NSDictionary *endDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelEndDate);
        
        [self.userReviseMoveIntoDateView setTextMoveInto:[NSString stringWithFormat:@"%@（%@）",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),StringForKeyInUnserializedJSONDic(beginDictionary, @"week")]];
        
        [self.userReviseMoveIntoDateView setTextLeaveDate:[NSString stringWithFormat:@"%@（%@）",StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),StringForKeyInUnserializedJSONDic(endDictionary, @"week")]];
        [self.userReviseMoveIntoDateView setTextStayRoomDay:[NSString stringWithFormat:@"%zi",self.hotelDetailInformation.orderStayDayesQuantityInteger]];
    }
    
    ///隐藏
    else if (KBtnForDoneReviseButtonTag == button.tag){
        
        
        if (self.userSelectedIntervalDay < 1) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"时间选择出错，更改失效");
            return;

        }
        
        CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.userReviseMoveIntoDateView setFrame:layerViewRect];
        }];
        
        
        ///更新数据
        [self.hotelDetailInformation setOrderForHotelBeginDate:self.userSelectedBeginDateStr];
        [self.hotelDetailInformation setOrderForHotelEndDate:self.userSelectedEndDateStr];
        [self.hotelDetailInformation setOrderStayDayesQuantityInteger:self.userSelectedIntervalDay];
        
        NSDictionary *beginDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelBeginDate);
        NSDictionary *endDictionary = dateYearMonthDayWeekWithDateStr(self.hotelDetailInformation.orderForHotelEndDate);
        
        
        ///更新界面
        NSString *titleInfor = [NSString stringWithFormat:@"%@ - %@   %zi晚",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),
                                StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),
                                self.hotelDetailInformation.orderStayDayesQuantityInteger];
        [self.hotelDetailTableHeaderView.hotelStayDayInforLabel setText:titleInfor];
    }
}


- (void)updateDateInfor{
    
    NSDictionary *beginDictionary = dateYearMonthDayWeekWithDateStr(self.userSelectedBeginDateStr);
    NSDictionary *endDictionary = dateYearMonthDayWeekWithDateStr(self.userSelectedEndDateStr);
    
//    NSString *titleInfor = [NSString stringWithFormat:@"%@ - %@   %zi晚",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),
//                            StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),
//                            self.hotelDetailInformation.orderStayDayesQuantityInteger];
//    [self.hotelDetailTableHeaderView.hotelStayDayInforLabel setText:titleInfor];
    
    
    [self.userReviseMoveIntoDateView setTextMoveInto:[NSString stringWithFormat:@"%@（%@）",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),StringForKeyInUnserializedJSONDic(beginDictionary, @"week")]];
    
    [self.userReviseMoveIntoDateView setTextLeaveDate:[NSString stringWithFormat:@"%@（%@）",StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),StringForKeyInUnserializedJSONDic(endDictionary, @"week")]];
    [self.userReviseMoveIntoDateView setTextStayRoomDay:[NSString stringWithFormat:@"%zi",self.userSelectedIntervalDay]];
    
}


- (NSInteger)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2{
    NSInteger dayes = 0;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // HH是24进制，hh是12进制
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDateDate = [formatter dateFromString:dateString1];
    NSDate *endDateDate = [formatter dateFromString:dateString2];

    NSTimeInterval timeInterval = [endDateDate timeIntervalSinceDate:beginDateDate];
    
//    NSLog(@"\n\ntimeInterval is %zi dayStr is %i\n\n",(int)timeInterval,(int)((((int)timeInterval)/kHUITimeIntervalDay)));
    dayes = ((((int)timeInterval)/kHUITimeIntervalDay));
    return dayes;
}


- (void)didSelectedHeaerViewWithPathIndex:(NSInteger)indexPath{
    
    if (indexPath < [self.dataSourceForHeaderCell count]) {
        
        ///将原来的关闭
        if (self.userShowRoomDetailIndex != NSIntegerMax) {
            NSNumber *numberBool = (NSNumber *)[self.isCloseMutArray objectAtIndex:self.userShowRoomDetailIndex];
            NSNumber *newBool = [NSNumber numberWithBool:(![numberBool boolValue])];
            [self.isCloseMutArray replaceObjectAtIndex:self.userShowRoomDetailIndex withObject:newBool];
        }
        
        ///将现在的打开
        NSNumber *numberBool = (NSNumber *)[self.isCloseMutArray objectAtIndex:indexPath];
        NSNumber *newBool = [NSNumber numberWithBool:(![numberBool boolValue])];
        [self.isCloseMutArray replaceObjectAtIndex:indexPath withObject:newBool];
        self.userShowRoomDetailIndex = indexPath;
        
        HotelInformation *itemRoom = (HotelInformation *)[self.dataSourceForHeaderCell.data objectAtIndex:indexPath];
        [self requestItemRoomDataInfor:itemRoom.hotelRoomClassIdStr index:indexPath];
    }
}


- (void)requestItemRoomDataInfor:(NSString *)roomId index:(NSInteger)indexPath {

    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有·数据
    [self.dataSourceForIndexCell cleanAllData];
    [self.mainTableView reloadData];

    
    NSLog(@"roomId \t %@\n BeginDate is %@ ,endDate %@",roomId,self.hotelDetailInformation.orderForHotelBeginDate,self.hotelDetailInformation.orderForHotelEndDate);
    
//    return;
    __weak __typeof(&*self)weakSelf = self;
    
//    wai
    self.requestDataOperation =  [XCAPPHTTPClient userRequestDetailRoomsInforWithRoomId:roomId beginDate:self.hotelDetailInformation.orderForHotelBeginDate endDate:self.hotelDetailInformation.orderForHotelEndDate completion:^(WebAPIResponse *response) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list")  isKindOfClass:[NSArray class]]) {
                        
                        NSArray *hotelRoomArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        if (hotelRoomArray.count > 0) {
                            
                            NSMutableArray *dataInforArray = [NSMutableArray array];
                            
                            for (NSDictionary *rommDic in hotelRoomArray) {
                                
                                [weakSelf.isCloseMutArray addObject:[NSNumber numberWithBool:NO]];
                                
                                HotelInformation *itemTicket = [HotelInformation initializaionWithItemHotelRoomInformationForProductIndexCellWithUnserializedJSONDic:rommDic];
                                [dataInforArray addObject:itemTicket];
                            }
                            [weakSelf.dataSourceForIndexCell appendPage:dataInforArray];
                            [weakSelf.dataSourceForIndexCell setPageCount:1];

                            [weakSelf.mainTableView reloadData];
                        }
                        
                    }
                }
            }
            
        });
    }];
}


@end
