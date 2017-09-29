//
//  HTTPClient+OrderRequest.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient+OrderRequest.h"

@implementation HTTPClient (OrderRequest)

#pragma mark -
#pragma mark - 用户个人查找个人优惠券信息
- (AFHTTPRequestOperation *)userPreferentialInformationWithUserId:(NSString *)userId
                                                       completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId};
    return [self getPath:@"user/searchCard" parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户个人查找为出行订单信息
- (AFHTTPRequestOperation *)userUnDepartOrderInforWithUserId:(NSString *)userId
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId};
    return [self getPath:KReqSearchUnGoOrderURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 个人订单列表信息

- (AFHTTPRequestOperation *)orderListInforWithuserId:(NSString *)userid
                                             pageRow:(NSInteger)pageRow
                                            pageSize:(NSInteger)pageSize
                                           styleType:(NSInteger)type
                                          completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userid length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userid,
                            KDataKeyCurrentPage:[NSNumber numberWithInteger:pageRow],
                            @"orderType":[NSNumber numberWithInteger:(type)]};
    
    return [self getPath:KReqOrderListURL parameters:param
              completion:completionBlock];

}
#pragma mark -
#pragma mark - 个人某个订单详情信息
- (AFHTTPRequestOperation *)getOrderDetailInforWithUserId:(NSString *)userId
                                                  orderid:(NSString *)orderId
                                               completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            KDataKeyOrderId:orderId};
    
    return [self getPath:KReqOrderItemDetailURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户取消订单操作请求
- (AFHTTPRequestOperation *)orderhasBenCancelOperationUserId:(NSString *)userId
                                                     orderid:(NSString *)orderId
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            KDataKeyOrderId:orderId};
    
    return [self getPath:KReqOrderCancelOperationURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 根据酒店订单ID，获取酒店订单详情信息内容
- (AFHTTPRequestOperation *)orderDetailForHotelOrderWithOrderId:(NSString *)orderId completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([orderId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{@"orderNo":orderId};
    
    return [self postPath:KReqOrderDetailForHotelURL parameters:param
              completion:completionBlock];
}
@end
