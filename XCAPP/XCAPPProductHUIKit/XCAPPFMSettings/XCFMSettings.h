//
//  XCFMSettings.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


#define KXCShareFMSetting [XCFMSettings shareXCFMSetting]

@interface XCFMSettings : NSObject


/** 编辑系统设置参数信息内容***/
+(XCFMSettings *)shareXCFMSetting;

/*!
 * @breif 用户登录手机号
 * @See
 */
@property (nonatomic , strong)      NSString            *userLoginPhoneNumberStr;

/*!
 * @breif 用户登录密码
 * @See
 */
@property (nonatomic , strong)      NSString            *userLoginPasswordStr;

/*!
 * @breif 判断用户以前是否登录过该客户端
 * @See YES，表示登录过，NO，表示没有；默认为NO
 */
@property (nonatomic , assign)      BOOL                userPersonalOnceLoginSuccessBool;

/*!
 * @breif 判断用户是否绑定过12306账户
 * @See YES，表示绑定过，NO，表示未曾绑定，默认为NO
 */
@property (nonatomic , assign)      BOOL                userPersonalIsRelatedAccountBool;

/*!
 * @breif 用户绑定过的12306账户，对应的账户名
 * @See
 */
@property (nonatomic , strong)      NSString            *userPersonalRelatedAccountNameStr;

/*!
 * @breif 用户当前位置(经纬度信息)
 * @See
 */
@property (nonatomic , assign)      CLLocationCoordinate2D userPerLocationCooridate;

/*!
 * @breif 用户当前所在的城市
 * @See
 */
@property (nonatomic , strong)      NSString            *userLocationCityNameStr;


/*!
 * @breif 用户证件信息对照表
 * @See
 */
@property (nonatomic , strong)      NSDictionary            *userCredentialsCompareDictionary;


/*!
 * @breif 用户预订酒店所用过的城市信息
 * @See
 */
@property (nonatomic , strong)      NSArray                 *userReserveHotelCitiesMutableArray;

/*!
 * @breif 用户预订航班所用过的城市信息
 * @See
 */
@property (nonatomic , strong)      NSArray                 *userReserveFlightCitiesMutableArray;

/*!
 * @breif 用户预订火车票所用过的城市信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray          *userReserveTrainTicketCitiesMutableArray;
@end
