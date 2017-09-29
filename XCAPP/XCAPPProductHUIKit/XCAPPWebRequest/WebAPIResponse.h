//
//  WebAPIResponse.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @breif 网络请求错误默认提示信息
 * @See
 */
extern    NSString *const     WebAPIResponseCodeFailedErrorMark;

#pragma mark -WebAPIResponseCode(服务器WebAPI响应状态代码)
//From: 服务器端下发文档
typedef NS_ENUM(NSInteger, WebAPIResponseCode)
{
    WebAPIResponseCodeNetError              = 0,            /**< 网络请求错误 */
    WebAPIResponseCodeParamError            = 1,            /**< 请求参数错误 */
    WebAPIResponseCodeSuccess               = 100,          /**< = 100,服务器返回成功 */
    WebAPIResponseCodeSuccessForHundred     = 100,          /**< = 100,服务器返回成功 */
    WebAPIResponseCodeTokenError            = 300,          /**< 帐号信息验证失败（token验证失败）需要重新登录*/
    WebAPIResponseCodeUserError             = 141,          /**< 账户或者密码错误*/
    WebAPIResponseCodeFailed                = 200,          /**< = 200,服务器返回失败*/
    WebAPIResponseCodeResourcesError        = 144,          /**< 请求的资源不存在或者无法找到该服务*/
    WebAPIResponseCodeLoginedError          = 146,          /**< 该账户已在其他终端登录*/
    WebAPIResponseCodeNOSpeakError          = 147,          /**< 该账户禁止发言*/
    WebAPIResponseCodeTitleRecurError       = 148,          /**< 话题的标题或者内容和上一条重复*/
    WebAPIResponseCodeAnsweRecurError       = 149,          /**< 话题回复的内容和上一条重复*/
    WebAPIResponseCodeForceUpdateError      = 600           /**< 强制用户进行升级操作处理*/
};


@interface WebAPIResponse : NSObject


/**  code:   表示API操作的结果状态, 见WebAPIResponseCode
 */
@property (nonatomic, assign) WebAPIResponseCode     code;

/**  codeDescription:   是对code的解释说明. 文本内容几乎都是由服务器端返回
 */
@property (nonatomic, strong) NSString  *codeDescription;

/**  responseObject:    服务器返回的数据对象
 */
@property (nonatomic, strong) NSDictionary  *responseObject;

/**
 successedResponse
 返回code==WebAPIResponseCodeSuccess的WebAPIResponseCode对象
 */
+ (id)successedResponse;


/**
 invalidArgumentsResonse
 返回code==WebAPIResponseCodeParamError的WebAPIResponseCode对象
 */
+ (id)invalidArgumentsResonse;

+ (id)responseWithCode:(WebAPIResponseCode)code;
+ (id)responseWithCode:(WebAPIResponseCode)code description:(NSString *)codeDescription;


/**
 //根据返回JSON数据，构建response
 */
+ (id)responseWithUnserializedJSONDic:(id)returnData;

/**
 *
 *  上传图片成功，构建response
 *
 *  @param  imageUrl    图片地址内容
 *
 */
+ (id)uploadImagesuccessedResponse:(NSString *)imageUrl;

@end
