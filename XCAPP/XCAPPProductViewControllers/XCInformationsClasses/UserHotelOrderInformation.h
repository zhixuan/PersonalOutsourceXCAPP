//
//  UserHotelOrderInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/4.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>
#import "HotelInformation.h"


////用户酒店入住订单信息
@interface UserHotelOrderInformation : NSObject


#pragma mark -
#pragma mark -  订单信息
/*!
 * @breif 订单ID
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderId;

/*!
 * @breif 订单编号
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderNumberStr;

///*!
// * @breif 订单当前状态
// * @See  默认为 OrderStateForWaitForPay = 0,  待支付
// */
//@property (nonatomic , assign)      XCAPPOrderPayStateStyle orderPayState;

/*!
 * @breif 酒店当前订单状态信息
 * @See     默认为：OrderStateForHotelNullConfirmNullPay = 0 待确认，未支付
 */
@property (nonatomic , assign)      XCAPPOrderForHotelPayStyle  orderHotelPayState;

/*!
 * @breif 订单对应的入住时间
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderUserMoveIntoDate;

/*!
 * @breif 订单的预定时间
 * @See 预定时间肯定在入住时间之前
 */
@property (nonatomic , copy)      NSString                  *orderCreateDate;

/*!
 * @breif 根据用户支付状态计算时间差值
 * @See 单位时秒 /s
 */
@property (nonatomic , assign)      NSTimeInterval          orderPayDownCalculateTimeInterval;


#pragma mark -
#pragma mark -  酒店信息
/*!
 * @breif 订单对应的酒店ID
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderHotelId;

/*!
 * @breif 订单对应的酒店名字
 * @See
 */
//@property (nonatomic , copy)      NSString                  *orderHotelName;

///*!
// * @breif 订单对应的酒店模糊地址（显示在订单列表中）
// * @See
// */
//@property (nonatomic , copy)      NSString                  *orderHotelBlurAddress;
//
///*!
// * @breif 订单对应的酒店详细地址（显示在订单详情中）
// * @See
// */
//@property (nonatomic , copy)      NSString                  *orderHotelDetailAddress;

/*!
 * @breif 酒店信息
 * @See
 */
@property (nonatomic , strong)  HotelInformation            *orderHotelInforation;

/*!
 * @breif 酒店房间信息信息
 * @See
 */
@property (nonatomic , strong)  HotelInformation            *orderHotelRoomInforation;


#pragma mark -
#pragma mark -  订单计费信息
/*!
 * @breif 订单单价信息
 * @See 需要设置默认为整数，小数部分不存在 \ref e.g ￥500，￥176
 */
@property (nonatomic , assign)      CGFloat                 orderUnitPriceFloat;

/*!
 * @breif 订单中单次入住天数(即：入住天数)
 * @See 需要设置默认为 1
 */
@property (nonatomic , assign)      NSInteger               orderStayDayesQuantityInteger;

/*!
 * @breif 订单中单次订购房间数(即：订房数)
 * @See 需要设置默认为 1
 */
@property (nonatomic , assign)      NSInteger               orderRoomQuantityInteger;

/*!
 * @breif 订单需要支付的总额
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderPaySumTotal;

#pragma mark -
#pragma mark - 订单创建者信息
/*!
 * @breif 订单创建者信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass    *orderCreateUserInfor;

/*!
 * @breif 酒店订单联系人
 * @See
 */
@property (nonatomic , strong)      UserInformationClass    *orderContactUserInfor;

/*!
 * @breif 订单人预定原因（因公/因私）
 * @See
 */
@property (nonatomic , assign)      UserMatterStateStyle    orderUserMatterStateStyle;

#pragma mark -
#pragma mark -  订单入住信息
/*!
 * @breif 订单人员入店时间
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderForHotelBeginDate;

/*!
 * @breif 订单人员离店时间
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderForHotelEndDate;

/*!
 * @breif 订单人员进店最早时间点
 * @See     e.g. 20：00点前，18：00点前
 */
@property (nonatomic , copy)      NSString                  *orderUserArrivedDateTimeStr;

/*!
 * @breif 订单入住人员名字信息
 * @See
 */
@property (nonatomic , strong)      NSArray                 *orderMoveIntoUsersArray;

/*!
 * @breif 预订酒店所在城市名字
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderAtCityNameStr;

/*!
 * @breif 预订酒店所在城市编号
 * @See
 */
@property (nonatomic , copy)      NSString                  *orderAtCityCodeStr;


/*!
 * @breif 创建预订酒店订单，格式化上传参数信息
 * @See
 */
- (NSMutableDictionary *)createHotelOrderInformationParameter;

/**
 *  @method
 *
 *  @brief          初始化用户订单列信息
 *
 */
+ (id)initializaionWithUserHotelOrderListInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor;

/**
 *  @method
 *
 *  @brief          初始化用户每个酒店订单详细信息
 *
 */
- (void)initializaionWithUserItemHotelOrderDetailInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor;
@end
//+_+QQ 10990 28580
