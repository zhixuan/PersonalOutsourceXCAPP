//
//  TrainticketInformation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainticketInformation.h"

@implementation TrainticketInformation

- (id)init{
    self = [super init];
    if (self) {
        [self setTraServiceCostStr:@"0"];
        self.traServiceAtAllLevelsArray = [[NSMutableArray alloc]init];
    }
    
    return self;
}


#pragma mark -
#pragma mark -  initializaionWithTrainticketListInfoWithJSONDic
+ (id)initializaionWithTrainticketListInfoWithJSONDic:(NSDictionary *)dicInfor{
    
    
    TrainticketInformation *itemTicket = [[TrainticketInformation alloc]init];
    if (dicInfor == nil || dicInfor.count == 0) {
        return itemTicket;
    }
    
    [itemTicket setTraCodeNameStr:StringForKeyInUnserializedJSONDic(dicInfor,@"trainNo")];
    [itemTicket setTraTypeStr:StringForKeyInUnserializedJSONDic(dicInfor,@"trainType")];
    [itemTicket setTraCabinModelStr:StringForKeyInUnserializedJSONDic(dicInfor,@"seatInfo")];
    
    [itemTicket setTraTakeOffSite:StringForKeyInUnserializedJSONDic(dicInfor,@"dptStation")];
    [itemTicket setTraTakeOffTime:StringForKeyInUnserializedJSONDic(dicInfor,@"dptTime")];
    [itemTicket setTraTakeOffTimeSealStr:StringForKeyInUnserializedJSONDic(dicInfor, @"dptDateTime")];
    
    
    [itemTicket setTraArrivedSite:StringForKeyInUnserializedJSONDic(dicInfor,@"arrStation")];
    [itemTicket setTraArrivedTime:StringForKeyInUnserializedJSONDic(dicInfor,@"arrTime")];
    [itemTicket setTraArrivedTimeSealStr:StringForKeyInUnserializedJSONDic(dicInfor, @"arrDateTime")];
    
    [itemTicket setTraTimeInterval:StringForKeyInUnserializedJSONDic(dicInfor,@"interval")];
    [itemTicket setTraTimeIntervalInteger:IntForKeyInUnserializedJSONDic(dicInfor,@"intervalSort")];
    [itemTicket setTraUnitPrice:StringForKeyInUnserializedJSONDic(dicInfor,@"seatPrice")];
    [itemTicket setTraScaleNumber:StringForKeyInUnserializedJSONDic(dicInfor, @"seatRemains")];
    
    ///车票种类数据信息
    if ([ObjForKeyInUnserializedJSONDic(dicInfor, @"seats") isKindOfClass:[NSArray class]]) {
        NSMutableArray *seatsArray = (NSMutableArray *)ObjForKeyInUnserializedJSONDic(dicInfor, @"seats");
        [itemTicket setTraServiceAtAllLevelsArray:seatsArray];
    }

    return itemTicket;
}
@end
