//
//  SelectedUserInforViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "SelectedUserInforViewController.h"
#import "SelectedUserInforTableViewCell.h"
#import "AddTrainTicketUserInforController.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"

@interface SelectedUserInforViewController ()<SelectedUserTableCellDelegate,UITableViewDelegate,UITableViewDataSource,AddTrainTicketUserInforDelegate>


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

@implementation SelectedUserInforViewController


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
    
    [self setupSelectedUserInforViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftButtonPopViewController{
    
    
    NSInteger ArrayCount = self.userSelectedUserInforArray.count;
    if (ArrayCount > 0) {
        
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(userSelectedUserArray: isDeleteSelectedBool:)]) {
                [self.delegate userSelectedUserArray:self.userSelectedUserInforArray isDeleteSelectedBool:YES];
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
    
    UserInformationClass *itemData = [[UserInformationClass alloc]init];
    AddTrainTicketUserInforController *viewController = [[AddTrainTicketUserInforController alloc]initWithUserInfor:itemData withIndex:0];
    [viewController setDelegate:self];
    XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

- (void)setupSelectedUserInforViewControllerFrame{
    
    
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
    
//    [self refreshListData];
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
    
     __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation = [XCAPPHTTPClient requestAllTrainUserDirectoryInforWithUserId:KXCAPPCurrentUserInformation.userPerId nextPage:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
        
            
            //关掉PullToRefreshView
            if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
                [weakSelf.mainTableView.pullToRefreshView stopAnimating];
            }

            NSLog(@"\n【 查询全部联系人信息 --- 查询预订过火车票的全部联系人信息内容】\nresponse.responseObject is %@",response.responseObject);
            
            
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list") isKindOfClass:[NSArray class]]) {
                        NSArray *userListArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        
                        
                        NSMutableArray *dataInforArray = [NSMutableArray array];
                        
                        for (NSDictionary *dataInfor in userListArray) {
                            
                            UserInformationClass *itemUser = [UserInformationClass initializaionWithUserForTrainTicketUserInforWithJSONDic:dataInfor];
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
    
//   
//    dispatch_async(dispatch_get_main_queue(), ^(void){
//        
//        
//        NSMutableArray *dataInforArray = [NSMutableArray array];
//        for (int index = 10; index < 20; index ++) {
//            
//            UserInformationClass *itemTicket = [[UserInformationClass alloc]init];
//            [itemTicket setUserPerId:[NSString stringWithFormat:@"48520JEIOVMAKF0383%i",index]];
//            if (index%3 == 0) {
//                [itemTicket setUserNameStr:@"薛之嫌"];
//                [itemTicket setUserPerCredentialStyle:@"身份证"];
//            }else  if (index%3 == 1) {
//                [itemTicket setUserNameStr:@"杨利伟"];
//                [itemTicket setUserPerCredentialStyle:@"护照"];
//            }
//            else  if (index%3 == 2) {
//                [itemTicket setUserNameStr:@"张丽娜"];
//                [itemTicket setUserPerCredentialStyle:@"军官证"];
//            }
//            
//            [itemTicket setUserPerCredentialContent:[NSString stringWithFormat:@"1304251987082974%i",index]];
//            
//            [dataInforArray addObject:itemTicket];
//        }
//
//        [self.dataSource appendPage:dataInforArray];
//        [self.dataSource setPageCount:1];
//        [self.mainTableView reloadData];
//        
//    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;
    
    if (indexPath.row < [self.dataSource.data count]) {
        return KSelectedUserInforTableViewCellHeight;
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
    SelectedUserInforTableViewCell* cell = [[SelectedUserInforTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                 reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    UserInformationClass *itemData = (UserInformationClass *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    SelectedUserInforTableViewCell *userCell = (SelectedUserInforTableViewCell* )cell;
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

- (void)userSelectedUserToEditWithIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    
    UserInformationClass *itemData = (UserInformationClass *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    AddTrainTicketUserInforController *viewController = [[AddTrainTicketUserInforController alloc]initWithUserInfor:itemData withIndex:indexPath.row];
    [viewController setDelegate:self];
    XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

- (void)addFinishUserInfor:(UserInformationClass *)userInfor{
    
    /*
    [self.dataSource insertForDataWithObject:userInfor atIndex:0];
    [self.mainTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self updateTableViewDateSourceWithUser:userInfor  indexPath: indexPath withTableView:self.mainTableView];
     */
    
    [self.mainTableView triggerPullToRefresh];
    
}
- (void)editFinishUserInfor:(UserInformationClass *)userInfor withIndex:(NSInteger)index{
//    [self.dataSource replaceForDataWithObjectAtIndex:index withObject:userInfor];
//    [self.mainTableView reloadData];

    [self.mainTableView triggerPullToRefresh];
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
                SelectedUserInforTableViewCell *userCell = (SelectedUserInforTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [userCell.userSelectedImageView setImage:createImageWithColor(KSepLineColorSetup)];
            }
            
            ///若没有则直接加入进去
            else{
                [self.userSelectedUserInforArray addObject:itemData];
                SelectedUserInforTableViewCell *userCell = (SelectedUserInforTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [userCell.userSelectedImageView setImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))];
                
            }
            break;
        }
        
    }else{
        [self.userSelectedUserInforArray addObject:itemData];
        SelectedUserInforTableViewCell *userCell = (SelectedUserInforTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [userCell.userSelectedImageView setImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))];
    }

}

@end
