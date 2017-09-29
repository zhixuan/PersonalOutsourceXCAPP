//
//  HTTPClient+OrderRequest.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient (OrderRequest)

#pragma mark -
#pragma mark - 用户个人查找个人优惠券信息
/**
 *  @method
 *
 *  @brief          用户个人查找个人优惠券信息
 *
 *  @param          userId          用户ID
 *
 *  @see            用户需要登录状态下查找优惠信息
 *
 */
- (AFHTTPRequestOperation *)userPreferentialInformationWithUserId:(NSString *)userId
                                                       completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户个人查找为出行订单信息
/**
 *  @method
 *
 *  @brief          用户个人查找为出行订单信息
 *
 *  @param          userId          用户ID
 *
 *  @see            用户需要登录状态下查找优惠信息
 *
 */
- (AFHTTPRequestOperation *)userUnDepartOrderInforWithUserId:(NSString *)userId
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;







#pragma mark -
#pragma mark - 个人订单列表信息
/**
 *  @method
 *
 *  @brief          个人订单列表信息
 *
 *  @param          userid          用户ID
 *
 *  @param          pageRow         当前页面
 *
 *  @param          pageSize        页面大小
 *
 *  @see            默认pageSize 为15
 *
 */
- (AFHTTPRequestOperation *)orderListInforWithuserId:(NSString *)userid
                                             pageRow:(NSInteger)pageRow
                                            pageSize:(NSInteger)pageSize styleType:(NSInteger)type
                                          completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 个人某个订单详情信息
/**
 *  @method
 *
 *  @brief          个人某个订单详情信息
 *
 *  @param          userId          用户ID
 *
 *  @param          orderId         订单ID信息
 *
 *  @see            null
 *
 */
- (AFHTTPRequestOperation *)getOrderDetailInforWithUserId:(NSString *)userId
                                                  orderid:(NSString *)orderId
                                               completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户取消订单操作请求
/**
 *  @method
 *
 *  @brief          用户取消订单操作请求
 *
 *  @param          userId          用户ID
 *
 *  @param          orderId         订单ID信息
 *
 *  @see            null
 *
 */
- (AFHTTPRequestOperation *)orderhasBenCancelOperationUserId:(NSString *)userId
                                                     orderid:(NSString *)orderId
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;



#pragma mark -
#pragma mark - 根据酒店订单ID，获取酒店订单详情信息内容
/**
 *  @method
 *
 *  @brief          根据酒店订单ID，获取酒店订单详情信息内容
 *
 *  @param          orderId         订单ID信息
 *
 *  @see            null
 *
 */
- (AFHTTPRequestOperation *)orderDetailForHotelOrderWithOrderId:(NSString *)orderId
                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;

@end
