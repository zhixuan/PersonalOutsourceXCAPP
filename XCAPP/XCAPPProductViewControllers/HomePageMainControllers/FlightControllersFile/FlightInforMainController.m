//
//  FlightInforMainController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightInforMainController.h"
#import "FlightOrderInformation.h"
#import "FlightMainListViewController.h"
#import "DefaultotelRecommendSearchLayerView.h"

#import "CityInforViewController.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"

#define KBtnForOnlyButtonTag                    (1420211)
#define KBtnForReturnButtonTag                  (1420212)

#define KBtnForBeginSiteBtnTag                  (1420213)
#define KBtnForExchangeButtonTag                (1430112)
#define KBtnForEndSiteButtonTag                 (1420214)

#define KBtnForBeginDateButtonTag               (1420215)
#define KBtnForEndDateButtonTag                 (1420216)

#define KBtnForStyleButtonTag                   (1420217)


#define KBtnForSearchButtonTag                  (1420218)

@interface FlightInforMainController ()<DefaultotelRecommendDelegate,SelectedCityInforDelegate>


/*!
 * @breif   单程选项按键
 * @See
 */
@property (nonatomic , weak)      UIButton  *btnOnlyTicket;

/*!
 * @breif   往返选项按键
 * @See
 */
@property (nonatomic , weak)      UIButton  *btnReturnTicket;

/*!
 * @breif 出发地
 * @See
 */
@property (nonatomic , weak)      UIButton  *btnBeginCityName;

/*!
 * @breif 出发地
 * @See
 */
@property (nonatomic , weak)      UIButton  *btnArrivedCityName;

/*!
 * @breif 出发日期
 * @See
 */
@property (nonatomic , weak)      UIButton  *btnBeginDate;

/*!
 * @breif 乘坐火车时间字符串
 * @See
 */
@property (nonatomic , strong)      NSString    *userBeginDateStr;

/*!
 * @breif 乘客返回时间按键
 * @See
 */
@property (nonatomic , weak)      UIButton  *btnReturnDate;

/*!
 * @breif 乘客返回时间字符串
 * @See
 */
@property (nonatomic , strong)      NSString    *userReturnDateStr;


/*!
 * @breif 搜索舱位信息按键
 * @See
 */
@property (nonatomic , weak)      UIButton      *btnCabinModelButton;


/*!
 * @breif 选择视图
 * @See
 */
@property (nonatomic , weak)      DefaultotelRecommendSearchLayerView *flightSearchLayerView;


/*!
 * @breif 用户是否选择了返程票
 * @See 默认为单程票，即NO
 */
@property (nonatomic , assign)      BOOL            userIsSelectedReturnTicketBool;
@end

@implementation FlightInforMainController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
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
    [self settingNavTitle:@"国内/国际机票"];
    
    self.userIsSelectedReturnTicketBool = NO;
    [self setupFlightInforMainControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFlightInforMainControllerFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                       (KProjectScreenWidth - 2*KInforLeftIntervalWidth),
                                       KFunctionModulButtonHeight*1.2*4+2.0f)];
    [contentBGView.layer setCornerRadius:5.0f];
    [contentBGView.layer setMasksToBounds:YES];
    [mainView addSubview:contentBGView];
    
    
    UIButton *onlyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [onlyBtn setBackgroundColor:[UIColor clearColor]];
    [onlyBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                        forState:UIControlStateNormal];
    [onlyBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                        forState:UIControlStateHighlighted];
    [onlyBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((22.0f)*KXCAdapterSizeWidth)]];
    [onlyBtn setTitleColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) forState:UIControlStateNormal];
    [onlyBtn setTitleColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) forState:UIControlStateHighlighted];
    [onlyBtn setTag:KBtnForOnlyButtonTag];
    [onlyBtn setTitle:@"单程" forState:UIControlStateNormal];
    [onlyBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [onlyBtn setFrame:CGRectMake(0.0f,0.0f, (contentBGView.width)/2,
                                  KFunctionModulButtonHeight*1.2)];
    self.btnOnlyTicket = onlyBtn;
    [contentBGView addSubview:self.btnOnlyTicket];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setBackgroundColor:[UIColor clearColor]];
    [returnBtn setBackgroundImage:createImageWithColor(HUIRGBColor(213, 221, 230, 1.0))
                       forState:UIControlStateNormal];
    [returnBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                       forState:UIControlStateHighlighted];
    [returnBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((22.0f)*KXCAdapterSizeWidth)]];
    [returnBtn setTitleColor:KFunContentColor forState:UIControlStateNormal];
    [returnBtn setTitleColor:KFunContentColor forState:UIControlStateHighlighted];
    [returnBtn setTag:KBtnForReturnButtonTag];
    [returnBtn setTitle:@"往返" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [returnBtn setFrame:CGRectMake((contentBGView.width)/2,0.0f, (contentBGView.width)/2,
                                 KFunctionModulButtonHeight*1.2)];
    self.btnReturnTicket = returnBtn;
    [contentBGView addSubview:self.btnReturnTicket];
    
    
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setBackgroundColor:[UIColor clearColor]];
    [beginBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                        forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                        forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [beginBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [beginBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [beginBtn setTag:KBtnForBeginSiteBtnTag];
    [beginBtn setTitle:@"北京" forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [beginBtn setFrame:CGRectMake(0.0f,KFunctionModulButtonHeight*1.2,
                                  (contentBGView.width - KFunctionModulButtonHeight*1.2)/2,
                                  KFunctionModulButtonHeight*1.2)];
    self.btnBeginCityName = beginBtn;
    [contentBGView addSubview:self.btnBeginCityName];
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchBtn setBackgroundColor:[UIColor clearColor]];
    [switchBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                         forState:UIControlStateNormal];
    [switchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                         forState:UIControlStateHighlighted];
    [switchBtn.titleLabel setFont:KXCAPPUIContentFontSize(18.0f)];
    [switchBtn setTag:KBtnForExchangeButtonTag];
    [switchBtn setTitle:@"交换" forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [switchBtn setFrame:CGRectMake(beginBtn.right,KFunctionModulButtonHeight*1.2, KFunctionModulButtonHeight*1.2,
                                   KFunctionModulButtonHeight*1.2)];
    [contentBGView addSubview:switchBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setBackgroundColor:[UIColor clearColor]];
    [endBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                      forState:UIControlStateNormal];
    [endBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                      forState:UIControlStateHighlighted];
    [endBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [endBtn setTag:KBtnForEndSiteButtonTag];
    [endBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [endBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [endBtn setTitle:@"上海" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [endBtn setFrame:CGRectMake(switchBtn.right,KFunctionModulButtonHeight*1.2,
                                (contentBGView.width - KFunctionModulButtonHeight*1.2)/2,
                                KFunctionModulButtonHeight*1.2)];
    self.btnArrivedCityName = endBtn;
    [contentBGView addSubview:self.btnArrivedCityName];

    
    
    UIView *sepCityView = [[UIView alloc]init];
    [sepCityView setFrame:CGRectMake(0.0f,(KFunctionModulButtonHeight*1.2*2),
                                     contentBGView.width,
                                             1.0f)];
    [sepCityView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepCityView];
    
    
    UIView *sepCityVerticalView = [[UIView alloc]init];
    [sepCityVerticalView setFrame:CGRectMake((contentBGView.width - 1.0f)/2,(KFunctionModulButtonHeight*1.2*2),
                                     1.0f,
                                     KFunctionModulButtonHeight*1.2)];
    [sepCityVerticalView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepCityVerticalView];
    
    UIButton *endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDateBtn setBackgroundColor:[UIColor clearColor]];
    [endDateBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                       forState:UIControlStateNormal];
    [endDateBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                       forState:UIControlStateHighlighted];
    [endDateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [endDateBtn setTag:KBtnForEndDateButtonTag];
    [endDateBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [endDateBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [endDateBtn setTitle:@"08月18日周六" forState:UIControlStateNormal];
    [endDateBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [endDateBtn setFrame:CGRectMake(sepCityVerticalView.right,sepCityView.bottom,(contentBGView.width - 1.0f)/2,
                                 KFunctionModulButtonHeight*1.2)];
    self.btnReturnDate = endDateBtn;
    [contentBGView addSubview:self.btnReturnDate];
    
    
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateBtn setBackgroundColor:[UIColor clearColor]];
    [dateBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                       forState:UIControlStateNormal];
    [dateBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                       forState:UIControlStateHighlighted];
    [dateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [dateBtn setTag:KBtnForBeginDateButtonTag];
    [dateBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [dateBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [dateBtn setTitle:@"08月15日周六" forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [dateBtn setFrame:CGRectMake(0.0f,sepCityView.bottom,contentBGView.width,
                                 KFunctionModulButtonHeight*1.2)];
    self.btnBeginDate = dateBtn;
    [contentBGView addSubview:self.btnBeginDate];
    
    NSRange departRange=[dateBtn.titleLabel.text rangeOfString:@"周六"];
    NSMutableAttributedString *departContent=[[NSMutableAttributedString alloc]initWithString:dateBtn.titleLabel.text];
    [departContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(15) range:departRange];
    [departContent addAttribute:NSForegroundColorAttributeName value:KFunContentColor range:departRange];
    [dateBtn.titleLabel setAttributedText:departContent];
    
    
    NSRange returnRange=[dateBtn.titleLabel.text rangeOfString:@"周六"];
    NSMutableAttributedString *returnDateContent=[[NSMutableAttributedString alloc]initWithString:endDateBtn.titleLabel.text];
    [returnDateContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(15) range:returnRange];
    [returnDateContent addAttribute:NSForegroundColorAttributeName value:KFunContentColor range:returnRange];
    [endDateBtn.titleLabel setAttributedText:returnDateContent];
    
    UIView *sepDateView = [[UIView alloc]init];
    [sepDateView setFrame:CGRectMake(0.0f,(KFunctionModulButtonHeight*1.2 + sepCityView.bottom),
                                     contentBGView.width,
                                     1.0f)];
    [sepDateView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepDateView];
    
    UIButton *flightStyleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flightStyleBtn setBackgroundColor:[UIColor clearColor]];
    [flightStyleBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                       forState:UIControlStateNormal];
    [flightStyleBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                       forState:UIControlStateHighlighted];
    [flightStyleBtn.titleLabel setFont:KXCAPPUIContentDefautFontSize(22.0f)];
    [flightStyleBtn setTag:KBtnForStyleButtonTag];
    [flightStyleBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [flightStyleBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [flightStyleBtn setTitle:@"不限舱位" forState:UIControlStateNormal];
    [flightStyleBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [flightStyleBtn setFrame:CGRectMake(0.0f,sepDateView.bottom,contentBGView.width,
                                 KFunctionModulButtonHeight*1.2)];
    self.btnCabinModelButton = flightStyleBtn;
    [contentBGView addSubview:self.btnCabinModelButton];
    
    
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
    [searchBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (contentBGView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [mainView addSubview:searchBtn];
    
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    
    NSArray *array =  @[@"不限舱位",
                        @"经济舱",
                        @"公务/头等舱",];
    DefaultotelRecommendSearchLayerView *hotelRecommendView = [[DefaultotelRecommendSearchLayerView alloc]initWithFrame:layerViewRect withSearchContent:array];
    [hotelRecommendView setDelegate:self];
    self.flightSearchLayerView = hotelRecommendView;
    [self.navigationController.view addSubview:self.flightSearchLayerView];
//    SE
}

- (void)userOperationButtonEventClicked:(UIButton *)button{

    
    if (KBtnForOnlyButtonTag == button.tag) {
        ///更改数据
        self.userIsSelectedReturnTicketBool = NO;
        ///更改界面按键
        [self.btnOnlyTicket setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                      forState:UIControlStateNormal];
        [self.btnReturnTicket setBackgroundImage:createImageWithColor(HUIRGBColor(213, 221, 230, 1.0))
                                        forState:UIControlStateNormal];
        
        [self.btnOnlyTicket setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
        [self.btnReturnTicket setTitleColor:KFunContentColor forState:UIControlStateNormal];
        
        ///更改时间选择
        [self.btnBeginDate setWidth:(KProjectScreenWidth - KInforLeftIntervalWidth*2)];
        

        
    }else if (KBtnForReturnButtonTag == button.tag){
        
        ///更改数据
        self.userIsSelectedReturnTicketBool = YES;
        ///更改界面按键
        [self.btnReturnTicket setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                      forState:UIControlStateNormal];
        [self.btnOnlyTicket setBackgroundImage:createImageWithColor(HUIRGBColor(213, 221, 230, 1.0))
                                        forState:UIControlStateNormal];
        
        [self.btnReturnTicket setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
        [self.btnOnlyTicket setTitleColor:KFunContentColor forState:UIControlStateNormal];
        
        ///更改时间选择
        [self.btnBeginDate setWidth:(KProjectScreenWidth - KInforLeftIntervalWidth*2 - 1.0f)/2];
    }
    
    else if (KBtnForBeginSiteBtnTag == button.tag) {
        
        CityInforViewController *viewController = [[CityInforViewController alloc]initWithTitleStr:@"出发城市" style:CityForTakeOffStyle];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
    }
    
    ///交换乘换信息
    else if (KBtnForExchangeButtonTag == button.tag){
        
        NSString *beginCityNameStr = self.btnBeginCityName.titleLabel.text;
        [self.btnBeginCityName setTitle:self.btnArrivedCityName.titleLabel.text forState:UIControlStateNormal];
        [self.btnArrivedCityName setTitle:beginCityNameStr forState:UIControlStateNormal];
        
    }
    
    else if (KBtnForEndSiteButtonTag == button.tag){
        CityInforViewController *viewController = [[CityInforViewController alloc]initWithTitleStr:@"到达城市" style:CityForArrivedStyle];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
    }
    ///选择舱位信息
    else if (KBtnForStyleButtonTag == button.tag){
        
         [self.view endEditing:YES];
        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.flightSearchLayerView setFrame:layerViewRect];
        }];
    }
    else if (KBtnForSearchButtonTag == button.tag){
        
        FlightOrderInformation *item = [[FlightOrderInformation alloc]init];
        [item setFliOrderTakeOffDate:@"8月30日 周六"];
        [item setFliOrderArrivedSite:@"上海"];
        [item setFliOrderTakeOffSite:@"北京"];
        [item setFliOrderIsReturnTicketBool:self.userIsSelectedReturnTicketBool];
        [item setFlightOrderCabinModelStr:self.btnCabinModelButton.titleLabel.text];
        [item setFliOrderReturnTakeOffDate:@""];
        if (self.userIsSelectedReturnTicketBool) {
            [item setFliOrderReturnTakeOffDate:self.btnReturnDate.titleLabel.text];
        }
        
        FlightMainListViewController *viewController = [[FlightMainListViewController alloc]initWithOrderSearchInfor:item];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)userSelectedDefaultotelRecommendSearchStyle:(NSInteger)Searchstyle styleName:(NSString *)styleNameStr{
    NSLog(@"Searchstyle is %zi\nstyleNameStr is %@",Searchstyle,styleNameStr);
    [self.btnCabinModelButton setTitle:styleNameStr forState:UIControlStateNormal];
}
- (void)userSelectedCityName:(NSString *)citynameStr cityCode:(NSString *)cityCodeStr style:(UserSelectedCityStyle)style{
    
    ///出发城市
    if (style == CityForTakeOffStyle) {
        
    }
    ///到达城市
    else if (style == CityForArrivedStyle){
        
    }
}

@end
