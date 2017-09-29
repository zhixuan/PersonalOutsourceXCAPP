//
//  PerOrderListViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "PerOrderListViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"
#import "HTTPClient+OrderRequest.h"

#import "PerOrderTableViewCell.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

#import "OrderMenuSelectedBGView.h"
#import "UserPersonalOrderInformation.h"

#import "TrainticketOrderInforController.h"
#import "FlightOrderInfoDetailController.h"
#import "HotelOrderInfoDetailController.h"

@interface PerOrderListViewController ()<UITableViewDelegate,UITableViewDataSource,OrderMenuSelectedDelegate>
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
@property (nonatomic , strong)          DataPage                    *dataSource;

#pragma mark - 网络请求链接
/*!
 * @breif 网络请求链接
 * @See
 */
@property (nonatomic , strong)          AFHTTPRequestOperation      *requestDataOperation;


/*!
 * @breif 选择订单显示视图
 * @See
 */
@property (nonatomic , weak)            UIView                      *selectedOrderBGView;

/*!
 * @breif 设置显示订单类别信息
 * @See
 */
@property (nonatomic , weak)            UILabel                     *selectedTitleLabel;
/*!
 * @breif 箭头指示视图
 * @See
 */
@property (nonatomic , weak)            UIImageView                 *selectedArrowImageView;

/*!
 * @breif 头部选择视图
 * @See
 */
@property (nonatomic , weak)            OrderMenuSelectedBGView     *orderMenuStyleView;

/*!
 * @breif 用户是否是管理员
 * @See
 */
@property (nonatomic , assign)          BOOL                        isAdminBool;

/*!
 * @breif 查询数据类别设置
 * @See 不传默认全部，1是酒店，2是火车票
 */
@property (nonatomic , assign)          NSInteger                   userCheckOrderStyleInteger;
@end

@implementation PerOrderListViewController
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.dataSource = [DataPage page];
        
    }
    return self;
}

- (id)initWithUserCheckAllOrder{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = TRUE;
        self.dataSource = [DataPage page];
        
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
//    [self settingNavTitle:@"订单"];
    [self setNavBarTitleView];
    [self.selectedTitleLabel setText:@"全部订单"];
    self.isAdminBool = KXCAPPCurrentUserInformation.userOptionRoleStyle == OptionRoleStyleForAdministration?YES:NO;

    [self setTitleFrame];
    // Do any additional setup after loading the view.
    
    
    self.userCheckOrderStyleInteger = 0;
    [self setupPerOrderListViewControllerFrame];
    
    
    ///用户在该界面点击TarBar后刷新界面信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPersonalRefreshOrderDataNotification:) name:KXCAPPUserRefreshUserOrderDataNotification object:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setNavBarTitleView{
    
    
    CGRect rcTileView = CGRectMake(80, 0, (KProjectScreenWidth - 80.0*2), 44);
    
    UIButton *navBarBGView = [[UIButton alloc]initWithFrame:rcTileView];
    [navBarBGView setBackgroundColor:[UIColor clearColor]];
    [navBarBGView setBackgroundImage:createImageWithColor([UIColor clearColor])
                            forState:UIControlStateNormal];
    [navBarBGView addTarget:self action:@selector(selectedOrderStyleEventClicked)
           forControlEvents:UIControlEventTouchUpInside];
    [navBarBGView setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                            forState:UIControlStateHighlighted];
    self.navigationItem.titleView = navBarBGView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.textColor = KDefineUIButtonTitleNormalColor;
    [titleLabel setFont:KXCAPPUIContentDefautFontSize(20.0f)];
    self.selectedTitleLabel = titleLabel;
    [navBarBGView addSubview:self.selectedTitleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:[FontAwesome imageWithIcon:FMIconLowerArrow iconColor:[UIColor whiteColor]
                                          iconSize:16.0f imageSize:CGSizeMake(20.0f, 20.0f)]];
    self.selectedArrowImageView = imageView;
    [navBarBGView addSubview:self.selectedArrowImageView ];
    
    [self setTitleFrame];
     
    /*
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedBtn setBackgroundColor:[UIColor clearColor]];
    [selectedBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                            forState:UIControlStateNormal];
    [selectedBtn addTarget:self action:@selector(selectedOrderStyleEventClicked)
           forControlEvents:UIControlEventTouchUpInside];
    [selectedBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                            forState:UIControlStateHighlighted];
     self.navigationItem.titleView = selectedBtn;
     */

}


- (void)setupOrderMenuSelectedView{
    
    
    CGRect orderRect = CGRectMake(0.0f, -KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    
    NSArray *titleArray = @[@"全部订单",@"酒店订单",@"机票订单",@"火车票订单",];
    OrderMenuSelectedBGView *selectedView = [[OrderMenuSelectedBGView alloc]initWithFrame:orderRect
                                                                            withMenuArray:titleArray];
    [selectedView setDelegate:self];
    self.orderMenuStyleView = selectedView;
    [self.navigationController.view addSubview:self.orderMenuStyleView];
}

- (void)setTitleFrame{
    
    CGFloat titleWidth = (KProjectScreenWidth - 80.0*2);
    CGSize titleSize = [self.selectedTitleLabel.text sizeWithFont:self.selectedTitleLabel.font];
    [self.selectedTitleLabel setFrame:CGRectMake((titleWidth - titleSize.width - 25.0f)/2,
                                                 0.0f, titleSize.width, 44.0f)];
    [self.selectedArrowImageView setFrame:CGRectMake(self.selectedTitleLabel.right + 5.0f,
                                                     12.0f, 20.0f, 20.0f)];
    
}



- (void)userPersonalRefreshOrderDataNotification:(NSNotification *)notification{
    
    NSLog(@"双击后刷新该界面");
    [self.mainTableView triggerPullToRefresh];
}

- (void)selectedOrderStyleEventClicked{
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.orderMenuStyleView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight)];
            weakSelf.selectedArrowImageView .transform = CGAffineTransformMakeRotation(M_PI);
        }];

    });
}

- (void)setupPerOrderListViewControllerFrame{
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStylePlain];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [tbview setTableHeaderView:[self tableViewHeaderView]];
    
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
    
    [self setupOrderMenuSelectedView];
}


- (void)refreshListData{
    
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有·数据
    [self.dataSource cleanAllData];
    [self.mainTableView reloadData];
    [self loadMoreListData];
}

- (void)loadMoreListData{
    [self setupPerOrderListViewControllerDataSource];
}

///设置热门信息信息内容(活动/装备/线路)
- (void)setupPerOrderListViewControllerDataSource{
    
    __weak __typeof(&*self)weakSelf = self;
    
    /*
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        //关掉PullToRefreshView
        if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
        {
            UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
            [weakSelf.mainTableView.pullToRefreshView stopAnimating];
        }
        
        NSMutableArray *dataInforArray = [NSMutableArray array];
        for (int index = 0; index < 60; index ++) {
            

            UserPersonalOrderInformation *itemHotel = [[UserPersonalOrderInformation alloc]init];
            [itemHotel setUserOptionRoleStyle:OptionRoleStyleForAdministration];
            [itemHotel setUserOrderStyle:XCAPPOrderHotelForStyle];
            [itemHotel.hotelOrderInfor setOrderHotelPayState:index%8];
//            if (index %5 == 0) {
//                [itemHotel.hotelOrderInfor setOrderPayState:OrderStateForAlreadyCancel];
//            }else if (index%5 == 1){
//                [itemHotel.hotelOrderInfor setOrderPayState:OrderStateForAlreadyLeave];
//            }else if (index%5 == 2){
//                [itemHotel.hotelOrderInfor setOrderPayState:OrderStateForAlreadyConfirm];
//            }
//            else if (index%5 == 3){
//                [itemHotel.hotelOrderInfor setOrderPayState:OrderStateForWaitForConfirm];
//            }
//            else if (index%5 == 4){
//                [itemHotel.hotelOrderInfor setOrderPayState:OrderStateForWaitForPay];
//            }
            [itemHotel.hotelOrderInfor setOrderId:@"EGJISOGNVSDFJDGLK"];
            [itemHotel.hotelOrderInfor setOrderNumberStr:@"XCAPP201607151543A12"];
            
            [itemHotel.hotelOrderInfor setOrderStayDayesQuantityInteger:(index%3+1)];
            [itemHotel.hotelOrderInfor setOrderUnitPriceFloat:456.0f];
            if (index%3 != 2) {
                [itemHotel.hotelOrderInfor setOrderUnitPriceFloat:index%3 == 0?372.0f: 657.0f];
            }
            [itemHotel.hotelOrderInfor setOrderPaySumTotal:[NSString stringWithFormat:@"%.0f",itemHotel.hotelOrderInfor.orderUnitPriceFloat *itemHotel.hotelOrderInfor.orderStayDayesQuantityInteger]];
            
            
            if (index%6 == 2) {
                [itemHotel.hotelOrderInfor.orderHotelInforation setHotelNameContentStr:@"布丁酒店"];
            }

            ///酒店信息
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelNameContentStr:@"布丁酒店"];
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelAddressRoughStr:@"上海陆家嘴八佰伴店"];
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelAddressDetailedStr:@"张杨路818号"];
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelCoordinate:CLLocationCoordinate2DMake(40.03481674194336, 116.3718872070312)];
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelTelPhoneStr:@"010-81788188"];
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelMorningMealContent:@"无早"];
            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelRoomBerthContent:@"大床"];
            if (index %4 == 0) {
                [itemHotel.hotelOrderInfor.orderHotelInforation setHotelRoomBerthContent:@"双人床"];
            }else if (index%4 == 1){
                [itemHotel.hotelOrderInfor.orderHotelInforation setHotelRoomBerthContent:@"单床"];
            }else if (index%4 == 2){
                [itemHotel.hotelOrderInfor.orderHotelInforation setHotelRoomBerthContent:@"通铺"];
            }

            [itemHotel.hotelOrderInfor.orderHotelInforation setHotelIdStr:@"82389fjsdfk"];
            [itemHotel.hotelOrderInfor setOrderHotelId:@"82389fjsdfk"];
            
            [itemHotel.hotelOrderInfor setOrderCreateDate:@"2016-07-05 13:48"];
            [itemHotel.hotelOrderInfor setOrderUserMoveIntoDate:@"2016-07-21 入住"];
            [itemHotel.hotelOrderInfor setOrderUserArrivedDateTimeStr:@"18:00之前"];
            [itemHotel.hotelOrderInfor setOrderForHotelBeginDate:@"2016-07-21"];
            [itemHotel.hotelOrderInfor setOrderForHotelEndDate:@"2016-07-28"];
            
            
            ///入店人员信息
            NSArray *userInforArray = @[@"张利广",@"娟娟",@"张志轩",@"王辉"];
            [itemHotel.hotelOrderInfor setOrderMoveIntoUsersArray:userInforArray];
            
            ///联系人信息
            [itemHotel.hotelOrderInfor.orderCreateUserInfor setUserPerPhoneNumberStr:@"18718806560"];
            [itemHotel.hotelOrderInfor.orderCreateUserInfor setUserPerEmailStr:@"zhangliguang@lvye.com"];
            [itemHotel.hotelOrderInfor.orderCreateUserInfor setUserNameStr:@"徐峥"];
            
            if (index%2 == 0) {
                [itemHotel.hotelOrderInfor setOrderUserMatterStateStyle:MatterStateStyleForOfficialBusinessStyle];
            }else{
                [itemHotel.hotelOrderInfor setOrderUserMatterStateStyle:MatterStateStyleForPrivateConcernStyle];
            }


            
            //////模拟火车票
            if (index/20 == 1) {
                [itemHotel setUserOrderStyle:XCAPPOrderForTrainTicketStyle];
                [itemHotel.trainticketOrderInfor setTtOrderDepartDate:@"2016-09-05"];
                [itemHotel.trainticketOrderInfor.ttOrderTrainticketInfor setTraTakeOffSite:@"上海虹桥"];
                [itemHotel.trainticketOrderInfor.ttOrderTrainticketInfor setTraArrivedSite:@"北京南"];
                [itemHotel.trainticketOrderInfor setTtOrderDepartDate:@"2016-09-06"];
                [itemHotel.trainticketOrderInfor setTtTicketTotalVolume:index%3 == 0?372.5f: 657.5f];
                
                ///预订人信息
                [itemHotel.trainticketOrderInfor.ttOrderReserveUserInfor setUserPerId:@"ksjksf"];
                [itemHotel.trainticketOrderInfor.ttOrderReserveUserInfor setUserNameStr:@"徐帆"];
                [itemHotel.trainticketOrderInfor.ttOrderReserveUserInfor setUserPerPhoneNumberStr:@"18615459060"];
//                [itemHotel.trainticketOrderInfor setTtOrderStateStyle:[NSString stringWithFormat:@"%zi",(index%5+1)]];
                [itemHotel.trainticketOrderInfor setTtOrderStateStyle:(index%7)];
//                NSLog(@"itemHotel.trainticketOrderInfor.ttOrderStateStyle is %zi",itemHotel.trainticketOrderInfor.ttOrderStateStyle);
                
                
                NSMutableArray *dataInforArray = [NSMutableArray array];
                for (int index = 10; index < 15; index ++) {
                    
                    UserInformationClass *itemTicket = [[UserInformationClass alloc]init];
                    [itemTicket setUserPerId:[NSString stringWithFormat:@"48520JEIOVMAKF0383%i",index]];
                    if (index%3 == 0) {
                        [itemTicket setUserNameStr:@"薛之嫌"];
                        [itemTicket setUserPerCredentialStyle:@"身份证"];
                    }else  if (index%3 == 1) {
                        [itemTicket setUserNameStr:@"杨利伟"];
                        [itemTicket setUserPerCredentialStyle:@"护照"];
                    }
                    else  if (index%3 == 2) {
                        [itemTicket setUserNameStr:@"张丽娜"];
                        [itemTicket setUserPerCredentialStyle:@"军官证"];
                    }
                    
                    [itemTicket setUserPerCredentialContent:[NSString stringWithFormat:@"1304251987082974%i",index]];
                    
                    [dataInforArray addObject:itemTicket];
                }
                
                [itemHotel.trainticketOrderInfor.ttOrderBuyTicketUserMutArray setArray:dataInforArray];

            }
            
            //////模拟飞机票
            else if (index/20 == 2) {
                [itemHotel setUserOrderStyle:XCAPPOrderForFlightStyle];
                [itemHotel.flightOrderInfor setFliOrderTakeOffDate:@"2016-09-05"];
                [itemHotel.flightOrderInfor setFliOrderArrivedSite:@"北京"];
                [itemHotel.flightOrderInfor setFliOrderTakeOffSite:@"上海"];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightTakeOffAirport:@"虹桥 T1"];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightArrivedAirport:@"首都 T3"];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightName:[NSString stringWithFormat:@"东航GU10%i",index]];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightModelName:[NSString stringWithFormat:@"74%i大",index%8]];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightUnitPrice:920+index*20];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightTakeOffTime:@"09:00"];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightArrivedTime:@"11:30"];
                [itemHotel.flightOrderInfor.fliOrderOneWayInfor setFlightCabinModelStr:@"高端经济舱"];
  
                [itemHotel.flightOrderInfor setFliOrderForFlightPayStyle:index%12];
                ///预订人信息
                [itemHotel.flightOrderInfor.flightOrderCreateUserInfor setUserPerId:@"ksjksf"];
                [itemHotel.flightOrderInfor.flightOrderCreateUserInfor setUserNameStr:@"徐帆"];
                [itemHotel.flightOrderInfor.flightOrderCreateUserInfor setUserPerPhoneNumberStr:@"18615459060"];
                
  
                NSMutableArray *dataInforArray = [NSMutableArray array];
                for (int index = 10; index < 13; index ++) {
                    
                    UserInformationClass *itemTicket = [[UserInformationClass alloc]init];
                    [itemTicket setUserPerId:[NSString stringWithFormat:@"48520JEIOVMAKF0383%i",index]];
                    if (index%3 == 0) {
                        [itemTicket setUserNameStr:@"薛之嫌"];
                        [itemTicket setUserPerCredentialStyle:@"身份证"];
                    }else  if (index%3 == 1) {
                        [itemTicket setUserNameStr:@"杨利伟"];
                        [itemTicket setUserPerCredentialStyle:@"护照"];
                    }
                    else  if (index%3 == 2) {
                        [itemTicket setUserNameStr:@"张丽娜"];
                        [itemTicket setUserPerCredentialStyle:@"军官证"];
                    }
                    
                    [itemTicket setUserPerCredentialContent:[NSString stringWithFormat:@"1304251987082974%i",index]];
                    
                    [dataInforArray addObject:itemTicket];
                }
                
                [itemHotel.flightOrderInfor.flightOrderUserMutArray setArray:dataInforArray];
            }
            
            
            [dataInforArray addObject:itemHotel];
        }
        
        
      
        
        [self.dataSource appendPage:dataInforArray];
        [self.dataSource setPageCount:1];
        [self.mainTableView reloadData];
        
    });
     
     */
    
    
    self.requestDataOperation = [XCAPPHTTPClient orderListInforWithuserId:KXCAPPCurrentUserInformation.userPerId pageRow:self.dataSource.nextPageIndex pageSize:0 styleType:self.userCheckOrderStyleInteger completion:^(WebAPIResponse *response) {
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
        
            NSLog(@"orderListInforWithuserId %@",response.responseObject);
            
            
            //关掉PullToRefreshView
            if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
                [weakSelf.mainTableView.pullToRefreshView stopAnimating];
            }
            
            
            if (response.code == WebAPIResponseCodeSuccess) {
//                NSLog(@"response.responseObject is %@",response.responseObject);
                
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyList) isKindOfClass:[NSArray class]]) {
                        NSArray *dataListArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyList);
                        
                        
                        NSMutableArray *dataInforArray = [NSMutableArray array];
                        for (NSDictionary *item in dataListArray) {
//                            NSLog(@"item is %@\n=========\n",item)
                            
                            UserPersonalOrderInformation *itemOrder = [UserPersonalOrderInformation initializaionWithUserAllOrderInfoWithUnserializedJSONDic:item];
                            
                            [dataInforArray addObject:itemOrder];
                        }
                        
                        [self.dataSource appendPage:dataInforArray];
                    }
                    
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyPageTotal) isKindOfClass:[NSNumber class]]) {
                        
                        
                        NSInteger pageTotal = IntForKeyInUnserializedJSONDic(dataDictionary,KDataKeyPageTotal);
                        [self.dataSource setPageCount:pageTotal];
                        
                        NSLog(@"NS pageTotal is %zi",pageTotal);
                    }
                    
//                    [self.dataSource setPageCount:1];
                    [self.mainTableView reloadData];
                
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
            }
            else{
                
                if (weakSelf.loadMoreCell) {
                    [weakSelf.loadMoreCell stopLoadingAnimation];
                    if (response.code == WebAPIResponseCodeNetError) {
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                    }else{
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
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
        
        return self.isAdminBool ? KPerOrderCellHeightForAdministration:KPerOrderCellHeightForGuest;
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
    PerOrderTableViewCell* cell = [[PerOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    UserPersonalOrderInformation *itemData = (UserPersonalOrderInformation *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    PerOrderTableViewCell *orderCell = (PerOrderTableViewCell* )cell;
    [orderCell setupPerOrderTableViewCellDataSource:itemData indexPath:indexPath];
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
//                cell.textLabel.text = LOADMORE_LOADOVER;
                cell.textLabel.text = @"没有更多了~仅支持查看3个月内订单";
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

    
    UserPersonalOrderInformation *itemOrder = (UserPersonalOrderInformation *)[self.dataSource.data objectAtIndex:indexPath.row];
    
    if (itemOrder.userOrderStyle == XCAPPOrderHotelForStyle) {

        HotelOrderInfoDetailController *viewController = [[HotelOrderInfoDetailController alloc]initWithHotelOrderInfor:itemOrder.hotelOrderInfor];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (itemOrder.userOrderStyle == XCAPPOrderForTrainTicketStyle){
        TrainticketOrderInforController *viewController = [[TrainticketOrderInforController alloc]initWithTrainticketOrderInfor:itemOrder.trainticketOrderInfor];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (itemOrder.userOrderStyle == XCAPPOrderForFlightStyle){
        
        FlightOrderInfoDetailController *viewController = [[FlightOrderInfoDetailController alloc]initWithFlightOrder:itemOrder.flightOrderInfor];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }

}

- (void)dismissViewOrderMenuSelectedAnimatedButtonEvent{
    __weak __typeof(&*self)weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.orderMenuStyleView setFrame:CGRectMake(0.0f, -KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight)];
            weakSelf.selectedArrowImageView .transform = CGAffineTransformMakeRotation(0);
        }];
    });
}

- (void)userSelectedShowOrderWithTitle:(NSString *)title withTag:(NSInteger)tag{

    self.userCheckOrderStyleInteger = tag - KBtnOperationButtonBaseTag;
    NSLog(@"title is %@ \n tag is %zi",title,self.userCheckOrderStyleInteger);
    [self.selectedTitleLabel setText:title];
    [self setTitleFrame];
    
    [self dismissViewOrderMenuSelectedAnimatedButtonEvent];
    
    [self.mainTableView triggerPullToRefresh];
}

@end
