//
//  TrainticketInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>

/** 火车票信息内容****/
@interface TrainticketInformation : NSObject

/*!
 * @breif 火车票ID
 * @See
 */
@property (nonatomic , strong)          NSString                *traIdStr;

/*!
 * @breif 火车票当前车次名字
 * @See e.g.    K842 / G58 / D2595
 */
@property (nonatomic , strong)          NSString                *traCodeNameStr;

/*!
 * @breif 火车出发时间（只是时间点）
 * @See e.g 07：30
 */
@property (nonatomic , copy)            NSString                *traTakeOffTime;
/*!
 * @breif 火车出发时间（时间字符串）
 * @See e.g 201610121412
 */
@property (nonatomic , copy)            NSString                *traTakeOffTimeSealStr;

/*!
 * @breif 火车出发地点
 * @See
 */
@property (nonatomic , copy)            NSString                *traTakeOffSite;

/*!
 * @breif 火车到达时间（只是时间点）
 * @See e.g 07：30
 */
@property (nonatomic , copy)            NSString                *traArrivedTime;
/*!
 * @breif 火车到达时间（（时间字符串）
 * @See e.g 201610121412
 */
@property (nonatomic , copy)            NSString                *traArrivedTimeSealStr;

/*!
 * @breif 火车到达地点
 * @See
 */
@property (nonatomic , copy)            NSString                *traArrivedSite;

/*!
 * @breif 火车票当前数量
 * @See
 */
@property (nonatomic , copy)            NSString                *traScaleNumber;

/*!
 * @breif 火车票价
 * @See
 */
@property (nonatomic , copy)            NSString                *traUnitPrice;

/*!
 * @breif 火车类型
 * @See     e.g.    普通列车 高速列车
 */
@property (nonatomic , copy)            NSString                *traTypeStr;

/*!
 * @breif 火车票等级
 * @See     e.g. 卧铺，软卧，硬座，二等座，商务座
 */
@property (nonatomic , copy)            NSString                *traCabinModelStr;

/*!
 * @breif 火车票两地之间到达时间差
 * @See     e.g.    10小时5分
 */
@property (nonatomic , copy)            NSString                *traTimeInterval;

/*!
 * @breif 火车票两地之间到达时间差
 * @See     e.g.    以分钟为单位，数值信息
 */
@property (nonatomic , assign)         NSInteger                traTimeIntervalInteger;

/*!
 * @breif 火车票购票服务费用信息
 * @See e.g.        ￥ 20/人，，40元
 */
@property (nonatomic , copy)            NSString                *traServiceCostStr;


/*!
 * @breif 火车票当前数据票价信息
 
 [
    [@"二等座",            //票信息
     @"400",                ///价格信息
     @"48",],               ///剩余票量
 
    [@"二等座",
     @"400",
     @"48",],
 
    [@"二等座",
     @"400",
     @"48",],
 ]
 
 
 * @See
 */
@property (nonatomic , strong)          NSMutableArray          *traServiceAtAllLevelsArray;


/**
 *  @method
 *
 *  @brief          初始化火车票列表数据
 *
 *  @see            null
 *
 */
+ (id)initializaionWithTrainticketListInfoWithJSONDic:(NSDictionary *)dicInfor;

@end
//+_+QQ 10990 28580
