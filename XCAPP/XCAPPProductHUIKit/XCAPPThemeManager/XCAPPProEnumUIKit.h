//
//  XCAPPProEnumUIKit.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef XCAPPProEnumUIKit_h
#define XCAPPProEnumUIKit_h



/**
 *  @ENUM
 *
 *  @brief          XCAPPUserGenderStyle                                用户性别信息
 *
 *  @param          GenderForNullStyle = 0                              未知性别信息
 *
 *  @param          GenderStyleForMaleStyle = 1                         男性性别
 *
 *  @param          GenderStyleForFemaleStyle = 2                       女性性别
 *
 *  @param          GenderStyleForDefautStyle = 1                       默认男性性别
 *
 *  @see
 *
 */
typedef NS_ENUM(NSInteger, XCAPPUserGenderStyle){
    GenderForNullStyle = 0 ,                                            /**< == 0   未知性别信息*/
    GenderStyleForMaleStyle = 1,                                        /**< == 1   男性性别 */
    GenderStyleForFemaleStyle = 2,                                      /**< == 2   女性性别*/
    GenderStyleForDefautStyle = GenderStyleForFemaleStyle,              /**< == 1   男性性别 */
};

/**
 *  @ENUM
 *
 *  @brief          XCAPPUserOptionRoleStyle                            用户权限信息
 *
 *  @param          OptionRoleStyleForAdministration = 1                管理员角色
 *
 *  @param          OptionRoleStyleForGuestStyle = 2                    二级权限角色
 *
 *  @param          OptionRoleStyleForDefautStyle = 2                   默认为二级权限角色
 *
 *  @see
 *
 */
typedef NS_ENUM(NSInteger, XCAPPUserOptionRoleStyle){
    OptionRoleStyleForGuestStyle = 0,                                   /**< == 2   二级权限角色*/
    OptionRoleStyleForDefautStyle = OptionRoleStyleForGuestStyle,       /**< == 2   二级权限角色 */
    OptionRoleStyleForAdministration = 7,                               /**< == 1   管理员角色 */
};


/**
 *  @ENUM
 *
 *  @brief          UserMatterStateStyle                                用户出行种类
 *
 *  @param          MatterStateStyleForOfficialBusinessStyle = 0        用户以公事出行
 *
 *  @param          MatterStateStyleForPrivateConcernStyle = 1          用户以私事出行
 *
 *  @see
 *
 */

typedef NS_ENUM(NSInteger, UserMatterStateStyle){
    MatterStateStyleForOfficialBusinessStyle = 0,                       /**< == 0   用户以公事出行 */
    MatterStateStyleForPrivateConcernStyle = 1,                         /**< == 1   用户以私事出行 */
};

/**
 *  @ENUM
 *
 *  @brief          酒店订单状态信息
 *
 *  @param          OrderStateForHotelNullConfirmNullPay                = 0   待确认，未支付
 *
 *  @param          OrderStateForHotelNullConfirmAlreadyPay             = 1   待确认，已支付 *
 *
 *  @param          OrderStateForHotelAlreadyConfirmNullPay             = 2   已确认，未支付 *
 *
 *  @param          OrderStateForHotelAlreadyConfirmAlreadyPay          = 3   已确认，已支付 *
 *
 *  @param          OrderStateForHotelAlreadyArrangeRoom                = 4   已排房 *
 *
 *  @param          OrderStateForHotelAlreadyLeave                      = 5   已离店 *
 *
 *  @param          OrderStateForHotelRefuse                            = 6   拒单-已取消，已退款 *
 *
 *  @param          OrderStateForHotelAlreadyCancleAlreadyRefund        = 7   已取消，已退款 *
 *
 *  @param          OrderStateForHotelAlreadyAutomaticCancel            = 8   已取消，未支付 系统自动取消 *
 *
 *  @param          OrderStateForHotelAlreadyCancelByUser               = 9   已取消，未支付 用户取消 *
 *
 *  @see
 *
 */

typedef NS_ENUM(NSInteger, XCAPPOrderForHotelPayStyle){
    OrderStateForHotelNullConfirmNullPay = 0,                           /**< == 0   待确认，未支付 */
    OrderStateForHotelNullConfirmAlreadyPay,                            /**< == 1   待确认，已支付 */
    OrderStateForHotelAlreadyConfirmNullPay,                            /**< == 2   已确认，未支付 */
    OrderStateForHotelAlreadyConfirmAlreadyPay,                         /**< == 3   已确认，已支付 */
    OrderStateForHotelAlreadyArrangeRoom,                               /**< == 4   已排房 */
    OrderStateForHotelAlreadyLeave,                                     /**< == 5   已离店 */
    OrderStateForHotelRefuse,                                           /**< == 6   拒单-已取消，已退款 */
    OrderStateForHotelAlreadyCancleAlreadyRefund,                       /**< == 7   已取消，已退款 */
    OrderStateForHotelAlreadyAutomaticCancel,                           /**< == 8   已取消，未支付 系统自动取消 */
    OrderStateForHotelAlreadyCancelByUser,                              /**< == 9   已取消，未支付 用户取消 */
};

/**
 *  @ENUM
 *
 *  @brief          
 *  @param          OrderStateForTTicketNullPay = 0                     未支付
 *  @param          OrderStateForTTicketAlreadyPay = 1                  出票中，已支付
 *  @param          OrderStateForTTicketAlreadySoldAndPay = 2           已出票，已支付
 *  @param          OrderStateForTTicketNullPayAndAutomaticCancel = 3   未支付，自动取消
 *  @param          OrderStateForTTicketAlreadyCancelAndRefund = 4      已取消，已退款
 *  @param          OrderStateForTTicketSoldFailureAndRefund = 5        出票失败，已退款
 *  @param          OrderStateForTTicketApplyRefundOperation = 6        申请退票
 *  @param          OrderStateForTTicketRefundSuccessful = 7            退票成功已退款
 *  @param          OrderStateForTTicketRefundFailure = 8               退票失败
 *
 *  @see
 *
 */

typedef NS_ENUM(NSInteger, XCAPPOrderForTrainTicketPayStyle){
    
    OrderStateForTTicketNullPay = 0,                    /**< == 0   未支付 */
    OrderStateForTTicketAlreadyPay,                     /**< == 1   出票中，已支付 */
    OrderStateForTTicketAlreadySoldAndPay,              /**< == 2   已出票，已支付 */
    OrderStateForTTicketNullPayAndAutomaticCancel,      /**< == 3   未支付，自动取消 */
    OrderStateForTTicketAlreadyCancelAndRefund,         /**< == 4   已取消，已退款 */
    OrderStateForTTicketSoldFailureAndRefund,           /**< == 5   出票失败，已退款 */
    OrderStateForTTicketApplyRefundOperation,           /**< == 6   申请退票 **/
     OrderStateForTTicketRefundSuccessful,              /**< == 7   退票成功已退款 */
    OrderStateForTTicketRefundFailure,                  /**< == 8   退票失败 */
};

/**
 *  @ENUM
 *
 *  @brief          XCAPPOrderForFlightPayStyle                             系统中用户订单状态信息
 *
 *  @param              OrderStateForFlightWaitForConfirm   = 0             待确认，未支付
 *
 *  @param              OrderStateForFlightWaitDrawer       = 1             出票中，已支付
 *
 *  @param              OrderStateForFlightDrawerSuccessful = 2             出票成功，已支付
 *
 *  @param              OrderStateForFlightDrawerFailure    = 3             出票失败，已退款
 *
 *  @param              OrderStateForFlightAutomaticCancel  = 4             已取消（自动取消）-未支付，自动取消
 *
//改签状态
 *  @param              OrderStateForFlightChangedWaitCheck = 5             改签申请，等待审核
 *
 *  @param              OrderStateForFlightChangedSuccessful   = 6             改签成功，补差价
 *
 *  @param              OrderStateForFlightChangedSuccessfulAndPay    = 7   已改签，已支付
 *
 *  @param              OrderStateForFlightChangedCheckFailure  = 8         改签申请审核失败
 *
///退票状态
 *  @param              OrderStateForFlightRefundWaitCheck  = 9             退票申请，等待审核
 *
 *  @param              OrderStateForFlightRefundSuccessful = 10            退票申请成功，已退票-已退款
 *
 *  @param              OrderStateForFlightRefundCheckFailure = 11          退票申请，审核失败

 *
 *  @see
 *
 */

typedef NS_ENUM(NSInteger, XCAPPOrderForFlightPayStyle){
    OrderStateForFlightWaitForConfirm,                                  /**< == 0   待确认，未支付 */
    OrderStateForFlightWaitDrawer,                                      /**< == 1   出票中，已支付 */
    OrderStateForFlightDrawerSuccessful,                                /**< == 2   出票成功，已支付 */
    OrderStateForFlightDrawerFailure,                                   /**< == 3   出票失败，已退款 */
    OrderStateForFlightAutomaticCancel,                                 /**< == 4   已取消（自动取消）-未支付，自动取消 */
    
    //改签状态
    OrderStateForFlightChangedWaitCheck,                                /**< == 5   改签申请，等待审核 */
    OrderStateForFlightChangedSuccessful,                               /**< == 6   改签成功，补差价 */
    OrderStateForFlightChangedSuccessfulAndPay,                         /**< == 7   已改签，已支付 */
    OrderStateForFlightChangedCheckFailure,                             /**< == 8   改签申请审核失败 */
    
    ///退票状态
    OrderStateForFlightRefundWaitCheck,                                 /**< == 9   退票申请，等待审核 */
    OrderStateForFlightRefundSuccessful,                                /**< == 10  退票申请成功，已退票-已退款 */
    OrderStateForFlightRefundCheckFailure,                              /**< == 11  退票申请，审核失败 */
    
};

/**
 *  @ENUM
 *
 *  @brief          XCAPPHotelStarStyle                                 酒店星级类别设置
 *
 *  @param          HotelStarForNullStyle = 0,                          酒店星级不限
 *
 *  @param          HotelStarForBelowTwoStarStyle = 1,                  酒店星级 二星及以下
 *
 *  @param          HotelStarForThreeStarStyle = 2 ,                    酒店星级 三星
 *
 *  @param          HotelStarForFourStarStyle = 3 ,                     酒店星级 四星
 *
 *  @param          HotelStarForFiveStarStyle = 4 ,                     酒店星级 五星
 *
 *  @see
 *
 */

typedef NS_ENUM(NSInteger, XCAPPHotelStarStyle){
    HotelStarForNullStyle = 0,                                          /**< == 0   酒店星级不限 */
    HotelStarForBelowTwoStarStyle,                                      /**< == 1   酒店星级 二星及以下 */
    HotelStarForThreeStarStyle,                                         /**< == 2   酒店星级 三星 */
    HotelStarForFourStarStyle,                                          /**< == 3   酒店星级 四星 */
    HotelStarForFiveStarStyle,                                          /**< == 4   酒店星级 五星 */
};

/**
 *  @ENUM
 *
 *  @brief          XCAPPOrderStyle                                     订单信息类别
 *
 *  @param          XCAPPOrderHotelForStyle = 0,                        酒店订单信息
 *
 *  @param          XCAPPOrderForFlightStyle = 1,                       机票订单信息
 *
 *  @param          XCAPPOrderForTrainTicketStyle = 2 ,                 火车票订单信息
 *
 *  @see
 *
 */

typedef NS_ENUM(NSInteger, XCAPPOrderStyle){
    XCAPPOrderHotelForStyle = 0,                                        /**< == 1   酒店订单信息 */
    XCAPPOrderForFlightStyle,                                           /**< == 2   机票订单信息 */
    XCAPPOrderForTrainTicketStyle,                                      /**< == 3   火车票订单信息 */
};

/**
 *  @ENUM
 *
 *  @brief          UserSelectedCityStyle                               城市信息
 *
 *  @param          CityForTakeOffStyle = 0,                            出发城市
 *
 *  @param          CityForArrivedStyle = 1,                            到达地城市
 *
 *  @see
 *
 */
typedef NS_ENUM(NSInteger,UserSelectedCityStyle){
    CityForTakeOffStyle = 0,                                            /**< == 0   出发城市信息 */
    CityForArrivedStyle = 1,                                            /**< == 1   到达地城市信息 */
};


typedef NS_ENUM(NSInteger,BabyGenderStyle){
        GenderForBoyStyle = 0,
        GenderForGirlStyle = 1,
        GenderForUnknownStyle = 2,
};

#endif /* XCAPPProEnumUIKit_h */
