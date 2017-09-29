//
//  UserPersonalOrderInformation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UserPersonalOrderInformation.h"

@implementation UserPersonalOrderInformation
- (id)init{
    self = [super init];
    if (self) {
        self.userOrderStyle = XCAPPOrderHotelForStyle;
        self.hotelOrderInfor = [[UserHotelOrderInformation alloc]init];
        self.trainticketOrderInfor = [[TrainticketOrderInformation alloc]init];
        self.flightOrderInfor = [[FlightOrderInformation alloc]init];
    }
    
    return self;
}


#pragma mark -
#pragma mark -  初始化用户订单列信息
+ (id)initializaionWithUserAllOrderInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    UserPersonalOrderInformation *item = [[UserPersonalOrderInformation alloc]init];
    
    NSString *typeStr = StringForKeyInUnserializedJSONDic(dicInfor,@"type");
    
    ///酒店订单
    if ([XCAPPOrderForHotelStyleStr isEqualToString:typeStr]) {
        
        [item setUserOrderStyle:XCAPPOrderHotelForStyle];
        item.hotelOrderInfor = [UserHotelOrderInformation initializaionWithUserHotelOrderListInfoWithUnserializedJSONDic:dicInfor];
    }
    ///火车票订单
    else if ([XCAPPOrderForTrainticketStyleStr isEqualToString:typeStr]){
        [item setUserOrderStyle:XCAPPOrderForTrainTicketStyle];
        [item setTrainticketOrderInfor:[TrainticketOrderInformation initializaionWithUserTrainticketInfoListWithUnserializedJSONDic:dicInfor]];
    }
    
    ///飞机票
    else if ([XCAPPOrderForFlightStyleStr isEqualToString:typeStr]){
        [item setUserOrderStyle:XCAPPOrderForFlightStyle];
    }
    
    return item;
}
@end
