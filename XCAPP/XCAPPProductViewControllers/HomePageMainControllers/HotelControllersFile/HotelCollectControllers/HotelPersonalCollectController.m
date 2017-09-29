//
//  HotelPersonalCollectController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/3.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelPersonalCollectController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"

#import "HotelInforTableViewCell.h"
#import "HotelDetailMainViewController.h"




@interface HotelPersonalCollectController ()<UITableViewDelegate,UITableViewDataSource>

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
 * @breif 城市信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                  *hotelCityMutableArray ;
@end

@implementation HotelPersonalCollectController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
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
    // Do any additional setup after loading the view.
    [self settingNavTitle:@"我的收藏"];
    
    [self setRightNavButtonTitleStr:@"编辑" withFrame:kNavBarButtonRect actionTarget:self action:@selector(rightBarButtonOperationEventClicked)];
    
    [self setupHotelPersonalCollectControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)rightBarButtonOperationEventClicked{
    
}


- (void)setupHotelPersonalCollectControllerFrame{
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStyleGrouped];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    self.hotelCityMutableArray = [[NSMutableArray alloc]initWithObjects:@"北京",
                                  @"苏州",
                                  @"上海",
                                  @"南京",
                                  @"泰安",
                                  @"辽宁",nil];
    
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        //关掉PullToRefreshView
        if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
        {
            UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
            [weakSelf.mainTableView.pullToRefreshView stopAnimating];
        }
        
        NSMutableArray *dataInforArray = [NSMutableArray array];
        
        
        
        for (int section = 1; section <= weakSelf.hotelCityMutableArray.count; section++) {
            
            NSMutableArray *itemArray = [NSMutableArray array];
            for (int index = 0; index < 2*(section*2); index ++) {
                
                HotelInformation *itemHotel = [[HotelInformation alloc]init];
                [itemHotel setHotelIdStr:@"001"];
                CGFloat distance = 184.2*(index+1);
                [itemHotel setHotelDistanceStr:[NSString stringWithFormat:@"%.0lf米",distance]];
                CGFloat distanceMax = distance/1e3;
                if ( distanceMax> 1) {
                    [itemHotel setHotelDistanceStr:[NSString stringWithFormat:@"%.2lf公里",distanceMax]];
                }
                
                //         lon=116.3718872070312&lat=40.03481674194336
                [itemHotel setHotelNameContentStr:@"京都尚水商务会馆"];
                [itemHotel setHotelRankContentStr:@"七星级"];
                [itemHotel setHotelMarkRecordContentStr:@"4.6分"];
                [itemHotel setHotelImageDisplayURLStr:@"http://mobile-res.lvye.cn/2016/06/29/33qepxmpg54i11yy.png"];
                [itemHotel setHotelMinUnitPriceFloat:458];
                [itemHotel setHotelAddressRoughStr:@"中关村、五道口"];
                [itemHotel setHotelCoordinate:CLLocationCoordinate2DMake(40.03481674194336, 116.3718872070312)];
                [itemArray addObject:itemHotel];
            }
            
            [dataInforArray addObject:itemArray];

        }
        [self.dataSource appendPage:dataInforArray];
        [self.dataSource setPageCount:1];
        [self.mainTableView reloadData];
        
    });
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return KHotelInforTableViewCellHeight;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat heightForHeader = 0.0f;
    if (section == 0) {
        heightForHeader = KXCUIControlSizeWidth(44) + KXCUIControlSizeWidth(10.0f);
    }else if (section < [self.dataSource count]){
        heightForHeader = KXCUIControlSizeWidth(44) + KXCUIControlSizeWidth(15.0f);
    }
    
    return heightForHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    UITableViewHeaderFooterView *iewForHeaderInSection = [[UITableViewHeaderFooterView alloc]init];
    
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UIView *whiteColorBGView = [[UIView alloc]init];
    [whiteColorBGView setBackgroundColor: [UIColor whiteColor]];
    
    if (section == 0) {
        [headerView setFrame:CGRectMake(0.0, 0.0, KProjectScreenWidth, KXCUIControlSizeWidth(44))];
        
        [whiteColorBGView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(44))];
        
    }else if (section < [self.dataSource count]){
         [headerView setFrame:CGRectMake(0.0, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(59))];
        
        [whiteColorBGView setFrame:CGRectMake(0.0f, KXCUIControlSizeWidth(0.0f), KProjectScreenWidth, KXCUIControlSizeWidth(44))];
    }
    
    [headerView addSubview:whiteColorBGView];
    
    
    UILabel *cityNameLabel = [[UILabel alloc]init];
    [cityNameLabel setTextColor:KContentTextColor];
    [cityNameLabel setBackgroundColor:[UIColor clearColor]];
    [cityNameLabel setTextAlignment:NSTextAlignmentLeft];
    [cityNameLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [cityNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, KXCUIControlSizeWidth(180.0f), KXCUIControlSizeWidth(44))];
    [whiteColorBGView addSubview:cityNameLabel];
    
    if (section < self.hotelCityMutableArray.count) {
        
        [cityNameLabel setText:[self.hotelCityMutableArray objectAtIndex:section]];
    }
    
    return headerView;
}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0f;
//}

#pragma mark - UITableViewDataSource


- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == [self.dataSource count]);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return ([self.dataSource count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSInteger numberOfRows = 0;
    
    if (section != [self.dataSource count]) {
        
        NSArray *itemDataArray = (NSArray *)[self.dataSource.data objectAtIndex:section];
        numberOfRows = itemDataArray.count;
    }

    return  numberOfRows;
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    HotelInforTableViewCell* cell = [[HotelInforTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section >= [self.dataSource.data count]) {
//        return;
//    }
    
    NSArray *itemDataArray = (NSArray *)[self.dataSource.data objectAtIndex:indexPath.section];
    
    HotelInformation *itemData = (HotelInformation *)[itemDataArray objectAtIndex:(indexPath.row)];
    HotelInforTableViewCell *hotelCell = (HotelInforTableViewCell* )cell;
    [hotelCell setupHotelInforTableViewCellDataSource:itemData indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"HotelInforTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self createCellWithIdentifier:cellIdentifier];
    }
    [self _configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self _isLoadMoreCellAtIndexPath:indexPath]){
        return;
    }

    if (indexPath.section >= [self.dataSource.data count]) {
        return;
    }
    
    NSArray *hotelArray = [self.dataSource.data objectAtIndex:indexPath.section];
    
    
    if (indexPath.row >= hotelArray.count) {
        return;
    }
    
    HotelInformation *itemHotel = (HotelInformation *)[hotelArray objectAtIndex:indexPath.row];
    HotelDetailMainViewController *viewController = [[HotelDetailMainViewController alloc]initWithHotelInfor:itemHotel];
    [self.navigationController pushViewController:viewController animated:YES];
    
}


@end
