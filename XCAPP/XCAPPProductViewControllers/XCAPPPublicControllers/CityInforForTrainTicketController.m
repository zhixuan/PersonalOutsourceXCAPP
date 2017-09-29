//
//  CityInforForTrainTicketController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//
/*
 
 lvye 项目 为 club项目 ，   lvyechina为 op项目
 
 */

#import "CityInforForTrainTicketController.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "CityInforForTrainTicketTableViewCell.h"

#define KTableForSeaerchTableViewTag            (1720111)
#define KTableForCityInforTableViewTag          (1720112)




#define KBtnForCurrentCityButtonTag             (1820111)

#define KBtnForHistoryCityButtonTag             (1920311)

@interface CityInforForTrainTicketController ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate, UISearchBarDelegate>




#pragma mark - 城市信息显示图
/*!
 * @breif 城市信息显示图
 * @See
 */
@property (nonatomic , weak)        UITableView                 *mainTableView;

#pragma mark - 加载更多Cell
/*!
 * @breif 加载更多Cell
 * @See
 */
@property (nonatomic , weak)            HUILoadMoreCell         *loadMoreCell;

#pragma mark - 界面数据源
/*!
 * @breif 左侧界面数据源
 * @See
 */
@property (nonatomic , strong)          DataPage                *dataSource;


#pragma mark - 界面数据源
/*!
 * @breif 左侧界面数据源
 * @See
 */
@property (nonatomic , strong)          DataPage                *searchCityDataSource;

#pragma mark - 网络请求链接
/*!
 * @breif 网络请求链接
 * @See
 */
@property (nonatomic , strong)          AFHTTPRequestOperation  *requestDataOperation;

/*!
 * @breif 用户选择的是出发地还是到达地
 * @See
 */
@property (nonatomic , assign)      UserSelectedCityStyle       cityStyle;
/*!
 * @breif 类名字符串
 * @See
 */
@property (nonatomic , strong)      NSString                    *controlTitleStr;
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


@end

@implementation CityInforForTrainTicketController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.dataSource = [DataPage page];
        self.searchCityDataSource = [DataPage page];
        
        
    }
    return self;
}

- (id)initWithTitleStr:(NSString *)titleStr style:(UserSelectedCityStyle)style{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
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
    // Do any additional setup after loading the view.
    
    [self settingNavTitle:self.controlTitleStr];
    
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect
                      actionTarget:self action:@selector(leftBarButtonClickedEvent)];
    [self setupCityInforForTrainTicketControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonClickedEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setupCityInforForTrainTicketControllerFrame{
    

    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStyleGrouped];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview setTag:KTableForCityInforTableViewTag];
    [tbview setTableHeaderView:[self cityTableHeaderView]];
    tbview.backgroundColor =  KDefaultViewBackGroundColor;
    tbview.dataSource = self;
    tbview.delegate = self;
    [self.view addSubview:tbview];
    self.mainTableView = tbview;
    [self refreshListData];
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
    self.requestDataOperation =  [XCAPPHTTPClient requestTrainTicketCitiesInformationCompletion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            
            //关掉PullToRefreshView
            if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
                [weakSelf.mainTableView.pullToRefreshView stopAnimating];
            }
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    
                    
                    if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSArray class]]) {
                        NSArray  *responeArray = (NSArray  *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                        //                        NSLog(@"responeDic 解析后的数据是%@",responeArray);
                        
                        NSMutableArray *cityInforArray = [NSMutableArray array];
                        for (NSString *cityNameStr in responeArray) {
                            //                            NSLog(@"cityNameStr is %@",cityNameStr);
                            [cityInforArray addObject:cityNameStr];
                        }
                        [weakSelf.dataSource appendPage:cityInforArray];
                        [weakSelf.dataSource setPageCount:1];
                        [weakSelf.mainTableView reloadData];
                        
                    }
                }else{
                    [weakSelf.dataSource setPageCount:1];
                    [weakSelf.mainTableView reloadData];
                }
                
            }
            else{
                [weakSelf.dataSource setPageCount:1];
                [weakSelf.mainTableView reloadData];
            }
        });
    }];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerInSectionView = [[UIView alloc]init];
    
    
    if (tableView == self.mainTableView) {
        
        UILabel *currentCityTitle = [[UILabel alloc]init];
        [currentCityTitle setBackgroundColor:[UIColor clearColor]];
        [currentCityTitle setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [currentCityTitle setTextColor:KContentTextColor];
        [currentCityTitle setTextAlignment:NSTextAlignmentLeft];
        [currentCityTitle setText:@"当前"];
        [currentCityTitle setFrame:CGRectMake(KInforLeftIntervalWidth,(KInforLeftIntervalWidth),
                                              KXCUIControlSizeWidth(90.0f), KXCUIControlSizeWidth(20.0f))];
        [headerInSectionView addSubview:currentCityTitle];

        
        
        
        // 当前位置
        UIButton *currentCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [currentCityButton setFrame:CGRectMake(0,(currentCityTitle.bottom+KInforLeftIntervalWidth),
                                               KProjectScreenWidth,
                                               KFunctionModulButtonHeight)];
        [currentCityButton setBackgroundColor:[UIColor clearColor]];
        [currentCityButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                     forState:UIControlStateNormal];
        [currentCityButton setTag:KBtnForCurrentCityButtonTag];
        [currentCityButton addTarget:self action:@selector(userPersonalSelectedCityNameOperationButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [currentCityButton setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                     forState:UIControlStateHighlighted];
        [headerInSectionView addSubview:currentCityButton];
        
        
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
        
        NSArray *historayArray = KXCShareFMSetting.userReserveTrainTicketCitiesMutableArray;
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
            [headerInSectionView addSubview:historyTitle];

            
            

            
            CGFloat bgeinX = 0.0f;
            CGFloat beginY = historyTitle.bottom + KInforLeftIntervalWidth;
            CGFloat starWidth = (KProjectScreenWidth)/5;
            CGFloat starButtonHeight = KFunctionModulButtonHeight;
            
            //            [UIColor whiteColor];
            UIView *whiteColorBGView = [[UIView alloc]init];
            [whiteColorBGView setBackgroundColor:[UIColor whiteColor]];
            [whiteColorBGView setFrame:CGRectMake(0.0f, beginY, KProjectScreenWidth,
                                                  (KFunctionModulButtonHeight*rowInteger))];
            [headerInSectionView addSubview:whiteColorBGView];

            
            for (int index=0; index<cityCount; index++) {
                
                int row=index/rowCount;//行号
                //1/3=0,2/3=0,3/3=1;
                int loc=index%rowCount;//列号
                
                CGFloat appviewx=bgeinX+(starWidth)*loc;
                CGFloat appviewy=(beginY)+(starButtonHeight)*row;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button.titleLabel setFont:KXCAPPUIContentFontSize(17.0f)];
                [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
                [button setTitle:[historayArray objectAtIndex:index] forState:UIControlStateNormal];
                [button setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                  forState:UIControlStateNormal];
                [button setTag:(KBtnForHistoryCityButtonTag + index)];
                [button addTarget:self action:@selector(userPersonalSelectedCityNameOperationButtonEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                  forState:UIControlStateHighlighted];
                [button setFrame:CGRectMake(appviewx,appviewy, starWidth,starButtonHeight)];
                [headerInSectionView addSubview:button];
            }

        }
        
        
        UILabel *cityListTitle = [[UILabel alloc]init];
        [cityListTitle setBackgroundColor:[UIColor clearColor]];
        [cityListTitle setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [cityListTitle setTextColor:KContentTextColor];
        [cityListTitle setTextAlignment:NSTextAlignmentLeft];
        [cityListTitle setText:@"城市列表"];
        [cityListTitle setFrame:CGRectMake(KInforLeftIntervalWidth,(heightForHeader + KInforLeftIntervalWidth),
                                           KXCUIControlSizeWidth(90.0f), KXCUIControlSizeWidth(20.0f))];
        [headerInSectionView addSubview:cityListTitle];
    }
    
    return headerInSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat heightForHeader= 0;
    
    if (tableView == self.mainTableView) {
        ///当前城市信息高度
        heightForHeader = (KInforLeftIntervalWidth + KXCUIControlSizeWidth(20.0f) + KInforLeftIntervalWidth + KFunctionModulButtonHeight);
        
        NSArray *historayArray = KXCShareFMSetting.userReserveTrainTicketCitiesMutableArray;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    heightForRow =  KCityForTrainTicketCellHeight;
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
    
    NSInteger numberOfRows = 0;
    if ([tableView isEqual:self.mainTableView]) {
        
        numberOfRows =  ([self.dataSource count]);
    }else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        numberOfRows = ([self.searchCityDataSource count]);
    }
    
    //    NSLog(@"numberOfRows is %zi",numberOfRows);
    return  numberOfRows;
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    CityInforForTrainTicketTableViewCell *cell = [[CityInforForTrainTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                             reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    //    if (indexPath.row >= [self.dataSource.data count]) {
    //        return;
    //    }
    
    if ([tableView isEqual:self.mainTableView]) {
        
        NSString *itemStr = (NSString *)[self.dataSource.data objectAtIndex:(indexPath.row)];
        CityInforForTrainTicketTableViewCell *cityCell = (CityInforForTrainTicketTableViewCell* )cell;
        [cityCell setupDataSourceCityName:itemStr indexPath:indexPath];
        
    }else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        NSDictionary *cityDictionary = (NSDictionary *)[self.searchCityDataSource.data objectAtIndex:(indexPath.row)];
        CityInforForTrainTicketTableViewCell *cityCell = (CityInforForTrainTicketTableViewCell* )cell;
        [cityCell setupDataSourceCityName:StringForKeyInUnserializedJSONDic(cityDictionary, @"display") indexPath:indexPath];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"CityInforForTrainTicketTableViewCell";
    
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
    if ([tableView isEqual:self.mainTableView]) {
        
        if (indexPath.row >= [self.dataSource.data count]) {
            return;
        }
        cityNameStr = (NSString *)[self.dataSource.data objectAtIndex:(indexPath.row)];
        
        
        ///若该城市不曾被搜索，则直接加入到里面
        if (![KXCShareFMSetting.userReserveTrainTicketCitiesMutableArray containsObject:cityNameStr]) {
            NSMutableArray *cityArray = [NSMutableArray arrayWithArray:KXCShareFMSetting.userReserveTrainTicketCitiesMutableArray];
            [cityArray addObject:cityNameStr];
            [KXCShareFMSetting setUserReserveTrainTicketCitiesMutableArray:cityArray];
        }
        
    }else if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        
        if (indexPath.row >= [self.searchCityDataSource.data count]) {
            return;
        }
        NSDictionary *cityDictionary = (NSDictionary *)[self.searchCityDataSource.data objectAtIndex:(indexPath.row)];
        cityNameStr =StringForKeyInUnserializedJSONDic(cityDictionary, @"key");
        [self.searchDisplayController.searchResultsTableView setHidden:YES];
    }
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (weakSelf.delegate) {
            
            if ([weakSelf.delegate respondsToSelector:@selector(userSelectedCityInforCityName:cityCode:style:)]) {
                [weakSelf.delegate userSelectedCityInforCityName:cityNameStr cityCode:@"" style:self.cityStyle];
            }
        }
        
        [weakSelf leftBarButtonClickedEvent];
    });
}



- (void)userPersonalSelectedCityNameOperationButtonEvent:(UIButton *)button{

    
    NSString *cityNameStr = @"";
    if (KBtnForCurrentCityButtonTag == button.tag) {
        
        cityNameStr = @"北京";
    }
    else {
        
         NSArray *cityInforArray = KXCShareFMSetting.userReserveTrainTicketCitiesMutableArray;
        
        NSInteger index = (button.tag - KBtnForHistoryCityButtonTag);
        if (index > -1 && index < cityInforArray.count) {
            NSString *selectedCityNameStr = (NSString *)[cityInforArray objectAtIndex:index];
            cityNameStr = selectedCityNameStr;
            
        }
    }
    
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (weakSelf.delegate) {
            
            if ([weakSelf.delegate respondsToSelector:@selector(userSelectedCityInforCityName:cityCode:style:)]) {
                [weakSelf.delegate userSelectedCityInforCityName:cityNameStr cityCode:@"" style:self.cityStyle];
            }
        }
        
        [weakSelf leftBarButtonClickedEvent];
    });
    
    
}


#pragma mark UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //    NSLog(@"searchText is %@",searchBar.text);
    
    [self userSearchCitiesWithSearchKeyRequest:searchBar.text];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //
    
    //     NSString *contentString = [self.searchBar.text substringFromIndex:0];
    //     ///若用户输入的字符大于5个字符则返回
    //     if ([contentString length] > 5) {
    //     //        [self clearNameListTableViewData];
    //     return;
    //     }
    //     self.userSelectedSearch = NO;
    //     [self initWithGetUserNameForEditNameKeyWord:contentString];
    
    
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
    
    
}

- (void)userSearchCitiesWithSearchKeyRequest:(NSString *)searchKeyStr{
    
    
    if (IsStringEmptyOrNull(searchKeyStr)) {
        return;
    }
    
    
    [self.searchCityDataSource cleanAllData];
    [self.searchDisplayController.searchResultsTableView reloadData];
    [self.searchDisplayController.searchResultsTableView setHidden:NO];
    
    
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient requestTrainTicketRecommendCitiesInforWithSearchKey:searchKeyStr completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"SearchCities is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"SearchCities is %@",response.responseObject);
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSArray class]]) {
                    NSArray  *responeArray = (NSArray  *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    NSLog(@"SearchCities 解析后的数据是%@",responeArray);
                    
                    NSMutableArray *cityInforArray = [NSMutableArray array];
                    for (NSDictionary *cityDic in responeArray) {
                        NSLog(@"cityNameStr is %@",cityDic);
                        [cityInforArray addObject:cityDic];
                    }
                    [weakSelf.searchCityDataSource appendPage:cityInforArray];
                    [weakSelf.searchCityDataSource setPageCount:1];
                    [weakSelf.searchDisplayController.searchResultsTableView reloadData];
                    
                }
            }
            else{
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    NSLog(@"msg is %@",msg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                [weakSelf.searchCityDataSource setPageCount:1];
                [weakSelf.searchDisplayController.searchResultsTableView reloadData];
            }
        } );
    }];
}


@end
