//
//  HotelOrderInfoDetailController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelOrderInfoDetailController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "HTTPClient.h"
#import "HTTPClient+OrderRequest.h"
#import "HTTPClient+HotelsRequest.h"
#import "HotelMapAddressController.h"
#import "OrderExpenseDetailView.h"



#define KOrderLeftContentFont               KXCAPPUIContentFontSize(14.0f)
#define KOrderContentFont                   KXCAPPUIContentDefautFontSize(14.0f)
#define KOrderContentIntervalFloat          (KXCUIControlSizeWidth(23))

#define KOrderwhiteColorContetHeight        (KXCUIControlSizeWidth(36.0f))

#define KBtnForHotelMapButtonTag            (1320101)
#define KBtnForExpenseButtonTag             (1340111)
#define KBtnForGotoPayButtonTag             (1340112)
#define KBtnForCancleOrderButtonTag         (1340113)

#define KAlertForUserReturnedTicketAlertTag (1340211)

@interface HotelOrderInfoDetailController ()<UIAlertViewDelegate>

/*!
 * @breif 订单明细说明
 * @See
 */
@property (nonatomic , weak)        OrderExpenseDetailView              *hotelOrderExpenseDetail;
/*!
 * @breif 状态信息所占用的高度
 * @See
 */
@property (nonatomic , assign)      CGFloat                             userOrderPayStatCellHeightFloat;

/*!
 * @breif 酒店数据信息
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation           *hotelOrderInformation;

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

@implementation HotelOrderInfoDetailController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}


- (id)initWithHotelOrderInfor:(UserHotelOrderInformation *)hotelOrder{
    self = [super init];
    if (self) {
        self.hotelOrderInformation = hotelOrder;
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
    
    self.timeIntervalInteger = 30;
    
    
    ///倒计时及操作按键
    if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelNullConfirmNullPay ||
        self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyConfirmNullPay) {
        self.timeIntervalInteger = (NSInteger)self.hotelOrderInformation.orderPayDownCalculateTimeInterval ;
    }
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    WaittingMBProgressHUD(HUIKeyWindow, @"正在加载订单...");
    [XCAPPHTTPClient orderDetailForHotelOrderWithOrderId:self.hotelOrderInformation.orderNumberStr completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
        
            NSLog(@"%@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    if (dataDictionary.count > 0) {
                        
                        [weakSelf.hotelOrderInformation initializaionWithUserItemHotelOrderDetailInfoWithUnserializedJSONDic:dataDictionary];
                        [weakSelf setupHotelOrderInfoDetailControllerFrame];
                        
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

- (void)setupHotelOrderInfoDetailControllerFrame{

    
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
    [orderTotalMoneyContent setText:[NSString stringWithFormat:@"￥%@",self.hotelOrderInformation.orderPaySumTotal]];
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
    if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelNullConfirmNullPay) {
        [willOrderState setText:@"待确认"];
        [payStateContent setText:@"未支付"];
        orderPayContentStr = @"您的订单已提交，请您尽快完成支付，以便您能安心入住，若未及时支付，订单将在1小时后自动取消！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelNullConfirmAlreadyPay){
        [willOrderState setText:@"待确认"];
        [payStateContent setText:@"已支付"];
        orderPayContentStr = @"您的订单已提交，我们会尽快确认，请耐心等待！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyConfirmNullPay){
        [willOrderState setText:@"待确认"];
        [payStateContent setText:@"未支付"];
        orderPayContentStr = @"您的订单已提交，请您尽快完成支付，以便您能安心入住，若未及时支付，订单将在1小时后自动取消！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyConfirmAlreadyPay){
        [willOrderState setText:@"已确认"];
        [payStateContent setText:@"已支付"];
        orderPayContentStr = @"您的订单已确认，欢迎您入住！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyArrangeRoom){
        [willOrderState setText:@"已排房"];
        [payStateContent setText:@"已支付"];
        orderPayContentStr = @"已为您安排舒适的入住房间，欢迎您入住！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyLeave){
        [willOrderState setText:@"已离店"];
        [payStateContent setText:@"已支付"];
        orderPayContentStr = @"感谢您的入住，欢迎下次再来！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelRefuse){
        [willOrderState setText:@"已取消"];
        [payStateContent setText:@"已退款"];
        orderPayContentStr = @"抱歉的通知您，由于客满，未能为您成功预订，款项已退至您的帐户，退款金额为：¥259，请注意查看，有疑问可致电客服！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyCancleAlreadyRefund){
        [willOrderState setText:@"已取消"];
        [payStateContent setText:@"已退款"];
        orderPayContentStr = @"您的订单已取消，款项已退至您的帐户，退款金额为：¥259，请注意查看，有疑问可致电客服！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyAutomaticCancel){
        [willOrderState setText:@"已取消"];
        [payStateContent setText:@"未支付"];
        orderPayContentStr = @"您的订单已取消！";
    }
    
    else if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyCancelByUser){
        
        [willOrderState setText:@"已取消"];
        [payStateContent setText:@"未支付"];
        orderPayContentStr = @"您的订单已取消！";
    }
    [orderPayStateLabel setText:orderPayContentStr];
    CGSize orderPayContentSize = [orderPayContentStr sizeWithFont:orderPayStateLabel.font
                                                constrainedToSize:CGSizeMake((KProjectScreenWidth - KInforLeftIntervalWidth*4), CGFLOAT_MAX)
                                                    lineBreakMode:NSLineBreakByWordWrapping];
    [orderPayStateLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, orderBaseView.bottom + KInforLeftIntervalWidth, (KProjectScreenWidth - KInforLeftIntervalWidth*4), orderPayContentSize.height)];
    self.userOrderPayStatCellHeightFloat+=orderPayContentSize.height;

    ///倒计时及操作按键
    if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelNullConfirmNullPay ||
        self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyConfirmNullPay) {
        
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
    
    
    ///飞机票信息
    UIView *hotelRoomInforBGView = [[UIView alloc]init];
    [hotelRoomInforBGView setBackgroundColor:[UIColor whiteColor]];
    [hotelRoomInforBGView setFrame:CGRectMake(0.0f,(orderBaseView.bottom +self.userOrderPayStatCellHeightFloat),
                                           KProjectScreenWidth,
                                           (KFunctionModulButtonHeight + KXCUIControlSizeWidth(121.0f)))];
    [mainView addSubview:hotelRoomInforBGView];
    
    ///MARK:初始化酒店信息
    UILabel *hotelNameLabel =  [[UILabel alloc]init];
    [hotelNameLabel setBackgroundColor:[UIColor clearColor]];
    [hotelNameLabel setTextColor:KContentTextColor];
    [hotelNameLabel setText:self.hotelOrderInformation.orderHotelInforation.hotelNameContentStr];
    [hotelNameLabel setTextAlignment:NSTextAlignmentLeft];
    [hotelNameLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [hotelNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                        (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                        KOrderContentIntervalFloat)];
    [hotelRoomInforBGView addSubview:hotelNameLabel];
    
    if (!IsStringEmptyOrNull(self.hotelOrderInformation.orderHotelInforation.hotelAddressRoughStr)) {
        NSString *address = [NSString stringWithFormat:@"%@（%@）",
                             self.hotelOrderInformation.orderHotelInforation.hotelNameContentStr,
                             self.hotelOrderInformation.orderHotelInforation.hotelAddressRoughStr];
        [hotelNameLabel setText:address];
    }
    
    UILabel *hotelAddressLabel =  [[UILabel alloc]init];
    [hotelAddressLabel setBackgroundColor:[UIColor clearColor]];
    [hotelAddressLabel setTextColor:KContentTextColor];
    NSString *address = [NSString stringWithFormat:@"地址:%@",
                         self.hotelOrderInformation.orderHotelInforation.hotelAddressRoughStr];
    [hotelAddressLabel setText:address];
    [hotelAddressLabel setFont:KXCAPPUIContentFontSize(13.0f)];
    CGSize hotelAddressSize = [address sizeWithFont:KXCAPPUIContentFontSize(15.0f)];
    [hotelAddressLabel setTextAlignment:NSTextAlignmentLeft];
    [hotelAddressLabel setFrame:CGRectMake(KInforLeftIntervalWidth, hotelNameLabel.bottom,
                                           (hotelAddressSize.width+5.0f),
                                           KOrderContentIntervalFloat)];
    [hotelRoomInforBGView addSubview:hotelAddressLabel];
    
    UIButton *addressBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn setBackgroundColor:[UIColor redColor]];
    [addressBtn setFrame:CGRectMake((hotelAddressLabel.right + 5.0f),
                                    (hotelAddressLabel.top - 7.5f),
                                    (KOrderContentIntervalFloat +15.0f), (KOrderContentIntervalFloat+15.0f))];
    addressBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [addressBtn.titleLabel setFont:[UIFont fontAwesomeFontOfSize:(15.0f)]];
    [addressBtn simpleButtonWithImageColor:KDefaultNavigationWhiteBackGroundColor];
    [addressBtn setAwesomeIcon:FMIconLocation];
    [addressBtn addTarget:self action:@selector(userPersonalOperaionButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [addressBtn setTag:KBtnForHotelMapButtonTag];
    [hotelRoomInforBGView addSubview:addressBtn];
    
    UILabel *roomInfoLabel =  [[UILabel alloc]init];
    [roomInfoLabel setBackgroundColor:[UIColor clearColor]];
    [roomInfoLabel setTextColor:KContentTextColor];
    NSString *roomInforStr = [NSString stringWithFormat:@"%@ %zi × %@",
                              self.hotelOrderInformation.orderHotelInforation.hotelRoomBerthContent,
                              self.hotelOrderInformation.orderRoomQuantityInteger,
                              self.hotelOrderInformation.orderHotelInforation.hotelMorningMealContent];
    [roomInfoLabel setText:roomInforStr];
    [roomInfoLabel setFont:KXCAPPUIContentFontSize(13.0f)];
    [roomInfoLabel setTextAlignment:NSTextAlignmentLeft];
    [roomInfoLabel setFrame:CGRectMake(KInforLeftIntervalWidth, hotelAddressLabel.bottom,
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KOrderContentIntervalFloat)];
    [hotelRoomInforBGView addSubview:roomInfoLabel];
    
    
    UILabel *beginEndLabel =  [[UILabel alloc]init];
    [beginEndLabel setBackgroundColor:[UIColor clearColor]];
    [beginEndLabel setTextColor:KContentTextColor];
    NSString *beginEndInforStr = [NSString stringWithFormat:@"%@ 至 %@（%zi晚）",
                                  self.hotelOrderInformation.orderForHotelBeginDate,
                                  self.hotelOrderInformation.orderForHotelEndDate,
                                  self.hotelOrderInformation.orderStayDayesQuantityInteger];
    [beginEndLabel setText:beginEndInforStr];
    [beginEndLabel setFont:KXCAPPUIContentFontSize(13.0f)];
    [beginEndLabel setTextAlignment:NSTextAlignmentLeft];
    [beginEndLabel setFrame:CGRectMake(KInforLeftIntervalWidth, roomInfoLabel.bottom,
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KOrderContentIntervalFloat)];
    [hotelRoomInforBGView addSubview:beginEndLabel];
    
    UILabel *hotelTelPhone =  [[UILabel alloc]init];
    [hotelTelPhone setBackgroundColor:[UIColor clearColor]];
    [hotelTelPhone setTextColor:KContentTextColor];
    [hotelTelPhone setText:self.hotelOrderInformation.orderHotelInforation.hotelTelPhoneStr];
    [hotelTelPhone setFont:KXCAPPUIContentFontSize(13.0f)];
    [hotelTelPhone setTextAlignment:NSTextAlignmentLeft];
    [hotelTelPhone setFrame:CGRectMake(KInforLeftIntervalWidth, beginEndLabel.bottom,
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KOrderContentIntervalFloat)];
    [hotelRoomInforBGView addSubview:hotelTelPhone];
    [hotelRoomInforBGView setHeight:hotelTelPhone.bottom + KInforLeftIntervalWidth];


    ///MARK:初始化入住人员信息
    UIView *moveInUserBaseView = [[UIView alloc]init];
    [moveInUserBaseView setBackgroundColor:[UIColor whiteColor]];
    [moveInUserBaseView setFrame:CGRectMake(0.0f,(hotelRoomInforBGView.bottom + KXCUIControlSizeWidth(10.0f)),
                                            KProjectScreenWidth,
                                            KOrderwhiteColorContetHeight)];
    [mainView addSubview:moveInUserBaseView];
    UILabel *titleMoveInUser = [[UILabel alloc]init];
    [titleMoveInUser setBackgroundColor:[UIColor clearColor]];
    [titleMoveInUser setTextColor:KSubTitleTextColor];
    [titleMoveInUser setText:[NSString stringWithFormat:@"入住人(%zi人)",
                              self.hotelOrderInformation.orderMoveIntoUsersArray.count]];
    [titleMoveInUser setTextAlignment:NSTextAlignmentLeft];
    [titleMoveInUser setFont:KOrderLeftContentFont];
    [titleMoveInUser setFrame:CGRectMake(KInforLeftIntervalWidth,0.0f,
                                         KXCUIControlSizeWidth(80.0f),  KOrderwhiteColorContetHeight)];
    [moveInUserBaseView addSubview:titleMoveInUser];
    
    NSMutableString *userNameStr = [NSMutableString new];
    for (NSString *userNameItem in self.hotelOrderInformation.orderMoveIntoUsersArray) {
        [userNameStr appendFormat:@"，%@",userNameItem];
    }
    NSString *userNameInforStr = [userNameStr substringFromIndex:1];
    UILabel *titleMoveInContent = [[UILabel alloc]init];
    [titleMoveInContent setBackgroundColor:[UIColor clearColor]];
    [titleMoveInContent setTextColor:KContentTextColor];
    [titleMoveInContent setText:userNameInforStr];
    [titleMoveInContent setTextAlignment:NSTextAlignmentLeft];
    [titleMoveInContent setFont:KOrderContentFont];
    [titleMoveInContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),0.0f,
                                            (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                            KOrderwhiteColorContetHeight)];
    [moveInUserBaseView addSubview:titleMoveInContent];

    
    ///MARK:初始化联系人信息
    UIView *createInUserBaseView = [[UIView alloc]init];
    [createInUserBaseView setBackgroundColor:[UIColor whiteColor]];
    [createInUserBaseView setFrame:CGRectMake(0.0f,(moveInUserBaseView.bottom + KXCUIControlSizeWidth(10.0f)), KProjectScreenWidth, (KOrderContentIntervalFloat*2.6f))];
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
                                  self.hotelOrderInformation.orderContactUserInfor.userPerPhoneNumberStr,
                                  self.hotelOrderInformation.orderContactUserInfor.userPerEmailStr]];
    
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
    [orderNumber setText:self.hotelOrderInformation.orderNumberStr];
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
    [willCreateDateLabel setText:self.hotelOrderInformation.orderCreateDate];
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
    
//    [reserveUserContent setText:@"徐志峰 13896148516"];
    [reserveUserContent setText:[NSString stringWithFormat:@"%@ %@",self.hotelOrderInformation.orderCreateUserInfor.userNameStr,self.hotelOrderInformation.orderCreateUserInfor.userPerPhoneNumberStr]];
    [reserveUserContent setTextAlignment:NSTextAlignmentLeft];
    [reserveUserContent setFont:KOrderContentFont];
    [reserveUserContent setFrame:CGRectMake(KXCUIControlSizeWidth(120),willCreateDateLabel.bottom,
                                            (KProjectScreenWidth - KXCUIControlSizeWidth(120) - KInforLeftIntervalWidth),
                                            KOrderContentIntervalFloat)];
    [orderCreateBaseInforView addSubview:reserveUserContent];
    
    
    if (orderCreateBaseInforView.bottom > self.view.height) {
        [mainView setContentSize:CGSizeMake(KProjectScreenWidth, orderCreateBaseInforView.bottom + 100.0f)];
    }

    if (self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelNullConfirmNullPay ||
        self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelNullConfirmAlreadyPay ||
        self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyConfirmAlreadyPay ||
        self.hotelOrderInformation.orderHotelPayState == OrderStateForHotelAlreadyArrangeRoom){
        
        UIButton *btnForRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForRefundButton setBackgroundColor:[UIColor clearColor]];
        [btnForRefundButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                      forState:UIControlStateNormal];
        [btnForRefundButton setBackgroundImage:createImageWithColor(HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f))
                                      forState:UIControlStateHighlighted];
        [btnForRefundButton setTitleColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f) forState:UIControlStateNormal];
        [btnForRefundButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [btnForRefundButton setTag:KBtnForCancleOrderButtonTag];
        [btnForRefundButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [btnForRefundButton.layer setCornerRadius:4.0f];
        [btnForRefundButton.layer setBorderColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f).CGColor];
        [btnForRefundButton.layer setBorderWidth:1.0f];
        [btnForRefundButton.layer setMasksToBounds:YES];
        [btnForRefundButton addTarget:self action:@selector(userPersonalOperaionButtonEvent:)
                     forControlEvents:UIControlEventTouchUpInside];
        
        [btnForRefundButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(150.0f))/2,
                                                (orderCreateBaseInforView.bottom + KXCUIControlSizeWidth(30.0f)),
                                                (KXCUIControlSizeWidth(150.0f)),
                                                KXCUIControlSizeWidth(32.0f))];
        [mainView addSubview:btnForRefundButton];
        
        [mainView setContentSize:CGSizeMake(KProjectScreenWidth, btnForRefundButton.bottom + 80.0f)];
        
    }

    CGRect detailRect = CGRectMake(KProjectScreenWidth, 0.0f,
                                   KProjectScreenWidth, KProjectScreenHeight);
    OrderExpenseDetailView *orderDetailView = [[OrderExpenseDetailView alloc]initWithFrame:detailRect
                                                                                     order:self.hotelOrderInformation];
    self.hotelOrderExpenseDetail = orderDetailView;
    [self.navigationController.view addSubview:self.hotelOrderExpenseDetail];
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
        
        [self.hotelOrderInformation setOrderHotelPayState: OrderStateForHotelAlreadyAutomaticCancel];
        [self setupHotelOrderInfoDetailControllerFrame];
    }
}


- (void)userPersonalOperaionButtonEvent:(UIButton *)button{
    
    ///查看明细
    if (button.tag == KBtnForExpenseButtonTag) {
        NSLog(@"查看明细");
        [UIView animateWithDuration:0.25 animations:^{
            CGRect detailRect = CGRectMake(0.0f, 0.0f,
                                           KProjectScreenWidth, KProjectScreenHeight);
            [self.hotelOrderExpenseDetail setFrame:detailRect];
        }];
    }
    
    ///查看地图信息
    if (button.tag == KBtnForHotelMapButtonTag) {
        HotelMapAddressController *viewController = [[HotelMapAddressController alloc]initWithHotelInfor:self.hotelOrderInformation.orderHotelInforation];
        [self presentViewController:viewController animated:YES completion:^{
            
        }];
    }
    
    ///立即支付
    else if (button.tag == KBtnForGotoPayButtonTag){
        
        NSLog(@"立即支付操作");
    }
    
    ///退票操作
    else if (button.tag == KBtnForCancleOrderButtonTag){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"您确定要取消订单？" delegate:self cancelButtonTitle:@"点错了" otherButtonTitles:@"取消订单", nil];
        [alertView setTag:KAlertForUserReturnedTicketAlertTag];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == KAlertForUserReturnedTicketAlertTag) {
        
        if (buttonIndex != 0 ) {
            NSLog(@"用户可以进行退票操作了");
            
            [self userPersonalCancelHotelOrderRequestion];
        }
    }
}

- (void)userPersonalCancelHotelOrderRequestion{
    
    __weak __typeof(&*self)weakSelf = self;
    
    WaittingMBProgressHUD(HUIKeyWindow, @"正在取消订单...");
    [XCAPPHTTPClient userOperationHotelOrderForCancelOrderWithOrderID:self.hotelOrderInformation.orderId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"%@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccess) {
       
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                SuccessMBProgressHUD(HUIKeyWindow,@"订单已取消");
                
                [weakSelf.hotelOrderInformation setOrderHotelPayState:OrderStateForHotelAlreadyCancelByUser];
                [weakSelf setupHotelOrderInfoDetailControllerFrame];
                
            }else{
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    if (!IsStringEmptyOrNull(msg)) {
                        FailedMBProgressHUD(HUIKeyWindow,msg);
                    }else{
                        FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                    }
                }
                else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
        });
    }];
}
@end
