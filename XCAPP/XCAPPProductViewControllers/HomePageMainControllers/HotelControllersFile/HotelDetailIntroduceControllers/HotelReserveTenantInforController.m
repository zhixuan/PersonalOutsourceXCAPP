//
//  HotelReserveTenantInforController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelReserveTenantInforController.h"
#import "AddMoveIntoPersonnelViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"
#import "HotelReserveTenantInforTableCell.h"

@interface HotelReserveTenantInforController ()<UITableViewDelegate,UITableViewDataSource,HotelReserveTenantInforTableCellDelegate,AddMoveIntoPersonnelFinishDelegate>

/*!
 * @breif 用户选择数据信息内容
 * @See
 */
@property (nonatomic , strong)      NSMutableArray          *userSelectedUserInforArray;

///*!
// * @breif 用户上次已经选择的数据信息内容
// * @See
// */
//@property (nonatomic , strong)      NSMutableArray          *hasSelectedUsersArray;

/*!
 * @breif 头不显示信息
 * @See
 */
@property (nonatomic , strong)      NSString                *titleString;
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
 * @breif 用户名
 * @See
 */
@property (nonatomic , weak)            UILabel                     *userPersonalNameLabel;
/*!
 * @breif 用户个人信息
 * @See
 */
@property (nonatomic , weak)            UILabel                     *userPhoneNumberLabel;

/*!
 * @breif 用户将要删除的数据信息
 * @See
 */
@property (nonatomic , strong)          UserInformationClass        *userDeleteItemUser;
@end

@implementation HotelReserveTenantInforController


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

- (id)initWithTitleStr:(NSString *)title withSelected:(NSArray *)userArray{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.dataSource = [DataPage page];
        self.titleString = title;
        self.userSelectedUserInforArray = [[NSMutableArray alloc]initWithArray:userArray];
        
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
    
    [self settingNavTitle:self.titleString];
    if (!self.userSelectedUserInforArray) {
        self.userSelectedUserInforArray = [[NSMutableArray alloc]init];
    }
    
    [self setLeftNavButtonFA:FMIconLeftReturn withFrame:kNavBarButtonRect
                actionTarget:self action:@selector(leftButtonPopViewController)];
    
    [self setupHotelReserveTenantInforControllerFrame];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftButtonPopViewController{
 
    NSInteger ArrayCount = self.userSelectedUserInforArray.count;
    if (ArrayCount > 0) {
        
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(userSelectedTenantUserArray: isDeleteSelectedBool:)]) {
                [self.delegate userSelectedTenantUserArray:self.userSelectedUserInforArray isDeleteSelectedBool:YES];
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)setupTableHeaderView{
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:KDefaultViewBackGroundColor];
    [headerView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                    (KFunctionModulButtonHeight + KInforLeftIntervalWidth*2))];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateHighlighted];
    [searchBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [searchBtn setTitleColor:KDefaultNavigationWhiteBackGroundColor forState:UIControlStateNormal];
    [searchBtn setTitleColor:kColorTextColorClay forState:UIControlStateHighlighted];
    [searchBtn setTitle:@"+ 新增" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(addNewUserOperationEventClicked)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setCornerRadius:1.0f];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn.layer setBorderColor:KDefaultNavigationWhiteBackGroundColor.CGColor];
    [searchBtn.layer setBorderWidth:1.0f];
    
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth*1.3,
                                   (KInforLeftIntervalWidth),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2.6),
                                   KFunctionModulButtonHeight)];
    [headerView addSubview:searchBtn];
    
    
    return headerView;
}


- (void)addNewUserOperationEventClicked{
    AddMoveIntoPersonnelViewController *viewController = [[AddMoveIntoPersonnelViewController alloc]init];
    [viewController setDelegate:self];
    XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

- (void)setupHotelReserveTenantInforControllerFrame{
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStylePlain];
    tbview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbview setShowsVerticalScrollIndicator:NO];
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
    [self setupHotelReserveTenantInforrDataSource];
}

///初始化人员信息内容
- (void)setupHotelReserveTenantInforrDataSource{

    __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation = [XCAPPHTTPClient userRequestReserveTenantUserInforListWithUserId:KXCAPPCurrentUserInformation.userPerId row:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
        
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
                    
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list") isKindOfClass:[NSArray class]]) {
                        NSArray *userListArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        NSMutableArray *dataInforArray = [NSMutableArray array];
                        
                        for (NSDictionary *dataInfor in userListArray) {
                            
                            UserInformationClass *itemUser = [[UserInformationClass alloc]init];
                            [itemUser setUserNameStr:StringForKeyInUnserializedJSONDic(dataInfor, @"link_name")];
                            [itemUser setUserPerId:StringForKeyInUnserializedJSONDic(dataInfor,@"id")];
                            [dataInforArray addObject:itemUser];
                        }
                        
                        
                        [self.dataSource appendPage:dataInforArray];
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
                    NSInteger pageCount = IntForKeyInUnserializedJSONDic(dataDictionary,@"pages");
                    [self.dataSource setPageCount:pageCount];
                    [self.mainTableView reloadData];
                    
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
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;
    
    if (indexPath.row < [self.dataSource.data count]) {
        return KHotelReserveTenantInforTableCellHeight;
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
    
    return  ([self.dataSource count] + 1);
}


- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
    {
        return CreateLoadMoreCell();
        
    }
    HotelReserveTenantInforTableCell* cell = [[HotelReserveTenantInforTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                 reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    UserInformationClass *itemData = (UserInformationClass *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    HotelReserveTenantInforTableCell *userCell = (HotelReserveTenantInforTableCell* )cell;
    for (UserInformationClass *userInfor in self.userSelectedUserInforArray) {
        
        
        //        NSLog(@"userInfor.userPerId is %@\n itemData.userPerId is %@",userInfor.userPerId,itemData.userPerId);
        if ([userInfor.userPerId isEqualToString:itemData.userPerId]) {
            [userCell.userSelectedImageView setImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))];
        }
    }
    [userCell setDelegate:self];
    [userCell setupDataSource:itemData indexPaht:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"SelectedUserInforTableViewCell";
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
    
    
    UserInformationClass *itemData = (UserInformationClass *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    
    ///若为空，则不处理
    if (IsStringEmptyOrNull(itemData.userPerId)) {
        
        return;
    }
    
    [self updateTableViewDateSourceWithUser:itemData indexPath:indexPath withTableView:tableView];
}

- (void)updateTableViewDateSourceWithUser:(UserInformationClass *)itemData indexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView{
    if (self.userSelectedUserInforArray.count > 0) {
        BOOL isSelectedBool = NO;
        for (UserInformationClass *userInfor in self.userSelectedUserInforArray) {
            if ([userInfor.userPerId isEqualToString:itemData.userPerId]) {
                
                isSelectedBool = YES;
                
                
            }
            
            ///若不为空
            ///判断是否被选中 //若选中，则移除
            if (isSelectedBool) {
                
                [self.userSelectedUserInforArray removeObject:userInfor];
                //KSepLineColorSetup
                HotelReserveTenantInforTableCell *userCell = (HotelReserveTenantInforTableCell *)[tableView cellForRowAtIndexPath:indexPath];
                [userCell.userSelectedImageView setImage:createImageWithColor(KSepLineColorSetup)];
            }
            
            ///若没有则直接加入进去
            else{
                [self.userSelectedUserInforArray addObject:itemData];
                HotelReserveTenantInforTableCell *userCell = (HotelReserveTenantInforTableCell *)[tableView cellForRowAtIndexPath:indexPath];
                [userCell.userSelectedImageView setImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))];
                
            }
            break;
        }
        
    }else{
        [self.userSelectedUserInforArray addObject:itemData];
        HotelReserveTenantInforTableCell *userCell = (HotelReserveTenantInforTableCell *)[tableView cellForRowAtIndexPath:indexPath];
        [userCell.userSelectedImageView setImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))];
    }
    
}

- (void)userSelectedReserveTenantUserToEditWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)userAddFinishUserName:(NSString *)userNameStr{

    [self.mainTableView triggerPullToRefresh];
}
@end
