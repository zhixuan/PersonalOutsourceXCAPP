//
//  WorkerManageSettingController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "WorkerManageSettingController.h"
#import "AddNewWorkerViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"

#import "WorkerManageTableViewCell.h"


@interface WorkerManageSettingController ()<UITableViewDelegate,UITableViewDataSource,WorkerManageTableViewCellDelegate,UIAlertViewDelegate>
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
 * @breif 用工个数
 * @See
 */
@property (nonatomic , weak)            UILabel                     *workerUserCount;


/*!
 * @breif 主管admin数据信息
 * @See
 */
@property (nonatomic , strong)          UserInformationClass        *userForAdminUserInfor;

/*!
 * @breif 用户将要删除的数据信息
 * @See
 */
@property (nonatomic , strong)          UserInformationClass        *userDeleteItemUser;
@end

@implementation WorkerManageSettingController


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
    
    [self settingNavTitle:@"员工管理"];
    
    
    if (KXCAPPCurrentUserInformation.userOptionRoleStyle == OptionRoleStyleForAdministration) {
        [self setRightNavButtonTitleStr:@"新增员工" withFrame:CGRectMake(0, 0.0f, 65.0f, 44.0f)
                           actionTarget:self action:@selector(setAddNewRightButtonEventClicked)];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSuccessFinishAddWorkerNotification:) name:KXCAPPUserAddNewWorkerSuccessFinishNotification object:nil];
    
    [self setupWorkerManageSettingControllerFrame];
}

- (void)userSuccessFinishAddWorkerNotification:(NSNotification *)notification{
    
    [self.mainTableView triggerPullToRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAddNewRightButtonEventClicked{
    
    AddNewWorkerViewController *viewController = [[AddNewWorkerViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}


- (UIView *)setupTableHeaderView{
    UIView *headerView = [[UIView alloc]init];
    [headerView setFrame:CGRectMake(0.0f,0.0f, KProjectScreenWidth, KWorkerManageTableViewCellHeight + KXCUIControlSizeWidth(40.0f))];
    [headerView setBackgroundColor:KDefaultViewBackGroundColor];
    
    UILabel *userCount = [[UILabel alloc]init];
    [userCount setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(40.0f))];
    [userCount setBackgroundColor:[UIColor clearColor]];
    [userCount setFont:KXCAPPUIContentFontSize(16.0f)];
    [userCount setTextColor:KContentTextColor];
    [userCount setTextAlignment:NSTextAlignmentLeft];
    [userCount setText:@"管理员"];
    [headerView addSubview:userCount];
    
    UIView *managerBGView = [[UIView alloc]init];
    [managerBGView setFrame:CGRectMake(0.0f,userCount.bottom, KProjectScreenWidth, KWorkerManageTableViewCellHeight)];
    [managerBGView setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:managerBGView];
    
    UILabel *userNameLabel = [[UILabel alloc]init];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setContentMode:UIViewContentModeCenter];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setTextColor:KContentTextColor];
    [userNameLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
    self.userPersonalNameLabel = userNameLabel;
    [managerBGView addSubview:self.userPersonalNameLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    [phoneLabel setBackgroundColor:[UIColor clearColor]];
    [phoneLabel setContentMode:UIViewContentModeCenter];
    [phoneLabel setTextAlignment:NSTextAlignmentLeft];
    [phoneLabel setTextColor:KSubTitleTextColor];
    [phoneLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    self.userPhoneNumberLabel = phoneLabel;
    [managerBGView addSubview:self.userPhoneNumberLabel];
    
    [self.userPersonalNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(6.0f), KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(25.0f))];
    
    [self.userPhoneNumberLabel setFrame:CGRectMake(KInforLeftIntervalWidth, (self.userPersonalNameLabel.bottom + KXCUIControlSizeWidth(3.0f)), KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(20.0f))];
    
    return headerView;
}
- (void)setupWorkerManageSettingControllerFrame{
    
    UITableView *tbview = [[UITableView alloc]initWithFrame:self.view.bounds
                                                      style:UITableViewStyleGrouped];
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
    
    __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation =  [XCAPPHTTPClient userGetAllWorkerUserInforWithUserId:KXCAPPCurrentUserInformation.userPerId userRole:KXCAPPCurrentUserInformation.userOptionRoleStyle pageNumber:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"【所有员工信息】response.responseObject is \n%@",response.responseObject);
            
            //关掉PullToRefreshView
            if (weakSelf.mainTableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf mainTableView]);
                [weakSelf.mainTableView.pullToRefreshView stopAnimating];
            }
            
            
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    NSLog(@"responeDic 解析后的数据是%@",responeDic);
                    
                    if (responeDic.count == 5) {
                        ///主管数据
                        if ([ObjForKeyInUnserializedJSONDic(responeDic, @"admin") isKindOfClass:[NSDictionary class]]) {
                            NSDictionary  *adminDic = ObjForKeyInUnserializedJSONDic(responeDic, @"admin");
                            weakSelf.userForAdminUserInfor = [UserInformationClass initializaionWithUserForWorkerAndAdminInforWithJSONDic:adminDic];
                            
                            [weakSelf.userPersonalNameLabel setText:weakSelf.userForAdminUserInfor.userNickNameStr];
                            [weakSelf.userPhoneNumberLabel setText:[NSString stringWithFormat:@"%@ %@",weakSelf.userForAdminUserInfor.userNameStr,weakSelf.userForAdminUserInfor.userPerPhoneNumberStr]];
                        }
                        
                        ///员工数据
                        if ([ObjForKeyInUnserializedJSONDic(responeDic, @"list") isKindOfClass:[NSArray class]]) {
                            NSArray *workerArray = (NSArray *)ObjForKeyInUnserializedJSONDic(responeDic, @"list");
                            
                            NSMutableArray *workerMutableArray = [NSMutableArray array];
                            for (NSDictionary  *jsonDic in workerArray) {
                                UserInformationClass *worker = [UserInformationClass initializaionWithUserForWorkerAndAdminInforWithJSONDic:jsonDic];
                                [workerMutableArray addObject:worker];
                            }
                            
                            [weakSelf.dataSource appendPage:workerMutableArray];

                            
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
                        
                        ///总页码数据
                        NSInteger pageCount = IntForKeyInUnserializedJSONDic(responeDic, @"pages");
                        [weakSelf.dataSource setPageCount:pageCount];
                        [weakSelf.mainTableView reloadData];
                        
                    }
                }
            }
            else{
                if (weakSelf.loadMoreCell) {
                    [weakSelf.loadMoreCell stopLoadingAnimation];
                    weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
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
        return KWorkerManageTableViewCellHeight;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return KXCUIControlSizeWidth(40.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    [headerView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(40.0f))];
    [headerView setBackgroundColor:KDefaultViewBackGroundColor];
    
    UILabel *userCount = [[UILabel alloc]init];
    [userCount setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(40.0f))];
    [userCount setBackgroundColor:[UIColor clearColor]];
    [userCount setFont:KXCAPPUIContentFontSize(16.0f)];
    [userCount setTextColor:KContentTextColor];
    [userCount setTextAlignment:NSTextAlignmentLeft];
    
    
    if ([self.dataSource count] > 0) {
        [userCount setText:[NSString stringWithFormat:@"员工（%zi人）",[self.dataSource count]]];
    }else{
        [userCount setText:@""];
    }
    
    self.workerUserCount = userCount;
    [headerView addSubview:self.workerUserCount];
    
    return headerView;
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
    {
        return CreateLoadMoreCell();
        
    }
    WorkerManageTableViewCell* cell = [[WorkerManageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                       reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    UserInformationClass *itemData = (UserInformationClass *)[self.dataSource.data objectAtIndex:(indexPath.row)];
    WorkerManageTableViewCell *userCell = (WorkerManageTableViewCell* )cell;
    [userCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [userCell setDelegate:self];
    [userCell setupUserInforDataSource:itemData indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"WorkerManageTableViewCell";
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
}

- (void)deleteUserWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    
    self.userDeleteItemUser = (UserInformationClass *)[self.dataSource.data objectAtIndex:indexPath.row];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"你确定要删除该员工吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"buttonIndex is %zi",buttonIndex);
    if (buttonIndex != 0) {
//        NSLog(@"userName %@,nickeName is %@,phone is %@",self.userDeleteItemUser.userNameStr,self.userDeleteItemUser.userNickNameStr,self.userDeleteItemUser.userPerPhoneNumberStr);
        [self userDeleteHttpRequestOperation];
    }
}


- (void)userDeleteHttpRequestOperation{
    
    
    
WaittingMBProgressHUD(HUIKeyWindow, @"正在删除...");
    
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userDeleteWorkerUserInforWithUserId:KXCAPPCurrentUserInformation.userPerId workerId:self.userDeleteItemUser.userPerId completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                FinishMBProgressHUD(HUIKeyWindow);
                [weakSelf.mainTableView triggerPullToRefresh];
                NSLog(@"response.responseObject is %@",response.responseObject);
            }else{
                NSLog(@"codeDescription is %@",response.codeDescription);
                FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
            }
        });
    }];
}

@end
