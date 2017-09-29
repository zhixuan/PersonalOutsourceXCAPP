//
//  LocationOrNameSearchController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "LocationOrNameSearchController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"
#import "MoreSiftRequirementAreaTableViewCell.h"

#define KBtnForAreaButtonTag        (1820111)
@interface LocationOrNameSearchController ()<UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

/*!
 * @breif 酒店所在城市ID
 * @See
 */
@property (nonatomic , strong)      NSString            *hotelAtCityCodeStr;

/*!
 * @breif 搜索设置
 * @See
 */
@property (nonatomic , weak)      UISearchBar           *hotelSearchBarView;

/*!
 * @breif 搜索到得数据内容
 * @See
 */
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;

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
 * @breif 默认选中的信息内容
 * @See
 */
@property (nonatomic , strong)      NSIndexPath                 *userSelectedIndexPath;

/*!
 * @breif 用户选中的区域编号
 * @See
 */
@property (nonatomic , strong)      NSString                    *userSelectedAreaCodeStr;



/*!
 * @breif 行政区域数据信息
 * @See
 */
@property (nonatomic , strong)          DataPage                    *dataSourceForArea;

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
//@property (nonatomic , weak)            HUILoadMoreCell             *loadMoreCell;

@end


@implementation LocationOrNameSearchController
@synthesize searchDisplayController;
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
    }
    return self;
}

- (id)initWithUserHotelAtCityCodeStr:(NSString *)cityCodeId{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.dataSourceForArea = [DataPage page];
        self.hotelAtCityCodeStr = [NSString stringWithFormat:@"%@",cityCodeId];
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
    
    [self settingNavTitle:@"筛选"];
    
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect actionTarget:self action:@selector(leftButtonOperationEvent)];
    
    [self setupLocationOrNameSearchControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLocationOrNameSearchControllerFrame{
    
    // 搜索框
    UIView *searchViewBg = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    KProjectScreenWidth,
                                                                    40)];
    searchViewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchViewBg];
    
    UISearchBar *m_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, KProjectScreenWidth, 40)];
    
    m_searchBar.delegate = self;
    m_searchBar.alpha = 1;
    m_searchBar.placeholder = @"位置/酒店名";
    m_searchBar.backgroundImage=createImageWithColor([UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1]);
    self.hotelSearchBarView = m_searchBar;
    [self.view addSubview:self.hotelSearchBarView];
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.hotelSearchBarView contentsController:self];
    self.searchDisplayController.active = NO;
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    
    
    self.userSelectedAreaCodeStr = @"";
    UIButton *areaSelectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaSelectedButton setBackgroundColor:[UIColor clearColor]];
    [areaSelectedButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                  forState:UIControlStateNormal];
    [areaSelectedButton setBackgroundImage:createImageWithColor(HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f))
                                  forState:UIControlStateHighlighted];
    [areaSelectedButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [areaSelectedButton setTag:KBtnForAreaButtonTag];
    [areaSelectedButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [areaSelectedButton setTitle:@"行政区" forState:UIControlStateNormal];
    [areaSelectedButton addTarget:self action:@selector(userOperationButtonEventClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
    [areaSelectedButton setFrame:CGRectMake(0.0f,(searchViewBg.bottom + KAreaTableViewCellHeight*2),(KXCUIControlSizeWidth(120.0f)),
                                            KFunctionModulButtonHeight)];
    [self.view addSubview:areaSelectedButton];
    
    UIView *sepLineBGView = [[UIView alloc]init];
    [sepLineBGView setBackgroundColor:KSepLineColorSetup];
    [sepLineBGView setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight - 1.0f,
                                       areaSelectedButton.width, 1.0f)];
    [areaSelectedButton addSubview:sepLineBGView];
    
    
    ///MARK:初始化底部信息
    CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
    
    CGRect tableViewRect = CGRectMake(areaSelectedButton.right, searchViewBg.bottom, (KProjectScreenWidth - areaSelectedButton.right), ((self.view.bounds.size.height - navigationBarHeight)));
    UITableView *tbview = [[UITableView alloc]initWithFrame:tableViewRect
                                                      style:UITableViewStylePlain];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview.layer setMasksToBounds:YES];
    [tbview.layer setBorderColor:KSepLineColorSetup.CGColor];
    [tbview.layer setBorderWidth:1.0f];
    tbview.backgroundColor =  KDefaultViewBackGroundColor;
    tbview.dataSource = self;
    tbview.delegate = self;
    [self.view addSubview:tbview];
    self.mainTableView = tbview;
    
    
    [self userRequestionAreaDataSourceOperation];

}

- (void)leftButtonOperationEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.mainTableView) {
        return [self.dataSourceForArea count];
    }
    return [self.dataSource count];
    
}
- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    if (tableView == self.mainTableView) {
        
        MoreSiftRequirementAreaTableViewCell* cityCell = [[MoreSiftRequirementAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        return cityCell;
        
    }
    
    return cell;
}

- (void)userOperationButtonEventClicked:(UIButton *)button{
    
}

#pragma mark - UITableViewDelegate
- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    
    if (tableView == self.mainTableView) {
    return (indexPath.row == [self.dataSourceForArea count]);
    }
    
    
    return (indexPath.row == [self.dataSource count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CircleCell";
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
       
        
        return cell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        BOOL isLoadMoreCell = [self _isLoadMoreCellAtIndexPath:indexPath tableView:tableView];
        cellIdentifier = isLoadMoreCell? kHUILoadMoreCellIdentifier: cellIdentifier;
        
        if (!cell) {
            
            if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
            {
                cell =  CreateLoadMoreCell();
            }else{
                
                cell = [self createCellWithIdentifier:cellIdentifier tableView:tableView];
                
            }
        }

        [self _configureCell:cell forRowAtIndexPath:indexPath tableView:tableView];
        
        return cell;
    }
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{

    if (tableView == self.mainTableView) {
        if (indexPath.row >= [self.dataSourceForArea.data count]) {
            return;
        }
        NSDictionary *dataDic = (NSDictionary *)[self.dataSourceForArea.data objectAtIndex:(indexPath.row)];
        
        MoreSiftRequirementAreaTableViewCell *hotelCell = (MoreSiftRequirementAreaTableViewCell* )cell;
        [hotelCell setupTableViewDataSource:StringForKeyInUnserializedJSONDic(dataDic,@"name") indexPath:indexPath];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    return 44.0f;
    else
    return KAreaTableViewCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
            }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if ([self _isLoadMoreCellAtIndexPath:indexPath tableView:tableView])
        return;
        
        NSDictionary *dataDic = (NSDictionary *)[self.dataSourceForArea.data objectAtIndex:(indexPath.row)];
        
        NSString *areaCodeStr = StringForKeyInUnserializedJSONDic(dataDic, @"code");
        
        NSLog(@"areaCodeStr is %@",areaCodeStr);
        
        MoreSiftRequirementAreaTableViewCell *userCell = (MoreSiftRequirementAreaTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [userCell.userSelectedImageView setImage:[UIImage imageNamed:@"nr_selected.png"]];
        
        if (indexPath.row == 0) {
            self.userSelectedAreaCodeStr = @"";
        }
        else{
            self.userSelectedAreaCodeStr = areaCodeStr;
        }
        
        ///将原先的处理掉
        MoreSiftRequirementAreaTableViewCell *oldCell = (MoreSiftRequirementAreaTableViewCell *)[tableView cellForRowAtIndexPath:self.userSelectedIndexPath];
        [oldCell.userSelectedImageView setImage:createImageWithColor([UIColor clearColor])];
        
        ///更新IndexPath信息
        self.userSelectedIndexPath =indexPath;
        
    }
    
    
}

#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    /*
    //若为空，则返回
    if (IsStringEmptyOrNull(self.searchBar.text)) {
//        [self clearNameListTableViewData];
        return;
    }
    NSString *contentString = [self.searchBar.text substringFromIndex:0];
    ///若用户输入的字符大于5个字符则返回
    if ([contentString length] > 5) {
//        [self clearNameListTableViewData];
        return;
    }
    self.userSelectedSearch = NO;
    [self initWithGetUserNameForEditNameKeyWord:contentString];
     */
    
    NSLog(@"searchText is %@",searchText);
    
    [XCAPPHTTPClient userRoughSearchHotelListInforWithHotelName:searchText pageRow:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                }
            }
        });
    }];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"");
}


- (void)userRequestionAreaDataSourceOperation{
    
    //清空当前数据源中所有·数据
    [self.dataSourceForArea cleanAllData];
    [self.mainTableView reloadData];
//    [self loadMoreListData];
    
    NSArray *defautlArray = @[@{@"name":@"不限",
                                @"code":@"0"}];
    [self.dataSourceForArea appendPage:defautlArray];
    self.userSelectedAreaCodeStr = @"";
    self.userSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userRequestAdministrativeAreaInforForHotelWithCityCode:self.hotelAtCityCodeStr completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    
                    ///火车票数据信息
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list") isKindOfClass:[NSArray class]]) {
                        NSArray *hotelArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        
                        
                        NSMutableArray *dataInforArray = [NSMutableArray array];
                        
                        for (NSDictionary *dataInfor in hotelArray) {
                            
                            
                            NSDictionary *areaDict=@{@"name":StringForKeyInUnserializedJSONDic(dataInfor, @"area"),
                                                     @"code":StringForKeyInUnserializedJSONDic(dataInfor, @"area_id"),};
                            [dataInforArray addObject:areaDict];
                            NSLog(@"areaDict is %@",areaDict);
                        }
                        [weakSelf.dataSourceForArea appendPage:dataInforArray];
                        [weakSelf.dataSourceForArea setPageCount:1];
                        [weakSelf.mainTableView reloadData];
                        
                    } else{
                        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                    }
                }
                else{
                    ShowIMAutoHideMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
            else{
                ShowIMAutoHideMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
            }
        });
    }];

}

@end
