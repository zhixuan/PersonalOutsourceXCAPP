//
//  PaySuccessfulViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "PaySuccessfulViewController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "PerOrderListViewController.h"


#define KImageIconHeight            (KXCUIControlSizeWidth(100.0f))

@interface PaySuccessfulViewController ()

/*!
 * @breif 用户订单信息
 * @See
 */
@property (nonatomic , strong)      UserPersonalOrderInformation        *userOrderInformation;

/*!
 * @breif 订单支付成功还是失败
 * @See 默认为NO，不成功， = YES，表示支付成功
 */
@property (nonatomic , assign)      BOOL                    isPaySuccessfulBool;
@end

@implementation PaySuccessfulViewController
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithOderInfor:(UserPersonalOrderInformation *)orderInfor isSuccessfulBool:(BOOL)isSuccessfulBool
{    self = [super init];
    if (self) {
        self.userOrderInformation = orderInfor;
        self.enableCustomNavbarBackButton = FALSE;
        self.isPaySuccessfulBool = isSuccessfulBool;
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

    [self settingNavTitle:@"订单支付"];
    [self setLeftNavButtonFA:FMIconLeftReturn withFrame:kNavBarButtonRect actionTarget:self action:@selector(leftButtonOperationEventClicked)];
    [self setupPaySuccessfulViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupPaySuccessfulViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setFrame:CGRectMake((KProjectScreenWidth - KImageIconHeight)/2, KXCUIControlSizeWidth(60.0f),KImageIconHeight, KImageIconHeight)];
    [imageView.layer setCornerRadius:KImageIconHeight/2];
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setBorderWidth:3.0f];
    [mainView addSubview:imageView];
    
    
    UILabel *securityShow = [[UILabel alloc]init];
    [securityShow setBackgroundColor:[UIColor clearColor]];
    [securityShow setTextColor:KContentTextColor];
    [securityShow setTextAlignment:NSTextAlignmentCenter];
    [securityShow setFont:KXCAPPUIContentDefautFontSize(17.0f)];
    [securityShow setFrame:CGRectMake(KXCUIControlSizeWidth(60.0f),
                                      (imageView.bottom + KInforLeftIntervalWidth*2),
                                      (KProjectScreenWidth - KXCUIControlSizeWidth(120.0f)), KXCUIControlSizeWidth(20.0f))];
    [mainView addSubview:securityShow];
    
    UILabel *orderCodeLable = [[UILabel alloc]init];
    [orderCodeLable setBackgroundColor:[UIColor clearColor]];
    [orderCodeLable setTextColor:KSubTitleTextColor];
    [orderCodeLable setTextAlignment:NSTextAlignmentCenter];
    [orderCodeLable setFont:KXCAPPUIContentFontSize(16.0f)];
    [orderCodeLable setFrame:CGRectMake(KXCUIControlSizeWidth(60.0f),
                                      (securityShow.bottom + KInforLeftIntervalWidth*2),
                                      (KProjectScreenWidth - KXCUIControlSizeWidth(120.0f)), KXCUIControlSizeWidth(20.0f))];
    [mainView addSubview:orderCodeLable];
    
    UILabel *orderSumMoneyLable = [[UILabel alloc]init];
    [orderSumMoneyLable setBackgroundColor:[UIColor clearColor]];
    [orderSumMoneyLable setTextColor:KUnitPriceContentColor];
    [orderSumMoneyLable setTextAlignment:NSTextAlignmentCenter];
    [orderSumMoneyLable setFont:KXCAPPUIContentFontSize(16.0f)];
    [orderSumMoneyLable setFrame:CGRectMake(KXCUIControlSizeWidth(60.0f),
                                        (orderCodeLable.bottom + KInforLeftIntervalWidth*2.8),
                                        (KProjectScreenWidth - KXCUIControlSizeWidth(120.0f)), KXCUIControlSizeWidth(20.0f))];
    [mainView addSubview:orderSumMoneyLable];
    
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackBtn setBackgroundColor:[UIColor clearColor]];
    [goBackBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateNormal];
    [goBackBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateHighlighted];
    [goBackBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [goBackBtn setTitleColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) forState:UIControlStateNormal];
    [goBackBtn setTitleColor:HUIRGBColor(60.0f, 127.0f, 205.0f, 1.0f) forState:UIControlStateHighlighted];
    [goBackBtn setTitle:@"返回订单列表" forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackButtonClickedEvent)
        forControlEvents:UIControlEventTouchUpInside];
    [goBackBtn.layer setCornerRadius:1.2f];
    [goBackBtn.layer setMasksToBounds:YES];
    [goBackBtn.layer setBorderColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f).CGColor];
    [goBackBtn.layer setBorderWidth:1.2f];
    [goBackBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(130.0f))/2,
                                   (orderSumMoneyLable.bottom + KInforLeftIntervalWidth*1.3),
                                   (KXCUIControlSizeWidth(130.0f)),
                                   KXCUIControlSizeWidth(40.0f))];
    [mainView addSubview:goBackBtn];
    



    
    ///支付成功
    if (self.isPaySuccessfulBool) {
        [imageView setImage:[FontAwesome imageWithIcon:FMIconSelectedBorder iconColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) iconSize:KXCUIControlSizeWidth(120.0f) imageSize:CGSizeMake(KXCUIControlSizeWidth(120.0f),KXCUIControlSizeWidth(120.0f))]];
        [imageView.layer setBorderColor:[UIColor clearColor].CGColor];
        
        [securityShow setText:@"担保 成功"];

    }
    ///支付失败
    else{
        [imageView setImage:[FontAwesome imageWithIcon:FMIconCloseEdit iconColor:KDefaultNavigationWhiteBackGroundColor iconSize:KXCUIControlSizeWidth(60.0f) imageSize:CGSizeMake(KXCUIControlSizeWidth(120.0f),KXCUIControlSizeWidth(120.0f))]];
        [imageView.layer setBorderColor:KDefaultNavigationWhiteBackGroundColor.CGColor];
        
        [securityShow setText:@"担保 失败"];
    }
    
    
    if (self.userOrderInformation.userOrderStyle == XCAPPOrderForTrainTicketStyle) {
        [orderCodeLable setText: [NSString stringWithFormat:@"订单号： %@",self.userOrderInformation.trainticketOrderInfor.ttOrderTradeNumber]];
        [orderSumMoneyLable setText:[NSString stringWithFormat:@"金额： %.02lf",self.userOrderInformation.trainticketOrderInfor.ttTicketTotalVolume]];
    }else if (self.userOrderInformation.userOrderStyle == XCAPPOrderHotelForStyle){
        
        [orderCodeLable setText: [NSString stringWithFormat:@"订单号： %@",self.userOrderInformation.hotelOrderInfor.orderId]];
        [orderSumMoneyLable setText:[NSString stringWithFormat:@"金额： %@",self.userOrderInformation.hotelOrderInfor.orderPaySumTotal]];
        
        
    }
    
    
}


- (void)setupInforButtonEvent:(UIButton *)button {
    
}

- (void)leftButtonOperationEventClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];

    ///查询用户个人最新余额信息
    [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserPersonalCheckPersonalAccountInforNotification
                                                        object:nil];

}

- (void)goBackButtonClickedEvent{
    
    
    ///查询用户个人最新余额信息
    [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserPersonalCheckPersonalAccountInforNotification
                                                        object:nil];
    
    PerOrderListViewController *viewController = [[PerOrderListViewController alloc]initWithUserCheckAllOrder];
    //先保存原有navigation
    UINavigationController* navController = self.navigationController;
    ///退回到跟视图
    [navController popToRootViewControllerAnimated:NO];
    ///隐藏底部TabBar
    viewController.hidesBottomBarWhenPushed = YES;
    ///push新视图
    [navController pushViewController:viewController animated:YES];
    
}
@end
