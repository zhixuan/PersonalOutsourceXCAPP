//
//  XCLocationManager.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/29.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCLocationManager.h"
#import <CoreLocation/CoreLocation.h>




@implementation XCLocationAPIResponse

- (id)init{
    self = [super init];
    if (self) {
        self.isSuccess = NO;
    }
    
    return self;
}

@end

@interface XCLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic , strong)CLLocationManager     *asLocationManage;

@property (nonatomic , strong)NSArray               *directlyArray;

@property (nonatomic , assign)  BOOL                locationFinish;
@end

@implementation XCLocationManager

- (id)init{
    self = [super init];
    
    if (self) {
        
        
        if ([CLLocationManager locationServicesEnabled] &&
            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
             || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
                
                self.asLocationManage = [[CLLocationManager alloc]init];
                [self.asLocationManage setDelegate:self];
                self.asLocationManage.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
                self.asLocationManage.distanceFilter = kCLDistanceFilterNone;
            }
        else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
            NSLog("定位功能不可用，提示用户或忽略");
        }
        self.directlyArray = @[@"北京市",@"上海市",@"天津市",@"重庆市",@"Beijing",@"Shanghai",@"Tianjin",@"Chongqing",];
    }
    
    return self;
}


- (void)starXCLocation{
    if (HUISystemVersionAboveOrIs(kHUISystemVersion_8_0)) {
        
        [self.asLocationManage requestAlwaysAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            
            
            if (self.asLocationManage) {
                [self.asLocationManage setDelegate:self];
                self.asLocationManage.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
                self.asLocationManage.distanceFilter = kCLDistanceFilterNone;
            }else{
                self.asLocationManage = [[CLLocationManager alloc]init];
                [self.asLocationManage setDelegate:self];
                self.asLocationManage.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
                self.asLocationManage.distanceFilter = kCLDistanceFilterNone;
            }
            
            [self.asLocationManage startUpdatingLocation];
        }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    CLGeocoder *revgeo = [[CLGeocoder alloc]init];
     CLLocationCoordinate2D corrdinate = newLocation.coordinate;
    [revgeo reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSString *provinceName = @"";
        NSString *cityName = @"";
        
       
//        NSLog(@"定位处理中...");
        NSMutableString *addressMutableStr = [NSMutableString new];
        ///已获取数据
        if (!error && placemarks.count > 0 ) {
            
            for (CLPlacemark *placemark in placemarks) {
                
                ///省份
                provinceName = placemark.administrativeArea;
                
                ///所在地市或区市
                cityName = placemark.locality;
                NSDictionary *address =  placemark.addressDictionary;
//                NSLog(@" i s %@",address);
                ///所在区县
                NSString *subLocality = StringForKeyInUnserializedJSONDic(address,@"SubLocality");
                ///所在街道
                NSString *street = StringForKeyInUnserializedJSONDic(address,@"Street");
                ///所在位置名字
                NSString *name = StringForKeyInUnserializedJSONDic(address,@"Name");
                
                
//                if (!IsStringEmptyOrNull(cityName)) {
//                    [addressMutableStr appendFormat:@" %@",cityName];
//                }
//                
//                if (!IsStringEmptyOrNull(subLocality)) {
//                    [addressMutableStr appendFormat:@" %@",subLocality];
//                }
//                
//                
//                if (!IsStringEmptyOrNull(street)) {
//                    [addressMutableStr appendFormat:@" %@",street];
//                }
//                
                
                if (!IsStringEmptyOrNull(name)) {
                    [addressMutableStr appendFormat:@" %@",name];
                }
                
            }
            
            ///若已获得数据
            if ([provinceName length] > 1) {
              
//
//                CLLocationCoordinate2D corrdinate = CLLocationCoordinate2DMake(36.6, 114.466666666667);
//                NSLog(@"provinceName is %@",provinceName);
                
                XCLocationAPIResponse *response = [[XCLocationAPIResponse alloc]init];
                [response setIsSuccess:YES];
                [response setCityStr:cityName];
                [response setProvinceStr:provinceName];
                [response setAddressStr:addressMutableStr];
                [response setLocationCoordinate:corrdinate];
                
                NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
                
                AddObjectForKeyIntoDictionary([NSNumber numberWithDouble:corrdinate.longitude],KKeyLongitude,resultDic);
                AddObjectForKeyIntoDictionary([NSNumber numberWithDouble:corrdinate.latitude],KKeyLatitude,resultDic);
                AddObjectForKeyIntoDictionary(provinceName, KKeyProvince ,resultDic);
                AddObjectForKeyIntoDictionary(cityName,KKeyCityName,resultDic);
                AddObjectForKeyIntoDictionary(addressMutableStr, KKeyAddress, resultDic);
                [response setResponseObject:resultDic];
                
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(locationDidFinishResponse:)]) {
                        [self.delegate locationDidFinishResponse:response];
                    }
                }
                //
            }
            
            else {
                
            }
        }
        else{
            
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    XCLocationAPIResponse *response = [[XCLocationAPIResponse alloc]init];
    [response setIsSuccess:NO];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [response setResponseObject:resultDic];
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(locationDidFinishResponse:)]) {
            [self.delegate locationDidFinishResponse:response];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    //    waiting
    [manager stopUpdatingLocation];
    
    
    if (locations.count == 0) {
        
        return;
    }
    
    CLLocation *location = locations.firstObject;
    CLLocationCoordinate2D corrdinate = location.coordinate;
//    CLLocationCoordinate2D corrdinate = CLLocationCoordinate2DMake(36.6, 114.466666666667);
    
    CLGeocoder *revgeo = [[CLGeocoder alloc]init];
    [revgeo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSString *provinceName = @"";
        NSString *cityName = @"";
        
        NSMutableString *addressMutableStr = [NSMutableString new];
        NSLog(@"-----定位成功");
        ///已获取数据
        if (!error && placemarks.count > 0 ) {
            
            for (CLPlacemark *placemark in placemarks) {
                
                ///省份
                provinceName = placemark.administrativeArea;
                NSDictionary *address =  placemark.addressDictionary;
//                NSLog(@" i s %@",address);
                ///所在地市或区市
                cityName = placemark.locality;
                
                ///所在区县
                NSString *subLocality = StringForKeyInUnserializedJSONDic(address,@"SubLocality");
                ///所在街道
                NSString *street = StringForKeyInUnserializedJSONDic(address,@"Street");
                ///所在位置名字
                NSString *name = StringForKeyInUnserializedJSONDic(address,@"Name");
                
//                
//                if (!IsStringEmptyOrNull(cityName)) {
//                    [addressMutableStr appendFormat:@"%@",cityName];
//                }
//                
//                if (!IsStringEmptyOrNull(subLocality)) {
//                    [addressMutableStr appendFormat:@" %@",subLocality];
//                }
//
//                
//                if (!IsStringEmptyOrNull(street)) {
//                    [addressMutableStr appendFormat:@" %@",street];
//                }

                
                if (!IsStringEmptyOrNull(name)) {
                    [addressMutableStr appendFormat:@" %@",name];
                }
                
            }
            ///若已获得数据
            if ([provinceName length] > 1) {

                NSLog(@"two  provinceName is %@",provinceName);
                XCLocationAPIResponse *response = [[XCLocationAPIResponse alloc]init];
                [response setIsSuccess:YES];
                [response setCityStr:cityName];
                [response setProvinceStr:provinceName];
                [response setAddressStr:addressMutableStr];
                [response setLocationCoordinate:corrdinate];
                
                NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
                
                AddObjectForKeyIntoDictionary([NSNumber numberWithDouble:corrdinate.longitude],KKeyLongitude,resultDic);
                AddObjectForKeyIntoDictionary([NSNumber numberWithDouble:corrdinate.latitude],KKeyLatitude,resultDic);
                AddObjectForKeyIntoDictionary(provinceName,KKeyProvince,resultDic);
                AddObjectForKeyIntoDictionary(cityName,KKeyCityName,resultDic);
                AddObjectForKeyIntoDictionary(addressMutableStr, KKeyAddress, resultDic);
                [response setResponseObject:resultDic];
                
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(locationDidFinishResponse:)]) {
                        [self.delegate locationDidFinishResponse:response];
                    }
                }
            }
            else {
                
            }
        }
        else{
            
        };
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.asLocationManage  respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.asLocationManage  requestAlwaysAuthorization];
            }
            break;
        default:
            break;
    }
}


@end
