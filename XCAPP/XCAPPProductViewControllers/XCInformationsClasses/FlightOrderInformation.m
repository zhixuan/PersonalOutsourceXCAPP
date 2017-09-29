//
//  FlightOrderInformation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightOrderInformation.h"

@implementation FlightOrderInformation
- (id)init{
    self = [super init];
    if (self) {
        self.fliOrderOneWayInfor = [[FlightInformation alloc]init];
        self.fliOrderReturnInfor = [[FlightInformation alloc]init];
        self.flightOrderUserMutArray = [[NSMutableArray alloc]init];
        self.flightOrderCreateUserInfor = [[UserInformationClass alloc]init];
        self.fliOrderForFlightPayStyle = OrderStateForFlightWaitForConfirm;
    }
    return self;
}
@end
