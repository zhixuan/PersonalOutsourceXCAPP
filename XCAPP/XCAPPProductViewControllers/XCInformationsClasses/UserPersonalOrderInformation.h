//
//  UserPersonalOrderInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>

///用户全部订单信息
@interface UserPersonalOrderInformation : NSObject

/*!
 * @breif 订单类别
 * @See
 */
@property (nonatomic , assign)      XCAPPOrderStyle         userOrderStyle;

/*!
 * @breif 用户个人身份说明
 * @See
 */
@property (nonatomic , assign)      XCAPPUserOptionRoleStyle        userOptionRoleStyle;

/*!
 * @breif 酒店订单
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation   *hotelOrderInfor;


/*!
 * @breif 飞机票订单
 * @See
 */
@property (nonatomic , strong)      FlightOrderInformation   *flightOrderInfor;


/*!
 * @breif 火车票订单
 * @See
 */
@property (nonatomic , strong)      TrainticketOrderInformation   *trainticketOrderInfor;


- (id)init;


/**
 *  @method
 *
 *  @brief          初始化用户订单列信息
 *
 */
+ (id)initializaionWithUserAllOrderInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor;
@end
//+_+QQ 10990 28580
