//
//  HTTPClient+FlightInforRequest.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/30.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient (FlightInforRequest)

#pragma mark -
#pragma mark - 用户取消飞机票订单操作请求
/**
 *  @method
 *
 *  @brief          用户取消飞机票订单操作请求
 *
 *  @param          userId          用户ID
 *
 *  @param          orderId         订单ID信息
 *
 *  @see            null
 *
 */
- (AFHTTPRequestOperation *)flightOrderUserCancelFlightOrderOperationUserId:(NSString *)userId
                                                     orderid:(NSString *)orderId
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  根据当前订单信息，查询当前订单的改签
/**
 *  @method
 *
 *  @brief          根据当前订单信息，查询当前订单的改签
 *
 *  @param          userId          用户ID
 *
 *  @param          orderId         订单ID信息
 *
 *  @see            null
 *
 */
- (AFHTTPRequestOperation *)flightOrderUserCheckUserChangeInforWithUserId:(NSString *)userId
                                                                  orderid:(NSString *)orderId
                                                               completion:(WebAPIRequestCompletionBlock)completionBlock;



#pragma mark -
#pragma mark -  用户改签飞机票订单操作请求
/**
 *  @method
 *
 *  @brief          用户改签飞机票订单操作请求
 *
 *  @param          userId          用户ID
 *
 *  @param          orderId         订单ID信息
 *
 *  @see            null
 *
 */
- (AFHTTPRequestOperation *)flightOrderUserChangeFlightOrderOperationUserId:(NSString *)userId
                                                                    orderid:(NSString *)orderId
                                                                 completion:(WebAPIRequestCompletionBlock)completionBlock;

@end
