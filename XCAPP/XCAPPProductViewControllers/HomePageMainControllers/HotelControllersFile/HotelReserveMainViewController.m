//
//  HotelReserveMainViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelReserveMainViewController.h"
#import "HotelMainListInforViewController.h"
#import "HotelPersonalCollectController.h"
#import "LocationOrNameSearchController.h"
#import "HotelAtCitySearchController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

#import "UserHotelOrderInformation.h"
#import "CityInforViewController.h"


#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"

#define KBtnForNearbyButtonTag              (1470111)
#define KBtnForLocationButtonTag            (1470112)

#define KBtnForMoveIntoButtonTag            (1470113)


#define KBtnForCollectButtonTag             (1470114)
#define KBtnForSearchHotelButtonTag         (1470115)
#define KBtnForSearchButtonTag              (1470116)

#define KBtnForAddOneDayButtonTag           (1470211)
#define KBtnForSubtractDayButtonTag         (1470212)




@interface HotelReserveMainViewController ()<XCLocationManagerDelegate,SelectedCityInforDelegate>


/*!
 * @breif 用户酒店预订订单
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation       *userReserveHotelOrder;
/*!
 * @breif 查询种类设置
 * @See
 */
@property (nonatomic , assign)      UserMatterStateStyle            userPerMatterStateStyle;

/*!
 * @breif 定位设置
 * @See
 */
@property (nonatomic , strong)      XCLocationManager           *hotelLocationManager;

/*!
 * @breif 定位信息
 * @See
 */
@property (nonatomic , strong)      XCLocationAPIResponse           *locationResponseResult;

/*!
 * @breif 日历选择信息
 * @See
 */
@property (nonatomic , strong)      CalendarHomeViewController *chvc;


/*!
 * @breif 显示入住时间
 * @See
 */
@property (nonatomic , weak)        UILabel                     *moveIntoDateLabel;

/*!
 * @breif 用户定位位置信息
 * @See
 */
@property (nonatomic , weak)      UIButton                      *userAtCityButton;

/*!
 * @breif 用户入住天数
 * @See
 */
@property (nonatomic , weak)      UILabel                       *userStayDayCountLabel;

/*!
 * @breif 用户离开时间
 * @See
 */
@property (nonatomic , weak)      UILabel                       *userMoveOutDateLabel;

/*!
 * @breif 用户选中的城市信息
 * @See
 */
@property (nonatomic , copy)      NSString                      *userWillAtCityNameStr;

/*!
 * @breif 用户选中的城市编号
 * @See
 */
@property (nonatomic , copy)      NSString                      *userWillAtCityCodeStr;

@end

@implementation HotelReserveMainViewController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
//        self.enableCustomNavbarBackButton = FALSE ;
      
    }
    return self;
}

- (id)initWithMatterStateStyle:(UserMatterStateStyle)stateStyle{
    self = [super init];
    if (self) {
        
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
    
    [self settingNavTitle:@"酒店查询"];
    
    self.userWillAtCityNameStr = [[NSString alloc]initWithFormat:@"%@",@"武汉市"];
    self.userWillAtCityCodeStr = [[NSString alloc]initWithFormat:@"%@",@"420100"];
    
    self.userReserveHotelOrder = [[UserHotelOrderInformation alloc]init];
    
    self.locationResponseResult = [[XCLocationAPIResponse alloc]init];
    [self.locationResponseResult setIsOpenLocationBool:NO];
    self.hotelLocationManager= [[XCLocationManager alloc]init];
    
    [self.userReserveHotelOrder setOrderUserMoveIntoDate:dateForCurrentWithYearRodMonthRodDay()];
    [self.userReserveHotelOrder setOrderForHotelBeginDate:dateForCurrentWithYearRodMonthRodDay()];

    
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(30.0f, (contentBGView.bottom + KXCUIControlSizeWidth(30.0f)),
                                        (KProjectScreenWidth - 60.0f)/3,40.0f)];
    [button setTitle:@"因公出行" forState:UIControlStateNormal];
    [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button setTag:10];
    [button addTarget:self action:@selector(buttonClickedOperation:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(button.right + 30.0f, (contentBGView.bottom + KXCUIControlSizeWidth(30.0f)),
                                 (KProjectScreenWidth - 60.0f)/3,40.0f)];
    [button1 setTitle:@"因私出行" forState:UIControlStateNormal];
    [button1 setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(buttonClickedOperation:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [button1 setTag:11];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(30.0f, (button1.bottom + KXCUIControlSizeWidth(30.0f)),
                                 (KProjectScreenWidth - 60.0f)/3,40.0f)];
    [button2 setTitle:@"开启定位" forState:UIControlStateNormal];
    [button2 setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(buttonClickedOperation:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [button2 setTag:KBtnForLocationButtonTag];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(button2.right + 30.0f, (button1.bottom + KXCUIControlSizeWidth(30.0f)),
                                 (KProjectScreenWidth - 60.0f)/2.2,40.0f)];
    [button3 setTitle:@"位置/酒店名搜索" forState:UIControlStateNormal];
    [button3 setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button3 addTarget:self action:@selector(buttonClickedOperation:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [button3 setTag:KBtnForSearchButtonTag];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setFrame:CGRectMake(30.0f, (button3.bottom + KXCUIControlSizeWidth(30.0f)),
                                 (KProjectScreenWidth - 60.0f)/3,40.0f)];
    [button4 setTitle:@"收藏" forState:UIControlStateNormal];
    [button4 setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button4 addTarget:self action:@selector(buttonClickedOperation:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [button4 setTag:KBtnForCollectButtonTag];
    [self.view addSubview:button4];
     */
    
    [self setupHotelReserveMainViewControllerFrame];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupHotelReserveMainViewControllerFrame{
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                       (KProjectScreenWidth - 2*KInforLeftIntervalWidth), KFunctionModulButtonHeight*1.3*4+3.0f)];
    [contentBGView.layer setCornerRadius:5.0f];
    [contentBGView.layer setMasksToBounds:YES];
    [mainView addSubview:contentBGView];
    
    UIButton *nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearbyBtn setFrame:CGRectMake(0.0f,0.0f, contentBGView.width,KFunctionModulButtonHeight*1.3)];
    [nearbyBtn setTitle:@"上海" forState:UIControlStateNormal];
    [nearbyBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [nearbyBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [nearbyBtn setTag:KBtnForNearbyButtonTag];
    [nearbyBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((28.0f)*KXCAdapterSizeWidth)]];
    [nearbyBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                         forState:UIControlStateNormal];
    [nearbyBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                         forState:UIControlStateHighlighted];
    [nearbyBtn addTarget:self action:@selector(buttonClickedOperation:)
        forControlEvents:UIControlEventTouchUpInside];
    self.userAtCityButton = nearbyBtn;
    [contentBGView addSubview:self.userAtCityButton];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setTag:KBtnForLocationButtonTag];
    [locationButton setBackgroundColor:[UIColor clearColor]];
    [locationButton.titleLabel setFont:KXCAPPUIContentFontSize(20.0f)];
    [locationButton setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [locationButton simpleButtonWithImageColor:KStateNormalContentColor];
    [locationButton setAwesomeIcon:FMIconLocation];
    [locationButton setFrame:CGRectMake((nearbyBtn.width -KFunctionModulButtonHeight*2.3) ,
                                        KFunctionModulButtonHeight*0.1, KFunctionModulButtonHeight*1.1,
                                        KFunctionModulButtonHeight*1.1)];
    [locationButton addTarget:self action:@selector(buttonClickedOperation:)
             forControlEvents:UIControlEventTouchUpInside];
    [locationButton setBackgroundColor:[UIColor clearColor]];
    [nearbyBtn addSubview:locationButton];
    
    UIView *sepNearbyView = [[UIView alloc]init];
    [sepNearbyView setFrame:CGRectMake(0.0f, nearbyBtn.bottom, nearbyBtn.width, 1.0f)];
    [sepNearbyView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepNearbyView];
    
    
    //MARK:入住时间
    UIButton *moveintoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moveintoBtn setFrame:CGRectMake(0.0f,sepNearbyView.bottom, contentBGView.width,KFunctionModulButtonHeight*1.3)];
    [moveintoBtn setTag:KBtnForMoveIntoButtonTag];
    [moveintoBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                           forState:UIControlStateNormal];
    [moveintoBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                           forState:UIControlStateHighlighted];
    [moveintoBtn addTarget:self action:@selector(buttonClickedOperation:)
          forControlEvents:UIControlEventTouchUpInside];
    [contentBGView addSubview:moveintoBtn];
    
    
    UILabel *moveIntoLabel = [[UILabel alloc]init];
    [moveIntoLabel setBackgroundColor:[UIColor clearColor]];
    [moveIntoLabel setTextColor:KContentTextColor];
    [moveIntoLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [moveIntoLabel setTextAlignment:NSTextAlignmentCenter];
    [moveIntoLabel setFrame:CGRectMake(KXCUIControlSizeWidth(60.0f), 0.0f, (moveintoBtn.width - KXCUIControlSizeWidth(60.0f)*2), (KFunctionModulButtonHeight*1.3))];
    
    self.moveIntoDateLabel = moveIntoLabel;
    
    NSDictionary *dateDictionary = (NSDictionary *)dateForCurrentDateWithYearMonthDay();
    NSString *dateCurrentStr = [NSString stringWithFormat:@"%@%@",[StringForKeyInUnserializedJSONDic(dateDictionary,@"date") substringToIndex:6],@"今天"];
    [self.moveIntoDateLabel setText:dateCurrentStr];
    
    [moveintoBtn addSubview:self.moveIntoDateLabel];
    
    UILabel *moveinto= [[UILabel alloc]init];
    [moveinto setBackgroundColor:[UIColor clearColor]];
    [moveinto setTextColor:KSubTitleTextColor];
    [moveinto setFont:KXCAPPUIContentFontSize(14.0f)];
    [moveinto setText:@"入住"];
    [moveinto setTextAlignment:NSTextAlignmentCenter];
    [moveinto setFrame:CGRectMake((moveintoBtn.width -KFunctionModulButtonHeight*2.1),(KFunctionModulButtonHeight*0.6),
                                  KXCUIControlSizeWidth(30.0f), (KFunctionModulButtonHeight*0.5))];
    [moveintoBtn addSubview:moveinto];
    UIView *sepMmoveintoView = [[UIView alloc]init];
    [sepMmoveintoView setFrame:CGRectMake(0.0f, moveintoBtn.bottom, nearbyBtn.width, 1.0f)];
    [sepMmoveintoView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepMmoveintoView];
    
    
    
    ///MARK：需要入住的天数信息
    
    UILabel *movestayLabel = [[UILabel alloc]init];
    [movestayLabel setBackgroundColor:[UIColor clearColor]];
    [movestayLabel setTextColor:KContentTextColor];
    [movestayLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [movestayLabel setTextAlignment:NSTextAlignmentCenter];
    [movestayLabel setFrame:CGRectMake(KXCUIControlSizeWidth(100.0f), (sepMmoveintoView.bottom + KInforLeftIntervalWidth), (moveintoBtn.width - KXCUIControlSizeWidth(100.0f)*2), KXCUIControlSizeWidth(23.0f))];
    self.userStayDayCountLabel = movestayLabel;
    [contentBGView addSubview:self.userStayDayCountLabel];
    
    UILabel *goOut= [[UILabel alloc]init];
    [goOut setBackgroundColor:[UIColor clearColor]];
    [goOut setTextColor:KSubTitleTextColor];
    [goOut setFont:KXCAPPUIContentFontSize(13.0f)];
    [goOut setTextAlignment:NSTextAlignmentCenter];
    [goOut setFrame:CGRectMake(movestayLabel.left,(movestayLabel.bottom + KXCUIControlSizeWidth(5.0f)),
                               movestayLabel.width, (KXCUIControlSizeWidth(15.0f)))];
    self.userMoveOutDateLabel = goOut;
    [contentBGView addSubview:self.userMoveOutDateLabel];
    
    
    
    [self setupViewShowInfor];
    
    UIButton *subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractButton setTag:KBtnForSubtractDayButtonTag];
    [subtractButton setBackgroundColor:[UIColor clearColor]];
    [subtractButton.titleLabel setFont:KXCAPPUIContentFontSize(23.0f)];
    [subtractButton setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [subtractButton simpleButtonWithImageColor:KStateNormalContentColor];
    [subtractButton.titleLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [subtractButton setAwesomeIcon:FMIconSubtract];
    [subtractButton setFrame:CGRectMake(KInforLeftIntervalWidth*2 ,
                                        (sepMmoveintoView.bottom),
                                        KFunctionModulButtonHeight*1.3,KFunctionModulButtonHeight*1.3)];
    [subtractButton addTarget:self action:@selector(userAddSubtractStayDaysOperationEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
    [subtractButton setBackgroundColor:[UIColor clearColor]];
    [contentBGView addSubview:subtractButton];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTag:KBtnForAddOneDayButtonTag];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton.titleLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [addButton setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [addButton simpleButtonWithImageColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f)];
    [addButton.titleLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [addButton setAwesomeIcon:FMIconAdd];
    [addButton setFrame:CGRectMake((contentBGView.width - KInforLeftIntervalWidth*2 - KFunctionModulButtonHeight*1.3),
                                   (sepMmoveintoView.bottom),
                                   KFunctionModulButtonHeight*1.3,KFunctionModulButtonHeight*1.3)];
    [addButton addTarget:self action:@selector(userAddSubtractStayDaysOperationEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [contentBGView addSubview:addButton];
    
    
    UIView *sepSearchView = [[UIView alloc]init];
    [sepSearchView setFrame:CGRectMake(0.0f,( sepMmoveintoView.bottom + KFunctionModulButtonHeight*1.3), nearbyBtn.width,
                                       1.0f)];
    [sepSearchView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepSearchView];
    
    UIButton *searchHotelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchHotelBtn setFrame:CGRectMake(0.0f,sepSearchView.bottom, contentBGView.width,KFunctionModulButtonHeight*1.3)];
    [searchHotelBtn setTitle:@"位置/酒店名搜索" forState:UIControlStateNormal];
    [searchHotelBtn setTitleColor:KFunContentColor forState:UIControlStateNormal];
    [searchHotelBtn setTitleColor:KFunContentColor forState:UIControlStateHighlighted];
    [searchHotelBtn setTag:KBtnForSearchHotelButtonTag];
    [searchHotelBtn.titleLabel setFont:[UIFont systemFontOfSize:((23.0f)*KXCAdapterSizeWidth)]];
    [searchHotelBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                              forState:UIControlStateNormal];
    [searchHotelBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                              forState:UIControlStateHighlighted];
    [searchHotelBtn addTarget:self action:@selector(buttonClickedOperation:)
             forControlEvents:UIControlEventTouchUpInside];
    [contentBGView addSubview:searchHotelBtn];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [searchBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [searchBtn setTag:KBtnForSearchButtonTag];
    [searchBtn setTitle:@"查   询" forState:UIControlStateNormal];
    [searchBtn.layer setCornerRadius:5.0f];
    [searchBtn addTarget:self action:@selector(buttonClickedOperation:)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (contentBGView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [mainView addSubview:searchBtn];
    
    
    

}
- (void)locationDidFinishResponse:(XCLocationAPIResponse *)locationResult{
    
    if (locationResult.isSuccess) {
        NSString *province =  StringForKeyInUnserializedJSONDic(locationResult.responseObject,KKeyProvince);
        NSString *cityname =  StringForKeyInUnserializedJSONDic(locationResult.responseObject,KKeyCityName);
        NSString *address = StringForKeyInUnserializedJSONDic(locationResult.responseObject, KKeyAddress);
        FinishMBProgressHUD(HUITopWindow);
        ShowImportErrorAlertView([NSString stringWithFormat:@"省份 %@\n城市%@\naddress i%@",province,cityname,address]);
        self.locationResponseResult = locationResult;
        [self.locationResponseResult setIsOpenLocationBool:YES];
        
        [self.userAtCityButton setTitle:cityname forState:UIControlStateNormal];
    }else{
         FailedMBProgressHUD(HUITopWindow,@"定位失败!");
    }
}

- (void)buttonClickedOperation:(UIButton *)button{
    
//    return;
    if (button.tag == KBtnForNearbyButtonTag) {
//        HotelMainListInforViewController *viewController = [[HotelMainListInforViewController alloc]initWithMatterStateStyle:MatterStateStyleForOfficialBusinessStyle locationInfor:self.locationResponseResult];
//        [viewController setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:viewController animated:YES];
        
        CityInforViewController *viewController = [[CityInforViewController alloc]initWithTitleStr:@"入住城市" style:CityForArrivedStyle];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];

    }else if(button.tag == 11){
        HotelMainListInforViewController *viewController = [[HotelMainListInforViewController alloc]initWithMatterStateStyle:MatterStateStyleForPrivateConcernStyle locationInfor:self.locationResponseResult searchInfor:self.userReserveHotelOrder];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    else if (button.tag == KBtnForLocationButtonTag){
        
        [self.hotelLocationManager starXCLocation];
        [self.hotelLocationManager setDelegate:self];
        WaittingMBProgressHUD(HUITopWindow,@"正在定位...");
    }
    
    ///入住时间
    else if(KBtnForMoveIntoButtonTag == button.tag){
        
        if (!self.chvc) {
            
            self.chvc = [[CalendarHomeViewController alloc]init];
            
            self.chvc.calendartitle = @"出发日期";
            
            [self.chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
            
        }
        
        __weak __typeof(&*self)weakSelf = self;
        self.chvc.calendarblock = ^(CalendarDayModel *model){
            NSDictionary *dateDictionary = dateYearMonthDayWeekWithDateStr([model toString]);
            
            [weakSelf.moveIntoDateLabel setText:StringForKeyInUnserializedJSONDic(dateDictionary, @"date")];
            
            [weakSelf.userReserveHotelOrder setOrderUserMoveIntoDate:[model toString]];
            [weakSelf.userReserveHotelOrder setOrderForHotelBeginDate:[model toString]];
            [weakSelf.userReserveHotelOrder setOrderStayDayesQuantityInteger:1];
            [weakSelf setupViewShowInfor];
            
        };
        
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:self.chvc];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
        
    }

    
    else if (button.tag == KBtnForCollectButtonTag){
      
        HotelPersonalCollectController*viewController = [[HotelPersonalCollectController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    //
    else if (KBtnForSearchHotelButtonTag == button.tag){
        LocationOrNameSearchController*viewController = [[LocationOrNameSearchController alloc]initWithUserHotelAtCityCodeStr:self.userReserveHotelOrder.orderAtCityCodeStr];
        [viewController setHidesBottomBarWhenPushed:YES];
        XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigation animated:YES
                         completion:^{
                             
                         }];
    }
    
    
    
    
    else if (button.tag == KBtnForSearchButtonTag){
        
        
        
        [self.userReserveHotelOrder setOrderAtCityNameStr:self.userWillAtCityNameStr];
        [self.userReserveHotelOrder setOrderAtCityCodeStr:self.userWillAtCityCodeStr];
        HotelMainListInforViewController *viewController = [[HotelMainListInforViewController alloc]initWithMatterStateStyle:MatterStateStyleForOfficialBusinessStyle
                                                                                                               locationInfor:self.locationResponseResult searchInfor:self.userReserveHotelOrder];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}


- (void)setupDateWithInterval:(CGFloat)intervalTime{
    
    NSString *dateString = self.userReserveHotelOrder.orderUserMoveIntoDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateString];
    NSDate *willDate = [NSDate dateWithTimeInterval:intervalTime sinceDate:date];
    [self.userReserveHotelOrder setOrderForHotelEndDate:[formatter stringFromDate:willDate]];
    
    NSDictionary *dateDic = dateYearMonthDayWeekWithDateStr(self.userReserveHotelOrder.orderForHotelEndDate);
    
    [self.userMoveOutDateLabel setText:StringForKeyInUnserializedJSONDic(dateDic, @"date")];
    
    
}



- (void)userAddSubtractStayDaysOperationEventClicked:(UIButton *)button{
    
    ///增加一天
    if (KBtnForAddOneDayButtonTag == button.tag) {
        
        self.userReserveHotelOrder.orderStayDayesQuantityInteger +=1;
       
        
    }
    ///减去一天
    else if (KBtnForSubtractDayButtonTag == button.tag){
    
        
        if ((self.userReserveHotelOrder.orderStayDayesQuantityInteger-1) == 0) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"至少住 1 晚!");
            return;
        }
        self.userReserveHotelOrder.orderStayDayesQuantityInteger -=1;
    }
    [self setupViewShowInfor];
}

- (void)setupViewShowInfor{
    
    [self.userStayDayCountLabel setText:[NSString stringWithFormat:@"住 %zi 晚",self.userReserveHotelOrder.orderStayDayesQuantityInteger]];
    
    NSRange contentRange=[self.userStayDayCountLabel.text rangeOfString:[NSString stringWithFormat:@"%zi",self.userReserveHotelOrder.orderStayDayesQuantityInteger]];
    NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:self.userStayDayCountLabel.text];
    [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(24) range:contentRange];
    [dynamicContent addAttribute:NSForegroundColorAttributeName value:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) range:contentRange];
    [self.userStayDayCountLabel setAttributedText:dynamicContent];
    
    [self setupDateWithInterval:(self.userReserveHotelOrder.orderStayDayesQuantityInteger*kHUITimeIntervalDay)];
}

- (void)userSelectedCityName:(NSString *)citynameStr cityCode:(NSString *)cityCodeStr style:(UserSelectedCityStyle)style{
    
    NSLog(@"citynameStr is %@,cityCodeStr %@",citynameStr,cityCodeStr);
    
    self.userWillAtCityNameStr = [NSString stringWithFormat:@"%@",citynameStr];
    self.userWillAtCityCodeStr = [NSString stringWithFormat:@"%@",cityCodeStr];
    
    [self.userAtCityButton setTitle:citynameStr forState:UIControlStateNormal];
}
@end
