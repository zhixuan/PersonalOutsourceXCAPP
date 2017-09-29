//
//  FlightOrderInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>
#import "FlightInformation.h"

@interface FlightOrderInformation : NSObject


/*!
 * @breif 飞机航班订单ID
 * @See
 */
@property (nonatomic , copy)            NSString            *fliOrderIdStr;

/*!
 * @breif 订单是否为往返机票信息
 * @See     若为往返机票则为YES，单程为NO，默认为单程；
 */
@property (nonatomic , assign)          BOOL                fliOrderIsReturnTicketBool;


/*!
 * @breif 订单状态
 * @See
 */
@property (nonatomic , assign)      XCAPPOrderForFlightPayStyle fliOrderForFlightPayStyle;



/*!
 * @breif 订单要求航班出发日期（单程/往返的出发日期，）
 * @See e.g     8月10日周四
 */
@property (nonatomic , copy)            NSString            *fliOrderTakeOffDate;

/*!
 * @breif 飞机航班订单对应的机票信息(单程，或往返中的第一张)
 * @See
 */
@property (nonatomic , strong)          FlightInformation   *fliOrderOneWayInfor;


/*!
 * @breif 航班起飞地点
 * @See
 */
@property (nonatomic , copy)            NSString            *fliOrderTakeOffSite;

/*!
 * @breif 航班到达地点
 * @See
 */
@property (nonatomic , copy)            NSString            *fliOrderArrivedSite;

/*!
 * @breif 飞机航班订单对应的机票信息（返程机票）
 * @See
 */
@property (nonatomic , strong)          FlightInformation   *fliOrderReturnInfor;

/*!
 * @breif 订单要求航班出发日期（返回的出发日期，）
 * @See e.g     8月10日周四
 */
@property (nonatomic , copy)            NSString            *fliOrderReturnTakeOffDate;

/*!
 * @breif 航班舱位型号
 * @See     e.g.   头等舱 经济舱，优惠头等舱/超值头等舱/公务舱等
 */
@property (nonatomic , copy)            NSString            *flightOrderCabinModelStr;

/*!
 * @breif 订单预订人员(这些人将预定飞机票，且不是同一个人)
 * @See
 */
@property (nonatomic , strong)          NSMutableArray      *flightOrderUserMutArray;

#pragma mark -
#pragma mark - 订单联系人信息
/*!
 * @breif 订单联系人信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass    *flightOrderCreateUserInfor;

@end
//+_+QQ 10990 28580
