//
//  FlightInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>

///航班信息内容
@interface FlightInformation : NSObject


/*!
 * @breif 航班Id
 * @See
 */
@property (nonatomic , copy)            NSString              *flightIdStr;

/*!
 * @breif 航班名字
 * @See e.g.    中行ZH9822，深航CZ8493，
 */
@property (nonatomic , copy)            NSString              *flightName;


/*!
 * @breif 航班飞机型号
 * @See e.g. 738中型型号，321中型型号，32F中
 */
@property (nonatomic , copy)            NSString              *flightModelName;

/*!
 * @breif 航班起步价格
 * @See e.g     ￥2790起/￥2540起
 */
@property (nonatomic , copy)            NSString              *flightBeginPrice;

/*!
 * @breif 当前航班单价
 * @See     一般为整数
 */
@property (nonatomic , assign)          CGFloat                 flightUnitPrice;

/*!
 * @breif 航班起飞时间
 * @See
 */
@property (nonatomic , copy)            NSString              *flightTakeOffTime;

/*!
 * @breif 航班起飞地点
 * @See e.g.    南苑机场/浦东机场/首都机场
 */
@property (nonatomic , copy)            NSString              *flightTakeOffAirport;

/*!
 * @breif 航班中继地点
 * @See
 */
@property (nonatomic , copy)            NSString              *flightMiddleSite;

/*!
 * @breif 航班到站时间
 * @See
 */
@property (nonatomic , copy)            NSString              *flightArrivedTime;

/*!
 * @breif 航班到达航站名字
 * @See     南苑机场/浦东机场/首都机场
 */
@property (nonatomic , copy)            NSString              *flightArrivedAirport;

/*!
 * @breif 航班舱位型号
 * @See     e.g.   头等舱 经济舱，优惠头等舱/超值头等舱/公务舱等
 */
@property (nonatomic , copy)            NSString              *flightCabinModelStr;

/*!
 * @breif 航班折扣方式
 * @See     e.g.   9.4折，4.4折，全价，半价，无折扣等
 */
@property (nonatomic , copy)            NSString              *flightDiscountStr;

@property (nonatomic , assign)          CGFloat               flightDiscountRateFloat;

/*!
 * @breif 是否提供餐食
 * @See     提供餐食 = YES。。不提供=NO。默认为NO。
 */
@property (nonatomic , assign)          BOOL                 flightProvideBoardBool;

/*!
 * @breif 航班标签
 * @See     e.g     飞行达人/航司直销/商务推荐/..
 */
@property (nonatomic , copy)            NSString              *flightLabelNameStr;

/*!
 * @breif 航班剩余票数
 * @See     e.g.   4张，10张，
 */
@property (nonatomic , assign)          NSInteger               flightStockNumber;

/*!
 * @breif 航班允许退改签票
 * @See     允许退票 = YES，不允许则 = NO；默认为NO；
 */
@property (nonatomic , assign)          BOOL                    flightAllowReturnBool;
/*!
 * @breif 航班允许退改签票
 * @See     退改签信息说明
 */
@property (nonatomic , copy)            NSString                *flightAllowReturnShowStr;

/*!
 * @breif 航班退票条件说明
 * @See
 */
@property (nonatomic , copy)            NSString              *flightReturnExplain;
/*!
 * @breif 航班改签条件说明
 * @See
 */
@property (nonatomic , copy)            NSString              *flightChangeExpStr;

/*!
 * @breif 航班签转条件说明
 * @See
 */
@property (nonatomic , copy)            NSString              *flightExecutedTransferStr;


/*!
 * @breif 航班燃油附加税
 * @See     50/100   人民币
 */
@property (nonatomic , copy)            NSString              *flightBunkerSurcharge;


/*!
 * @breif 航班购票服务费或者运送费
 * @See
 */
@property (nonatomic , copy)            NSString              *flightServeCostStr;

@end
//+_+QQ 10990 28580
