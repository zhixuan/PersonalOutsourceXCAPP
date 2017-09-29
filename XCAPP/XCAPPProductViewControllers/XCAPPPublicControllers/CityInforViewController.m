//
//  CityInforViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/17.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "CityInforViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "HTTPClient+HotelsRequest.h"

#import "CityInforForTrainTicketTableViewCell.h"

#define KTableForSeaerchTableViewTag            (1720111)
#define KTableForCityInforTableViewTag          (1720112)


#define KBtnForCurrentCityButtonTag             (1820111)
#define KBtnForNearbyCityButtonTag              (1820112)
#define KBtnForHistoryCityButtonTag             (1920111)

@interface CityInforViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>


#pragma mark - 城市信息显示图
/*!
 * @breif 城市信息显示图
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
 * @breif 用户选择的是出发地还是到达地
 * @See
 */
@property (nonatomic , assign)      UserSelectedCityStyle           cityStyle;
/*!
 * @breif 类名字符串
 * @See
 */
@property (nonatomic , strong)                  NSString                *controlTitleStr;



#pragma mark - 界面数据源
/*!
 * @breif 左侧界面数据源
 * @See
 */
@property (nonatomic , strong)          DataPage                *searchCityDataSource;

/*
 * @breif 搜索设置
 * @See
 */
@property (nonatomic , weak)      UISearchBar                   *hotelSearchBarView;


/*!
 * @breif 当前城市信息
 * @See
 */
@property (nonatomic , weak)      UILabel                       *userAtCurrentCityNameLabel;

/*!
 * @breif 搜索到得数据内容
 * @See
 */
@property (nonatomic, strong) UISearchDisplayController         *searchDisplayController;

/*!
 * @breif 搜索背景图信息
 * @See
 */
@property (nonatomic , weak)      UIView                        *searchViewBgView;
@end

@implementation CityInforViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.searchCityDataSource = [DataPage page];
    }
    return self;
}

- (id)initWithTitleStr:(NSString *)titleStr style:(UserSelectedCityStyle)style{
    self = [super init];
    if (self) {
        self.controlTitleStr = titleStr;
        self.cityStyle = style;
        self.dataSource = [DataPage page];
        self.searchCityDataSource = [DataPage page];
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
    
    [self settingNavTitle:self.controlTitleStr];
    
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect
                      actionTarget:self action:@selector(leftBarButtonClickedEvent)];
    // Do any additional setup after loading the view.
    
    [self setupCityInforViewControllerFrame];
    //    [self setupCityInforViewControllerDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonClickedEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)setupCityInforViewControllerFrame{
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStyleGrouped];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview setTableHeaderView:[self cityTableHeaderView]];
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
    
}



- (UIView *)cityTableHeaderView{
    UIView *cityTableHeaderBGView = [[UIView alloc]init];
    [cityTableHeaderBGView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(40.0f))];
    [cityTableHeaderBGView setBackgroundColor:[UIColor whiteColor]];
    UISearchBar *m_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0.0f, KProjectScreenWidth, 40)];
    
    m_searchBar.delegate = self;
    m_searchBar.alpha = 1;
    m_searchBar.placeholder = @"北京/beijing/bj";
    m_searchBar.backgroundImage=createImageWithColor([UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1]);
    self.hotelSearchBarView = m_searchBar;
    [cityTableHeaderBGView  addSubview:self.hotelSearchBarView];
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.hotelSearchBarView contentsController:self];
    self.searchDisplayController.active = NO;
    [self.searchDisplayController.searchResultsTableView setTag:KTableForSeaerchTableViewTag];
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    
    return cityTableHeaderBGView;
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
    [self setupCityInforViewControllerDataSource];
}


- (void)setupCityInforViewControllerDataSource{
    
    
    __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation =[XCAPPHTTPClient  userRequestCityInforForHotelCompletion:^(WebAPIResponse *response) {
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
                        
                        NSMutableArray *citiesArray = [NSMutableArray array];
                        for (NSDictionary *cityDic in dataListArray) {
                            NSLog(@"\ncityName\t\t%@cityCode\t\t%@",StringForKeyInUnserializedJSONDic(cityDic,@"city_id"),StringForKeyInUnserializedJSONDic(cityDic,@"city"));
                            
                            NSDictionary *itemDic = @{@"name":StringForKeyInUnserializedJSONDic(cityDic,@"city"),
                                                      @"code":StringForKeyInUnserializedJSONDic(cityDic,@"city_id")};
                            [citiesArray addObject:itemDic];
                        }
                        
                        [self.dataSource appendPage:citiesArray];
                        [self.dataSource setPageCount:1];
                        [self.mainTableView reloadData];
                    }
                }
            }
        });
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    heightForRow =  KCityForTrainTicketCellHeight;
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat  heightForHeader = 0.0f;
    if (tableView  == self.mainTableView) {
        
        ///当前城市信息高度
        heightForHeader = (KInforLeftIntervalWidth + KXCUIControlSizeWidth(20.0f) + KInforLeftIntervalWidth + KFunctionModulButtonHeight*2);
        
        NSArray *historayArray = KXCShareFMSetting.userReserveHotelCitiesMutableArray;
        ///数据个数
        NSInteger cityCount = historayArray.count;
        
        if (cityCount > 0) {
            
            if (cityCount > 20) {
                cityCount = 20;
            }
            
            ///历史城市头部高度
            heightForHeader = (heightForHeader+(KInforLeftIntervalWidth + KXCUIControlSizeWidth(20.0f) + KInforLeftIntervalWidth));
            
            NSInteger rowCount = 5;
            ///当前行数
            NSInteger rowInteger = cityCount/rowCount;
            
            ///最后一行的数据个数
            NSInteger columnMin = cityCount%rowCount;
            
            if (columnMin != 0) {
                rowInteger+=1;
            }
            heightForHeader= (heightForHeader+KFunctionModulButtonHeight*rowInteger);
        }
        
        
        
        ///城市列表高度
        heightForHeader = (heightForHeader + KInforLeftIntervalWidth*2 + KXCUIControlSizeWidth(20.0f));
        
        return heightForHeader;
    }
    
    return heightForHeader;
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
    
    NSInteger numberOfRows = 0;
    if ([tableView isEqual:self.mainTableView]) {
        
        numberOfRows =  ([self.dataSource count]);
    }else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        numberOfRows = ([self.searchCityDataSource count]);
    }
    
    return  numberOfRows;

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *viewForHeader = [[UIView alloc]init];
    if (tableView == self.mainTableView) {
        
        UILabel *currentCityTitle = [[UILabel alloc]init];
        [currentCityTitle setBackgroundColor:[UIColor clearColor]];
        [currentCityTitle setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [currentCityTitle setTextColor:KContentTextColor];
        [currentCityTitle setTextAlignment:NSTextAlignmentLeft];
        [currentCityTitle setText:@"当前"];
        [currentCityTitle setFrame:CGRectMake(KInforLeftIntervalWidth,(KInforLeftIntervalWidth),
                                              KXCUIControlSizeWidth(90.0f), KXCUIControlSizeWidth(20.0f))];
        [viewForHeader addSubview:currentCityTitle];
        
        
        // 当前位置
        UIButton *nearHotelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nearHotelButton setFrame:CGRectMake(0,(currentCityTitle.bottom + KInforLeftIntervalWidth),
                                             KProjectScreenWidth,
                                             KFunctionModulButtonHeight)];
        [nearHotelButton setBackgroundColor:[UIColor clearColor]];
        [nearHotelButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                   forState:UIControlStateNormal];
        [nearHotelButton setTag:KBtnForCurrentCityButtonTag];
        [nearHotelButton addTarget:self action:@selector(userPersonalSelectedCityNameOperationButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [nearHotelButton setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                   forState:UIControlStateHighlighted];
        [viewForHeader addSubview:nearHotelButton];
        
        
        UILabel *nearNameLabel = [[UILabel alloc]init];
        [nearNameLabel setBackgroundColor:[UIColor clearColor]];
        [nearNameLabel setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [nearNameLabel setTextColor:KContentTextColor];
        [nearNameLabel setTextAlignment:NSTextAlignmentLeft];
        [nearNameLabel setText:@"我附近的酒店"];
        [nearNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth,(0.0f),
                                           KXCUIControlSizeWidth(200.0f),
                                           KFunctionModulButtonHeight)];
        [nearHotelButton addSubview:nearNameLabel];
        
        
        // 当前位置
        UIButton *currentCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [currentCityButton setFrame:CGRectMake(0,(nearHotelButton.bottom+KXCUIControlSizeWidth(1.0f)),
                                               KProjectScreenWidth,
                                               KFunctionModulButtonHeight)];
        [currentCityButton setBackgroundColor:[UIColor clearColor]];
        [currentCityButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                     forState:UIControlStateNormal];
        [currentCityButton setTag:KBtnForCurrentCityButtonTag];
        [currentCityButton addTarget:self action:@selector(userPersonalSelectedCityNameOperationButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [currentCityButton setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                     forState:UIControlStateHighlighted];
        [viewForHeader addSubview:currentCityButton];
        
        
        UILabel *currentCityNameLabel = [[UILabel alloc]init];
        [currentCityNameLabel setBackgroundColor:[UIColor clearColor]];
        [currentCityNameLabel setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [currentCityNameLabel setTextColor:KContentTextColor];
        [currentCityNameLabel setTextAlignment:NSTextAlignmentLeft];
        [currentCityNameLabel setText:@"北京"];
        [currentCityNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth,(0.0f),
                                                  KXCUIControlSizeWidth(200.0f),
                                                  KFunctionModulButtonHeight)];
        self.userAtCurrentCityNameLabel = currentCityNameLabel;
        [currentCityButton addSubview:self.userAtCurrentCityNameLabel];
        
        CGFloat heightForHeader = currentCityButton.bottom;
        
        NSArray *historayArray = KXCShareFMSetting.userReserveHotelCitiesMutableArray;
        ///数据个数
        NSInteger cityCount = historayArray.count;
        
        if (cityCount > 20) {
            cityCount = 20;
        }
        
        if (cityCount > 0) {
            ///历史城市头部高度
            heightForHeader = (heightForHeader+(KInforLeftIntervalWidth + KXCUIControlSizeWidth(20.0f) + KInforLeftIntervalWidth));
            
            NSInteger rowCount = 5;
            ///当前行数
            NSInteger rowInteger = cityCount/rowCount;
            
            ///最后一行的数据个数
            NSInteger columnMin = cityCount%rowCount;
            
            if (columnMin != 0) {
                rowInteger+=1;
            }
            heightForHeader= (heightForHeader+KFunctionModulButtonHeight*rowInteger);
            
            UILabel *historyTitle = [[UILabel alloc]init];
            [historyTitle setBackgroundColor:[UIColor clearColor]];
            [historyTitle setFont:KXCAPPUIContentDefautFontSize(17.0f)];
            [historyTitle setTextColor:KContentTextColor];
            [historyTitle setTextAlignment:NSTextAlignmentLeft];
            [historyTitle setText:@"历史城市"];
            [historyTitle setFrame:CGRectMake(KInforLeftIntervalWidth,(currentCityButton.bottom + KInforLeftIntervalWidth), KXCUIControlSizeWidth(90.0f), KXCUIControlSizeWidth(20.0f))];
            [viewForHeader addSubview:historyTitle];
            
            
            CGFloat bgeinX = 0.0f;
            CGFloat beginY = historyTitle.bottom + KInforLeftIntervalWidth;
            CGFloat starWidth = (KProjectScreenWidth)/5;
            CGFloat starButtonHeight = KFunctionModulButtonHeight;
            
            //            [UIColor whiteColor];
            UIView *whiteColorBGView = [[UIView alloc]init];
            [whiteColorBGView setBackgroundColor:[UIColor whiteColor]];
            [whiteColorBGView setFrame:CGRectMake(0.0f, beginY, KProjectScreenWidth,
                                                  (KFunctionModulButtonHeight*rowInteger))];
            [viewForHeader addSubview:whiteColorBGView];
            
            for (int index=0; index<cityCount; index++) {
                
                int row=index/rowCount;//行号
                //1/3=0,2/3=0,3/3=1;
                int loc=index%rowCount;//列号
                
                NSDictionary *cityDitionary = (NSDictionary *)[historayArray objectAtIndex:index];
                
                CGFloat appviewx=bgeinX+(starWidth)*loc;
                CGFloat appviewy=(beginY)+(starButtonHeight)*row;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button.titleLabel setFont:KXCAPPUIContentFontSize(17.0f)];
                [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
                [button setTitle:StringForKeyInUnserializedJSONDic(cityDitionary, @"name") forState:UIControlStateNormal];
                [button setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                  forState:UIControlStateNormal];
                [button setTag:(KBtnForHistoryCityButtonTag + index)];
                [button addTarget:self action:@selector(userPersonalSelectedCityNameOperationButtonEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                  forState:UIControlStateHighlighted];
                [button setFrame:CGRectMake(appviewx,appviewy, starWidth,starButtonHeight)];
                [viewForHeader addSubview:button];
            }
            
            
            
        }
        UILabel *cityListTitle = [[UILabel alloc]init];
        [cityListTitle setBackgroundColor:[UIColor clearColor]];
        [cityListTitle setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [cityListTitle setTextColor:KContentTextColor];
        [cityListTitle setTextAlignment:NSTextAlignmentLeft];
        [cityListTitle setText:@"城市列表"];
        [cityListTitle setFrame:CGRectMake(KInforLeftIntervalWidth,(heightForHeader + KInforLeftIntervalWidth), KXCUIControlSizeWidth(90.0f), KXCUIControlSizeWidth(20.0f))];
        [viewForHeader addSubview:cityListTitle];
    }
    
    return viewForHeader;
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    CityInforForTrainTicketTableViewCell *cell = [[CityInforForTrainTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                             reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{

    if ([tableView isEqual:self.mainTableView]) {
        
        NSDictionary *cityDictionary = (NSDictionary *)[self.dataSource.data objectAtIndex:(indexPath.row)];        CityInforForTrainTicketTableViewCell *cityCell = (CityInforForTrainTicketTableViewCell* )cell;
        [cityCell setupDataSourceCityName:StringForKeyInUnserializedJSONDic(cityDictionary, @"name") indexPath:indexPath];
        
    }else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        NSDictionary *cityDictionary = (NSDictionary *)[self.searchCityDataSource.data objectAtIndex:(indexPath.row)];
        CityInforForTrainTicketTableViewCell *cityCell = (CityInforForTrainTicketTableViewCell* )cell;
        [cityCell setupDataSourceCityName:StringForKeyInUnserializedJSONDic(cityDictionary, @"hotelname") indexPath:indexPath];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"TravelActiviesItemTableViewCell";
    BOOL isLoadMoreCell = [self _isLoadMoreCellAtIndexPath:indexPath];
    cellIdentifier = isLoadMoreCell? kHUILoadMoreCellIdentifier: cellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self createCellWithIdentifier:cellIdentifier];
    }
    
    [self _configureCell:cell forRowAtIndexPath:indexPath tableView:tableView];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    NSString *cityNameStr = @"";
    NSString *cityCodeStr = @"";
    if ([tableView isEqual:self.mainTableView]) {
        
        if (indexPath.row >= [self.dataSource.data count]) {
            return;
        }
        NSDictionary *cityDictionary = (NSDictionary *)[self.dataSource.data objectAtIndex:(indexPath.row)];
        cityNameStr =StringForKeyInUnserializedJSONDic(cityDictionary, @"name");
        cityCodeStr = StringForKeyInUnserializedJSONDic(cityDictionary, @"code");
        
        
        NSArray *historayArray = KXCShareFMSetting.userReserveHotelCitiesMutableArray;
        
        BOOL isHasHistoary = NO;
        for (NSDictionary *cityDic in historayArray) {
            
            NSString *historayCityNameStr = StringForKeyInUnserializedJSONDic(cityDic, @"name");
            if ([historayCityNameStr isEqualToString:cityNameStr]) {
                isHasHistoary = YES;
                break;
            }
        }
        
        if (!isHasHistoary) {
            NSMutableArray *oldMutableArray = [[NSMutableArray alloc]initWithArray:historayArray];
            [oldMutableArray addObject:cityDictionary];
            [KXCShareFMSetting setUserReserveHotelCitiesMutableArray:oldMutableArray];
        }
        
        
    }else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        
        if (indexPath.row >= [self.searchCityDataSource.data count]) {
            return;
        }
        NSDictionary *cityDictionary = (NSDictionary *)[self.searchCityDataSource.data objectAtIndex:(indexPath.row)];
        cityNameStr =StringForKeyInUnserializedJSONDic(cityDictionary, @"key");
    }
    
    if (self.delegate) {
        
        if ([self.delegate respondsToSelector:@selector(userSelectedCityName:cityCode:style:)]) {
            [self.delegate userSelectedCityName:cityNameStr cityCode:cityCodeStr style:self.cityStyle];
        }
    }
    
    [self leftBarButtonClickedEvent];
}


#pragma mark UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    

    
    [self userSearchCitiesWithSearchKeyRequest:searchBar.text];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    
    //若为空，则返回
    if (IsStringEmptyOrNull(self.hotelSearchBarView.text)) {
        //                [self clearNameListTableViewData];
        return;
    }
    
    NSLog(@"self.hotelSearchBarView.text is %@",self.hotelSearchBarView.text);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"");
    [self.searchCityDataSource cleanAllData];
//    [self leftBarButtonClickedEvent];
    
}

- (void)userSearchCitiesWithSearchKeyRequest:(NSString *)searchKeyStr{
    
    
    if (IsStringEmptyOrNull(searchKeyStr)) {
        return;
    }
    
    [self.searchCityDataSource cleanAllData];
    [self.searchDisplayController.searchResultsTableView reloadData];
    [self.searchDisplayController.searchResultsTableView setHidden:NO];
//    
//    __weak __typeof(&*self)weakSelf = self;
//    [XCAPPHTTPClient userRoughSearchHotelListInforWithHotelName:searchKeyStr pageRow:self.searchCityDataSource.nextPageIndex completion:^(WebAPIResponse *response) {
//       
//        
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            
//            NSLog(@"SearchCities is %@",response.responseObject);
//            if (response.code == WebAPIResponseCodeSuccess) {
//                NSLog(@"SearchCities is %@",response.responseObject);
//                
//                
//                NSArray  *responeArray = (NSArray  *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
//                NSLog(@"SearchCities 解析后的数据是%@",responeArray);
//                
//                NSMutableArray *cityInforArray = [NSMutableArray array];
//                for (NSDictionary *cityDic in responeArray) {
//                    
//                    
//                    NSMutableDictionary *hotelDitionary = [NSMutableDictionary dictionary];
////                    AddObjectForKeyIntoDictionary(id object, id key, NSMutableDictionary *dic)
//                    NSString *hotelNameStr = StringForKeyInUnserializedJSONDic(cityDic, @"ahotel_name");
//                    NSString *hotelIdStr =  StringForKeyInUnserializedJSONDic(cityDic, @"hid");
//                    
//                    AddObjectForKeyIntoDictionary(hotelNameStr,@"hotelname",hotelDitionary);
//                    AddObjectForKeyIntoDictionary(hotelIdStr,@"hotelid",hotelDitionary);
//                    [cityInforArray addObject:hotelDitionary];
//                }
//                [weakSelf.searchCityDataSource appendPage:cityInforArray];
//                [weakSelf.searchCityDataSource setPageCount:1];
//                [weakSelf.searchDisplayController.searchResultsTableView reloadData];
//
//               
//            }
//            
//        });
//    }];
}

- (void)userPersonalSelectedCityNameOperationButtonEvent:(UIButton *)button{
    if (button.tag == KBtnForCurrentCityButtonTag) {
        
        
    }
    
    else if (button.tag == KBtnForNearbyCityButtonTag){
        
    }
    
    else{
        
        NSInteger index = button.tag - KBtnForHistoryCityButtonTag;
        
        NSArray *historayArray = KXCShareFMSetting.userReserveHotelCitiesMutableArray;
        ///数据个数
        NSInteger cityCount = historayArray.count;
        if (index > -1 && index < cityCount) {
            NSDictionary *cityDitionary = (NSDictionary *)[historayArray objectAtIndex:index];
            
            NSLog(@"cityname is %@,cityCode is %@",StringForKeyInUnserializedJSONDic(cityDitionary, @"name"),StringForKeyInUnserializedJSONDic(cityDitionary, @"code"));
            ;
            
            
            NSString *cityNameStr = StringForKeyInUnserializedJSONDic(cityDitionary, @"name");
            NSString *cityCodeStr = StringForKeyInUnserializedJSONDic(cityDitionary, @"code");
            if ((!IsStringEmptyOrNull(cityNameStr)) && (!IsStringEmptyOrNull(cityCodeStr))) {
                if (self.delegate) {
                    
                    if ([self.delegate respondsToSelector:@selector(userSelectedCityName:cityCode:style:)]) {
                        [self.delegate userSelectedCityName:cityNameStr cityCode:cityCodeStr style:self.cityStyle];
                    }
                    [self leftBarButtonClickedEvent];
                }
                
            }
        }
    }
}
@end
