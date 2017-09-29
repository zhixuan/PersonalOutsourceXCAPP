//
//  XCLocationManager.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/29.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>



#define KKeyProvince            @"province"
#define KKeyCityName            @"cityname"
#define KKeyLatitude            @"latitude"
#define KKeyLongitude           @"longitude"
#define KKeyAddress             @"address"


@interface XCLocationAPIResponse :NSObject

@property (nonatomic , assign)BOOL          isSuccess;


@property (nonatomic , assign)BOOL          isOpenLocationBool;

/*!
 * @breif 省份
 * @See
 */
@property (nonatomic , strong)NSString      *provinceStr;

/*!
 * @breif 城市
 * @See
 */
@property (nonatomic , strong)NSString      *cityStr;

/*!
 * @breif 详细地址
 * @See
 */
@property (nonatomic , strong)NSString      *addressStr;

/*!
 * @breif 经纬度
 * @See
 */
@property (nonatomic , assign)CLLocationCoordinate2D   locationCoordinate;


/**  responseObject:    定位得到的数据信息
 */
@property (nonatomic, strong) NSDictionary  *responseObject;
@end



@protocol XCLocationManagerDelegate <NSObject>

- (void)locationDidFinishResponse:(XCLocationAPIResponse *)locationResult;

@end


@interface XCLocationManager : NSObject


/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<XCLocationManagerDelegate>       delegate;

/*!
 * @breif 定义的数据量
 * @See
 */
@property (nonatomic , copy)       void (^LocationManagerCompletionBlock)(XCLocationAPIResponse* response);
- (void)starXCLocation;
@end
//+_+QQ 10990 28580
