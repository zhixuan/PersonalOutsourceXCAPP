//
//  PerOrderTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "PerOrderTableViewCell.h"

@interface PerOrderTableViewCell ()
/*!
 * @breif 订单背景图
 * @See
 */
@property (nonatomic , weak)      UIView                *orderBackGroundView;

/*!
 * @breif 订单头部状态视图
 * @See
 */
@property (nonatomic , weak)      UIView                *orderHeaderTitleView;

/*!
 * @breif 订单当前支付状态
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderPayStateLabel;

/*!
 * @breif 订单支付的全部金额
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderPaytotalSumLabel;

/*!
 * @breif 订单酒店名字及位置
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderHotelNameLabel;

/*!
 * @breif 订单酒店入住时间
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderHotelMoveIntoDateLabel;

/*!
 * @breif 订单中航班信息
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderFlightInforLabel;


/*!
 * @breif 预订该信息用户的真实名字和电话
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderReserveRealNamePhoneLabel;

/*!
 * @breif 订单数据信息
 * @See
 */
@property (nonatomic , strong) UserPersonalOrderInformation *cellOrderDataSource;

@end

@implementation PerOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /*
         //设置选中Cell后的背景图
         UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
         KPerOrderTableViewCellHeight)];
         [selectedView setBackgroundColor:KTableViewCellSelectedColor];
         self.selectedBackgroundView = selectedView;
         self.backgroundColor =  [UIColor clearColor];
         
         UIView *orderBackGround = [[UIView alloc]init];
         [orderBackGround setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f),KInforLeftIntervalWidth,
         (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
         KPerOrderTableViewCellContentHeight)];
         [orderBackGround setBackgroundColor:[UIColor whiteColor]];
         [orderBackGround.layer setCornerRadius:5.0f];
         [orderBackGround.layer setMasksToBounds:YES];
         self.orderBackGroundView = orderBackGround;
         [self.contentView addSubview:self.orderBackGroundView];
         */
        
        
        
        BOOL isAdminBool = KXCAPPCurrentUserInformation.userOptionRoleStyle == OptionRoleStyleForAdministration?YES:NO;
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        (isAdminBool?KPerOrderCellHeightForAdministration:KPerOrderCellHeightForGuest))];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor clearColor];
        
        UIView *orderBackGround = [[UIView alloc]init];
        [orderBackGround setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f),KInforLeftIntervalWidth,
                                             (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                             (isAdminBool?KPerOrderCellContentHeightForAdministration:KPerOrderCellContentHeightForGuest))];
        [orderBackGround setBackgroundColor:[UIColor whiteColor]];
        [orderBackGround.layer setCornerRadius:5.0f];
        [orderBackGround.layer setMasksToBounds:YES];
        self.orderBackGroundView = orderBackGround;
        [self.contentView addSubview:self.orderBackGroundView];
        
        UIView *headerBGView = [[UIView alloc]init];
        [headerBGView setBackgroundColor:HUIRGBColor(092.0f, 156.0f, 235.0f, 1.0f)];
        [headerBGView setFrame:CGRectMake(0.0f, 0.0f,
                                          (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                          KFunctionModulButtonHeight)];
        self.orderHeaderTitleView = headerBGView;
        [self.orderBackGroundView addSubview:self.orderHeaderTitleView];
        
        
        ///订单状态
        UILabel *statLabel = [[UILabel alloc]init];
        [statLabel setBackgroundColor:[UIColor clearColor]];
        [statLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [statLabel setTextAlignment:NSTextAlignmentLeft];
        [statLabel setTextColor:[UIColor whiteColor]];
        [statLabel setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f), 0.0f,
                                       KXCUIControlSizeWidth(200.0f), KFunctionModulButtonHeight)];
        self.orderPayStateLabel = statLabel;
        [self.orderHeaderTitleView addSubview:self.orderPayStateLabel];
        
        
        ///订单总价格
        UILabel *priceSumLabel = [[UILabel alloc]init];
        [priceSumLabel setBackgroundColor:[UIColor clearColor]];
        [priceSumLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        [priceSumLabel setTextAlignment:NSTextAlignmentRight];
        [priceSumLabel setTextColor:[UIColor whiteColor]];
        [priceSumLabel setFrame:CGRectMake((self.orderHeaderTitleView.width - KXCUIControlSizeWidth(110.0f)), 0.0f,
                                           KXCUIControlSizeWidth(100.0f), KFunctionModulButtonHeight)];
        self.orderPaytotalSumLabel = priceSumLabel;
        [self.orderHeaderTitleView addSubview:self.orderPaytotalSumLabel];
        
        
        ///酒店名字
        UILabel *hotelNameLabel = [[UILabel alloc]init];
        [hotelNameLabel setBackgroundColor:[UIColor clearColor]];
        [hotelNameLabel setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [hotelNameLabel setTextAlignment:NSTextAlignmentLeft];
        [hotelNameLabel setTextColor:KContentTextColor];
        self.orderHotelNameLabel = hotelNameLabel;
        [self.orderBackGroundView addSubview:self.orderHotelNameLabel];
        
        ///入住时间
        UILabel *moveintoDateLabel = [[UILabel alloc]init];
        [moveintoDateLabel setBackgroundColor:[UIColor clearColor]];
        [moveintoDateLabel setFont:KXCAPPUIContentFontSize(13.0f)];
        [moveintoDateLabel setTextAlignment:NSTextAlignmentLeft];
        [moveintoDateLabel setTextColor:KSubTitleTextColor];
        self.orderHotelMoveIntoDateLabel = moveintoDateLabel;
        [self.orderBackGroundView addSubview:self.orderHotelMoveIntoDateLabel];
        
//        orderFlightInforLabel
        
        ///航班信息
        UILabel *flightInforLabel = [[UILabel alloc]init];
        [flightInforLabel setBackgroundColor:[UIColor clearColor]];
        [flightInforLabel setFont:KXCAPPUIContentFontSize(13.0f)];
        [flightInforLabel setTextAlignment:NSTextAlignmentLeft];
        [flightInforLabel setTextColor:KSubTitleTextColor];
        self.orderFlightInforLabel = flightInforLabel;
        [self.orderBackGroundView addSubview:self.orderFlightInforLabel];
        
        ///真实姓名和电话
        UILabel *realNamePhoneLabel = [[UILabel alloc]init];
        [realNamePhoneLabel setBackgroundColor:[UIColor clearColor]];
        [realNamePhoneLabel setFont:KXCAPPUIContentFontSize(13.0f)];
        [realNamePhoneLabel setTextAlignment:NSTextAlignmentLeft];
        [realNamePhoneLabel setTextColor:KSubTitleTextColor];
        self.orderReserveRealNamePhoneLabel = realNamePhoneLabel;
        [self.orderBackGroundView addSubview:self.orderReserveRealNamePhoneLabel];
        
    }
    
    return self;
}



- (void)clearDataInfor{
    [self.orderPayStateLabel setText:@""];
    [self.orderPaytotalSumLabel setText:@""];
    [self.orderHotelNameLabel setText:@""];
    [self.orderHotelMoveIntoDateLabel setText:@""];
    [self.orderReserveRealNamePhoneLabel setText:@""];
}

- (void)setupPerOrderTableViewCellDataSource:(UserPersonalOrderInformation *)itemData
                                   indexPath:(NSIndexPath *)indexPath{
    
    
    if (itemData == nil) {
        return;
    }
    self.cellOrderDataSource = itemData;
    
    [self clearDataInfor];
    [self.orderFlightInforLabel setHidden:YES];
    if (itemData.userOrderStyle == XCAPPOrderHotelForStyle) {

        
//        OrderStateForHotelNullConfirmNullPay = 0,                           /**< == 0   待确认，未支付 */
//        OrderStateForHotelNullConfirmAlreadyPay,                            /**< == 1   待确认，已支付 */
//        OrderStateForHotelAlreadyConfirmNullPay,                            /**< == 2   已确认，未支付 */
//        OrderStateForHotelAlreadyConfirmAlreadyPay,                         /**< == 3   已确认，已支付 */
//        OrderStateForHotelAlreadyArrangeRoom,                               /**< == 4   已排房 */
//        OrderStateForHotelAlreadyLeave,                                     /**< == 5   已离店 */
//        OrderStateForHotelRefuse,                                           /**< == 6   拒单-已取消，已退款 */
//        OrderStateForHotelAlreadyCancleAlreadyRefund,                       /**< == 7   已取消，已退款 */
//        OrderStateForHotelAlreadyAutomaticCancel,                           /**< == 8   已取消，未支付 系统自动取消 */
//        OrderStateForHotelAlreadyCancelByUser,                              /**< == 9   已取消，未支付 用户取消 */
        if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelNullConfirmNullPay) {
            [self.orderPayStateLabel setText:@"待确认,未支付(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelNullConfirmAlreadyPay){
            [self.orderPayStateLabel setText:@"待确认，已支付(酒店)"];
        }
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyConfirmNullPay){
            [self.orderPayStateLabel setText:@"已确认，未支付(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyConfirmAlreadyPay){
            [self.orderPayStateLabel setText:@"已确认，已支付(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyArrangeRoom){
            [self.orderPayStateLabel setText:@"已排房(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyLeave){
            [self.orderPayStateLabel setText:@"已离店(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelRefuse){
            [self.orderPayStateLabel setText:@"拒单(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyCancleAlreadyRefund){
            [self.orderPayStateLabel setText:@"已取消，已退款(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyAutomaticCancel){
            [self.orderPayStateLabel setText:@"已自动取消(酒店)"];
        }
        
        else if (itemData.hotelOrderInfor.orderHotelPayState == OrderStateForHotelAlreadyCancelByUser){
            [self.orderPayStateLabel setText:@"已取消(酒店)"];
        }
        
        
        NSString *totolSumStr = [NSString stringWithFormat:@"￥%@",itemData.hotelOrderInfor.orderPaySumTotal];
        [self.orderPaytotalSumLabel setText:totolSumStr];
        
        NSString *hotelNameStr = itemData.hotelOrderInfor.orderHotelInforation.hotelNameContentStr;
        [self.orderHotelNameLabel setText:hotelNameStr];
        
        [self.orderHotelMoveIntoDateLabel setText:[NSString stringWithFormat:@"%@ 入住",itemData.hotelOrderInfor.orderUserMoveIntoDate]];
        
        NSString *userinforStr = [NSString stringWithFormat:@"预订人: %@ %@",        itemData.hotelOrderInfor.orderCreateUserInfor.userNickNameStr,itemData.hotelOrderInfor.orderCreateUserInfor.userPerPhoneNumberStr];
        [self.orderReserveRealNamePhoneLabel setText:userinforStr];
        
    }else if (itemData.userOrderStyle == XCAPPOrderForTrainTicketStyle){
        
        
//        OrderStateForTTicketNullPay = 0,                    /**< == 0   未支付 */
//        OrderStateForTTicketAlreadyPay,                     /**< == 1   出票中，已支付 */
//        OrderStateForTTicketAlreadySoldAndPay,              /**< == 2   已出票，已支付 */
//        OrderStateForTTicketNullPayAndAutomaticCancel,      /**< == 3   未支付，自动取消 */
//        OrderStateForTTicketAlreadyCancelAndRefund,         /**< == 4   已取消，已退款 */
//        OrderStateForTTicketSoldFailureAndRefund,           /**< == 5   出票失败，已退款 */
//        OrderStateForTTicketApplyRefundOperation,           /**< == 6   申请退票 **/
//        OrderStateForTTicketRefundSuccessful,              /**< == 7   退票成功已退款 */
//        OrderStateForTTicketRefundFailure,                  /**< == 8   退票失败 */
        if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketNullPay) {
            [self.orderPayStateLabel setText:@"未支付(火车票)"];
        }
        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketAlreadyPay){
            [self.orderPayStateLabel setText:@"出票中，已支付(火车票)"];
        }
        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketAlreadySoldAndPay){
            [self.orderPayStateLabel setText:@"已出票，已支付(火车票)"];
        }

        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketNullPayAndAutomaticCancel){
            [self.orderPayStateLabel setText:@"未支付，自动取消(火车票)"];
        }
        
        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketAlreadyCancelAndRefund){
            [self.orderPayStateLabel setText:@"已取消，已退款(火车票)"];
        }

        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketSoldFailureAndRefund){
            [self.orderPayStateLabel setText:@"出票失败，已退款(火车票)"];
        }
        
        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketApplyRefundOperation){
            [self.orderPayStateLabel setText:@"已申请退票(火车票)"];
        }
        
        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketRefundSuccessful){
            [self.orderPayStateLabel setText:@"退票成功，已退款(火车票)"];
        }
        
        else if (itemData.trainticketOrderInfor.ttOrderStateStyle ==OrderStateForTTicketRefundFailure){
            [self.orderPayStateLabel setText:@"退票失败(火车票)"];
        }
        else{
            [self.orderPayStateLabel setText:@"待支付(火车票)"];
        }
        
        NSString *totolSumStr = [NSString stringWithFormat:@"￥%.1lf",itemData.trainticketOrderInfor.ttTicketTotalVolume];
        [self.orderPaytotalSumLabel setText:totolSumStr];
        
        NSString *trainAddressInforNameStr = [NSString stringWithFormat:@"%@ - %@",itemData.trainticketOrderInfor.ttOrderTrainticketInfor.traTakeOffSite,itemData.trainticketOrderInfor.ttOrderTrainticketInfor.traArrivedSite];
        
        [self.orderHotelNameLabel setText:trainAddressInforNameStr];
        NSString *trainBeginGo = [NSString stringWithFormat:@"%@ 出发",itemData.trainticketOrderInfor.ttOrderDepartDate];
        [self.orderHotelMoveIntoDateLabel setText:trainBeginGo];
        
        NSString *userinforStr = [NSString stringWithFormat:@"预订人: %@ %@",itemData.trainticketOrderInfor.ttOrderReserveUserInfor.userNickNameStr,itemData.trainticketOrderInfor.ttOrderReserveUserInfor.userPerPhoneNumberStr];
        [self.orderReserveRealNamePhoneLabel setText:userinforStr];
        
    }else if (itemData.userOrderStyle == XCAPPOrderForFlightStyle){
        

        /**< == 0   待确认，未支付 */
        if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightWaitForConfirm) {
            [self.orderPayStateLabel setText:@"待确认，未支付(飞机票)"];
        }
        /**< == 1   出票中，已支付 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightWaitDrawer){
            
           [self.orderPayStateLabel setText:@"出票中，已支付(飞机票)"];
        }
        
        /**< == 2   出票成功，已支付 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightDrawerSuccessful){
           [self.orderPayStateLabel setText:@"出票成功，已支付(飞机票)"];
        }
        
        /**< == 3   出票失败，已退款 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightDrawerFailure){
            [self.orderPayStateLabel setText:@"出票失败，已退款(飞机票)"];
        }
        
        /**< == 4   已取消（自动取消）-未支付，自动取消 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightAutomaticCancel){
            [self.orderPayStateLabel setText:@"已取消（自动取消）(飞机票)"];
        }
        
        /**< == 5   改签申请，等待审核 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedWaitCheck){
            [self.orderPayStateLabel setText:@"改签申请，等待审核(飞机票)"];
        }
        
        /**< == 6   改签成功，补差价 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedSuccessful){
            [self.orderPayStateLabel setText:@"改签成功，补差价(飞机票)"];
        }
        
        /**< == 7   已改签，已支付 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedSuccessfulAndPay){

            [self.orderPayStateLabel setText:@"已改签，已支付(飞机票)"];
        }
        
        /**< == 8   改签申请审核失败 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightChangedCheckFailure){
            [self.orderPayStateLabel setText:@"改签申请审核失败(飞机票)"];
        }
        
        /**< == 9   退票申请，等待审核 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightRefundWaitCheck){
            [self.orderPayStateLabel setText:@"退票申请，等待审核(飞机票)"];
        }
        
        /**< == 10  退票申请成功，已退票-已退款*/
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightRefundSuccessful){
            [self.orderPayStateLabel setText:@"已退票-已退款(飞机票)"];
        }
        
        /**< == 11 退票申请，审核失败 */
        else if (itemData.flightOrderInfor.fliOrderForFlightPayStyle == OrderStateForFlightRefundCheckFailure){
            [self.orderPayStateLabel setText:@"退票申请，审核失败(飞机票)"];
        }
        
        [self.orderFlightInforLabel setHidden:NO];
        NSString *flightBeginEndAddressStr = [NSString stringWithFormat:@"%@ - %@",itemData.flightOrderInfor.fliOrderTakeOffSite,itemData.flightOrderInfor.fliOrderArrivedSite];
        
        [self.orderHotelNameLabel setText:flightBeginEndAddressStr];
        
        NSString *flightDateInfor = [NSString stringWithFormat:@"%@ %@ - %@",itemData.flightOrderInfor.fliOrderTakeOffDate,itemData.flightOrderInfor.fliOrderOneWayInfor.flightTakeOffTime,itemData.flightOrderInfor.fliOrderOneWayInfor.flightArrivedTime];
        [self.orderHotelMoveIntoDateLabel setText:flightDateInfor];
        
        NSString *flightInforStr = [NSString stringWithFormat:@"%@  |  %@  |  %@",itemData.flightOrderInfor.fliOrderOneWayInfor.flightName,itemData.flightOrderInfor.fliOrderOneWayInfor.flightModelName,itemData.flightOrderInfor.fliOrderOneWayInfor.flightCabinModelStr];
        [self.orderFlightInforLabel setText:flightInforStr];
        
        NSString *userinforStr = [NSString stringWithFormat:@"预订人: %@ %@",itemData.flightOrderInfor.flightOrderCreateUserInfor.userNameStr,itemData.flightOrderInfor.flightOrderCreateUserInfor.userPerPhoneNumberStr];
        [self.orderReserveRealNamePhoneLabel setText:userinforStr];
    }
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    if (self.cellOrderDataSource.userOrderStyle == XCAPPOrderHotelForStyle ||
        self.cellOrderDataSource.userOrderStyle == XCAPPOrderForTrainTicketStyle)
    {
        
        [self.orderHotelNameLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                      (KFunctionModulButtonHeight + KXCUIControlSizeWidth(5.0f)),
                                                      (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                      KXCUIControlSizeWidth(30.0f))];
        
        [self.orderHotelMoveIntoDateLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                              (self.orderHotelNameLabel.bottom),
                                                              (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                              KXCUIControlSizeWidth(25.0f))];
        if (!IsStringEmptyOrNull(self.orderReserveRealNamePhoneLabel.text)) {
            [self.orderReserveRealNamePhoneLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                                     self.orderHotelMoveIntoDateLabel.bottom,
                                                                     (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                                     KXCUIControlSizeWidth(25.0f))];
            
        }
    }
    else if (self.cellOrderDataSource.userOrderStyle == XCAPPOrderForFlightStyle){
        
        
        [self.orderHotelNameLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                      (KFunctionModulButtonHeight + KXCUIControlSizeWidth(5.0f)),
                                                      (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                      KXCUIControlSizeWidth(23.0f))];
        
        [self.orderHotelMoveIntoDateLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                              (self.orderHotelNameLabel.bottom),
                                                              (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                              KXCUIControlSizeWidth(18.0f))];
        
        [self.orderFlightInforLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                        self.orderHotelMoveIntoDateLabel.bottom,
                                                        (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                        KXCUIControlSizeWidth(18.0f))];
        if (!IsStringEmptyOrNull(self.orderReserveRealNamePhoneLabel.text)) {
            [self.orderReserveRealNamePhoneLabel setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)),
                                                                     self.orderFlightInforLabel.bottom,
                                                                     (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)),
                                                                     KXCUIControlSizeWidth(18.0f))];
            
        }
    }
}

@end
