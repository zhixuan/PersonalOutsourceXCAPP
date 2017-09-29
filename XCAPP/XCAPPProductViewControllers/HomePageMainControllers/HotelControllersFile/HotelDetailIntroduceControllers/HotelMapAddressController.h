//
//  HotelMapAddressController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/29.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//
/*
 *
 *   ╭＾＾★╮╭＾＾☆╮
 *  {/ ． ．\}{/ ． ．\}
 *  (　 (oo) )(　 (oo) )  总是加班会死人的的....
 *
 *
 *
 */



#import "XCAPPUIViewController.h"
#import <MapKit/MapKit.h>
@interface HotelMKAnnotation :NSObject<MKAnnotation>

/*!
 * @breif 经纬度
 * @See
 */
@property (nonatomic , assign)       CLLocationCoordinate2D coordinate;

/*!
 * @breif 标题
 * @See
 */
@property (nonatomic , copy)        NSString *title;

/*!
 * @breif 副标题
 * @See
 */
@property (nonatomic , copy)        NSString  *subtitle;
@end

/**
 *  @method 酒店地图位置
 *
 *  @brief
 */
@interface HotelMapAddressController : XCAPPUIViewController

/**
 *  @method 初始化酒店信息数据
 *
 *  @brief
 */
- (id)initWithHotelInfor:(HotelInformation *)hotelInfor;
@end
//:-D QQ 10990  28580