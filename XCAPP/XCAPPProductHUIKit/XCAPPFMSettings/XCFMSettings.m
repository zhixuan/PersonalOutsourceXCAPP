//
//  XCFMSettings.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCFMSettings.h"

@implementation XCFMSettings


- (id)init{
    self = [super init];
    
    if (self) {
//        self.userCredentialsCompareDictionary = @{@"0":@"身份证",
//                                                  @"4":@"护照",
//                                                  @"6":@"台胞证",
//                                                  @"7":@"港澳通行证",};
        self.userCredentialsCompareDictionary = @{@"0":@"身份证",};
    }
    
    return self;
}

//声明静态实例
static XCFMSettings       *xcShareSetting = nil;
+ (XCFMSettings *)shareXCFMSetting{
    
    @synchronized(self){
        if (!xcShareSetting) {
            xcShareSetting = [[self alloc]init];
        }
    }
    return xcShareSetting;

}


#pragma mark -
#pragma mark -  用户当前所在的城市
- (void)setUserLocationCityNameStr:(NSString *)userLocationCityNameStr{
    [[NSUserDefaults standardUserDefaults] setObject:userLocationCityNameStr forKey:@"XCAPPUserLocationCityNameStr"];
}

- (NSString *)userLocationCityNameStr{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserLocationCityNameStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserLocationCityNameStr"];
}


#pragma mark -
#pragma mark -  用户当前位置(经纬度信息)
- (void)setUserPerLocationCooridate:(CLLocationCoordinate2D)userPerLocationCooridate{
    [[NSUserDefaults standardUserDefaults] setObject:@{KDataKeyLatitude:[NSNumber numberWithDouble:userPerLocationCooridate.latitude],
                                                       KDataKeyLongitude:[NSNumber numberWithDouble:userPerLocationCooridate.longitude]}
                                              forKey:@"XCAPPUserPerLocationCooridate"];
}

- (CLLocationCoordinate2D)userPerLocationCooridate{

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"XCAPPUserPerLocationCooridate"]) {
        return CLLocationCoordinate2DMake(0.0f, 0.0f);
    }
    
    NSDictionary *locationCooridateDict =(NSDictionary *)[[NSUserDefaults standardUserDefaults]
                                                            objectForKey:@"XCAPPUserPerLocationCooridate"];
    return CLLocationCoordinate2DMake(DoubleForKeyInUnserializedJSONDic(locationCooridateDict, KDataKeyLatitude), DoubleForKeyInUnserializedJSONDic(locationCooridateDict, KDataKeyLongitude));
}
#pragma mark -
#pragma mark -  用户登录手机号
- (void)setUserLoginPhoneNumberStr:(NSString *)userLoginPhoneNumberStr{
    [[NSUserDefaults standardUserDefaults] setObject:userLoginPhoneNumberStr forKey:@"XCAPPUserLoginPhoneNumberStr"];
}

- (NSString *)userLoginPhoneNumberStr{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserLoginPhoneNumberStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserLoginPhoneNumberStr"];
}

#pragma mark -
#pragma mark -  判断用户以前是否登录过该客户端
- (void)setUserPersonalOnceLoginSuccessBool:(BOOL)userPersonalOnceLoginSuccessBool{
    [[NSUserDefaults standardUserDefaults] setBool: userPersonalOnceLoginSuccessBool forKey:@"XCAPPUserPersonalOnceLoginSuccessBool"];
}

#pragma mark -
#pragma mark -  判断用户以前是否登录过该客户端
- (BOOL)userPersonalOnceLoginSuccessBool{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserPersonalOnceLoginSuccessBool"]) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"XCAPPUserPersonalOnceLoginSuccessBool"];
}

#pragma mark -
#pragma mark -  判断用户是否绑定过12306账户
- (void)setUserPersonalIsRelatedAccountBool:(BOOL)userPersonalIsRelatedAccountBool{
     [[NSUserDefaults standardUserDefaults] setBool: userPersonalIsRelatedAccountBool forKey:@"XCAPPUserPersonalIsRelatedAccountBool"];
}
- (BOOL)userPersonalIsRelatedAccountBool{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserPersonalIsRelatedAccountBool"]) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"XCAPPUserPersonalIsRelatedAccountBool"];
}

- (void)setUserPersonalRelatedAccountNameStr:(NSString *)userPersonalRelatedAccountNameStr{
    [[NSUserDefaults standardUserDefaults] setObject:userPersonalRelatedAccountNameStr forKey:@"XCAPPUserPersonalRelatedAccountNameStr"];
}

- (NSString *)userPersonalRelatedAccountNameStr{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserPersonalRelatedAccountNameStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserPersonalRelatedAccountNameStr"];
}

#pragma mark -
#pragma mark - 用户登录密码
- (void)setUserLoginPasswordStr:(NSString *)userLoginPasswordStr{
     [[NSUserDefaults standardUserDefaults] setObject:userLoginPasswordStr forKey:@"XCAPPUserLoginPasswordStr"];
}

- (NSString *)userLoginPasswordStr{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserLoginPasswordStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"XCAPPUserLoginPasswordStr"];
}

#pragma mark -
#pragma mark -  用户预订酒店所用过的城市信息
- (void)setUserReserveHotelCitiesMutableArray:(NSArray *)userReserveHotelCitiesMutableArray{
    [[NSUserDefaults standardUserDefaults] setObject:userReserveHotelCitiesMutableArray
                                              forKey:@"XCAPPUserReserveHotelCitiesMutableArray"];
}


#pragma mark -
#pragma mark -  用户预订酒店所用过的城市信息
- (NSArray *)userReserveHotelCitiesMutableArray{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"XCAPPUserReserveHotelCitiesMutableArray"]) {
        return [NSMutableArray array];
    }
    return (NSMutableArray *)[[NSUserDefaults standardUserDefaults]
                              objectForKey:@"XCAPPUserReserveHotelCitiesMutableArray"];
}

- (void)setUserReserveFlightCitiesMutableArray:(NSArray *)userReserveFlightCitiesMutableArray{
    [[NSUserDefaults standardUserDefaults] setObject:userReserveFlightCitiesMutableArray
                                              forKey:@"XCAPPUserReserveFlightCitiesMutableArray"];
}

- (NSArray *)userReserveFlightCitiesMutableArray{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"XCAPPUserReserveFlightCitiesMutableArray"]) {
        return [NSArray array];
    }
    return (NSArray *)[[NSUserDefaults standardUserDefaults]
                       objectForKey:@"XCAPPUserReserveFlightCitiesMutableArray"];
}

- (void)setUserReserveTrainTicketCitiesMutableArray:(NSMutableArray *)userReserveTrainTicketCitiesMutableArray{
    [[NSUserDefaults standardUserDefaults] setObject:userReserveTrainTicketCitiesMutableArray
                                              forKey:@"XCAPPUserReserveTrainTicketCitiesMutableArray"];
}

- (NSMutableArray *)userReserveTrainTicketCitiesMutableArray{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"XCAPPUserReserveTrainTicketCitiesMutableArray"]) {
        return [NSMutableArray array];
    }
    return (NSMutableArray *)[[NSUserDefaults standardUserDefaults]
                       objectForKey:@"XCAPPUserReserveTrainTicketCitiesMutableArray"];
}


@end

