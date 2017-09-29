//
//  TrainTicketListViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketListViewController.h"
#import "TrainTicketTableViewCell.h"
#import "TrainticketInformation.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "FillTrainTicketOrderViewController.h"
#import "TrainTicketSearchListLayerView.h"
#import "TrainTicketAllSiftConditionLayerView.h"

#define KBtnForBeforeDayButtonTag               (1830111)
#define KBtnForNextDayButtonTag                 (1830112)

@interface TrainTicketListViewController ()<UITableViewDelegate,UITableViewDataSource,TrainTicketSearchListDelegate,TrainTicketAllSiftConditionDelegate>

/*!
 * @breif 火车票总数头部显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *trainticketTitleLabel;

/*!
 * @breif 火车票总数头部显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *trainticketNumberLabel;

/*!
 * @breif 购票时间显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *userPayTicketDateLabel;
#pragma mark - 火车票信息显示图
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

#pragma mark - 网络请求链接
/*!
 * @breif 网络请求链接
 * @See
 */
@property (nonatomic , strong)          AFHTTPRequestOperation      *requestDataOperation;
/*!
 * @breif 订单信息
 * @See
 */
@property (nonatomic , strong)      TrainticketOrderInformation             *orderForTrainticketInfor;


/*!
 * @breif 搜索查询条件设置界面
 * @See
 */
@property (nonatomic , weak)      TrainTicketSearchListLayerView     *trainTicketSearchListBottomLayerView;


/*!
 * @breif 用户筛选火车票操作界面
 * @See
 */
@property (nonatomic , weak)      TrainTicketAllSiftConditionLayerView  *trainTicketSiftConditionAllLayerView;

/*!
 * @breif 头部导航栏高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                     navigationBarHeight;


/*!
 * @breif 用户搜索操作字段设置
 * @See
 */
@property (nonatomic , strong)      NSString                        *searchOrderByStr;

/*!
 * @breif 坐席类型
 * @See
 */
@property (nonatomic , strong)      NSString                        *seatTypeStr;

/*!
 * @breif 火车票类型
 * @See
 */
@property (nonatomic , strong)      NSString                        *trainTypeStr;
/*!
 * @breif 出发站站筛选
 * @See
 */
@property (nonatomic , strong)      NSString                        *filterFromStr;
/*!
 * @breif 终点站筛选
 * @See
 */
@property (nonatomic , strong)      NSString                        *filterToStr;

/*!
 * @breif 坐席类型数据选择内容
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                  *seatTypesMutableArray;

/*!
 * @breif 火车票类型数据选择内容
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                  *trainTypesMutableArray;
/*!
 * @breif 出发站站筛选数据选择内容
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                  *filterFromMutableArray;

/*!
 * @breif 终点站筛选数据选择内容
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                  *filterToMutableArray;

@end

@implementation TrainTicketListViewController
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
    }
    return self;
}

- (id)initWithOrderInfor:(TrainticketOrderInformation *)orderItem{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.orderForTrainticketInfor = orderItem;
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setsettingNavTitle];
    
    self.searchOrderByStr = [[NSString alloc]initWithFormat:@"%@",@""];
    self.seatTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
    self.trainTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
    self.filterFromStr = [[NSString alloc]initWithFormat:@"%@",@""];
    self.filterToStr = [[NSString alloc]initWithFormat:@"%@",@""];
    
    self.seatTypesMutableArray = [[NSMutableArray alloc]init];
    self.trainTypesMutableArray = [[NSMutableArray alloc]init];
    self.filterFromMutableArray = [[NSMutableArray alloc]init];
    self.filterToMutableArray = [[NSMutableArray alloc]init];
    
    [self.trainticketTitleLabel setText:[NSString stringWithFormat:@"%@ - %@",self.orderForTrainticketInfor.ttOrderTrainticketInfor.traTakeOffSite,self.orderForTrainticketInfor.ttOrderTrainticketInfor.traArrivedSite]];
    [self.trainticketNumberLabel setText:@"共5个车次"];
    [self setupTrainTicketListViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.trainticketTitleLabel = titleLabel;
    [titleBCView addSubview:self.trainticketTitleLabel];
    
    UILabel *moveintoDate = [[UILabel alloc]init];
    [moveintoDate setBackgroundColor:[UIColor clearColor]];
    [moveintoDate setFont:KXCAPPUIContentDefautFontSize(12)];
    [moveintoDate setTextColor:HUIRGBColor(143.0f, 232.0f, 255.0f, 1.0f)];
    [moveintoDate setTextAlignment:NSTextAlignmentCenter];
    [moveintoDate setFrame:CGRectMake(0.0f, titleLabel.bottom, titleLabel.width, 20.0f)];
    self.trainticketNumberLabel = moveintoDate;
    [titleBCView addSubview:self.trainticketNumberLabel];
    
    
    self.navigationItem.titleView = titleBCView;
}


- (UIView *)setupTableHeaderView{
    
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:KDefaultViewBackGroundColor];
    [headerView setFrame:CGRectMake(0.0, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(42.0f))];
    UIView  *separator = [[UIView alloc]init];
    [separator setBackgroundColor:KSepLineColorSetup];
    [separator setFrame:CGRectMake(0.0f, KXCUIControlSizeWidth(41.0f), KProjectScreenWidth, 1.0f)];
    [headerView addSubview:separator];
    
    
    UIButton *dayBeforeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dayBeforeBtn setBackgroundColor:[UIColor clearColor]];
    [dayBeforeBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                            forState:UIControlStateNormal];
    [dayBeforeBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                            forState:UIControlStateHighlighted];
    [dayBeforeBtn setTitle:@"< 前一天" forState:UIControlStateNormal];
    [dayBeforeBtn setTag:KBtnForBeforeDayButtonTag];
    [dayBeforeBtn addTarget:self action:@selector(userSelectedDateEventClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    [dayBeforeBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [dayBeforeBtn setTitleColor:KSubTitleTextColor forState:UIControlStateHighlighted];
    [dayBeforeBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [dayBeforeBtn setFrame:CGRectMake(5.0f, 0.0f, KXCUIControlSizeWidth(65.0f), KXCUIControlSizeWidth(42.0f))];
    
    [headerView addSubview:dayBeforeBtn];
    
    
    UILabel *dateLb = [[UILabel alloc]init];
    [dateLb setFont:KXCAPPUIContentFontSize(15.0f)];
    [dateLb setBackgroundColor:[UIColor clearColor]];
    [dateLb setTextColor:KContentTextColor];
    [dateLb setFrame:CGRectMake(KXCUIControlSizeWidth(90.0f), 0.0f,
                                (KProjectScreenWidth - KXCUIControlSizeWidth(180.0f)),
                                KXCUIControlSizeWidth(42.0f))];
    [dateLb setTextAlignment:NSTextAlignmentCenter];
    self.userPayTicketDateLabel = dateLb;
    [headerView addSubview:self.userPayTicketDateLabel];
    
    
    UIButton *dayNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dayNextBtn setBackgroundColor:[UIColor clearColor]];
    [dayNextBtn setTag:KBtnForNextDayButtonTag];
    [dayNextBtn addTarget:self action:@selector(userSelectedDateEventClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [dayNextBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                          forState:UIControlStateNormal];
    [dayNextBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                          forState:UIControlStateHighlighted];
    [dayNextBtn setTitle:@"后一天 >" forState:UIControlStateNormal];
    [dayNextBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [dayNextBtn setTitleColor:KSubTitleTextColor forState:UIControlStateHighlighted];
    [dayNextBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [dayNextBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(65.0f) - 5.0f),
                                    0.0f, KXCUIControlSizeWidth(65.0f),
                                    KXCUIControlSizeWidth(42.0f))];
    
    
    
    [self.userPayTicketDateLabel setText:self.orderForTrainticketInfor.ttOrderDepartDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([self.userPayTicketDateLabel.text length] > 12) {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *selectedDate = [formatter dateFromString:[self.userPayTicketDateLabel.text substringToIndex:10]];
    [self.userPayTicketDateLabel setText:[formatter stringFromDate:selectedDate]];
    [headerView addSubview:dayNextBtn];
    
    
    return headerView;
}

- (void)userSelectedDateEventClicked:(UIButton *)button{
    
    if (KBtnForBeforeDayButtonTag == button.tag) {
        [self setupDateWithInterval:(-kHUITimeIntervalDay)];
    }
    
    else if (KBtnForNextDayButtonTag== button.tag) {
        
        [self setupDateWithInterval:kHUITimeIntervalDay];
    }
    
    
    [self.mainTableView triggerPullToRefresh];
}


- (void)setupDateWithInterval:(CGFloat)intervalTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = self.userPayTicketDateLabel.text;
    NSDate *date = [formatter dateFromString:dateString];
    NSDate *yesterday = [NSDate dateWithTimeInterval:intervalTime sinceDate:date];
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:intervalTime sinceDate:date];
    
    
    [self.userPayTicketDateLabel setText:[formatter stringFromDate:yesterday]];
    
    NSLog(@"yesterday %@    tomorrow %@", [formatter stringFromDate:yesterday], [formatter stringFromDate:tomorrow]);
}
- (void)setupTrainTicketListViewControllerFrame{
    
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStylePlain];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview setTableHeaderView:[self setupTableHeaderView]];
    
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
                                   (self.view.bounds.size.height - KTrainTicketSearchSetupBottomViewHeight
                                    - self.navigationBarHeight)
                                   , KProjectScreenWidth, KTrainTicketSearchSetupBottomViewHeight);
    TrainTicketSearchListLayerView *bottomView = [[TrainTicketSearchListLayerView alloc]initWithFrame:bottomRect];
    [bottomView setDelegate:self];
    self.trainTicketSearchListBottomLayerView = bottomView;
    [self.view addSubview:self.trainTicketSearchListBottomLayerView];
    
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    TrainTicketAllSiftConditionLayerView *hotelRecommendView = [[TrainTicketAllSiftConditionLayerView alloc]initWithFrame:layerViewRect ];
    [hotelRecommendView setDelegate:self];
    self.trainTicketSiftConditionAllLayerView = hotelRecommendView;
    [self.navigationController.view addSubview:self.trainTicketSiftConditionAllLayerView];
    
}


- (void)refreshListData{
    
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    [self.seatTypesMutableArray removeAllObjects];
    [self.filterToMutableArray removeAllObjects];
    [self.filterFromMutableArray removeAllObjects];
    [self.trainTypesMutableArray removeAllObjects];
    //清空当前数据源中所有·数据
    [self.dataSource cleanAllData];
    [self.mainTableView reloadData];
    [self loadMoreListData];
}

- (void)loadMoreListData{
    [self setupHomeHotTopicInforControllerDataSource];
}

///设置热门信息信息内容(活动/装备/线路)
- (void)setupHomeHotTopicInforControllerDataSource{
    
    __weak __typeof(&*self)weakSelf = self;
    
    self.requestDataOperation = [XCAPPHTTPClient requestTrainTickeListFrom:self.orderForTrainticketInfor.ttOrderTrainticketInfor.traTakeOffSite  to:self.orderForTrainticketInfor.ttOrderTrainticketInfor.traArrivedSite  date:self.orderForTrainticketInfor.ttOrderDepartDate isHSBool:self.orderForTrainticketInfor.tticketIsHighspeedBool  orderby:self.searchOrderByStr  descend:1   seatType:self.seatTypeStr  trainType:self.trainTypeStr fromType:self.filterFromStr  toType:self.filterToStr completion:^(WebAPIResponse *response) {
        
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
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    ///坐席内容
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"seatTypeFiters") isKindOfClass:[NSArray class]]) {
                        
                        NSArray *seatTypeArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"seatTypeFiters");
                        [weakSelf.seatTypesMutableArray addObjectsFromArray:seatTypeArray];
                    }
                    
                    ///等级内容
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"trainTypeFiters") isKindOfClass:[NSArray class]]) {
                        
                        NSArray *trainTypeArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"trainTypeFiters");
                        [weakSelf.trainTypesMutableArray addObjectsFromArray:trainTypeArray];
                    }
                    
                    ///出发位置
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"dptStationFiters") isKindOfClass:[NSArray class]]) {
                        
                        NSArray *fromStationArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"dptStationFiters");
                        [weakSelf.filterFromMutableArray addObjectsFromArray:fromStationArray];
                    }
                    
                    ///到达位置
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"arrStationFiters") isKindOfClass:[NSArray class]]) {
                        
                        NSArray *arrStationArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"arrStationFiters");
                        [weakSelf.filterToMutableArray addObjectsFromArray:arrStationArray];
                    }
                    
                    
                    [weakSelf.trainTicketSiftConditionAllLayerView setupFrameWithSeatArray:weakSelf.seatTypesMutableArray trainNumber:weakSelf.trainTypesMutableArray  beginArray:weakSelf.filterFromMutableArray endArray:weakSelf.filterToMutableArray];
                    
                    ///火车票数据信息
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"trains") isKindOfClass:[NSArray class]]) {
                        NSArray *trainsArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"trains");
                        
                        
                        NSMutableArray *dataInforArray = [NSMutableArray array];
                        
                        for (NSDictionary *dataInfor in trainsArray) {
                            
                            TrainticketInformation *itemTicket = [TrainticketInformation initializaionWithTrainticketListInfoWithJSONDic:dataInfor];
                            [dataInforArray addObject:itemTicket];
                        }
                        
                        [weakSelf.dataSource appendPage:dataInforArray];
                        [weakSelf.dataSource setPageCount:1];
                        [weakSelf.mainTableView reloadData];
                        
                        
                        [weakSelf.trainticketNumberLabel setText:[NSString stringWithFormat:@"共%zi个车次",dataInforArray.count]];
                        
                    }
                    else{
                        if (weakSelf.loadMoreCell) {
                            [weakSelf.loadMoreCell stopLoadingAnimation];
                            if (response.code == WebAPIResponseCodeNetError) {
                                weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                            }else{
                                weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                            }
                        }
                    }
                    
                    
                } else{
                    if (weakSelf.loadMoreCell) {
                        [weakSelf.loadMoreCell stopLoadingAnimation];
                        if (response.code == WebAPIResponseCodeNetError) {
                            weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                        }else{
                            weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                        }
                    }
                }
                
                
            } else{
                if (weakSelf.loadMoreCell) {
                    [weakSelf.loadMoreCell stopLoadingAnimation];
                    if (response.code == WebAPIResponseCodeNetError) {
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                    }else{
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                    }
                }
            }
        });
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;
    
    if (indexPath.row < [self.dataSource.data count]) {
        return KTrainTicketTableViewCellHeight;
    }
    return heightForRow;
}


#pragma mark - UITableViewDataSource


- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [self.dataSource count]);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  ([self.dataSource count] +1);
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
    {
        return CreateLoadMoreCell();
        
    }
    TrainTicketTableViewCell* cell = [[TrainTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                     reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    TrainticketInformation *itemData = (TrainticketInformation *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    TrainTicketTableViewCell *hotelCell = (TrainTicketTableViewCell* )cell;
    [hotelCell setuprainTicketTableViewCellDataSource:itemData indexPath:indexPath];
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
        if ([self.dataSource canLoadMore])
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
    
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    TrainticketInformation *itemData = (TrainticketInformation *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    [self.orderForTrainticketInfor setTtOrderTrainticketInfor:itemData];
    [self.orderForTrainticketInfor setTtOrderTradeNumber:@"08161433093"];
    FillTrainTicketOrderViewController *viewController = [[FillTrainTicketOrderViewController alloc]initWithOrderInfor:self.orderForTrainticketInfor];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)userSelectedTrainTicketSearchDefaultotelSearchWithSequenceButton:(UIButton *)button{
    if (button.tag == KBtnForDepartButton) {
        self.searchOrderByStr = @"1";
        [self.trainTicketSearchListBottomLayerView.btnForTimeIntervalButton setTitleColor:[UIColor whiteColor]
                                                                                 forState:UIControlStateNormal];
        [self.trainTicketSearchListBottomLayerView.btnForAchieveButton setTitleColor:[UIColor whiteColor]
                                                                            forState:UIControlStateNormal];
        [self.trainTicketSearchListBottomLayerView.btnForDepartButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                                           forState:UIControlStateNormal];
        
        [self.mainTableView triggerPullToRefresh];
    }
    
    else if (button.tag == KBtnForAchieveButton) {
        self.searchOrderByStr = @"2";
        [self.trainTicketSearchListBottomLayerView.btnForTimeIntervalButton setTitleColor:[UIColor whiteColor]
                                                                                 forState:UIControlStateNormal];
        [self.trainTicketSearchListBottomLayerView.btnForAchieveButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                                            forState:UIControlStateNormal];
        [self.trainTicketSearchListBottomLayerView.btnForDepartButton setTitleColor:[UIColor whiteColor]
                                                                           forState:UIControlStateNormal];
        
        [self.mainTableView triggerPullToRefresh];
    }
    
    else if (button.tag == KBtnForTimeIntervalButton) {
        
        self.searchOrderByStr = @"3";
        
        [self.trainTicketSearchListBottomLayerView.btnForTimeIntervalButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                                                                                 forState:UIControlStateNormal];
        [self.trainTicketSearchListBottomLayerView.btnForAchieveButton setTitleColor:[UIColor whiteColor]
                                                                            forState:UIControlStateNormal];
        [self.trainTicketSearchListBottomLayerView.btnForDepartButton setTitleColor:[UIColor whiteColor]
                                                                           forState:UIControlStateNormal];
        
        [self.mainTableView triggerPullToRefresh];
    }
    
    else if (button.tag == KBtnForSiftRequirementButton) {
        
        self.searchOrderByStr = @"";
        if (self.trainTicketSiftConditionAllLayerView) {
            
            __weak __typeof(&*self)weakSelf = self;
            CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
            [UIView animateWithDuration:0.3 animations:^{
                [weakSelf.trainTicketSiftConditionAllLayerView  setFrame:layerViewRect];
            }];
        }
    }
}

#pragma mark -
#pragma mark -  Method For UIScrollViewDelegate

//开始滑动，则隐藏信息
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.30 animations:^{
        CGRect bottomRect = CGRectMake(0.0f,
                                       (weakSelf.view.bounds.size.height)
                                       , KProjectScreenWidth, KTrainTicketSearchSetupBottomViewHeight);
        [weakSelf.trainTicketSearchListBottomLayerView setFrame:bottomRect];
    }];
}
//停止滑动，则显示搜索界面信息
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.30 animations:^{
        CGRect bottomRect = CGRectMake(0.0f,
                                       (weakSelf.view.bounds.size.height - KTrainTicketSearchSetupBottomViewHeight
                                        )
                                       , KProjectScreenWidth, KTrainTicketSearchSetupBottomViewHeight);
        [weakSelf.trainTicketSearchListBottomLayerView setFrame:bottomRect];
    }];
}


#pragma mark -
#pragma mark -  Method For TrainTicketAllSiftConditionDelegate
- (void)userSelectedConditionWithSeat:(NSString *)seatStr trainNumber:(NSString *)numberStr
                         beginStatuse:(NSString *)beginStr endStatuse:(NSString *)endStr{
    
    //坐席类型
    self.seatTypeStr = @"";
    if (!IsStringEmptyOrNull(seatStr)) {
        self.seatTypeStr = seatStr;
    }
    
    //火车票类型
    self.trainTypeStr = @"";
    if (!IsStringEmptyOrNull(numberStr)) {
        self.trainTypeStr = numberStr;
    }
    
    //出发站站筛选
    self.filterFromStr = @"";
    if (!IsStringEmptyOrNull(beginStr)) {
        self.filterFromStr = beginStr;
    }
    
    //终点站筛选
    self.filterToStr = @"";
    if (!IsStringEmptyOrNull(endStr)) {
        self.filterToStr = endStr;
    }
    
    [self.mainTableView triggerPullToRefresh];
    NSLog(@"self.seatTypeStr is 【%@】\nself.trainTypeStr is 【%@】\nself.filterFromStr is 【%@】\nself.filterToStr is 【%@】\n",self.seatTypeStr,self.trainTypeStr,self.filterFromStr,self.filterToStr);
}

@end
