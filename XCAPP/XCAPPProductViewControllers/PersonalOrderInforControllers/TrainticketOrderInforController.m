//
//  TrainticketOrderInforController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainticketOrderInforController.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "HTTPClient.h"
#import "OrderExpenseTrainTicketDetailView.h"
#import "TrainTicketReturnController.h"


#define KOrderLeftContentFont               KXCAPPUIContentFontSize(14.0f)
#define KOrderContentFont                   KXCAPPUIContentDefautFontSize(14.0f)
#define KOrderContentIntervalFloat          (KXCUIControlSizeWidth(23))

#define KOrderwhiteColorContetHeight        (KXCUIControlSizeWidth(36.0f))


#define KBtnForExpenseButtonTag             (1340111)
#define KBtnForGotoPayButtonTag             (1340112)
#define KBtnForReturnedTicketButtonTag      (1340113)

#define KAlertForUserReturnedTicketAlertTag (1340211)

@interface TrainticketOrderInforController ()<UIAlertViewDelegate>
/*!
 * @breif 状态信息所占用的高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                             userOrderPayStatCellHeightFloat;
/*!
 * @breif 火车票订单详情信息
 * @See
 */
@property (nonatomic , strong)      TrainticketOrderInformation         *userTrainTicketOrderInformation;

/*!
 * @breif 倒计时显示时间标签
 * @See
 */
@property (nonatomic , weak)      UILabel                               *orderPayTimeIntervalLabel;

/*!
 * @breif 倒计时时间计算
 * @See
 */
@property (nonatomic , assign)      NSInteger                           timeIntervalInteger;

/*!
 * @breif 倒计时定时器
 * @See
 */
@property (nonatomic , strong)      NSTimer                             *orderIntervalTime;

/*!
 * @breif 订单明细信息
 * @See
 */
@property (nonatomic , weak)      OrderExpenseTrainTicketDetailView     *orderExpenseForTrainDetailView;
@end

@implementation TrainticketOrderInforController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithTrainticketOrderInfor:(TrainticketOrderInformation *)trainTicketOrder{
    self = [super init];
    if (self) {
        
        self.userTrainTicketOrderInformation = trainTicketOrder;
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
    
    [self settingNavTitle:@"订单详情"];
    
    self.timeIntervalInteger = 30;
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    WaittingMBProgressHUD(HUIKeyWindow, @"正在加载订单...");
    [XCAPPHTTPClient requestTrainTicketItemOrderDetailInforWtihOrderId:self.userTrainTicketOrderInformation.ttOrderIdStr completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"接口名：%@ %@",KReqUserTTOrderItemDetailURL,response.responseObject);

            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    if (dataDictionary.count > 0) {
                        [weakSelf.userTrainTicketOrderInformation supplementUserTrainticketOrderDetailInfoWithUnserializedJSONDic:dataDictionary];
                        [weakSelf setupTrainticketOrderInforControllerFrame];
                        
                        FinishMBProgressHUD(HUIKeyWindow);

                    }else{
                        FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                    }
                }else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
            if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                FailedMBProgressHUD(HUIKeyWindow,msg);
            }
            else{
                FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
            }
            
        });
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTrainticketOrderInforControllerFrame{
    
    NSLog(@"初始化一次");
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:KDefaultViewBackGroundColor];
    [mainView setTag:100];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    ///MARK:初始化订单基本信息
    UIView *orderBaseView = [[UIView alloc]init];
    [orderBaseView setBackgroundColor:[UIColor whiteColor]];
    [orderBaseView setFrame:CGRectMake(0.0f,KInforLeftIntervalWidth, KProjectScreenWidth,
                                       (KOrderContentIntervalFloat*3 + 8.0f))];
    [mainView addSubview:orderBaseView];
    
    

    UILabel *titleOrderState = [[UILabel alloc]init];
    [titleOrderState setBackgroundColor:[UIColor clearColor]];
    [titleOrderState setTextColor:KSubTitleTextColor];
    [titleOrderState setText:@"订单状态"];
    [titleOrderState setTextAlignment:NSTextAlignmentLeft];
    [titleOrderState setFont:KOrderLeftContentFont];
    [titleOrderState setFrame:CGRectMake(KInforLeftIntervalWidth, 4.0f, KXCUIControlSizeWidth(80.0f), KOrderContentIntervalFloat)];
    [orderBaseView addSubview:titleOrderState];

    UILabel *willOrderState = [[UILabel alloc]init];
    [willOrderState setBackgroundColor:[UIColor clearColor]];
    [willOrderState setTextColor:KContentTextColor];

    [willOrderState setTextAlignment:NSTextAlignmentLeft];
    [willOrderState setFont:KOrderContentFont];
    [willOrderState setFrame:CGRectMake(KXCUIControlSizeWidth(120),4.0f, KXCUIControlSizeWidth(180.0f), KOrderContentIntervalFloat)];
    [orderBaseView addSubview:willOrderState];
    
    UILabel *titlePayState = [[UILabel alloc]init];
    [titlePayState setBackgroundColor:[UIColor clearColor]];
    [titlePayState setTextColor:KSubTitleTextColor];
    [titlePayState setText:@"支付状态"];
    [titlePayState setTextAlignment:NSTextAlignmentLeft];
    [titlePayState setFont:KOrderLeftContentFont];
    [titlePayState setFrame:CGRectMake(KInforLeftIntervalWidth, titleOrderState.bottom, KXCUIControlSizeWidth(80.0f), KOrderContentIntervalFloat)];
    [orderBaseView addSubview:titlePayState];
    
    UILabel *payStateContent = [[UILabel alloc]init];
    [payStateContent setBackgroundColor:[UIColor clearColor]];
    [payStateContent setTextColor:KContentTextColor];
    
    [payStateContent setTextAlignment:NSTextAlignmentLeft];
    [payStateContent setFont:KOrderContentFont];
    [payStateContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),titleOrderState.bottom, KXCUIControlSizeWidth(180.0f), KOrderContentIntervalFloat)];
    [orderBaseView addSubview:payStateContent];
    
    UILabel *titleOrderTotalMoney = [[UILabel alloc]init];
    [titleOrderTotalMoney setBackgroundColor:[UIColor clearColor]];
    [titleOrderTotalMoney setTextColor:KSubTitleTextColor];
    [titleOrderTotalMoney setText:@"订单总价"];
    [titleOrderTotalMoney setTextAlignment:NSTextAlignmentLeft];
    [titleOrderTotalMoney setFont:KOrderLeftContentFont];
    [titleOrderTotalMoney setFrame:CGRectMake(KInforLeftIntervalWidth, payStateContent.bottom, KXCUIControlSizeWidth(80.0f), KOrderContentIntervalFloat)];
    [orderBaseView addSubview:titleOrderTotalMoney];
    
    UILabel *orderTotalMoneyContent = [[UILabel alloc]init];
    [orderTotalMoneyContent setBackgroundColor:[UIColor clearColor]];
    [orderTotalMoneyContent setTextColor:KContentTextColor];
    
    [orderTotalMoneyContent setTextAlignment:NSTextAlignmentLeft];
    [orderTotalMoneyContent setFont:KOrderContentFont];
    [orderTotalMoneyContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),payStateContent.bottom, KXCUIControlSizeWidth(180.0f), KOrderContentIntervalFloat)];
    [orderBaseView addSubview:orderTotalMoneyContent];
    
    
    
    UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailsButton setBackgroundColor:[UIColor clearColor]];
    [detailsButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                                  forState:UIControlStateNormal];
    [detailsButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                                  forState:UIControlStateHighlighted];
    [detailsButton setTitleColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f)
                             forState:UIControlStateNormal];
    [detailsButton setTitleColor:HUIRGBColor(062.0f, 126.0f, 205.0f, 1.0f)
                             forState:UIControlStateHighlighted];

    [detailsButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [detailsButton setTag:KBtnForExpenseButtonTag];
    [detailsButton setTitle:@"查看明细" forState:UIControlStateNormal];
    [detailsButton addTarget:self action:@selector(userPersonalOperaionButtonEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
    [detailsButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(120.0f)),
                                            (orderBaseView.height - KXCUIControlSizeWidth(32.0f)),
                                            (KXCUIControlSizeWidth(120.0f)),
                                            KXCUIControlSizeWidth(22.0f))];
    [orderBaseView addSubview:detailsButton];

    
    
    
    //
    //        OrderStateForTTicketNullPay = 0,                    /**< == 0   未支付 */
    //        OrderStateForTTicketNullPayAndAutomaticCancel,      /**< == 1   未支付，自动取消 */
    //        OrderStateForTTicketAlreadyPay,                     /**< == 2   出票中，已支付 */
    //        OrderStateForTTicketAlreadyCancelAndRefund,         /**< == 3   已取消，已退款 */
    //        OrderStateForTTicketAlreadySoldAndPay,              /**< == 4   已出票，已支付 */
    //        OrderStateForTTicketSoldFailureAndRefund,           /**< == 5   出票失败，已退款 */
    //        OrderStateForTTicketRefundFailure,                  /**< == 6   退票失败 */
    
    
    self.userOrderPayStatCellHeightFloat = KInforLeftIntervalWidth*2;
    UILabel *orderPayStateLabel = [[UILabel alloc]init];
    [orderPayStateLabel setTextColor:KSubTitleTextColor];
    [orderPayStateLabel setTextAlignment:NSTextAlignmentCenter];
    [orderPayStateLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [orderPayStateLabel setNumberOfLines:0];
    [orderPayStateLabel setBackgroundColor:[UIColor clearColor]];
    [orderPayStateLabel setFont:KXCAPPUIContentDefautFontSize(17.0f)];
    [mainView addSubview:orderPayStateLabel];
    NSString *orderPayContentStr = @"";
    if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketNullPay) {
        [willOrderState setText:@"待确认"];
        [payStateContent setText:@"未支付"];
        orderPayContentStr = @"请及时支付，订单将在15分钟后自动取消！";
    }
    
    else if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketNullPayAndAutomaticCancel){
        
        [willOrderState setText:@"已取消"];
        [payStateContent setText:@"未支付"];
        orderPayContentStr = @"由于您未在规定时间内支付，订单已自动取消！";
    }
    
    else if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketAlreadyPay){
        
        [willOrderState setText:@"出票中"];
        [payStateContent setText:@"已支付"];
        orderPayContentStr = @"订单正在出票中，请耐心等候！";
    }
    
    else if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketAlreadyCancelAndRefund){
        
        [willOrderState setText:@"已取消"];
        [payStateContent setText:@"已退款"];
        
        orderPayContentStr = @"退款953元于2016－07-17 19:59已操作，到账时间根据银行不同，请以实际为准。";
        
    }
    else if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketAlreadySoldAndPay){
        
        [willOrderState setText:@"已出票"];
        [payStateContent setText:@"已支付"];
        
        orderPayContentStr = @"出票成功，祝您出行愉快！";
    }
    else if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketSoldFailureAndRefund){
        [willOrderState setText:@"出票失败"];
        [payStateContent setText:@"已退款"];
        orderPayContentStr = @"退款953元于2016－07-17 19:59已操作，到账时间根据银行不同，请以实际为准。";
    }
    else if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketRefundFailure){
        
        [willOrderState setText:@"退票失败"];
        [payStateContent setText:@"已支付"];
        orderPayContentStr = @"由于各种原因退票失败，有疑问请致电客服！";
    }
    

    
    [orderPayStateLabel setText:orderPayContentStr];
    CGSize orderPayContentSize = [orderPayContentStr sizeWithFont:orderPayStateLabel.font
                                                constrainedToSize:CGSizeMake((KProjectScreenWidth - KInforLeftIntervalWidth*3), CGFLOAT_MAX)
                                                    lineBreakMode:NSLineBreakByWordWrapping];
    [orderPayStateLabel setFrame:CGRectMake(KInforLeftIntervalWidth*1.5, orderBaseView.bottom + KInforLeftIntervalWidth, (KProjectScreenWidth - KInforLeftIntervalWidth*3), orderPayContentSize.height)];
    self.userOrderPayStatCellHeightFloat+=orderPayContentSize.height;

    
    ///倒计时及操作按键
    if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketNullPay) {
        
        UILabel  *timeIntervalLabel = [[UILabel alloc]init];
        [timeIntervalLabel setBackgroundColor:[UIColor clearColor]];
        [timeIntervalLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [timeIntervalLabel setTextAlignment:NSTextAlignmentCenter];
        [timeIntervalLabel setTextColor:HUIRGBColor(2550.0f, 0.0f, 0.0f, 1.0f)];
        [timeIntervalLabel setText:@""];
        [timeIntervalLabel setFrame:CGRectMake(0.0f, orderPayStateLabel.bottom + KXCUIControlSizeWidth(6.0f),
                                               KProjectScreenWidth, KXCUIControlSizeWidth(20.0f))];
        self.orderPayTimeIntervalLabel = timeIntervalLabel;
        [mainView addSubview:self.orderPayTimeIntervalLabel];
        self.userOrderPayStatCellHeightFloat+= KXCUIControlSizeWidth(26.0f);
        
        self.orderIntervalTime = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeIntervalIntegerStep) userInfo:nil repeats:YES];
        
        UIButton *btnForRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForRefundButton setBackgroundColor:[UIColor clearColor]];
        [btnForRefundButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                      forState:UIControlStateNormal];
        [btnForRefundButton setBackgroundImage:createImageWithColor(HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f))
                                      forState:UIControlStateHighlighted];
        [btnForRefundButton setTitleColor:HUIRGBColor(255.0f, 0.0f, 0.0f, 1.0f) forState:UIControlStateNormal];
        [btnForRefundButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [btnForRefundButton setTag:KBtnForGotoPayButtonTag];
        [btnForRefundButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [btnForRefundButton.layer setCornerRadius:4.0f];
        [btnForRefundButton.layer setBorderColor:HUIRGBColor(255.0f, 0.0f, 0.0f, 1.0f).CGColor];
        [btnForRefundButton.layer setBorderWidth:1.0f];
        [btnForRefundButton.layer setMasksToBounds:YES];
        [btnForRefundButton addTarget:self action:@selector(userPersonalOperaionButtonEvent:)
                     forControlEvents:UIControlEventTouchUpInside];
        
        [btnForRefundButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(120.0f))/2,
                                                (timeIntervalLabel.bottom + KXCUIControlSizeWidth(10.0f)),
                                                (KXCUIControlSizeWidth(120.0f)),
                                                KXCUIControlSizeWidth(32.0f))];
        [mainView addSubview:btnForRefundButton];
        self.userOrderPayStatCellHeightFloat+= KXCUIControlSizeWidth(42.0f);
    }
    
    UIView *trainTicketInforBGView = [[UIView alloc]init];
    [trainTicketInforBGView setBackgroundColor:[UIColor whiteColor]];
    [trainTicketInforBGView setFrame:CGRectMake(0.0f,(orderBaseView.bottom + self.userOrderPayStatCellHeightFloat),
                                                KProjectScreenWidth,
                                                (KFunctionModulButtonHeight + KXCUIControlSizeWidth(121.0f)))];
    [mainView addSubview:trainTicketInforBGView];

    UILabel *beginSite = [[UILabel alloc]init];
    [beginSite setTextAlignment:NSTextAlignmentLeft];
    [beginSite setTextColor:KSubTitleTextColor];
    [beginSite setFrame:CGRectMake(KInforLeftIntervalWidth*2, KXCUIControlSizeWidth(20.0f),
                                   (trainTicketInforBGView.width/3),
                                   KXCUIControlSizeWidth(15.0f))];
    [beginSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginSite setBackgroundColor:[UIColor clearColor]];
    [beginSite setText:self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traTakeOffSite];
    [trainTicketInforBGView addSubview:beginSite];
    
    UILabel *arrivedSite = [[UILabel alloc]init];
    [arrivedSite setTextColor:KSubTitleTextColor];
    [arrivedSite setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                     (KXCUIControlSizeWidth(20.0f)),
                                     (trainTicketInforBGView.width/3),
                                     KXCUIControlSizeWidth(15.0f))];
    [arrivedSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedSite setBackgroundColor:[UIColor clearColor]];
    [arrivedSite setTextAlignment:NSTextAlignmentRight];
    [arrivedSite setText:self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traArrivedSite];
    [trainTicketInforBGView addSubview:arrivedSite];
    
    UILabel *beginDateTime = [[UILabel alloc]init];
    [beginDateTime setTextAlignment:NSTextAlignmentLeft];
    [beginDateTime setTextColor:KContentTextColor];
    [beginDateTime setFrame:CGRectMake(KInforLeftIntervalWidth*2, (beginSite.bottom + KXCUIControlSizeWidth(5.0f)),
                                   (trainTicketInforBGView.width/3),
                                   KXCUIControlSizeWidth(40.0f))];
    [beginDateTime setFont:KXCAPPUIContentDefautFontSize(27.0f)];
    [beginDateTime setBackgroundColor:[UIColor clearColor]];
    [beginDateTime setText:self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traTakeOffTime];
    [trainTicketInforBGView addSubview:beginDateTime];
    
    UILabel *endDateTime = [[UILabel alloc]init];
    [endDateTime setTextColor:KContentTextColor];
    [endDateTime setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                 (beginSite.bottom + KXCUIControlSizeWidth(5.0f)),
                                 (trainTicketInforBGView.width/3),
                                 KXCUIControlSizeWidth(40.0f))];
    [endDateTime setFont:KXCAPPUIContentDefautFontSize(27.0f)];
    [endDateTime setBackgroundColor:[UIColor clearColor]];
    [endDateTime setTextAlignment:NSTextAlignmentRight];
    [endDateTime setText:self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traArrivedTime];
    [trainTicketInforBGView addSubview:endDateTime];
    
    UILabel *beginDateLabel = [[UILabel alloc]init];
    [beginDateLabel setTextAlignment:NSTextAlignmentLeft];
    [beginDateLabel setTextColor:KSubTitleTextColor];
    [beginDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, (KXCUIControlSizeWidth(5.0f) + beginDateTime.bottom),
                                   (trainTicketInforBGView.width/3),
                                   KXCUIControlSizeWidth(15.0f))];
    [beginDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginDateLabel setBackgroundColor:[UIColor clearColor]];
    

    NSDictionary *beginDateDictionary = dateYearMonthDayWeekWithDateStr(self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traTakeOffTimeSealStr);
    [beginDateLabel setText:StringForKeyInUnserializedJSONDic(beginDateDictionary, @"date")];
    [trainTicketInforBGView addSubview:beginDateLabel];
    
    UILabel *arrivedDateLabel = [[UILabel alloc]init];
    [arrivedDateLabel setTextColor:KSubTitleTextColor];
    [arrivedDateLabel setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                     (KXCUIControlSizeWidth(5.0f) + endDateTime.bottom),
                                     (trainTicketInforBGView.width/3),
                                     KXCUIControlSizeWidth(15.0f))];
    [arrivedDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedDateLabel setBackgroundColor:[UIColor clearColor]];
    [arrivedDateLabel setTextAlignment:NSTextAlignmentRight];
    NSDictionary *arrivedDateDictionary = dateYearMonthDayWeekWithDateStr(self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traArrivedTimeSealStr);
    [arrivedDateLabel setText:StringForKeyInUnserializedJSONDic(arrivedDateDictionary, @"date")];
    [trainTicketInforBGView addSubview:arrivedDateLabel];
    
    UIView *separatorView = [[UIView alloc]init] ;
    [separatorView setBackgroundColor:KSepLineColorSetup];
    [separatorView setFrame:CGRectMake(KInforLeftIntervalWidth,
                                       (arrivedDateLabel.bottom + KXCUIControlSizeWidth(20.0f)),
                                       (trainTicketInforBGView.width - KInforLeftIntervalWidth*2), 1.0f)];
    [trainTicketInforBGView addSubview:separatorView];
    
    
    UILabel *traintNameLabel = [[UILabel alloc]init];
    [traintNameLabel setBackgroundColor:[UIColor clearColor]];
    [traintNameLabel setFrame:CGRectMake((KInforLeftIntervalWidth ),
                                         ((arrivedDateLabel.bottom/2-KXCUIControlSizeWidth(8.0f))),
                                         (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                         KXCUIControlSizeWidth(14.0f))];
    [traintNameLabel setFont:KXCAPPUIContentDefautFontSize(13.0f)];
    [traintNameLabel setTextColor:KSubTitleTextColor];
    [traintNameLabel setTextAlignment:NSTextAlignmentCenter];
    [trainTicketInforBGView addSubview:traintNameLabel];
    [traintNameLabel setText:self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traCodeNameStr];
    
    
    UIImageView *fromToImageView = [[UIImageView alloc]init];
    [fromToImageView setBackgroundColor:[UIColor clearColor]];
    [fromToImageView setImage:[UIImage imageNamed:@"FromToImage.png"]];
    [fromToImageView setFrame:CGRectMake(beginDateLabel.right - KXCUIControlSizeWidth(40.0f),
                                         (arrivedDateLabel.bottom/2+12),
                                         (KProjectScreenWidth - beginDateLabel.right*2 +
                                          KXCUIControlSizeWidth(80.0f)),
                                         KXCUIControlSizeWidth(10.0f))];
    [trainTicketInforBGView addSubview:fromToImageView];
    
    UILabel *traintIntervalLabel = [[UILabel alloc]init];
    [traintIntervalLabel setBackgroundColor:[UIColor clearColor]];
    [traintIntervalLabel setFrame:CGRectMake((KInforLeftIntervalWidth),(fromToImageView.bottom),
                                             (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                             KXCUIControlSizeWidth(18.0f))];
    [traintIntervalLabel setFont:KXCAPPUIContentDefautFontSize(13.0f)];
    [traintIntervalLabel setTextColor:KSubTitleTextColor];
    [traintIntervalLabel setTextAlignment:NSTextAlignmentCenter];
    [trainTicketInforBGView addSubview:traintIntervalLabel];
    [traintIntervalLabel setText:@"约4小时48分"];
    
    
    UILabel *seatTypeLabel = [[UILabel alloc]init];
    [seatTypeLabel setTextAlignment:NSTextAlignmentLeft];
    [seatTypeLabel setTextColor:KContentTextColor];
    [seatTypeLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, separatorView.bottom,
                                        (trainTicketInforBGView.width/3),
                                        KFunctionModulButtonHeight)];
    [seatTypeLabel setFont:KFunctionModuleContentFont];
    [seatTypeLabel setBackgroundColor:[UIColor clearColor]];
    [seatTypeLabel setText:self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traCabinModelStr];
    [trainTicketInforBGView addSubview:seatTypeLabel];
    
    UILabel *seatPriceLabel = [[UILabel alloc]init];
    [seatPriceLabel setTextColor:KSubTitleTextColor];
    [seatPriceLabel setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                          (separatorView.bottom),
                                          (trainTicketInforBGView.width/3),
                                          KFunctionModulButtonHeight)];
    [seatPriceLabel setFont:KFunctionModuleContentFont];
    [seatPriceLabel setBackgroundColor:[UIColor clearColor]];
    [seatPriceLabel setTextAlignment:NSTextAlignmentRight];
    [seatPriceLabel setText:[NSString stringWithFormat: @"￥%@",self.userTrainTicketOrderInformation.ttOrderTrainticketInfor.traUnitPrice]];
    [trainTicketInforBGView addSubview:seatPriceLabel];
    
    ////乘客人信息
    UIView *passengersBGView = [[UIView alloc]init];
    [passengersBGView setBackgroundColor:[UIColor whiteColor]];
    [passengersBGView setFrame:CGRectMake(0.0f,(trainTicketInforBGView.bottom + KXCUIControlSizeWidth(10.0f)), KProjectScreenWidth, (KOrderContentIntervalFloat*2.6f))];
    [mainView addSubview:passengersBGView];
    

    NSInteger passengerCountInt = self.userTrainTicketOrderInformation.ttOrderBuyTicketUserMutArray.count;
    
    
    UILabel *titlePassengerInUser = [[UILabel alloc]init];
    [titlePassengerInUser setBackgroundColor:[UIColor clearColor]];
    [titlePassengerInUser setTextColor:KSubTitleTextColor];
    [titlePassengerInUser setText:[NSString stringWithFormat:@"乘客(%zi人)",passengerCountInt]];
    [titlePassengerInUser setTextAlignment:NSTextAlignmentLeft];
    [titlePassengerInUser setFont:KFunctionModuleContentFont];
    [titlePassengerInUser setFrame:CGRectMake(KInforLeftIntervalWidth,5.0f,
                                           KXCUIControlSizeWidth(100.0f), KOrderContentIntervalFloat*1.2)];
    [passengersBGView addSubview:titlePassengerInUser];
    

    CGFloat beginPointY = KXCUIControlSizeWidth(10.0f);
    
    for (UserInformationClass * userInfor in self.userTrainTicketOrderInformation.ttOrderBuyTicketUserMutArray) {
    
        UILabel *createInUserContent = [[UILabel alloc]init];
        [createInUserContent setBackgroundColor:[UIColor clearColor]];
        [createInUserContent setTextColor:KContentTextColor];
        [createInUserContent setNumberOfLines:2];
        [createInUserContent setText:[NSString stringWithFormat:@"%@\n身份证号 %@",
                                      userInfor.userNameStr,
                                      userInfor.userPerCredentialContent]];
        
        [createInUserContent setTextAlignment:NSTextAlignmentLeft];
        [createInUserContent setFont:KFunctionModuleContentFont];
        [createInUserContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),beginPointY,
                                                 (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                                 KOrderContentIntervalFloat*2)];
        [passengersBGView addSubview:createInUserContent];
        
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:createInUserContent.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:KXCUIControlSizeWidth(KXCUIControlSizeWidth(4.0f))];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [createInUserContent.text length])];
        
        NSRange attributeRange=[createInUserContent.text rangeOfString:createInUserContent.text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:attributeRange];
        createInUserContent.attributedText = attributedString;
        [createInUserContent sizeToFit];
        
        beginPointY+=createInUserContent.height + KInforLeftIntervalWidth;
    }
    
    [passengersBGView setHeight:(KOrderContentIntervalFloat*1.2 + beginPointY - KXCUIControlSizeWidth(12.0f))];
    
    
    ///MARK:初始化联系人信息
    UIView *createInUserBaseView = [[UIView alloc]init];
    [createInUserBaseView setBackgroundColor:[UIColor whiteColor]];
    [createInUserBaseView setFrame:CGRectMake(0.0f,(passengersBGView.bottom + KXCUIControlSizeWidth(10.0f)), KProjectScreenWidth, (KOrderContentIntervalFloat*2.6f))];
    [mainView addSubview:createInUserBaseView];
    
    UILabel *titlecreateInUser = [[UILabel alloc]init];
    [titlecreateInUser setBackgroundColor:[UIColor clearColor]];
    [titlecreateInUser setTextColor:KSubTitleTextColor];
    [titlecreateInUser setText:@"联系信息"];
    [titlecreateInUser setTextAlignment:NSTextAlignmentLeft];
    [titlecreateInUser setFont:KFunctionModuleContentFont];
    [titlecreateInUser setFrame:CGRectMake(KInforLeftIntervalWidth,5.0f,
                                           KXCUIControlSizeWidth(80.0f), KOrderContentIntervalFloat*1.2)];
    [createInUserBaseView addSubview:titlecreateInUser];
    
    UILabel *createInUserContent = [[UILabel alloc]init];
    [createInUserContent setBackgroundColor:[UIColor clearColor]];
    [createInUserContent setTextColor:KContentTextColor];
    [createInUserContent setNumberOfLines:2];
    [createInUserContent setText:[NSString stringWithFormat:@"%@\n%@",
                                  self.userTrainTicketOrderInformation.ttOrderBookUserInfor.userPerPhoneNumberStr,
                                  self.userTrainTicketOrderInformation.ttOrderBookUserInfor.userPerEmailStr]];
    
    [createInUserContent setTextAlignment:NSTextAlignmentLeft];
    [createInUserContent setFont:KFunctionModuleContentFont];
    [createInUserContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),KInforLeftIntervalWidth,
                                             (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                             KOrderContentIntervalFloat*2)];
    [createInUserBaseView addSubview:createInUserContent];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:createInUserContent.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KXCUIControlSizeWidth(KXCUIControlSizeWidth(4.0f))];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [createInUserContent.text length])];
    
    NSRange attributeRange=[createInUserContent.text rangeOfString:createInUserContent.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:attributeRange];
    createInUserContent.attributedText = attributedString;
    [createInUserContent sizeToFit];
    
    
    
    UIView *orderCreateBaseInforView = [[UIView alloc]init];
    [orderCreateBaseInforView setBackgroundColor:[UIColor whiteColor]];
    [orderCreateBaseInforView setFrame:CGRectMake(0.0f, (createInUserBaseView.bottom + KInforLeftIntervalWidth),
                                                  KProjectScreenWidth, (KOrderContentIntervalFloat*3 + 10.0f))];
    [mainView addSubview:orderCreateBaseInforView];
    
    UILabel *titleNumber = [[UILabel alloc]init];
    [titleNumber setBackgroundColor:[UIColor clearColor]];
    [titleNumber setTextColor:KSubTitleTextColor];
    [titleNumber setText:@"订单号"];
    [titleNumber setTextAlignment:NSTextAlignmentLeft];
    [titleNumber setFont:KOrderLeftContentFont];
    [titleNumber setFrame:CGRectMake(KInforLeftIntervalWidth, 5.0f, KXCUIControlSizeWidth(80.0f),
                                     KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:titleNumber];
    UILabel *orderNumber = [[UILabel alloc]init];
    [orderNumber setBackgroundColor:[UIColor clearColor]];
    [orderNumber setTextColor:KContentTextColor];
    [orderNumber setText:self.userTrainTicketOrderInformation.ttOrderTradeNumber];
    [orderNumber setTextAlignment:NSTextAlignmentLeft];
    [orderNumber setFont:KOrderContentFont];
    [orderNumber setFrame:CGRectMake(KXCUIControlSizeWidth(120), 4.0f, KXCUIControlSizeWidth(180.0f), KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:orderNumber];
    
    
    UILabel *willCreateDate = [[UILabel alloc]init];
    [willCreateDate setBackgroundColor:[UIColor clearColor]];
    [willCreateDate setTextColor:KSubTitleTextColor];
    [willCreateDate setText:@"预订时间"];
    [willCreateDate setTextAlignment:NSTextAlignmentLeft];
    [willCreateDate setFont:KOrderLeftContentFont];
    [willCreateDate setFrame:CGRectMake(KInforLeftIntervalWidth, titleNumber.bottom, KXCUIControlSizeWidth(80.0f), KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:willCreateDate];
    UILabel *willCreateDateLabel = [[UILabel alloc]init];
    [willCreateDateLabel setBackgroundColor:[UIColor clearColor]];
    [willCreateDateLabel setTextColor:KContentTextColor];
    [willCreateDateLabel setText:self.userTrainTicketOrderInformation.ttOrderCreateDate];
    [willCreateDateLabel setTextAlignment:NSTextAlignmentLeft];
    [willCreateDateLabel setFont:KOrderContentFont];
    [willCreateDateLabel setFrame:CGRectMake(KXCUIControlSizeWidth(120), orderNumber.bottom, KXCUIControlSizeWidth(180.0f), KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:willCreateDateLabel];
    
    UILabel *titleReserveUser = [[UILabel alloc]init];
    [titleReserveUser setBackgroundColor:[UIColor clearColor]];
    [titleReserveUser setTextColor:KSubTitleTextColor];
    [titleReserveUser setText:@"预订人"];
    [titleReserveUser setTextAlignment:NSTextAlignmentLeft];
    [titleReserveUser setFont:KOrderLeftContentFont];
    [titleReserveUser setFrame:CGRectMake(KInforLeftIntervalWidth,willCreateDateLabel.bottom,
                                           KXCUIControlSizeWidth(80.0f), KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:titleReserveUser];
    
    UILabel *reserveUserContent = [[UILabel alloc]init];
    [reserveUserContent setBackgroundColor:[UIColor clearColor]];
    [reserveUserContent setTextColor:KContentTextColor];
    [reserveUserContent setTextAlignment:NSTextAlignmentLeft];
    [reserveUserContent setFont:KOrderContentFont];
    [reserveUserContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),willCreateDateLabel.bottom,
                                             (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                             KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:reserveUserContent];
    
    NSString *reserveUserStr = [NSString stringWithFormat:@"%@ %@",self.userTrainTicketOrderInformation.ttOrderReserveUserInfor.userNameStr,self.userTrainTicketOrderInformation.ttOrderReserveUserInfor.userPerPhoneNumberStr];
    [reserveUserContent setText:reserveUserStr];

     
    
    if (orderCreateBaseInforView.bottom > self.view.height) {
        [mainView setContentSize:CGSizeMake(KProjectScreenWidth, orderCreateBaseInforView.bottom + 100.0f)];
    }
    
    
    if (self.userTrainTicketOrderInformation.ttOrderStateStyle ==OrderStateForTTicketAlreadySoldAndPay){
        
        
        UIButton *btnForRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForRefundButton setBackgroundColor:[UIColor clearColor]];
        [btnForRefundButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                            forState:UIControlStateNormal];
        [btnForRefundButton setBackgroundImage:createImageWithColor(HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f))
                            forState:UIControlStateHighlighted];
        [btnForRefundButton setTitleColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f) forState:UIControlStateNormal];
        [btnForRefundButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [btnForRefundButton setTag:KBtnForReturnedTicketButtonTag];
        [btnForRefundButton setTitle:@"退 票" forState:UIControlStateNormal];
        [btnForRefundButton.layer setCornerRadius:4.0f];
        [btnForRefundButton.layer setBorderColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f).CGColor];
        [btnForRefundButton.layer setBorderWidth:1.0f];
        [btnForRefundButton.layer setMasksToBounds:YES];
        [btnForRefundButton addTarget:self action:@selector(userPersonalOperaionButtonEvent:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [btnForRefundButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(100.0f))/2,
                                      (orderCreateBaseInforView.bottom + KXCUIControlSizeWidth(30.0f)),
                                      (KXCUIControlSizeWidth(100.0f)),
                                      KXCUIControlSizeWidth(32.0f))];
        [mainView addSubview:btnForRefundButton];
        
        [mainView setContentSize:CGSizeMake(KProjectScreenWidth, btnForRefundButton.bottom + 80.0f)];

    }
    
    
    CGRect detailRect = CGRectMake(KProjectScreenWidth, 0.0f,
                                   KProjectScreenWidth, KProjectScreenHeight);
    OrderExpenseTrainTicketDetailView *orderDetailView = [[OrderExpenseTrainTicketDetailView alloc]initWithFrame:detailRect
                                                                                     order:self.userTrainTicketOrderInformation];
    self.orderExpenseForTrainDetailView = orderDetailView;
    [self.navigationController.view addSubview:self.orderExpenseForTrainDetailView];
}

- (void)timeIntervalIntegerStep{
    
    
    if (self.timeIntervalInteger < -1) {
        NSLog(@"timeStr is %zi",self.timeIntervalInteger);
        return;
    }
    NSInteger minuteInt = self.timeIntervalInteger/60;
    
    NSInteger secondInt = self.timeIntervalInteger%60;
    
    NSString *minuteStr = [NSString stringWithFormat:@"%zi",minuteInt];
    if (minuteInt < 10) {
        minuteStr = [NSString stringWithFormat:@"0%zi",minuteInt];
    }
    
    NSString *secondStr = [NSString stringWithFormat:@"%zi",secondInt];
    if (secondInt < 10) {
        secondStr = [NSString stringWithFormat:@"0%zi",secondInt];
    }
    
    NSString *timeStr = [NSString stringWithFormat:@"剩余时间：%@:%@",minuteStr,secondStr];

    
    [self.orderPayTimeIntervalLabel setText:timeStr];
    
    self.timeIntervalInteger-=1;
    
//    if (self.timeIntervalInteger< 0) {
//        self.timeIntervalInteger = INT_MAX;
//        [self.orderPayTimeIntervalLabel setText:@""];
//    }
    if (self.timeIntervalInteger == 0 ) {
        [self.orderPayTimeIntervalLabel setText:@""];
        ///计时结束
        NSLog(@"计时结束");
        [self.orderIntervalTime fire];
        [self.orderIntervalTime invalidate] ;
        
        UIScrollView *mainView = (UIScrollView *)[self.view viewWithTag:100];
        if (mainView) {
            
            [mainView superview];
            mainView = nil;
        }
        
        [self.userTrainTicketOrderInformation setTtOrderStateStyle:OrderStateForTTicketNullPayAndAutomaticCancel];
        [self setupTrainticketOrderInforControllerFrame];
    }
}



- (void)userPersonalOperaionButtonEvent:(UIButton *)button{
    
    ///查看明细
    if (button.tag == KBtnForExpenseButtonTag) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect detailRect = CGRectMake(0.0f, 0.0f,
                                           KProjectScreenWidth, KProjectScreenHeight);
            [self.orderExpenseForTrainDetailView setFrame:detailRect];
        }];
    }
    
    ///立即支付
    else if (button.tag == KBtnForGotoPayButtonTag){
    
        NSLog(@"立即支付操作");
    }
    
    ///退票操作
    else if (button.tag == KBtnForReturnedTicketButtonTag){
        
        TrainTicketReturnController *viewController = [[TrainTicketReturnController alloc]initWithTrainTicketOrder:self.userTrainTicketOrderInformation];
        [self.navigationController pushViewController:viewController animated:YES];
//        return;
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"您确定要退票吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退票", nil];
//        [alertView setTag:KAlertForUserReturnedTicketAlertTag];
//        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == KAlertForUserReturnedTicketAlertTag) {
        
        if (buttonIndex != 0 ) {
            NSLog(@"用户可以进行退票操作了");
            
            [XCAPPHTTPClient requestUserApplyForRefundOrderTrainTicketWithOrderInfor:self.userTrainTicketOrderInformation completion:^(WebAPIResponse *response) {
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    
                    NSLog(@"接口名：%@ %@",@"退票操作接口",response.responseObject);
                    
                    if (response.code == WebAPIResponseCodeSuccess) {
                        
                    }
                });
            }];
            
            
            [XCAPPHTTPClient requestUserCheckTrainTicketOrderRefundPrepareWithUserId:KXCAPPCurrentUserInformation.userPerId orderNo:self.userTrainTicketOrderInformation.ttOrderTradeNumber qunarOrderNo:self.userTrainTicketOrderInformation.ttOrderTradeNumberCodeForQuNaErStr completion:^(WebAPIResponse *response) {
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    
                    NSString *errorStr = [NSString stringWithFormat:@"【退票手续查询内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    ShowAutoHideMBProgressHUDWithOneSec(HUIKeyWindow,errorStr);
                    NSLog(@"response.responseObject【确认担保支付】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                });
                
            }];

        }
    }
}
@end
