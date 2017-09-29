//
//  HTTPClient.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "WebAPIDefine.h"
#import "WebAPIResponse.h"



typedef void (^WebAPIRequestCompletionBlock)(WebAPIResponse* response);

//定义网络错误提示信息
#define NETERROR_LOADERR_TIP            @"读取失败,网络异常"

#define XCAPPHTTPClient [HTTPClient sharedHTTPClient]


@interface HTTPClient : AFHTTPClient


//获取API单实例
+ (HTTPClient *)sharedHTTPClient;

//get请求
- (AFHTTPRequestOperation *)getPath:(NSString *)path
                         parameters:(NSDictionary *)parameters
                         completion:(WebAPIRequestCompletionBlock)completionBlock;


//post请求
- (AFHTTPRequestOperation *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                          completion:(WebAPIRequestCompletionBlock)completionBlock;

@end
