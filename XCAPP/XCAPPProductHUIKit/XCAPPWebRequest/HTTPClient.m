//
//  HTTPClient.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#import "WebAPIDefine.h"
#import "WebAPIResponse.h"
#import "XCAPPFunctionsInfor.h"


#pragma mark - 图片服务器
#define kImageUpload                @"upload/qiniu"
#define kImageUploadForSalon        @"upload/sync/qiniu"

@implementation HTTPClient
//声明静态实例
+ (HTTPClient *)sharedHTTPClient
{
    static HTTPClient *_sharedHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[HTTPClient alloc] initWithBaseURL:[NSURL URLWithString:KWebResponseURL]];
    });
    
    return _sharedHTTPClient;
    
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self == nil)
        return nil;
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    //只接受JSON格式的返回数据, 向服务器传消息也用JSON数据
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    //如果使用JSON格式请求RESTFUL API,打开此选项
    //[self setParameterEncoding:AFJSONParameterEncoding];
    
    return self;
}
- (AFHTTPRequestOperation*)getPath:(NSString *)path
                        parameters:(NSDictionary *)parameters
                        completion:(WebAPIRequestCompletionBlock)completionBlock

{
    
    NSMutableDictionary *mutableParameters = [[NSMutableDictionary alloc]init];
    if (parameters != nil) {
        [mutableParameters setDictionary:parameters];
    }
    
    
    NSLog(@"\n\nGET is %@\nparam is %@\n",path,mutableParameters);
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                         parameters:mutableParameters];
    
    
    
    AFHTTPRequestOperation *operation =
    [self HTTPRequestOperationWithRequest:request
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                                      if (httpResponse.statusCode == 200) {
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithUnserializedJSONDic:responseObject]);
                                              });
                                          }
                                      } else {
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                              });
                                          }
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      if (completionBlock) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                          });
                                      }
                                  }];
    //   operation]
    [self enqueueHTTPRequestOperation:operation];
    return operation;
}

- (AFHTTPRequestOperation *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                          completion:(WebAPIRequestCompletionBlock)completionBlock
{
    
    NSMutableDictionary *mutableParameters = [[NSMutableDictionary alloc]init];
    if (parameters != nil) {
        [mutableParameters setDictionary:parameters];
        
    }
//    [mutableParameters setObject:@"parma" forKey:@"location"];
    NSLog(@"\n\n POST 请求is %@\nparam is %@\n",path,mutableParameters);

    NSURLRequest *request = [self requestWithMethod:@"POST" path:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                         parameters:mutableParameters];
    
    AFHTTPRequestOperation *operation =
    [self HTTPRequestOperationWithRequest:request
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                                      
                                      
                                      if (httpResponse.statusCode == 200) {
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithUnserializedJSONDic:responseObject]
                                                                  );
                                              });
                                          }
                                      } else {
                                          
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                              });
                                          }
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Received: %@", [error localizedDescription]);
                                      if (completionBlock) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                              
                                              //                                              NSLog(@"error=%@",error);
                                          });
                                      }
                                  }];
    [self enqueueHTTPRequestOperation:operation];
    return operation;
}


@end
