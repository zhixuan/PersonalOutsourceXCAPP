//
//  HomeMainViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HomeMainViewController.h"
#import "HotelReserveMainViewController.h"
#import "UserLoginViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"
#import "FlightInforMainController.h"
#import "TrainTicketInforMainController.h"

#import <CoreText/CoreText.h>

#define KBtnForHotelButtonTag           (1820111)
#define KBtnForTrainButtonTag           (1820112)
#define KBtnForFlightButtonTag          (1820113)

#define KBtnOperationWidth              (KXCUIControlSizeWidth(50.0f))

@interface HomeMainViewController ()

@end

@implementation HomeMainViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}

#pragma mark -
#pragma mark -  系统方法
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    
    [self.navigationController.navigationBar setHidden:NO];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    [bgImageView setFrame:self.view.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"homeImage.jpg"]];
    [self.view addSubview:bgImageView];

    UILabel *titleCompany =[[UILabel alloc]init];
    [titleCompany setBackgroundColor:[UIColor clearColor]];
    [titleCompany setFont:[UIFont boldSystemFontOfSize:((35)*KXCAdapterSizeWidth)]];
    [titleCompany setTextColor:[UIColor whiteColor]];
    [titleCompany setTextAlignment:NSTextAlignmentCenter];
    [titleCompany setFrame:CGRectMake(0.0f, KXCUIControlSizeWidth(100.0f),
                                      KProjectScreenWidth,KXCUIControlSizeWidth(50.0f))];
    [titleCompany setText:@"中国商旅国际"];
    [self.view addSubview:titleCompany];
    
    
    long number = 15.0;
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:titleCompany.text];
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
    
    CFRelease(num);
    [titleCompany setAttributedText:attributedString];
    
    UILabel *subtitleCotnent=[[UILabel alloc]init];
    [subtitleCotnent setBackgroundColor:[UIColor clearColor]];
    [subtitleCotnent setFont:[UIFont boldSystemFontOfSize:((18.0f)*KXCAdapterSizeWidth)]];
    [subtitleCotnent setTextColor:[UIColor whiteColor]];
    [subtitleCotnent setTextAlignment:NSTextAlignmentCenter];
    [subtitleCotnent setFrame:CGRectMake(0.0f,
                                         (titleCompany.bottom + KInforLeftIntervalWidth),
                                         KProjectScreenWidth,
                                         KXCUIControlSizeWidth(20.0f))];
    [subtitleCotnent setText:@"掌上轻松出行"];
    [self.view addSubview:subtitleCotnent];
    
    
    UIView *btnBGView = [[UIView alloc]init];
    [btnBGView setBackgroundColor:HUIRGBColor(255.0f, 255.0f, 255.0f, 0.8f)];
    [btnBGView setFrame:CGRectMake(0.0f, (self.view.height - KXCUIControlSizeWidth(120.0f)*2.6),
                                   KProjectScreenWidth, KXCUIControlSizeWidth(120.0f)*1.3)];
    [self.view addSubview:btnBGView];
    
    CGFloat intFloat = (KProjectScreenWidth - KBtnOperationWidth*4)/5;
    
    UIButton *hotelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotelbutton setFrame:CGRectMake(intFloat, (KXCUIControlSizeWidth(130.0f) - KBtnOperationWidth)/2,
                                KBtnOperationWidth,KBtnOperationWidth)];
//    [button setTitle:@"查询酒店" forState:UIControlStateNormal];
    [hotelbutton setBackgroundImage:[UIImage imageNamed:@"homeHotelImage.jpg"] forState:UIControlStateNormal];
    [hotelbutton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [hotelbutton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [hotelbutton addTarget:self action:@selector(buttonClickedOperation:)
          forControlEvents:UIControlEventTouchUpInside];
    [hotelbutton setTag:KBtnForHotelButtonTag];
    [btnBGView addSubview:hotelbutton];
    
    UILabel *hotelName =[[UILabel alloc]init];
    [hotelName setBackgroundColor:[UIColor clearColor]];
    [hotelName setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [hotelName setTextColor:KContentTextColor];
    [hotelName setTextAlignment:NSTextAlignmentCenter];
    [hotelName setFrame:CGRectMake(hotelbutton.left - KXCUIControlSizeWidth(10.0f), hotelbutton.bottom + KXCUIControlSizeWidth(4.0f), hotelbutton.width + KXCUIControlSizeWidth(20.0f), KXCUIControlSizeWidth(30.0f))];
    [hotelName setText:@"酒店"];
    [btnBGView addSubview:hotelName];
    
    UIButton *flightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flightButton setFrame:CGRectMake((hotelbutton.right + intFloat),
                                 (KXCUIControlSizeWidth(130.0f) - KBtnOperationWidth)/2,
                                 KBtnOperationWidth,KBtnOperationWidth)];
//    [button1 setTitle:@"查询机票" forState:UIControlStateNormal];
    [flightButton setBackgroundImage:[UIImage imageNamed:@"homeFlightImage.jpg"] forState:UIControlStateNormal];
    [flightButton addTarget:self action:@selector(buttonClickedOperation:)
           forControlEvents:UIControlEventTouchUpInside];
    [flightButton setTag:KBtnForFlightButtonTag];
    [btnBGView addSubview:flightButton];
    UILabel *flightName =[[UILabel alloc]init];
    [flightName setBackgroundColor:[UIColor clearColor]];
    [flightName setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [flightName setTextColor:KContentTextColor];
    [flightName setTextAlignment:NSTextAlignmentCenter];
    [flightName setFrame:CGRectMake(flightButton.left - KXCUIControlSizeWidth(10.0f), flightButton.bottom + KXCUIControlSizeWidth(4.0f), flightButton.width + KXCUIControlSizeWidth(20.0f), KXCUIControlSizeWidth(30.0f))];
    [flightName setText:@"航班"];
    [btnBGView addSubview:flightName];
    
    UIButton *trainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [trainButton setFrame:CGRectMake((flightButton.right + intFloat),
                                 (KXCUIControlSizeWidth(130.0f) - KBtnOperationWidth)/2,
                                 KBtnOperationWidth,KBtnOperationWidth)];
    [trainButton setBackgroundImage:[UIImage imageNamed:@"homeTrainTicketImage.jpg"]
                       forState:UIControlStateNormal];
    [trainButton addTarget:self action:@selector(buttonClickedOperation:)
      forControlEvents:UIControlEventTouchUpInside];
    [trainButton setTag:KBtnForTrainButtonTag];
    [btnBGView addSubview:trainButton];
    UILabel *trainName =[[UILabel alloc]init];
    [trainName setBackgroundColor:[UIColor clearColor]];
    [trainName setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [trainName setTextColor:KContentTextColor];
    [trainName setTextAlignment:NSTextAlignmentCenter];
    [trainName setFrame:CGRectMake(trainButton.left,(trainButton.bottom + KXCUIControlSizeWidth(4.0f)), trainButton.width, KXCUIControlSizeWidth(30.0f))];
    [trainName setText:@"火车票"];
    [btnBGView addSubview:trainName];
    
    
    UIButton *taxiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [taxiButton setFrame:CGRectMake((trainButton.right + intFloat),
                                     (KXCUIControlSizeWidth(130.0f) - KBtnOperationWidth)/2,
                                     KBtnOperationWidth,KBtnOperationWidth)];
    [taxiButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [taxiButton setBackgroundImage:[UIImage imageNamed:@"homeTaxiImage.png"]
                           forState:UIControlStateNormal];
    [taxiButton addTarget:self action:@selector(buttonClickedOperation:)
          forControlEvents:UIControlEventTouchUpInside];
    [taxiButton.layer setCornerRadius:10.0];
    [taxiButton.layer setMasksToBounds:YES];
    [taxiButton setTag:(KBtnForFlightButtonTag+2)];
    [btnBGView addSubview:taxiButton];
    UILabel *taxiName =[[UILabel alloc]init];
    [taxiName setBackgroundColor:[UIColor clearColor]];
    [taxiName setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [taxiName setTextColor:KContentTextColor];
    [taxiName setTextAlignment:NSTextAlignmentCenter];
    [taxiName setFrame:CGRectMake(taxiButton.left,(taxiButton.bottom + KXCUIControlSizeWidth(4.0f)),
                                 taxiButton.width, KXCUIControlSizeWidth(30.0f))];
    [taxiName setText:@"用车"];
    [btnBGView addSubview:taxiName];
    
    
    UILabel *bottomCotnent=[[UILabel alloc]init];
    [bottomCotnent setBackgroundColor:[UIColor clearColor]];
    [bottomCotnent setFont:[UIFont boldSystemFontOfSize:((18.0f)*KXCAdapterSizeWidth)]];
    [bottomCotnent setTextColor:[UIColor whiteColor]];
    [bottomCotnent setTextAlignment:NSTextAlignmentCenter];
    [bottomCotnent setFrame:CGRectMake(0.0f,
                                         (self.view.height - KXCUIControlSizeWidth(20.0f) - 50.0f),
                                         KProjectScreenWidth,
                                         KXCUIControlSizeWidth(20.0f))];
    [bottomCotnent setText:@"中国商旅国际有限公司"];
    [self.view addSubview:bottomCotnent];

    if (IsStringEmptyOrNull(KXCShareFMSetting.userLoginPasswordStr) ||IsStringEmptyOrNull(KXCShareFMSetting.userLoginPhoneNumberStr) ) {
        [self userLogoutFinishSuccessNotification:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogoutFinishSuccessNotification:) name:KXCAPPUserLogoutSuccessFinishNotification object:nil];
}
- (void)userLogoutFinishSuccessNotification:(NSNotification *)notification{
    UserLoginViewController *viewController = [[UserLoginViewController alloc]init];
    XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:navigation animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClickedOperation:(UIButton *)button{
    
    //
    if (button.tag == KBtnForHotelButtonTag) {
        HotelReserveMainViewController *viewController = [[HotelReserveMainViewController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    else if (button.tag == KBtnForFlightButtonTag){
    
        FlightInforMainController *viewController = [[FlightInforMainController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
       
//        NSString *titleContentStr = @"四年前的伦敦奥运会，中国女乒派出李晓霞和丁宁，两人就成功会师决赛，最终李晓霞在决赛中以4-1战胜丁宁夺冠。四年后，李晓霞和丁宁再次携手出战奥运，成为奥运乒乓球历史上第一对连续两届在决赛中相遇的对手。进入新世纪，王楠和张怡宁也曾有机会。2008年北京奥运会，王楠和张怡宁一起闯入决赛，但是在2004年的雅典，王楠作为卫冕冠军却在1/4决赛1-4不敌李佳薇早早出局\n“台湾领导人首先要检讨台湾的安全措施，保障中国大陆旅客的生命安全。第二，蔡英文在处理这个事情的时候，没有对大陆的逝者做一个敬意的表态。她应该要出来道歉。”\n邵宗海又说，陆客火烧车的事件，可能会在中国大陆演变成一个非常强烈的民意反应。“现在我们看起来，大陆的民意反弹短时间好像还不会发生，但是事件会发酵。” 他认为该事件可能引起中国大陆人民对台湾的反感。";
//        
//        NSLog(@"titleContentStr lenght is %zi",[titleContentStr length]);
//        [KASShareASASLocalSetupSystemNotification createLocalNotificationWithTitleInfor:titleContentStr withDateStr:@"2016-08-11 13:46" withKeyStr:KASRecordCalorietInforLocalNotificationKey];
        
        [KASShareASASLocalSetupSystemNotification removeLocalNoticationWithKeyStr:KASRecordCalorietInforLocalNotificationKey];
        
    }
    
    else if (button.tag == KBtnForTrainButtonTag){
        TrainTicketInforMainController *viewController = [[TrainTicketInforMainController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }else {
        ShowImportErrorAlertView(@"该功能暂未开通");
    }
}

@end
