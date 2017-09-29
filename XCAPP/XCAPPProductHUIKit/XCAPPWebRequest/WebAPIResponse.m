//
//  WebAPIResponse.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "WebAPIResponse.h"
#import "XCAPPFunctionsInfor.h"

//@implementation WebAPIResponse
#define kCodeNameOnServer               @"code"
#define kCodeDescriptionNameOnServer    @"RetValue"

/*!
 * @breif 网络请求错误默认提示信息
 * @See
 */
NSString *const     WebAPIResponseCodeFailedErrorMark = @"服务器君累坏了，请稍后重试...";

@implementation WebAPIResponse

+ (id)responseWithCode:(WebAPIResponseCode)code
{
    return [[self class] responseWithCode:code description:nil];
}

+ (id)responseWithCode:(WebAPIResponseCode)code description:(NSString *)codeDescription
{
    id response = [[self alloc] init];
    [(WebAPIResponse*)response setCode:code];
    [(WebAPIResponse*)response setCodeDescription:codeDescription];
    return response;
}

//TODO: 拼写错误
+ (id)invalidArgumentsResonse
{
    return [self responseWithCode:WebAPIResponseCodeParamError
                      description:@"请求参数错误"];
}

+ (id)successedResponse
{
    return [self responseWithCode:WebAPIResponseCodeSuccess];
}


+ (id)uploadImagesuccessedResponse:(NSString *)imageUrl{
    
    WebAPIResponse* response = [[self alloc] init];
    
    if (IsStringEmptyOrNull(imageUrl)) {
        [response setCode:WebAPIResponseCodeFailed];
        [response setResponseObject:@{KDataKeyData:@"上传图片失败"}];
    }else{
        [response setCode:WebAPIResponseCodeSuccess];
        [response setResponseObject:@{KDataKeyData:imageUrl}];
    }
    return response;
}


+ (id)responseWithUnserializedJSONDic:(id)returnData
{
    WebAPIResponse* response = [[self alloc] init];
    
    if (returnData == nil || ![returnData isKindOfClass:[NSDictionary class]])
    {
        [response setCode:WebAPIResponseCodeFailed];
        [response setCodeDescription:@"服务器返回数据异常"];
    }
    else{
        
        [response setCode:[ObjForKeyInUnserializedJSONDic((NSDictionary* )returnData, kCodeNameOnServer) integerValue]];
        [response setCodeDescription:ObjForKeyInUnserializedJSONDic((NSDictionary* )returnData, kCodeDescriptionNameOnServer)];
        [response setResponseObject:(NSDictionary* )returnData];
    }
    return response;
}
@end
