//
//  FlightOrderInfoDetailController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightOrderInfoDetailController.h"
#import "HTTPClient.h"
#import "HTTPClient+FlightInforRequest.h"

#define KOrderLeftContentFont               KXCAPPUIContentFontSize(14.0f)
#define KOrderContentFont                   KXCAPPUIContentDefautFontSize(14.0f)
#define KOrderContentIntervalFloat          (KXCUIControlSizeWidth(23))

#define KOrderwhiteColorContetHeight        (KXCUIControlSizeWidth(36.0f))


///查看详情
#define KBtnForExpenseButtonTag             (1340111)
///去支付
#define KBtnForGotoPayButtonTag             (1340112)
///用户去改签
#define KBtnForChangedButtonTag             (1340113)
///用户去退票
#define KBtnForReturnedTicketButtonTag      (1340114)

#define KAlertForUserReturnedTicketAlertTag (1340211)

@interface FlightOrderInfoDetailController ()<UIAlertViewDelegate>



/*!
 * @breif 飞机票订单信息数据
 * @See
 */
@property (nonatomic , strong)      FlightOrderInformation              *userFlightOrderInfor;

/*!
 * @breif 状态信息所占用的高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                             userOrderPayStatCellHeightFloat;

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
@end

@implementation FlightOrderInfoDetailController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithFlightOrder:(FlightOrderInformation *)flightOrderInfor{
    self = [super init];
    if (self) {
        self.userFlightOrderInfor = flightOrderInfor;
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
    
    [self settingNavTitle:@"订单详情"];
    // Do any additional setup after loading the view.
    
    [self setupFlightOrderInforDetailControllerFrame ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFlightOrderInforDetailControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
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
    [willOrderState setText:@"待确定"];
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
    [payStateContent setText:@"未支付"];
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
    [orderTotalMoneyContent setText:@"￥503"];
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
    
    
    ///
//    您的订单已提交，请您尽快完成支付，订单将在15分钟后自动取消！
    
    self.userOrderPayStatCellHeightFloat = KInforLeftIntervalWidth*2;
    UILabel *orderPayStateLabel = [[UILabel alloc]init];
    [orderPayStateLabel setTextColor:KSubTitleTextColor];
    [orderPayStateLabel setTextAlignment:NSTextAlignmentCenter];
    [orderPayStateLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [orderPayStateLabel setNumberOfLines:0];
    [orderPayStateLabel setBackgroundColor:[UIColor clearColor]];
    [orderPayStateLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
    [mainView addSubview:orderPayStateLabel];
    NSString *orderPayContentStr = @"";

    /**< == 0   待确认，未支付 */
    if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightWaitForConfirm) {
        orderPayContentStr = @"您的订单已提交，请您尽快完成支付，订单将在15分钟后自动取消！";
           }
    /**< == 1   出票中，已支付 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightWaitDrawer){
        
//        恭喜您预订成功，请耐心等待出票！
        orderPayContentStr = @"恭喜您预订成功，请耐心等待出票！";
    }
    
    /**< == 2   出票成功，已支付 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightDrawerSuccessful){
        orderPayContentStr = @"已出票成功，祝您旅途成功！";
    }
    
    /**< == 3   出票失败，已退款 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightDrawerFailure){

        //退款810元于2016－06-08 19:59退至您账户，具体以实际为准
        orderPayContentStr = @"由于您未在规定时间内支付，订单已取消";
    }
    
    /**< == 4   已取消（自动取消）-未支付，自动取消 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightAutomaticCancel){
        orderPayContentStr = @"退款810元于2016－06-08 19:59退至您账户，具体以实际为准";
    }
    
    /**< == 5   改签申请，等待审核 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedWaitCheck){
        //改签请求已受理，请耐心等待！
        orderPayContentStr = @"改签请求已受理，请耐心等待！";
    }
    
    /**< == 6   改签成功，补差价 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedSuccessful){
        
        orderPayContentStr = @"改签申请审核通过，请在15分钟内支付差价，过期将自动取消！！";
    }
    
    /**< == 7   已改签，已支付 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedSuccessfulAndPay){
        orderPayContentStr = @"改签成功，祝您出行愉快！";
    }
    
    /**< == 8   改签申请审核失败 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedCheckFailure){
        
        orderPayContentStr = @"由于各种原因无法为您成功改签，具体原因请致电客服咨询";
    }
    
    /**< == 9   退票申请，等待审核 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightRefundWaitCheck){
        orderPayContentStr = @"退票请求已受理，请耐心等待！";
    }
    
    /**< == 10  退票申请成功，已退票-已退款*/
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightRefundSuccessful){
        orderPayContentStr = @"退款810元于2016－06-08 19:59退至您账户，具体以实际为准";
    }
    
    /**< == 11 退票申请，审核失败 */
    else if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightRefundCheckFailure){
        
        orderPayContentStr = @"由于各种原因无法为您成功退票，具体原因请致电客服咨询";
        
    }
    [orderPayStateLabel setText:orderPayContentStr];
    CGSize orderPayContentSize = [orderPayContentStr sizeWithFont:orderPayStateLabel.font
                                                constrainedToSize:CGSizeMake((KProjectScreenWidth - KInforLeftIntervalWidth*4), CGFLOAT_MAX)
                                                    lineBreakMode:NSLineBreakByWordWrapping];
    [orderPayStateLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, orderBaseView.bottom + KInforLeftIntervalWidth, (KProjectScreenWidth - KInforLeftIntervalWidth*4), orderPayContentSize.height)];
    self.userOrderPayStatCellHeightFloat+=orderPayContentSize.height;

    ////改签失败状态
    

    
    ///出票中

    ///飞机票信息
    UIView *flightInforBGView = [[UIView alloc]init];
    [flightInforBGView setBackgroundColor:[UIColor whiteColor]];
    [flightInforBGView setFrame:CGRectMake(0.0f,(orderBaseView.bottom +self.userOrderPayStatCellHeightFloat),
                                                KProjectScreenWidth,
                                                (KFunctionModulButtonHeight + KXCUIControlSizeWidth(121.0f)))];
    [mainView addSubview:flightInforBGView];
    
    
    UILabel *flightDateLabel = [[UILabel alloc]init];
    [flightDateLabel setTextColor:KContentTextColor];
    [flightDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(20.0f),
                                          (flightInforBGView.width/3),
                                          KXCUIControlSizeWidth(15.0f))];
    [flightDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [flightDateLabel setBackgroundColor:[UIColor clearColor]];
    [flightDateLabel setTextAlignment:NSTextAlignmentLeft];
    [flightDateLabel setText:@"08-02 周二"];
    [flightInforBGView addSubview:flightDateLabel];
    
    UILabel *beginAndEndSiteLabel = [[UILabel alloc]init];
    [beginAndEndSiteLabel setTextAlignment:NSTextAlignmentLeft];
    [beginAndEndSiteLabel setTextColor:KContentTextColor];
    [beginAndEndSiteLabel setFrame:CGRectMake(KXCUIControlSizeWidth(120),(KXCUIControlSizeWidth(20.0f)),
                                        (flightInforBGView.width/3),
                                        KXCUIControlSizeWidth(15.0f))];
    [beginAndEndSiteLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginAndEndSiteLabel setBackgroundColor:[UIColor clearColor]];
    [beginAndEndSiteLabel setText:@"北京-上海"];
    [flightInforBGView addSubview:beginAndEndSiteLabel];
    
    
    UILabel *beginDateTime = [[UILabel alloc]init];
    [beginDateTime setTextAlignment:NSTextAlignmentLeft];
    [beginDateTime setTextColor:KContentTextColor];
    [beginDateTime setFrame:CGRectMake(KInforLeftIntervalWidth*2, (beginAndEndSiteLabel.bottom + KXCUIControlSizeWidth(5.0f)),
                                       (flightInforBGView.width/3),
                                       KXCUIControlSizeWidth(40.0f))];
    [beginDateTime setFont:KXCAPPUIContentDefautFontSize(30.0f)];
    [beginDateTime setBackgroundColor:[UIColor clearColor]];
    [beginDateTime setText:@"19:40"];
    [flightInforBGView addSubview:beginDateTime];
    
    UILabel *endDateTime = [[UILabel alloc]init];
    [endDateTime setTextColor:KContentTextColor];
    [endDateTime setFrame:CGRectMake((flightInforBGView.width -  KInforLeftIntervalWidth*2 - (flightInforBGView.width/3)),
                                     (beginAndEndSiteLabel.bottom + KXCUIControlSizeWidth(5.0f)),
                                     (flightInforBGView.width/3),
                                     KXCUIControlSizeWidth(40.0f))];
    [endDateTime setFont:KXCAPPUIContentDefautFontSize(30.0f)];
    [endDateTime setBackgroundColor:[UIColor clearColor]];
    [endDateTime setTextAlignment:NSTextAlignmentRight];
    [endDateTime setText:@"19:40"];
    [flightInforBGView addSubview:endDateTime];
    
    UILabel *beginSite = [[UILabel alloc]init];
    [beginSite setTextAlignment:NSTextAlignmentLeft];
    [beginSite setTextColor:KSubTitleTextColor];
    [beginSite setFrame:CGRectMake(KInforLeftIntervalWidth*2,(endDateTime.bottom + KXCUIControlSizeWidth(5.0f)),
                                   (flightInforBGView.width/3),
                                   KXCUIControlSizeWidth(15.0f))];
    [beginSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginSite setBackgroundColor:[UIColor clearColor]];
    [beginSite setText:@"首都机场 T1"];
    [flightInforBGView addSubview:beginSite];
    
    UILabel *arrivedSite = [[UILabel alloc]init];
    [arrivedSite setTextColor:KSubTitleTextColor];
    [arrivedSite setFrame:CGRectMake((flightInforBGView.width -  KInforLeftIntervalWidth*2 - (flightInforBGView.width/3)),
                                     (endDateTime.bottom + KXCUIControlSizeWidth(5.0f)),
                                     (flightInforBGView.width/3),
                                     KXCUIControlSizeWidth(15.0f))];
    [arrivedSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedSite setBackgroundColor:[UIColor clearColor]];
    [arrivedSite setTextAlignment:NSTextAlignmentRight];
    [arrivedSite setText:@"浦东机场 T2"];
    [flightInforBGView addSubview:arrivedSite];
    

    
    
    
    
    UILabel *seatTypeLabel = [[UILabel alloc]init];
    [seatTypeLabel setTextAlignment:NSTextAlignmentLeft];
    [seatTypeLabel setTextColor:KSubTitleTextColor];
    [seatTypeLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, arrivedSite.bottom,
                                       (flightInforBGView.width/3),
                                       KFunctionModulButtonHeight)];
    [seatTypeLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [seatTypeLabel setBackgroundColor:[UIColor clearColor]];
    [seatTypeLabel setText:@"海航HU7609 | 787大 | 经济舱"];
    [flightInforBGView addSubview:seatTypeLabel];
    
    CGSize seatTypeSize = [seatTypeLabel.text sizeWithFont:seatTypeLabel.font];
    [seatTypeLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, arrivedSite.bottom,
                                       seatTypeSize.width,
                                       KFunctionModulButtonHeight)];
    
//    UILabel *seatPriceLabel = [[UILabel alloc]init];
//    [seatPriceLabel setTextColor:KSubTitleTextColor];
//    [seatPriceLabel setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
//                                        (separatorView.bottom),
//                                        (trainTicketInforBGView.width/3),
//                                        KFunctionModulButtonHeight)];
//    [seatPriceLabel setFont:KFunctionModuleContentFont];
//    [seatPriceLabel setBackgroundColor:[UIColor clearColor]];
//    [seatPriceLabel setTextAlignment:NSTextAlignmentRight];
//    [seatPriceLabel setText:@"￥9385"];
//    [trainTicketInforBGView addSubview:seatPriceLabel];
    
    
    
    ////乘客人信息
    UIView *passengersBGView = [[UIView alloc]init];
    [passengersBGView setBackgroundColor:[UIColor whiteColor]];
    [passengersBGView setFrame:CGRectMake(0.0f,(flightInforBGView.bottom + KXCUIControlSizeWidth(10.0f)), KProjectScreenWidth, (KOrderContentIntervalFloat*2.6f))];
    [mainView addSubview:passengersBGView];
    
    
    NSInteger passengerCountInt = self.userFlightOrderInfor.flightOrderUserMutArray.count;
    
    
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
    
    for (UserInformationClass * userInfor in self.userFlightOrderInfor.flightOrderUserMutArray) {
        
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
                                  @"18716569375",
                                  @"m_zhangxuan@hotmail.com"]];
    
    [createInUserContent setTextAlignment:NSTextAlignmentLeft];
    [createInUserContent setFont:KFunctionModuleContentFont];
    [createInUserContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),KInforLeftIntervalWidth,
                                             (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                             KOrderContentIntervalFloat*2)];
    [createInUserBaseView addSubview:createInUserContent];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:createInUserContent.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KXCUIControlSizeWidth(5.0f)];
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
    [orderNumber setText:@"2016KLJDNBIIONVKSDJJI"];
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
    [willCreateDateLabel setText:@"2016-09-16 16:03"];
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
    [reserveUserContent setNumberOfLines:2];
    [reserveUserContent setText:@"张利广 18615459060"];
    [reserveUserContent setTextAlignment:NSTextAlignmentLeft];
    [reserveUserContent setFont:KOrderContentFont];
    [reserveUserContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),willCreateDateLabel.bottom,
                                            (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                            KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:reserveUserContent];
    
    
    ///在这里用户可以改签，可以退票操作
    if (self.userFlightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightDrawerSuccessful){
        
        /**
         ///用户去改签
         #define KBtnForChangedButtonTag             (1340113)
         ///用户去退票
         #define KBtnForReturnedTicketButtonTag      (1340114)
         **/
        
        
        
        UIButton *btnForChangedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForChangedButton setBackgroundColor:[UIColor clearColor]];
        [btnForChangedButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                      forState:UIControlStateNormal];
        [btnForChangedButton setBackgroundImage:createImageWithColor(HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f))
                                      forState:UIControlStateHighlighted];
        [btnForChangedButton setTitleColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f) forState:UIControlStateNormal];
        [btnForChangedButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [btnForChangedButton setTag:KBtnForChangedButtonTag];
        [btnForChangedButton setTitle:@"改 签" forState:UIControlStateNormal];
        [btnForChangedButton.layer setCornerRadius:4.0f];
        [btnForChangedButton.layer setBorderColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f).CGColor];
        [btnForChangedButton.layer setBorderWidth:1.0f];
        [btnForChangedButton.layer setMasksToBounds:YES];
        [btnForChangedButton addTarget:self action:@selector(userPersonalOperaionButtonEvent:)
                     forControlEvents:UIControlEventTouchUpInside];
        
        [btnForChangedButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(280.0f)),
                                                (orderCreateBaseInforView.bottom + KXCUIControlSizeWidth(30.0f)),
                                                (KXCUIControlSizeWidth(100.0f)),
                                                KXCUIControlSizeWidth(32.0f))];
        [mainView addSubview:btnForChangedButton];
        
        
        
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
        
        [btnForRefundButton setFrame:CGRectMake((btnForChangedButton.right + KXCUIControlSizeWidth(40)),
                                                (orderCreateBaseInforView.bottom + KXCUIControlSizeWidth(30.0f)),
                                                (KXCUIControlSizeWidth(100.0f)),
                                                KXCUIControlSizeWidth(32.0f))];
        [mainView addSubview:btnForRefundButton];
        
        [mainView setContentSize:CGSizeMake(KProjectScreenWidth, btnForRefundButton.bottom + 80.0f)];
        
    }

}


- (void)userPersonalOperaionButtonEvent:(UIButton *)button{
    
    
    ///查询详情信息
    if (button.tag == KBtnForExpenseButtonTag) {
        
    }
    ///立即支付信息
    else if (button.tag == KBtnForGotoPayButtonTag) {
        
    }
    ///改签飞机票
    else if (button.tag == KBtnForChangedButtonTag) {
        
        [XCAPPHTTPClient flightOrderUserCancelFlightOrderOperationUserId:KXCAPPCurrentUserInformation.userPerId orderid:self.userFlightOrderInfor.fliOrderIdStr completion:^(WebAPIResponse *response) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    
                    NSString *errorStr = [NSString stringWithFormat:@"【正确内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FinishMBProgressHUD(HUIKeyWindow);
                    NSLog(@"response.responseObject【确认担保支付】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                    
                    
                }else{
                    
                    NSString *errorStr = [NSString stringWithFormat:@"%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FailedMBProgressHUD(HUIKeyWindow,errorStr);
                    NSLog(@"response.responseObject【确认担保支付】【错误内容】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                }
                
            });
        }];
    }
    ///退票操作
    else if (button.tag == KBtnForReturnedTicketButtonTag){
        
        [XCAPPHTTPClient flightOrderUserChangeFlightOrderOperationUserId:KXCAPPCurrentUserInformation.userPerId orderid:self.userFlightOrderInfor.fliOrderIdStr completion:^(WebAPIResponse *response) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    
                    NSString *errorStr = [NSString stringWithFormat:@"【正确内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    FinishMBProgressHUD(HUIKeyWindow);
                    NSLog(@"response.responseObject【确认担保支付】 is %@\nerrorStr is %@",response.responseObject,errorStr);
                    
                   
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
