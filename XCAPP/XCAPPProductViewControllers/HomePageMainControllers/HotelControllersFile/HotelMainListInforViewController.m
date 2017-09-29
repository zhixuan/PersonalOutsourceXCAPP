//
//  HotelMainListInforViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelMainListInforViewController.h"
#import "HotelInforTableViewCell.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"
#import "BusinessTravelExplainController.h"
#import "HTTPClient+PersonalInfor.h"
#import "HotelSearcSetupBottomView.h"
#import "MoreSiftRequirementController.h"

#import "HotelDetailMainViewController.h"

#import "DefaultotelRecommendSearchLayerView.h"
#import "PriceStarSearchLayerView.h"


#define KBtnForRoadAddressBtnTag                (1530111)


@interface HotelMainListInforViewController ()<UITableViewDataSource,UITableViewDelegate,XCLocationManagerDelegate,HotelSearcSetupDelegate,MoreSiftRequirementDelegate,DefaultotelRecommendDelegate,PriceStarSearchDelegate>


/*!
 * @breif 当前搜索到得酒店总数
 * @See
 */
@property (nonatomic , assign)      NSInteger               hotelCountInteger;

/*!
 * @breif 酒店总数头部显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *hotelTitleLabel;

/*!
 * @breif 酒店总数头部显示信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *hotelMoveIntoLabel;

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
 * @breif 查询种类设置
 * @See
 */
@property (nonatomic , assign)      UserMatterStateStyle            userPerMatterStateStyle;


/*!
 * @breif 右侧头部按键
 * @See
 */
@property (nonatomic , weak)            UIButton                    *rightBarButton;


/*!
 * @breif 设置是否可操作右侧按键
 * @See 默认为NO，
 */
@property (nonatomic , assign)      BOOL                        rightButtonOperationBool;


/*!
 * @breif 定位信息
 * @See
 */
@property (nonatomic , strong)      XCLocationAPIResponse           *locationResponseResult;

/*!
 * @breif 定位设置
 * @See
 */
@property (nonatomic , strong)      XCLocationManager           *hotelLocationManager;


/*!
 * @breif 定位信息
 * @See
 */
@property (nonatomic , weak)      UILabel                       *hotelNearbyAddress;

/*!
 * @breif 搜索查询条件设置界面
 * @See
 */
@property (nonatomic , weak)      HotelSearcSetupBottomView     *hotelSearchView;

/*!
 * @breif 头部导航栏高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                     navigationBarHeight;


/*!
 * @breif 默认搜索视图设置
 * @See
 */
@property (nonatomic , weak)        DefaultotelRecommendSearchLayerView         *hotelRecommendSearchLayerView;

/*!
 * @breif 价格星级搜索视图
 * @See
 */
@property (nonatomic , weak)      PriceStarSearchLayerView                  *priceStarSearchView;



/*!
 * @breif 用户模糊搜索按键
 * @See
 */
@property (nonatomic , weak)      UIButton                              *userSearchBtn;

/*!
 * @breif 用户个人的搜索条件信息
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation           *userPersonalHotelOrderInfor;

/*!
 * @breif 价格排序
 * @See
 */
@property (nonatomic , strong)      NSString                            *userWillPriceSequenceStr;

/*!
 * @breif 排序规则（降序或者升序）
 * @See 升序为0，降序为1
 */
@property (nonatomic , assign)      NSInteger                           userWillUpAndDownSequenceType;

/*!
 * @breif 最高价格
 * @See
 */
@property (nonatomic , strong)      NSString                            *userHotelMaxPirceStr;

/*!
 * @breif 最低价格
 * @See
 */
@property (nonatomic , strong)      NSString                            *userHotelMinPirceStr;

/*!
 * @breif 星级信息
 * @See 数字表示
 */
@property (nonatomic , strong)      NSString                            *userHotelStarStypeStr;

/*!
 * @breif 所在行政区编码
 * @See
 */
@property (nonatomic , strong)      NSString                            *userHotelAtAreaCodeStr;
@end

@implementation HotelMainListInforViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (id)initWithMatterStateStyle:(UserMatterStateStyle)stateStyle locationInfor:(XCLocationAPIResponse *)locationInfor searchInfor:(UserHotelOrderInformation *)orderInfor{
    self = [super init];
    if (self) {
        self.userPerMatterStateStyle = stateStyle;
        self.dataSource = [DataPage page];
        self.locationResponseResult = locationInfor;
        self.userPersonalHotelOrderInfor = orderInfor;
        
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
    NSDictionary *beginDictionary = dateYearMonthDayWeekWithDateStr(self.userPersonalHotelOrderInfor.orderForHotelBeginDate);
    NSDictionary *endDictionary = dateYearMonthDayWeekWithDateStr(self.userPersonalHotelOrderInfor.orderForHotelEndDate);
    
    NSString *titleInfor = [NSString stringWithFormat:@"%@ - %@ | %zi晚",StringForKeyInUnserializedJSONDic(beginDictionary, @"monthday"),
                            StringForKeyInUnserializedJSONDic(endDictionary, @"monthday"),
                            self.self.userPersonalHotelOrderInfor.orderStayDayesQuantityInteger];
    
    [self setsettingNavTitle];
    
    [self.hotelTitleLabel setText:@"会员酒店--家"];
    [self.hotelMoveIntoLabel setText:titleInfor];
    [self setupHotelMainListInforViewControllerFrame];
    
    self.userWillPriceSequenceStr = @"";
    self.userWillUpAndDownSequenceType = 1;
    
    self.userHotelMaxPirceStr = @"";
    
    self.userHotelMinPirceStr = @"";
    self.userHotelStarStypeStr = @"";
    self.userHotelAtAreaCodeStr = @"";
    
}


- (void)setsettingNavTitle{
    
    CGFloat left_X = KXCUIControlSizeWidth(90.0f);
    CGRect rcTitleView = CGRectMake(left_X, 0, (KProjectScreenWidth - left_X*2), 44);
    UIView *titleBCView = [[UIView alloc]initWithFrame:rcTitleView];
    [titleBCView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:KXCAPPUIContentDefautFontSize(18)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFrame:CGRectMake(0.0f, 0.0f, titleBCView.width, 22.0f)];
    self.hotelTitleLabel = titleLabel;
    [titleBCView addSubview:self.hotelTitleLabel];
    
    UILabel *moveintoDate = [[UILabel alloc]init];
    [moveintoDate setBackgroundColor:[UIColor clearColor]];
    [moveintoDate setFont:KXCAPPUIContentDefautFontSize(12)];
    [moveintoDate setTextColor:HUIRGBColor(143.0f, 232.0f, 255.0f, 1.0f)];
    [moveintoDate setTextAlignment:NSTextAlignmentCenter];
    [moveintoDate setFrame:CGRectMake(0.0f, titleLabel.bottom, titleLabel.width, 20.0f)];
    self.hotelMoveIntoLabel = moveintoDate;
    [titleBCView addSubview:self.hotelMoveIntoLabel];
    
    
    self.navigationItem.titleView = titleBCView;
}

- (void)setRightNavButtonTitleStr:(NSString *)titleStr withFrame:(CGRect)frame actionTarget:(id)target action:(SEL)action{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = KXCAPPUIContentFontSize(14.0f);
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [navButton setTitle:titleStr forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor colorWithRed:205.0f/255.0f green:205.0f/255.0f
                                              blue:205.0f/255.0f alpha:0.7f]
                    forState:UIControlStateHighlighted];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightBarButton = navButton;
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarButton];
    
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4);
    }
    self.navigationItem.rightBarButtonItem = navItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)rightButtonOperationEvent{
    
    
    if (!self.rightButtonOperationBool) {
        return;
    }
    
    BusinessTravelExplainController *viewController = [[BusinessTravelExplainController alloc]init];
    XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc]init];
    [headerView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(10.0f + 30.0f))];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    
    UIView *greyColorView = [[UIView alloc]init];
    [greyColorView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
    [greyColorView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(30.0f))];
    [headerView addSubview:greyColorView];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    [addressLabel setBackgroundColor:[UIColor clearColor]];
    [addressLabel setTextColor:[UIColor whiteColor]];
    [addressLabel setFont:KXCAPPUIContentFontSize(12)];
    [addressLabel setTextAlignment:NSTextAlignmentLeft];
    [addressLabel setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f), 0.0f,
                                      (KProjectScreenWidth - KXCUIControlSizeWidth(40.0f + 10.0f)),
                                      KXCUIControlSizeWidth(30.0f))];
    self.hotelNearbyAddress = addressLabel;
    [greyColorView addSubview:self.hotelNearbyAddress];
    
    [self.hotelNearbyAddress setText:@"位置:---"];
    if (self.locationResponseResult.isSuccess) {
        [self.hotelNearbyAddress setText:[NSString stringWithFormat:@"位置: %@",self.locationResponseResult.addressStr]];
    }
    
    return headerView;
}
- (void)setupHotelMainListInforViewControllerFrame{
    
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
    HotelSearcSetupBottomView *bottomView = [[HotelSearcSetupBottomView alloc]initWithFrame:bottomRect];
    //    [bottomView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 0.30)];
    [bottomView setDelegate:self];
    self.hotelSearchView = bottomView;
    [self.view addSubview:self.hotelSearchView];
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    
    NSArray *array =  @[@"推荐排序",
                        @"价格从低到高",
                        @"价格从高到低",
                        @"距离由近到远",];
    DefaultotelRecommendSearchLayerView *hotelRecommendView = [[DefaultotelRecommendSearchLayerView alloc]initWithFrame:layerViewRect withSearchContent:array];
    [hotelRecommendView setDelegate:self];
    self.hotelRecommendSearchLayerView = hotelRecommendView;
    [self.navigationController.view addSubview:self.hotelRecommendSearchLayerView];
    //    [self.hotelRecommendSearchLayerView setHidden:YES];
    
    PriceStarSearchLayerView *priceSearchView = [[PriceStarSearchLayerView alloc]initWithFrame:layerViewRect];
    [priceSearchView setDelegate:self];
    self.priceStarSearchView = priceSearchView;
    [self.navigationController.view addSubview:self.priceStarSearchView];
    //    [self.priceStarSearchView setHidden:YES];
}


- (void)setupWithOperationButtonClickedEvent:(UIButton *)button{
    
    self.userSearchBtn = button;
    if (button.tag == KBtnForDistanceButtonTag) {
        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.self.hotelRecommendSearchLayerView setFrame:layerViewRect];
        }];
        //        [self.hotelRecommendSearchLayerView setHidden:NO];
    }
    
    else  if (button.tag == KBtnForPriceButtonTag) {
        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        //        [self.priceStarSearchView setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            [self.priceStarSearchView setFrame:layerViewRect];
        }];
        
    }
    
    ///更多筛选条件
    else  if (button.tag == KBtnForMoreButtonTag) {
        MoreSiftRequirementController *viewController = [[MoreSiftRequirementController alloc]initWithCityCodeStr:self.userPersonalHotelOrderInfor.orderAtCityCodeStr];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigation animated:YES completion:^{
            
        }];
        
    }
}
#pragma mark -
#pragma mark -  定位成功使用方法
- (void)locationDidFinishResponse:(XCLocationAPIResponse *)locationResult{
    if (locationResult.isSuccess) {
        
    }
}

#pragma mark -
#pragma mark -  默认用户推荐搜索操作控制协议方法
- (void)userSelectedDefaultotelRecommendSearchStyle:(NSInteger)Searchstyle styleName:(NSString *)styleNameStr{
    if(self.userSearchBtn){
        [self.userSearchBtn setTitle:styleNameStr forState:UIControlStateNormal];
        
        if (Searchstyle == 0) {
            self.userWillPriceSequenceStr = @"";
            self.userWillUpAndDownSequenceType = 1;
        }
        
        else if (Searchstyle == 1) {
            self.userWillPriceSequenceStr = @"price";
            self.userWillUpAndDownSequenceType = 0;
        }
        
        else if (Searchstyle == 2) {
            self.userWillPriceSequenceStr = @"price";
            self.userWillUpAndDownSequenceType = 1;
        }
        
        else if (Searchstyle == 3) {
            self.userWillPriceSequenceStr = @"";
            self.userWillUpAndDownSequenceType = 0;
        }
    }
    NSLog(@" Searchstyle is %zi\n styleNameStr is %@",Searchstyle,styleNameStr);
    
    [self.mainTableView triggerPullToRefresh];
}



#pragma mark -
#pragma mark -  价格星级搜索操作控制协议方法
- (void)userPriceStarSearchWithMinPice:(NSString *)minPrice maxPrice:(NSString *)maxPrice starStyle:(NSString *)starStyle{
    NSLog(@"\t\tminPrice is %@\tmaxPrice is %@\t\tstarStyle is %@",minPrice,maxPrice,starStyle);
    
    
    self.userHotelMaxPirceStr = maxPrice;
    
    self.userHotelMinPirceStr = minPrice;
    self.userHotelStarStypeStr = starStyle;
    
    [self.mainTableView triggerPullToRefresh];
}
#pragma mark -
#pragma mark - 行政区域设置【搜索】
- (void)moreSiftRequirementButtonOperationEventWithAreaCode:(NSString *)areaCodeStr{
    NSLog(@"行政区域设置 areaCodeStr is %@",areaCodeStr);
    
    self.userHotelAtAreaCodeStr = areaCodeStr;
    
    [self.mainTableView triggerPullToRefresh];
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
    [self setupHomeHotTopicInforControllerDataSource];
}

///设置热门信息信息内容(活动/装备/线路)
- (void)setupHomeHotTopicInforControllerDataSource{
    
    __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation = [XCAPPHTTPClient userRoughSearchHotelListInforWithCityName:self.userPersonalHotelOrderInfor.orderAtCityNameStr areaId:self.userHotelAtAreaCodeStr hName:@"" maxPrice:self.userHotelMaxPirceStr minPrice:self.userHotelMinPirceStr hStar:self.userHotelStarStypeStr pageRow:self.dataSource.nextPageIndex
                                                                                     field:self.userWillPriceSequenceStr
                                                                                    upDown:self.userWillUpAndDownSequenceType completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            //关掉PullToRefreshView
            if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
                [weakSelf.mainTableView.pullToRefreshView stopAnimating];
            }
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    
                    ///火车票数据信息
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list") isKindOfClass:[NSArray class]]) {
                        NSArray *hotelArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        
                        
                        NSMutableArray *dataInforArray = [NSMutableArray array];
                        
                        for (NSDictionary *dataInfor in hotelArray) {
                            
                            HotelInformation *itemTicket = [HotelInformation initializaionWithHotelListInformationWithUnserializedJSONDic:dataInfor];
                            [dataInforArray addObject:itemTicket];
                        }
                        
                        NSInteger hotelCount = dataInforArray.count;
                        [weakSelf.hotelTitleLabel setText:[NSString stringWithFormat: @"会员酒店%zi家",hotelCount]];
                        [weakSelf.dataSource appendPage:dataInforArray];
                        [weakSelf.dataSource setPageCount:1];
                        [weakSelf.mainTableView reloadData];
                        
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
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                    }
                }
            }
        });
    }];
    
  /*
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        //关掉PullToRefreshView
        if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
        {
            UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
            [weakSelf.mainTableView.pullToRefreshView stopAnimating];
        }
        
        NSArray *nameArray = @[@"京都尚水商务会馆",
                               @"武汉五月花酒店",
                               @"武汉四季鑫宝来酒店",
                               @"武汉君庭酒店",
                               @"武汉沌口长江大酒店",
                               @"全季酒店",
                               @"四季御园国际大酒店",
                               @"雾灵山庄",
                               ];
        
        NSArray *starArray = @[@"舒适型",
                               @"高档型",
                               @"五星级",
                               @"经济型",
                               @"四星级",
                               @"豪华型",
                               @"三星级",];
        
        NSArray *commentArray = @[@"4.7分",
                                  @"4.4分",
                                  @"3.9分",
                                  @"4.2分",
                                  @"4.8分",
                                  @"3.6分",
                                  @"4.9分",];
        NSMutableArray *dataInforArray = [NSMutableArray array];
        for (int index = 0; index < 18; index ++) {
            
            HotelInformation *itemHotel = [[HotelInformation alloc]init];
            [itemHotel setHotelIdStr:@"001"];
            CGFloat distance = 184.2*(index+1);
            [itemHotel setHotelDistanceStr:[NSString stringWithFormat:@"%.0lf米",distance]];
            CGFloat distanceMax = distance/1e3;
            if ( distanceMax> 1) {
                [itemHotel setHotelDistanceStr:[NSString stringWithFormat:@"%.2lf公里",distanceMax]];
            }
            [itemHotel setHotelNameContentStr:nameArray[(index%8)]];
            [itemHotel setHotelRankContentStr:starArray[(index%7)]];
            [itemHotel setHotelAddressDetailedStr:@"张杨路818号 能汤臣中心C栋161"];
            [itemHotel setHotelMarkRecordContentStr:commentArray[(index%7)]];
            [itemHotel setHotelImageDisplayURLStr:@"http://mobile-res.lvye.cn/2016/06/29/33qepxmpg54i11yy.png"];
            [itemHotel setHotelMinUnitPriceFloat:458];
            [itemHotel setHotelAddressRoughStr:@"中关村、五道口"];
            [itemHotel setHotelCoordinate:CLLocationCoordinate2DMake(40.03481674194336, 116.3718872070312)];
            [dataInforArray addObject:itemHotel];
        }
        
        [self.dataSource appendPage:dataInforArray];
        [self.dataSource setPageCount:1];
        [self.mainTableView reloadData];
        
    });
    
    
    */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;
    
    
    
    if (indexPath.row < [self.dataSource.data count]) {
        
        
        
        return KHotelInforTableViewCellHeight;
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
    HotelInforTableViewCell* cell = [[HotelInforTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    HotelInformation *itemData = (HotelInformation *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    HotelInforTableViewCell *hotelCell = (HotelInforTableViewCell* )cell;
    [hotelCell setupHotelInforTableViewCellDataSource:itemData indexPath:indexPath];
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
    
    
    HotelInformation *itemHotel = (HotelInformation *)[self.dataSource.data objectAtIndex:indexPath.row];
    [self.userPersonalHotelOrderInfor setOrderHotelInforation:itemHotel];
    [self.userPersonalHotelOrderInfor setOrderHotelId:itemHotel.hotelIdStr];
    HotelDetailMainViewController *viewController = [[HotelDetailMainViewController alloc]initWithHotelInfor:self.userPersonalHotelOrderInfor];
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
        [self.hotelSearchView setFrame:bottomRect];
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
        [self.hotelSearchView setFrame:bottomRect];
    }];
    
}


@end
