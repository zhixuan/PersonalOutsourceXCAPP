//
//  HotelInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HotelInformation : NSObject

/*!
 * @breif 酒店ID
 * @See 酒店ID
 */
@property (nonatomic , copy)      NSString                      *hotelIdStr;

/*!
 * @breif 聚合房型（房型）ID
 * @See 聚合房型（房型）ID
 */
@property (nonatomic , copy)      NSString                      *hotelRoomClassIdStr;


/*!
* @breif 房间产品ID
* @See  房间产品ID
*/
@property (nonatomic , copy)      NSString                      *hotelRoomProductIdStr;

/*!
 * @breif 酒店图片地址
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelImageDisplayURLStr;

/*!
 * @breif 酒店距离
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelDistanceStr;

/*!
 * @breif 酒店名字
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelNameContentStr;

/*!
 * @breif 酒店简介信息
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelIntroductionInfor;

/*!
 * @breif 聚合房型名字
 * @See 聚合房型名字
 */
@property (nonatomic , copy)      NSString                      *hotelRoomClassNameContentStr;

/*!
 * @breif 酒店评分
 * @See eg. 4.5分，8.6分
 */
@property (nonatomic , copy)      NSString                      *hotelMarkRecordContentStr;

/*!
 * @breif 酒店级别
 * @See 四星级/五星级/
 */
@property (nonatomic , copy)      NSString                      *hotelRankContentStr;

/*!
 * @breif 酒店错略地址
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelAddressRoughStr;

/*!
 * @breif 酒店详细地址
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelAddressDetailedStr;

/*!
 * @breif 酒店经纬度信息
 * @See
 */
@property (nonatomic , assign)  CLLocationCoordinate2D          hotelCoordinate;

/*!
 * @breif 酒店最低单价
 * @See
 */
@property (nonatomic , assign)    CGFloat                       hotelMinUnitPriceFloat;

/*!
 * @breif 酒店实际单价
 * @See
 */
@property (nonatomic , assign)    CGFloat                       hotelRealityUnitPriceFloat;

/*!
 * @breif 酒店房间剩余量
 * @See
 */
@property (nonatomic , assign)    NSInteger                     hotelRoomResidueCountInteger;

/*!
 * @breif 酒店房间信息说明
 * @See
 */
@property (nonatomic , copy)    NSString                        *hotelRoomStyleExplanationContent;


/*!
 * @breif 酒店提供早餐情况
 * @See e.g. 无早/免费早餐，30元早餐
 */
@property (nonatomic , copy)      NSString                      *hotelMorningMealContent;

/*!
 * @breif 酒店提供房间床位情况
 * @See e.g. 大床/双人床/单人床
 */
@property (nonatomic , copy)      NSString                      *hotelRoomBerthContent;

/*!
 * @breif 酒店电话
 * @See e.g.
 */
@property (nonatomic , copy)      NSString                      *hotelTelPhoneStr;

/*!
 * @breif 预订成功是否可取消
 * @See
 */
@property (nonatomic , assign)      BOOL                        hotelAllowCancelBool;

/*!
 * @breif 酒店提供服务的内容数组
 * @See
 */
@property (nonatomic , strong)      NSArray                     *hotelServiceContentArray;


/*!
 * @breif 是否有宽带
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelHasWiFiStr;

/*!
 * @breif 房间面积
 * @See
 */
@property (nonatomic , copy)      NSString                      *hotelRoomAreaStr;

/**
 *  @method
 *
 *  @brief          初始化酒店列表数据内容
 *
 */
+ (id)initializaionWithHotelListInformationWithUnserializedJSONDic:(NSDictionary *)dicInfor;

/**
 *  @method
 *
 *  @brief          初始化酒店房间数据（聚合一级数据）
 *
 */
+ (id)initializaionWithItemHotelRoomInformationForPolymerizeHeaderCellWithUnserializedJSONDic:(NSDictionary *)dicInfor;

/**
 *  @method
 *
 *  @brief          初始化酒店房间产品数据（聚合二级数据）
 *
 */
+ (id)initializaionWithItemHotelRoomInformationForProductIndexCellWithUnserializedJSONDic:(NSDictionary *)dicInfor;

@end
//+_+QQ 10990 28580
