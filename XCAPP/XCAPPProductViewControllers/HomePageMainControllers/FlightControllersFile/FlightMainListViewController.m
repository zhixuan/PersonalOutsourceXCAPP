//
//  FlightMainListViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightMainListViewController.h"
#import "FlightNumberTableViewCell.h"
#import "UITableViewFlightHeaderView.h"
#import "WriteOutFlightOrderController.h"
#import "RCStandardController.h"
#import "HTTPClient.h"


#import "FlightSearchListLayerView.h"
#import "DefaultotelRecommendSearchLayerView.h"

#import "FlightAccurateSiftController.h"

#import "CityInforViewController.h"


@interface FlightMainListViewController ()<UITableViewDataSource,UITableViewDelegate,UITableViewFlightHeaderDelegate,FlightNumberCellDelegate,FlightSearchListSequenceDelegate,DefaultotelRecommendDelegate,FlightAccurateSiftDelegate>

/*!
 * @breif 搜索查询条件设置界面
 * @See
 */
@property (nonatomic , weak)      FlightSearchListLayerView     *flightSearchView;

/*!
 * @breif 头部导航栏高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                     navigationBarHeight;


/*!
 * @breif 默认搜索视图设置
 * @See
 */
@property (nonatomic , weak)        DefaultotelRecommendSearchLayerView         *flightDateRecommendSearchLayerView;

/*!
 * @breif 默认搜索视图设置
 * @See
 */
@property (nonatomic , weak)        DefaultotelRecommendSearchLayerView         *flightPriceRecommendSearchLayerView;

/*!
 * @breif 火车票总数头部显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *flightTicketTitleLabel;

/*!
 * @breif 火车票总数头部显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *flightTicketNumberLabel;
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
@property (nonatomic , strong)          DataPage                    *dataSource;

/*!
 * @breif 左侧界面数据源
 * @See
 */
@property (nonatomic , strong)          DataPage                    *dataCellSource;

#pragma mark - 网络请求链接
/*!
 * @breif 网络请求链接
 * @See
 */
@property (nonatomic , strong)          AFHTTPRequestOperation      *requestDataOperation;

/*!
 * @breif 搜索信息
 * @See
 */
@property (nonatomic , strong)          FlightOrderInformation      *userSearchFlightInfor;


/*!
 * @breif 标示数据数组
 * @See
 */

@property (nonatomic , strong)          NSMutableArray              *isCloseMutArray;


@end

@implementation FlightMainListViewController



#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        
        self.dataCellSource = [DataPage page];
        
    }
    return self;
}

- (id)initWithOrderSearchInfor:(FlightOrderInformation *)searchItem{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.dataCellSource = [DataPage page];
        self.userSearchFlightInfor = searchItem;
        
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}

- (void)setsettingNavTitle{
    
    CGRect rcTitleView = CGRectMake(100, 0, (KProjectScreenWidth - 100.0*2), 44);
    UIView *titleBCView = [[UIView alloc]initWithFrame:rcTitleView];
    [titleBCView setBackgroundColor:[UIColor clearColor]];
    
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:KXCAPPUIContentDefautFontSize(18)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFrame:CGRectMake(0.0f, 0.0f, titleBCView.width, 22.0f)];
    self.flightTicketTitleLabel = titleLabel;
    [titleBCView addSubview:self.flightTicketTitleLabel];
    
    UILabel *moveintoDate = [[UILabel alloc]init];
    [moveintoDate setBackgroundColor:[UIColor clearColor]];
    [moveintoDate setFont:KXCAPPUIContentDefautFontSize(12)];
    [moveintoDate setTextColor:HUIRGBColor(143.0f, 232.0f, 255.0f, 1.0f)];
    [moveintoDate setTextAlignment:NSTextAlignmentCenter];
    [moveintoDate setFrame:CGRectMake(0.0f, titleLabel.bottom, titleLabel.width, 20.0f)];
    self.flightTicketNumberLabel = moveintoDate;
    [titleBCView addSubview:self.flightTicketNumberLabel];
    
    
    self.navigationItem.titleView = titleBCView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setsettingNavTitle];
    
    [self.flightTicketTitleLabel setText:[NSString stringWithFormat:@"%@ - %@",
                                          self.userSearchFlightInfor.fliOrderTakeOffSite,
                                          self.userSearchFlightInfor.fliOrderArrivedSite]];
    [self.flightTicketNumberLabel setText:@"共57个航班信息"];
    
    self.isCloseMutArray = [[NSMutableArray alloc]init];
    [self setupFlightMainListViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:KDefaultViewBackGroundColor];
    [headerView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(45.0f))];
    UIView *sepView = [[UIView alloc]init];
    
    UILabel *startDateLabel = [[UILabel alloc]init];
    [startDateLabel setBackgroundColor:[UIColor clearColor]];
    [startDateLabel setFont:KXCAPPUIContentFontSize(12.0f)];
    [startDateLabel setText:@"出发时间："];
    [startDateLabel setTextColor:KSubTitleTextColor];
    [startDateLabel setTextAlignment:NSTextAlignmentLeft];
    [startDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(10.0f), KXCUIControlSizeWidth(60.0f), KXCUIControlSizeWidth(25.0f))];
    [headerView addSubview:startDateLabel];
    
    UILabel *startDateContent = [[UILabel alloc]init];
    [startDateContent setBackgroundColor:[UIColor clearColor]];
    [startDateContent setFont:[UIFont boldSystemFontOfSize:((12.0f)*KXCAdapterSizeWidth)]];
    [startDateContent setText:self.userSearchFlightInfor.fliOrderTakeOffDate];
    [startDateContent setTextColor:KContentTextColor];
    [startDateContent setTextAlignment:NSTextAlignmentLeft];
    [startDateContent setFrame:CGRectMake(startDateLabel.right, KXCUIControlSizeWidth(10.0f), KXCUIControlSizeWidth(150.0f), KXCUIControlSizeWidth(25.0f))];
    [headerView addSubview:startDateContent];
    
    [sepView setBackgroundColor:HUIRGBColor(205.0f, 206.0f, 207.0f, 1.0f)];
    [sepView setFrame:CGRectMake(0.0f, headerView.height - 1.0f, KProjectScreenWidth, 1.0f)];
    [headerView addSubview:sepView];
    
    return headerView;
}

- (void)setupFlightMainListViewControllerFrame{
 
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStylePlain];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview setTableHeaderView:[self tableViewHeaderView]];
    
    tbview.backgroundColor =  KDefaultViewBackGroundColor;
    tbview.dataSource = self;
    tbview.delegate = self;
    [self.view addSubview:tbview];
    self.mainTableView = tbview;
    __weak __typeof(&*self)weakSelf = self;
    [self.mainTableView addPullToRefreshWithActionHandler:^(void){
        [weakSelf refreshListData];
    }];
    ConfiguratePullToRefreshViewAppearanceForScrollView(tbview);
    [tbview triggerPullToRefresh];
    
    
    self.navigationBarHeight = self.navigationController.navigationBar.height;
    NSLog(@"self.view.bounds.size.height is %lf",self.view.bounds.size.height);
    CGRect bottomRect = CGRectMake(0.0f,
                                   (self.view.bounds.size.height - KHotelSearcSetupBottomViewHeight
                                    - self.navigationBarHeight)
                                   , KProjectScreenWidth, KHotelSearcSetupBottomViewHeight);
    FlightSearchListLayerView *bottomView = [[FlightSearchListLayerView alloc]initWithFrame:bottomRect];
    //    [bottomView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 0.30)];
    [bottomView setDelegate:self];
    self.flightSearchView = bottomView;
    [self.view addSubview:self.flightSearchView];
    
    
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    NSArray *array =  @[@"从早到晚",
                        @"从晚到早",
                        @"不限时间"];
    DefaultotelRecommendSearchLayerView *hotelRecommendView = [[DefaultotelRecommendSearchLayerView alloc]initWithFrame:layerViewRect withSearchContent:array];
    [hotelRecommendView setDelegate:self];
    self.flightDateRecommendSearchLayerView = hotelRecommendView;
    [self.navigationController.view addSubview:self.flightDateRecommendSearchLayerView];
    
    
    NSArray *arrayPrice =  @[@"从高到低",
                             @"从低到高",
                             @"不限价格"];
    DefaultotelRecommendSearchLayerView *flightRecommendView = [[DefaultotelRecommendSearchLayerView alloc]initWithFrame:layerViewRect withSearchContent:arrayPrice];
    [flightRecommendView setDelegate:self];
    self.flightPriceRecommendSearchLayerView = flightRecommendView;
    [self.navigationController.view addSubview:self.flightPriceRecommendSearchLayerView];

}


- (void)refreshListData{
    
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有·数据
    [self.dataSource cleanAllData];
    [self.mainTableView reloadData];
    [self.isCloseMutArray removeAllObjects];
    [self loadMoreListData];
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
    
    
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        //关掉PullToRefreshView
        if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
        {
            UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
            [weakSelf.mainTableView.pullToRefreshView stopAnimating];
        }
        
        
        
//        for (int index = 0; index < 18; index ++) {
//            
//            TrainticketInformation *itemTicket = [[TrainticketInformation alloc]init];
//            [itemTicket setTraIdStr:@"001"];
//            [itemTicket setTraCodeNameStr:[NSString stringWithFormat:@"G10%i",index]];
//            [itemTicket setTraTakeOffSite:@"北京"];
//            [itemTicket setTraTakeOffTime:@"08:42"];
//            [itemTicket setTraArrivedSite:@"深圳南"];
//            [itemTicket setTraArrivedTime:@"12:50 次日"];
//            [itemTicket setTraTimeInterval:@"28小时8分"];
//            [itemTicket setTraUnitPrice:@"900"];
//            [itemTicket setTraScaleNumber:@"90"];
//            [itemTicket setTraTypeStr:@"高速动车"];
//            [itemTicket setTraCabinModelStr:@"二等座"];
//            
//            
//            [dataCellInforArray addObject:itemTicket];
//        }
//        
//
        
        NSMutableArray *dataCellInforArray = [NSMutableArray array];
        NSMutableArray *dataInforArray = [NSMutableArray array];
        for (int index = 0; index < 30; index ++) {
            
            
            
            [self.isCloseMutArray addObject:[NSNumber numberWithBool:NO]];
            FlightInformation *itemTicket = [[FlightInformation alloc]init];
            [itemTicket setFlightIdStr:@"001"];
            [itemTicket setFlightName:[NSString stringWithFormat:@"东航GU10%i",index]];
            [itemTicket setFlightModelName:[NSString stringWithFormat:@"74%i大",index%8]];
            [itemTicket setFlightUnitPrice:920+index*20];
            [itemTicket setFlightBeginPrice:[NSString stringWithFormat:@"%zi",920+index*20]];
            [itemTicket setFlightAllowReturnBool:YES];
            [itemTicket setFlightBunkerSurcharge:@"50"];
            
            int reslut = index%5;
            if (reslut == 0) {
                [itemTicket setFlightTakeOffTime:@"08:40"];
                [itemTicket setFlightArrivedTime:@"11:30"];
                [itemTicket setFlightTakeOffAirport:@"南苑 T1"];
                [itemTicket setFlightArrivedAirport:@"浦东 T3"];
                [itemTicket setFlightCabinModelStr:@"经济舱"];
                [itemTicket setFlightDiscountStr:@"7.5折"];
                [itemTicket setFlightDiscountRateFloat:0.75f];
                [itemTicket setFlightLabelNameStr:@"旅行套餐"];
                [itemTicket setFlightStockNumber:100];
                [itemTicket setFlightAllowReturnShowStr:@"可以退改签 >"];

            }
            else if (reslut == 1) {
                [itemTicket setFlightTakeOffTime:@"09:00"];
                [itemTicket setFlightArrivedTime:@"11:30"];
                
                [itemTicket setFlightTakeOffAirport:@"首都 T1"];
                [itemTicket setFlightArrivedAirport:@"虹桥 T1"];
                [itemTicket setFlightProvideBoardBool:YES];
                [itemTicket setFlightCabinModelStr:@"高端经济舱"];
                [itemTicket setFlightDiscountStr:@"半价"];
                [itemTicket setFlightStockNumber:9];
                [itemTicket setFlightDiscountRateFloat:0.5f];
                [itemTicket setFlightLabelNameStr:@"航司直销"];
                [itemTicket setFlightAllowReturnShowStr:@"退改费用低 >"];
            }
            
            else if (reslut == 2) {
                [itemTicket setFlightTakeOffTime:@"09:20"];
                [itemTicket setFlightArrivedTime:@"11:50"];
                
                [itemTicket setFlightTakeOffAirport:@"西苑 T1"];
                [itemTicket setFlightArrivedAirport:@"虹桥 T3"];
                
                 [itemTicket setFlightCabinModelStr:@"高端经济舱"];
                [itemTicket setFlightDiscountStr:@"9.7折"];
                [itemTicket setFlightDiscountRateFloat:0.97f];
                [itemTicket setFlightLabelNameStr:@"飞行达人"];
                [itemTicket setFlightStockNumber:100];
                [itemTicket setFlightAllowReturnShowStr:@"退改费用高 >"];
            }
            
            else if (reslut == 3) {
                [itemTicket setFlightTakeOffTime:@"09:40"];
                [itemTicket setFlightArrivedTime:@"12:00"];
                [itemTicket setFlightProvideBoardBool:YES];
                
                [itemTicket setFlightTakeOffAirport:@"南苑 T2"];
                [itemTicket setFlightArrivedAirport:@"浦东 T2"];
                
                [itemTicket setFlightCabinModelStr:@"超值头等舱"];
                [itemTicket setFlightDiscountStr:@"9.6折"];
                [itemTicket setFlightDiscountRateFloat:0.96f];
                [itemTicket setFlightLabelNameStr:@"国庆回馈"];
                [itemTicket setFlightStockNumber:12];
                [itemTicket setFlightAllowReturnShowStr:@"退改费用高 >"];
            }
            
            else if (reslut == 4) {
                [itemTicket setFlightTakeOffTime:@"09:50"];
                [itemTicket setFlightArrivedTime:@"12:30"];
                [itemTicket setFlightTakeOffAirport:@"首都 T2"];
                [itemTicket setFlightArrivedAirport:@"浦东 T1"];
                [itemTicket setFlightCabinModelStr:@"超值头等舱"];
                [itemTicket setFlightStockNumber:100];
                [itemTicket setFlightDiscountStr:@"全价"];
                [itemTicket setFlightDiscountRateFloat:1.0];
                [itemTicket setFlightLabelNameStr:@"商务推荐"];
                [itemTicket setFlightAllowReturnShowStr:@"退改费用低 >"];
            }

            ///详细信息
            
            
            
            
            if (index < 15){
                [dataInforArray addObject:itemTicket];
            }
            
            [dataCellInforArray addObject:itemTicket];
            
        }
        [self.dataCellSource appendPage:dataCellInforArray];
        [self.dataSource appendPage:dataInforArray];
        [self.dataSource setPageCount:1];
        [self.mainTableView reloadData];
    });
    
}



#pragma mark - UITableViewDataSource

#pragma mark -
#pragma mark - 设置Cell信息

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;
    
    if (indexPath.row < [self.dataCellSource.data count]) {
        return KFlightNumberTableViewHeight;
    }
    return heightForRow;
}

- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [self.dataCellSource count]);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSInteger numberOfRows = 0;
    if (section < self.isCloseMutArray.count) {
        
        NSNumber *boolNumber = (NSNumber *)[self.isCloseMutArray objectAtIndex:section];
        if ([boolNumber boolValue]) {
            numberOfRows = [self.dataCellSource count];
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
    FlightNumberTableViewCell* cell = [[FlightNumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                     reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataCellSource.data count]) {
        return;
    }
    
    FlightInformation *itemData = (FlightInformation *)[self.dataCellSource.data objectAtIndex:(indexPath.row)];
    FlightNumberTableViewCell *hotelCell = (FlightNumberTableViewCell* )cell;
    [hotelCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [hotelCell setDelegate:self];
    [hotelCell setupCellWithDataSource:itemData indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"TravelActiviesItemTableViewCell";
    BOOL isLoadMoreCell = [self _isLoadMoreCellAtIndexPath:indexPath];
    cellIdentifier = isLoadMoreCell? kHUILoadMoreCellIdentifier: cellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self createCellWithIdentifier:cellIdentifier];
    }
    
    if (!isLoadMoreCell)
    {
        [self _configureCell:cell forRowAtIndexPath:indexPath];
    }
    
    else
    {
        self.loadMoreCell = (HUILoadMoreCell*)cell;
        if ([self.dataCellSource canLoadMore])
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



#pragma mark -
#pragma mark - 设置TableHeaderView视图信息
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat heightForRow = 0.0f;
    
    if (section < [self.dataSource.data count]) {
        heightForRow = KUITableViewFlightHeaderHeight;
    }
    return heightForRow;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    NSString *cellIdentifier = @"UITableViewFlightHeaderView";
    
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (!headerView) {
        headerView = [[UITableViewFlightHeaderView alloc]initWithReuseIdentifier:cellIdentifier];

    }

    if (section < [self.dataSource count]) {
        FlightInformation *itemData = (FlightInformation *)[self.dataSource.data objectAtIndex:(section)];
        
        UITableViewFlightHeaderView *fliHeader = (UITableViewFlightHeaderView* )headerView;
        [fliHeader setDelegate:self];
        [fliHeader setupFlightHeaderViewDataSource:itemData indexPath:section];
    }
    
    return headerView;
    
}

#pragma mark -
#pragma mark -  METHOD FOR UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self _isLoadMoreCellAtIndexPath:indexPath]){
        return;
    }
    
    if (indexPath.row >= [self.dataCellSource.data count]) {
        return;
    }
}

#pragma mark -
#pragma mark -  用户选择行程出发时间操作
- (void)userSelectedIndexPath:(NSInteger)indexPath{

    if (indexPath < [self.dataSource count]) {
        
        
        NSNumber *numberBool = (NSNumber *)[self.isCloseMutArray objectAtIndex:indexPath];
        
        NSNumber *newBool = [NSNumber numberWithBool:(![numberBool boolValue])];
        [self.isCloseMutArray replaceObjectAtIndex:indexPath withObject:newBool];
        
        //刷新列表
        NSIndexSet * index = [NSIndexSet indexSetWithIndex:indexPath];
        [self.mainTableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

#pragma mark -
#pragma mark - 用户查看航班退改费信息
- (void)userCheckReturnCostInfor:(NSIndexPath *)indexPath{

    ShowImportErrorAlertView(@"在这里查看退款说明信息");
}


#pragma mark -
#pragma mark - 用户预订航班操作
- (void)userPersonalReserveFlightWithIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"进行下一步预订操作");
    
    
    if (indexPath.row >= [self.dataCellSource count]) {
        return;
    }
    
    FlightInformation *itemData = (FlightInformation *)[self.dataCellSource.data objectAtIndex:(indexPath.row)];
    [self.userSearchFlightInfor setFliOrderOneWayInfor:itemData];
    
    WriteOutFlightOrderController *viewController = [[WriteOutFlightOrderController alloc]initWithFlightOrderInfor:self.userSearchFlightInfor ];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark -
#pragma mark -  Method For UIScrollViewDelegate

//开始滑动，则隐藏信息
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //    NSLog(@"scrollViewWillBeginDragging ");
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect bottomRect = CGRectMake(0.0f,
                                       (self.view.bounds.size.height)
                                       , KProjectScreenWidth, KHotelSearcSetupBottomViewHeight);
        [self.flightSearchView setFrame:bottomRect];
    }];
}
//停止滑动，则显示搜索界面信息
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    NSLog(@"scrollViewDidEndDecelerating ");
    [UIView animateWithDuration:0.25 animations:^{
        CGRect bottomRect = CGRectMake(0.0f,
                                       (self.view.bounds.size.height - KHotelSearcSetupBottomViewHeight
                                        )
                                       , KProjectScreenWidth, KHotelSearcSetupBottomViewHeight);
        [self.flightSearchView setFrame:bottomRect];
    }];
}

- (void)userSelectedDefaultotelSearchWithSequenceButton:(UIButton *)button{
 
    if (KBtnForDateSequenceButtonTag == button.tag) {

        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.flightDateRecommendSearchLayerView setFrame:layerViewRect];
        }];
        NSLog(@"title is %@",self.flightSearchView.dateSequenceButton.titleLabel.text);
    }
    
    else if (KBtnForPricSequenceeButtonTag == button.tag){
        NSLog(@"title is %@",self.flightSearchView.priceSequenceButton.titleLabel.text);
        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.flightPriceRecommendSearchLayerView setFrame:layerViewRect];
        }];
    }
    
    else if (KBtnForMoreSequenceButtonTag == button.tag){
        
        FlightAccurateSiftController *viewController = [[FlightAccurateSiftController alloc]init];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
    }
}

#pragma mark -
#pragma mark -  默认用户推荐搜索操作控制协议方法
- (void)userSelectedDefaultotelRecommendSearchStyle:(NSInteger)Searchstyle styleName:(NSString *)styleNameStr{
    
    NSLog(@" Searchstyle is %zi\n styleNameStr is %@",Searchstyle,styleNameStr);
    
    
    if ([styleNameStr isEqualToString:@"不限时间"]) {
        [self.flightSearchView.dateSequenceButton setTitle:@"时间排序" forState:UIControlStateNormal];
        [self.flightSearchView.dateSequenceButton setTitleColor:[UIColor whiteColor]
                                                       forState:UIControlStateNormal];
        [self.flightSearchView.dateSequenceButton setTitleColor:[UIColor whiteColor]
                                                       forState:UIControlStateHighlighted];
    }else if ([styleNameStr isEqualToString:@"从早到晚"] || [styleNameStr isEqualToString:@"从晚到早"]){
        [self.flightSearchView.dateSequenceButton setTitle:styleNameStr forState:UIControlStateNormal];
        [self.flightSearchView.dateSequenceButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                       forState:UIControlStateNormal];
        [self.flightSearchView.dateSequenceButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                       forState:UIControlStateHighlighted];
    }
    
    else if ([styleNameStr isEqualToString:@"不限价格"]) {
        [self.flightSearchView.priceSequenceButton setTitle:@"价格排序" forState:UIControlStateNormal];
        [self.flightSearchView.priceSequenceButton setTitleColor:[UIColor whiteColor]
                                                       forState:UIControlStateNormal];
        [self.flightSearchView.priceSequenceButton setTitleColor:[UIColor whiteColor]
                                                       forState:UIControlStateHighlighted];
    }else if ([styleNameStr isEqualToString:@"从高到底"] || [styleNameStr isEqualToString:@"从低到高"]){
        [self.flightSearchView.priceSequenceButton setTitle:styleNameStr forState:UIControlStateNormal];
        [self.flightSearchView.priceSequenceButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                       forState:UIControlStateNormal];
        [self.flightSearchView.priceSequenceButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                       forState:UIControlStateHighlighted];
    }
}


- (void)userSelectedSiftInforStartDate:(NSString *)dateStr type:(NSString *)typeStr cabin:(NSString *)cabinStr company:(NSString *)companyStr{

    NSLog(@"\ndateStr is %@\ntypeStr is %@\ncabinStr is %@\ncompanyStr is %@",dateStr,typeStr,cabinStr,companyStr);
}

@end
