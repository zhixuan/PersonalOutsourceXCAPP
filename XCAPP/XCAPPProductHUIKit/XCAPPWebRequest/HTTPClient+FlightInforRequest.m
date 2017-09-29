//
//  HTTPClient+FlightInforRequest.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/30.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient+FlightInforRequest.h"

@implementation HTTPClient (FlightInforRequest)


#pragma mark -
#pragma mark - 用户取消飞机票订单操作请求

- (AFHTTPRequestOperation *)flightOrderUserCancelFlightOrderOperationUserId:(NSString *)userId
                                                                    orderid:(NSString *)orderId
                                                                 completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1             ||
        [orderId length] < 1    ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
    NSDictionary *param = @{@"userid":userId,
                            @"orderNo":orderId,};
    
    return [self getPath:KReqUserCancleTrainTicketOrderURL parameters:param
              completion:completionBlock];

}

#pragma mark -
#pragma mark -  根据当前订单信息，查询当前订单的改签

- (AFHTTPRequestOperation *)flightOrderUserCheckUserChangeInforWithUserId:(NSString *)userId orderid:(NSString *)orderId completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1             ||
        [orderId length] < 1    ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
    NSDictionary *param = @{@"userid":userId,
                            @"orderNo":orderId,};
    
    return [self getPath:KReqUserCancleTrainTicketOrderURL parameters:param
              completion:completionBlock];

}



#pragma mark -
#pragma mark -  用户改签飞机票订单操作请求

- (AFHTTPRequestOperation *)flightOrderUserChangeFlightOrderOperationUserId:(NSString *)userId
                                                                    orderid:(NSString *)orderId
                                                                 completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1             ||
        [orderId length] < 1    ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
    NSDictionary *param = @{@"userid":userId,
                            @"orderNo":orderId,};
    
    return [self getPath:KReqUserCancleTrainTicketOrderURL parameters:param
              completion:completionBlock];
}
@end
