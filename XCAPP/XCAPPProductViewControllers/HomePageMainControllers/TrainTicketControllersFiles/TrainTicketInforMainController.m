//
//  TrainTicketInforMainController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketInforMainController.h"
#import "TrainTicketListViewController.h"

//#import "CityInforViewController.h"
#import "CityInforForTrainTicketController.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"


#define KBtnForBeginButtonTag           (1430111)
#define KBtnForExchangeButtonTag        (1430112)
#define KBtnForArrivedButtonTag         (1430113)
#define KBtnForDateButtonTag            (1430114)
#define KBtnForSearchButtonTag          (1430115)

#define KBtnForSearchSwithTag           (1430116)

@interface TrainTicketInforMainController ()<CityInforForTrainTicketDelegate>

/*!
 * @breif 出发地
 * @See
 */
@property (nonatomic , assign)      UIButton  *btnBeginCityName;

/*!
 * @breif 出发地
 * @See
 */
@property (nonatomic , assign)      UIButton  *btnArrivedCityName;

/*!
 * @breif 出发日期
 * @See
 */
@property (nonatomic , assign)      UIButton  *btnBeginDate;

/*!
 * @breif 乘坐火车时间字符串
 * @See
 */
@property (nonatomic , strong)      NSString        *userBeginDateStr;

/*!
 * @breif 是否只查看高铁动车
 * @See
 */
@property (nonatomic , assign)      BOOL            isOnlyCheckHighspeedBool;

/*!
 * @breif 日历选择信息
 * @See
 */
@property (nonatomic , strong)      CalendarHomeViewController *chvc;

/*!
 * @breif 用户搜索使用的数据内容
 * @See
 */
@property (nonatomic , strong)     TrainticketOrderInformation          *userSeaerchTrainticket;


@end

@implementation TrainTicketInforMainController

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
    // Do any additional setup after loading the view.
    
    [self settingNavTitle:@"火车票"];
    self.userSeaerchTrainticket = [[TrainticketOrderInformation alloc]init];
    [self setupTrainTicketInforMainControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTrainTicketInforMainControllerFrame{
    self.isOnlyCheckHighspeedBool = NO;
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                       (KProjectScreenWidth - 2*KInforLeftIntervalWidth), KFunctionModulButtonHeight*1.3*3+3.0f)];
    [contentBGView.layer setCornerRadius:5.0f];
    [contentBGView.layer setMasksToBounds:YES];
    [mainView addSubview:contentBGView];
    
    NSString *beginStateStr = @"北京";
    
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setBackgroundColor:[UIColor clearColor]];
    [beginBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                             forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                             forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [beginBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [beginBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [beginBtn setTag:KBtnForBeginButtonTag];
    [beginBtn setTitle:beginStateStr forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(buttonOperationEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [beginBtn setFrame:CGRectMake(0.0f,0.0f,
                                   (contentBGView.width - KFunctionModulButtonHeight*1.3)/2,
                                   KFunctionModulButtonHeight*1.3)];
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
    [switchBtn addTarget:self action:@selector(buttonOperationEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [switchBtn setFrame:CGRectMake(beginBtn.right,0.0f, KFunctionModulButtonHeight*1.3,
                                  KFunctionModulButtonHeight*1.3)];
    [contentBGView addSubview:switchBtn];
    
    
    NSString *endStateStr = @"上海";
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setBackgroundColor:[UIColor clearColor]];
    [endBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                        forState:UIControlStateNormal];
    [endBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                        forState:UIControlStateHighlighted];
    [endBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [endBtn setTag:KBtnForArrivedButtonTag];
    [endBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [endBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [endBtn setTitle:endStateStr forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(buttonOperationEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [endBtn setFrame:CGRectMake(switchBtn.right,0.0f,
                                  (contentBGView.width - KFunctionModulButtonHeight*1.3)/2,
                                  KFunctionModulButtonHeight*1.3)];
    self.btnArrivedCityName = endBtn;
    [contentBGView addSubview:self.btnArrivedCityName];
    
    [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraTakeOffSite:beginStateStr];
    [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraArrivedSite:endStateStr];

    
    
    UIView *sepDateView = [[UIView alloc]init];
    [sepDateView setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight*1.3, contentBGView.width, 1.0f)];
    [sepDateView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepDateView];
    
    NSDictionary *dateDicInfor = dateForCurrentDateWithYearMonthDay();
    NSLog(@"dataDicInfor is %@",dateDicInfor);
    [self.userSeaerchTrainticket setTtOrderDepartDate:StringForKeyInUnserializedJSONDic(dateDicInfor, @"flagdate")];
    
    
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateBtn setBackgroundColor:[UIColor clearColor]];
    [dateBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                      forState:UIControlStateNormal];
    [dateBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                      forState:UIControlStateHighlighted];
    [dateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:((24.0f)*KXCAdapterSizeWidth)]];
    [dateBtn setTag:KBtnForDateButtonTag];
    [dateBtn setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [dateBtn setTitleColor:KStateNormalContentColor forState:UIControlStateHighlighted];
    [dateBtn setTitle:StringForKeyInUnserializedJSONDic(dateDicInfor,@"date") forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(buttonOperationEventClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [dateBtn setFrame:CGRectMake(0.0f,sepDateView.bottom,contentBGView.width,
                                KFunctionModulButtonHeight*1.3)];
    self.btnBeginDate = dateBtn;
    [contentBGView addSubview:self.btnBeginDate];
    
    UIView *sepOnlyView = [[UIView alloc]init];
    [sepOnlyView setFrame:CGRectMake(0.0f, (KFunctionModulButtonHeight*1.3 + sepDateView.bottom),
                                     contentBGView.width, 1.0f)];
    [sepOnlyView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepOnlyView];
    
    NSRange contentRange=[dateBtn.titleLabel.text rangeOfString:StringForKeyInUnserializedJSONDic(dateDicInfor,@"week")];
    NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:dateBtn.titleLabel.text];
    [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(15) range:contentRange];
    [dynamicContent addAttribute:NSForegroundColorAttributeName value:KFunContentColor range:contentRange];
    [dateBtn.titleLabel setAttributedText:dynamicContent];
    
    
    UILabel *highspeedLabel = [[UILabel alloc]init];
    [highspeedLabel setBackgroundColor:[UIColor clearColor]];
    [highspeedLabel setFont:KXCAPPUIContentFontSize(20.0f)];
    [highspeedLabel setTextColor:KStateNormalContentColor];
    [highspeedLabel setText:@"只看高铁动车"];
    [highspeedLabel setTextAlignment:NSTextAlignmentLeft];
    [highspeedLabel setFrame:CGRectMake(KInforLeftIntervalWidth, sepOnlyView.bottom,
                                        KXCUIControlSizeWidth(120.0f), KFunctionModulButtonHeight*1.3)];
    [contentBGView addSubview:highspeedLabel];
    
    UISwitch *switchExercise = [[UISwitch alloc]initWithFrame:CGRectMake((contentBGView.width - 80.0f - KInforLeftIntervalWidth),
                                                                         0.0f,90.0f, 44.0f)];
//    [switchExercise.layer setBorderWidth:1.0f];
//    [switchExercise.layer setBorderColor:KDefineNavigationItemBtnColor.CGColor];
    if (HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)) {
        switchExercise.frame = CGRectMake(contentBGView.width-15-51,
                                          (sepOnlyView.bottom + (KFunctionModulButtonHeight*1.3 - 31.0f)/2),
                                          51, 31);
        [switchExercise.layer setCornerRadius:15.5f];
    }else{
        switchExercise.frame = CGRectMake(contentBGView.width-15-79,
                                          (sepOnlyView.bottom + (KFunctionModulButtonHeight*1.3 - 27.0f)/2),
                                          79, 27);
        [switchExercise.layer setCornerRadius:13.5f];
    }
    [switchExercise.layer setMasksToBounds:YES];
    [switchExercise addTarget:self action:@selector(switchOperationEvent:) forControlEvents:UIControlEventValueChanged];
    [switchExercise setOn:NO];
    [switchExercise setOffImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))];
    [switchExercise setOnTintColor:HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f)];
    [contentBGView addSubview:switchExercise];
    
    
    
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
    [searchBtn addTarget:self action:@selector(buttonOperationEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (contentBGView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [mainView addSubview:searchBtn];

}
- (void)buttonOperationEventClicked:(UIButton *)button{
    
    
    NSLog(@"search train ticket");
    
    if (KBtnForBeginButtonTag == button.tag) {
        
        
        CityInforForTrainTicketController *viewController = [[CityInforForTrainTicketController alloc]initWithTitleStr:@"出发城市" style:CityForTakeOffStyle];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
        
        [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraTakeOffSite:@"北京"];
        
    }
    
    ///交换乘换信息
    else if (KBtnForExchangeButtonTag == button.tag){
        
        ///界面转换
        NSString *beginCityNameStr = self.btnBeginCityName.titleLabel.text;
        [self.btnBeginCityName.titleLabel setText:self.btnArrivedCityName.titleLabel.text];
        [self.btnArrivedCityName.titleLabel setText:beginCityNameStr];
        
        
        ///数据转换
        NSString *trainTicketCityStr = self.userSeaerchTrainticket.ttOrderTrainticketInfor.traTakeOffSite;
        [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraTakeOffSite:self.userSeaerchTrainticket.ttOrderTrainticketInfor.traArrivedSite];
        [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraArrivedSite:trainTicketCityStr];
    }
    
    else if (KBtnForArrivedButtonTag == button.tag){
        
        CityInforForTrainTicketController *viewController = [[CityInforForTrainTicketController alloc]initWithTitleStr:@"到达城市" style:CityForArrivedStyle];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
        [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraArrivedSite:@"深圳"];
        
    }
    
    else if (KBtnForDateButtonTag == button.tag){
    
        if (!self.chvc) {
            
            self.chvc = [[CalendarHomeViewController alloc]init];
            
            self.chvc.calendartitle = @"出发日期";
            
            [self.chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
            
        }
        
         __weak __typeof(&*self)weakSelf = self;
        self.chvc.calendarblock = ^(CalendarDayModel *model){
            
            NSLog(@"\n---------------------------");
            NSLog(@"1星期 %@",[model getWeek]);
            NSLog(@"2字符串 %@",[model toString]);
            NSLog(@"3节日  %@",model.holiday);
            
            NSLog(@"toString is %@",dateYearMonthDayWeekWithDateStr([model toString]));
            
            NSDictionary *dateDictionary = dateYearMonthDayWeekWithDateStr([model toString]);
            
            [weakSelf.btnBeginDate setTitle:StringForKeyInUnserializedJSONDic(dateDictionary, @"date")
                               forState:UIControlStateNormal];
            NSRange contentRange=[weakSelf.btnBeginDate.titleLabel.text rangeOfString:StringForKeyInUnserializedJSONDic(dateDictionary,@"week")];
            NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:weakSelf.btnBeginDate.titleLabel.text];
            [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(15) range:contentRange];
            [dynamicContent addAttribute:NSForegroundColorAttributeName value:KFunContentColor range:contentRange];
            [weakSelf.btnBeginDate.titleLabel setAttributedText:dynamicContent];
            [weakSelf.userSeaerchTrainticket setTtOrderDepartDate:[model toString]];
        };
        
        XCAPPNavigationController *navigationContro = [[XCAPPNavigationController alloc]initWithRootViewController:self.chvc];
        [self presentViewController:navigationContro animated:YES completion:^{
            
        }];
    }
    
    else if (KBtnForSearchButtonTag == button.tag){
        
        TrainticketOrderInformation *searchItem = [[TrainticketOrderInformation alloc]init];
        [searchItem.ttOrderTrainticketInfor setTraTakeOffSite:@"北京"];
        [searchItem.ttOrderTrainticketInfor setTraArrivedSite:@"深圳"];
        TrainTicketListViewController*viewController = [[TrainTicketListViewController alloc]initWithOrderInfor:self.userSeaerchTrainticket];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)switchOperationEvent:(UISwitch *)swch{
    
    if (swch.on) {
        self.isOnlyCheckHighspeedBool = YES;
        [swch setOn:YES animated:YES];
        [self.userSeaerchTrainticket setTticketIsHighspeedBool:YES];
        
    }else{
        self.isOnlyCheckHighspeedBool = NO;
        [self.userSeaerchTrainticket setTticketIsHighspeedBool:NO];
        [swch setOn:NO animated:YES];
    }
    
    NSLog(@" 是否只看动车信息 %zi",self.isOnlyCheckHighspeedBool);
}

- (void)userSelectedCityInforCityName:(NSString *)citynameStr cityCode:(NSString *)cityCodeStr style:(UserSelectedCityStyle)style{
    
    
    if (style == CityForTakeOffStyle) {
        [self.btnBeginCityName setTitle:citynameStr forState:UIControlStateNormal];
        [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraTakeOffSite:citynameStr];
    }else if (style == CityForArrivedStyle){
        [self.btnArrivedCityName setTitle:citynameStr forState:UIControlStateNormal];
        [self.userSeaerchTrainticket.ttOrderTrainticketInfor setTraArrivedSite:citynameStr];
    }
    NSLog(@"citynameStr is %@",citynameStr);
}
@end
