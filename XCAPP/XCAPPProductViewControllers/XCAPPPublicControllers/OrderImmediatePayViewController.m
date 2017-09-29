//
//  OrderImmediatePayViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "OrderImmediatePayViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "PaySuccessfulViewController.h"
#import "HTTPClient+HotelsRequest.h"

#define KBtnForImmediatePayButton           (1540112)

@interface OrderImmediatePayViewController ()

/*!
 * @breif 用户已下单完成的火车票订单信息
 * @See
 */
@property (nonatomic , strong)      UserPersonalOrderInformation            *personalOrderInformation;
@end

@implementation OrderImmediatePayViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithOderInfor:(UserPersonalOrderInformation *)orderInfor{
    self = [super init];
    if (self) {
        self.personalOrderInformation = orderInfor;
        
        
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
    
    [self settingNavTitle:@"确认担保支付"];
    
    [self setupOrderImmediatePayViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupOrderImmediatePayViewControllerFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];

    
    
    
    UILabel *itemNameAndAddressLabel = [[UILabel alloc]init];
    [itemNameAndAddressLabel setBackgroundColor:[UIColor clearColor]];
    [itemNameAndAddressLabel setFrame:CGRectMake(0.0f, KXCUIControlSizeWidth(50.0f),
                                                 KProjectScreenWidth, KXCUIControlSizeWidth(30.0f))];
    [itemNameAndAddressLabel setFont:KXCAPPUIContentDefautFontSize(24.0f)];
    [itemNameAndAddressLabel setTextColor:KContentTextColor];
    [itemNameAndAddressLabel setTextAlignment:NSTextAlignmentCenter];
    [mainView addSubview:itemNameAndAddressLabel];
    
    UILabel *totalVolumeLabel = [[UILabel alloc]init];
    [totalVolumeLabel setBackgroundColor:[UIColor clearColor]];
    [totalVolumeLabel setFrame:CGRectMake(0.0f, (itemNameAndAddressLabel.bottom + KInforLeftIntervalWidth*2),
                                          KProjectScreenWidth, KXCUIControlSizeWidth(26.0f))];
    [totalVolumeLabel setFont:KXCAPPUIContentDefautFontSize(28.0f)];
    [totalVolumeLabel setTextColor:KContentTextColor];
    [totalVolumeLabel setTextAlignment:NSTextAlignmentCenter];
    [mainView addSubview:totalVolumeLabel];
    
    
    /**
     *
     *
     *  @param          XCAPPOrderHotelForStyle = 0,                        酒店订单信息
     *
     *  @param          XCAPPOrderForFlightStyle = 1,                       机票订单信息
     *
     *  @param          XCAPPOrderForTrainTicketStyle = 2 ,                 火车票订单信息
     **/
    
    ///酒店订单信息
    if (self.personalOrderInformation.userOrderStyle == XCAPPOrderHotelForStyle) {
//        self.personalOrderInformation.hotelOrderInfor.order
        NSString *beginEndAddress = [NSString stringWithFormat:@"%@ (%@ )",@"酒店预订费",@"账号里"];
        [itemNameAndAddressLabel setText:beginEndAddress];
       
        
        NSString *totalVolumeStr = [NSString stringWithFormat:@"￥%@", self.personalOrderInformation.hotelOrderInfor.orderPaySumTotal];
        [totalVolumeLabel setText:totalVolumeStr];
       
    }
    
    ///火车票订单信息
    else if (self.personalOrderInformation.userOrderStyle == XCAPPOrderForTrainTicketStyle) {
        NSString *beginEndAddress = [NSString stringWithFormat:@"%@ (%@ -- %@)",@"火车票费",self.personalOrderInformation.trainticketOrderInfor.ttOrderTrainticketInfor.traTakeOffSite,self.personalOrderInformation.trainticketOrderInfor.ttOrderTrainticketInfor.traArrivedSite];
        [itemNameAndAddressLabel setText:beginEndAddress];
        
        
        NSString *totalVolumeStr = [NSString stringWithFormat:@"￥%.1lf",self.personalOrderInformation.trainticketOrderInfor.ttTicketTotalVolume];
        [totalVolumeLabel setText:totalVolumeStr];
    }
    
    ///机票订单信息
    else if (self.personalOrderInformation.userOrderStyle == XCAPPOrderForFlightStyle) {
        

        NSString *beginEndAddress = [NSString stringWithFormat:@"%@ (%@ -- %@ %@)",@"机票费",self.personalOrderInformation.trainticketOrderInfor.ttOrderTrainticketInfor.traTakeOffSite,self.personalOrderInformation.trainticketOrderInfor.ttOrderTrainticketInfor.traArrivedSite,self.personalOrderInformation.flightOrderInfor.fliOrderIsReturnTicketBool?@"往返":@"单程"];
        [itemNameAndAddressLabel setText:beginEndAddress];
    }
    
    

    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [searchBtn.titleLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [searchBtn setTag:KBtnForImmediatePayButton];
    [searchBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [searchBtn.layer setCornerRadius:5.0f];
    [searchBtn addTarget:self action:@selector(buttonOperationEventClicked)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (totalVolumeLabel.bottom + KXCUIControlSizeWidth(80.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [mainView addSubview:searchBtn];

}

- (void)buttonOperationEventClicked{
    
    WaittingMBProgressHUD(HUIKeyWindow,@"正在验证....");
    __weak __typeof(&*self)weakSelf = self;
    
    if (self.personalOrderInformation.userOrderStyle == XCAPPOrderForTrainTicketStyle) {
        [XCAPPHTTPClient requestUserProceedGuaranteePayWithUserId:KXCAPPCurrentUserInformation.userPerId orderNo:self.personalOrderInformation.trainticketOrderInfor.ttOrderTradeNumber qunarOrderNo:self.personalOrderInformation.trainticketOrderInfor.ttOrderTradeNumberCodeForQuNaErStr completion:^(WebAPIResponse *response) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    
                    NSString *errorStr = [NSString stringWithFormat:@"【正确内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FinishMBProgressHUD(HUIKeyWindow);
                    NSLog(@"response.responseObject【确认担保支付】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                    
                    PaySuccessfulViewController *viewController = [[PaySuccessfulViewController alloc]initWithOderInfor:weakSelf.personalOrderInformation isSuccessfulBool:YES];
                    [weakSelf.navigationController pushViewController:viewController animated:YES];
                    
                }else{
                    
                    NSString *errorStr = [NSString stringWithFormat:@"%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FailedMBProgressHUD(HUIKeyWindow,errorStr);
                    NSLog(@"response.responseObject【确认担保支付】【错误内容】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                }
                
            });
            
        }];
    }
    else if (self.personalOrderInformation.userOrderStyle == XCAPPOrderHotelForStyle){
        
        NSLog(@"写接口哈");
        
        [XCAPPHTTPClient userRequestGotoProceedGuaranteePayForPayCheck:KXCAPPCurrentUserInformation.userPerId orderId:self.personalOrderInformation.hotelOrderInfor.orderId completion:^(WebAPIResponse *response) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    
                    NSString *errorStr = [NSString stringWithFormat:@"【正确内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FinishMBProgressHUD(HUIKeyWindow);
                    NSLog(@"response.responseObject【确认担保支付】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                    
                    PaySuccessfulViewController *viewController = [[PaySuccessfulViewController alloc]initWithOderInfor:weakSelf.personalOrderInformation isSuccessfulBool:YES];
                    [weakSelf.navigationController pushViewController:viewController animated:YES];
                    
                    
                }else{
                    
                    NSString *errorStr = [NSString stringWithFormat:@"%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FailedMBProgressHUD(HUIKeyWindow,errorStr);
                    NSLog(@"response.responseObject【确认担保支付】【错误内容】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                }
                
            });

        }];
    }
}

@end
