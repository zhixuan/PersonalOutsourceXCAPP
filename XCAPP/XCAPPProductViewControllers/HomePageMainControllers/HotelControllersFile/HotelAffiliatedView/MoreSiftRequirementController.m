//
//  MoreSiftRequirementController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/3.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "MoreSiftRequirementController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"
#import "MoreSiftRequirementAreaTableViewCell.h"

#define KBtnForLeftTag              (1430112)
#define KBtnForCenterTag            (1430113)
#define KBtnForRightTag             (1430114)

//#define KBtnForBeginSiftTag         (1430115)

#define KBtnForAreaButtonTag        (1430116)
#define KBtnForDoneButtonTag        (1430118)

@interface MoreSiftRequirementController ()<UITableViewDelegate,UITableViewDataSource>


/*!
 * @breif 城市编号信息
 * @See
 */
@property (nonatomic , strong)      NSString                *hotelAtCityCodeStr;
///*!
// * @breif 预付房型
// * @See
// */
//@property (nonatomic , weak)      UIButton                  *hotelAdvanceBtn;
//
///*!
// * @breif 尊贵酒店
// * @See
// */
//@property (nonatomic , weak)      UIButton                  *hotelHighclassBtn;
///*!
// * @breif 符合差标
// * @See
// */
//@property (nonatomic , weak)      UIButton                  *hotelAccordBtn;
//
///*!
// * @breif 头部房型搜索类别
// * @See
// */
//@property (nonatomic , strong)      NSMutableArray          *hotelStyleArray;



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
@property (nonatomic , strong)          DataPage                    *dataSourceForArea;

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


@end

@implementation MoreSiftRequirementController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE;
        self.dataSourceForArea = [DataPage page];
    }
    return self;
}

- (id)initWithCityCodeStr:(NSString *)cityCode{
    self = [super init];
    if (self) {
        self.dataSourceForArea = [DataPage page];
        self.enableCustomNavbarBackButton = FALSE;
        self.hotelAtCityCodeStr = [NSString stringWithFormat:@"%@",cityCode];
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

    [self setupMoreSiftRequirementControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setRightNavButtonTitleStr:(NSString *)titleStr withFrame:(CGRect)frame
                     actionTarget:(id)target action:(SEL)action{
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
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -6);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -6);
    }
    self.navigationItem.rightBarButtonItem = navItem;
}


- (void)leftButtonOperationEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setupMoreSiftRequirementControllerFrame{
    
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
    [areaSelectedButton setFrame:CGRectMake(0.0f,(0.0f),(KXCUIControlSizeWidth(120.0f)),
                                 KFunctionModulButtonHeight)];
    [self.view addSubview:areaSelectedButton];
    
    UIView *sepLineBGView = [[UIView alloc]init];
    [sepLineBGView setBackgroundColor:KSepLineColorSetup];
    [sepLineBGView setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight - 1.0f,
                                       areaSelectedButton.width, 1.0f)];
    [areaSelectedButton addSubview:sepLineBGView];
    
    
    ///MARK:初始化底部信息
    CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
    
    CGRect tableViewRect = CGRectMake(areaSelectedButton.right, 0.0f, (KProjectScreenWidth - areaSelectedButton.right), ((self.view.bounds.size.height - KXCUIControlSizeWidth(80.0f)- navigationBarHeight)));
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
    
    CGRect bottomRect = CGRectMake(KInforLeftIntervalWidth,
                                   (tbview.bottom + KXCUIControlSizeWidth(15.0f))
                                   , (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KXCUIControlSizeWidth(50.0f));
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [doneBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [doneBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [doneBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [doneBtn.layer setCornerRadius:5.0f];
    [doneBtn addTarget:self action:@selector(userGotoSiftBtnEventClicked)
        forControlEvents:UIControlEventTouchUpInside];
    [doneBtn.layer setMasksToBounds:YES];
    [doneBtn setFrame:bottomRect];
    [self.view addSubview:doneBtn];
    
    [self refreshListData];

}


- (void)userGotoSiftBtnEventClicked{
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(moreSiftRequirementButtonOperationEventWithAreaCode:)]) {
            [self.delegate moreSiftRequirementButtonOperationEventWithAreaCode:self.userSelectedAreaCodeStr];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)userOperationButtonEventClicked:(UIButton *)button{
    
    
    if (button.tag == KBtnForAreaButtonTag) {
        ///刷新界面操作
        [self refreshListData];
    }
}

- (void)refreshListData{
    
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有·数据
    [self.dataSourceForArea cleanAllData];
    [self.mainTableView reloadData];
    [self loadMoreListData];
    
    NSArray *defautlArray = @[@{@"name":@"不限",
                                @"code":@"0"}];
    [self.dataSourceForArea appendPage:defautlArray];
    self.userSelectedAreaCodeStr = @"";
    self.userSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)loadMoreListData{
    [self setupHomeHotTopicInforControllerDataSource];
}

///设置热门信息信息内容(活动/装备/线路)
- (void)setupHomeHotTopicInforControllerDataSource{
    
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0.0f;
    
    if([self _isLoadMoreCellAtIndexPath:indexPath])
        heightForRow =  kSizeLoadMoreCellHeight;

    if (indexPath.row < [self.dataSourceForArea.data count]) {

        return KAreaTableViewCellHeight;
    }
    return heightForRow;
}


#pragma mark - UITableViewDataSource


- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [self.dataSourceForArea count]);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  ([self.dataSourceForArea count]);
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
    {
        return CreateLoadMoreCell();
        
    }
    MoreSiftRequirementAreaTableViewCell* cell = [[MoreSiftRequirementAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:cellIdentifier];
    return cell;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSourceForArea.data count]) {
        return;
    }
    
    NSDictionary *dataDic = (NSDictionary *)[self.dataSourceForArea.data objectAtIndex:(indexPath.row)];

    MoreSiftRequirementAreaTableViewCell *hotelCell = (MoreSiftRequirementAreaTableViewCell* )cell;
    [hotelCell setupTableViewDataSource:StringForKeyInUnserializedJSONDic(dataDic,@"name") indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"MoreSiftRequirementAreaTableViewCell";
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
        if ([self.dataSourceForArea canLoadMore])
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
    
    if (indexPath.row >= [self.dataSourceForArea.data count]) {
        return;
    }
    
    
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

@end
