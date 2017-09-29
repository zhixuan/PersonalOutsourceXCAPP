//
//  HTTPClient+PersonalInfor.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient.h"
#import <CoreLocation/CoreLocation.h>

@interface HTTPClient (PersonalInfor)

#pragma mark -  用户登录操作请求数据
#pragma mark -
/**
 *  @method
 *
 *  @brief          用户登录操作请求数据
 *
 *  @param          phoneStr        手机号
 *
 *  @param          passwordStr     登录密码
 *
 *  @see            用户登录操作请求数据
 *
 */
- (AFHTTPRequestOperation *)userPersonalLoginWithPhoneStr:(NSString *)phoneStr
                                                 password:(NSString *)passwordStr
                                               completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  用户登录成功后，修改初始化密码
/**
 *  @method
 *
 *  @brief          用户登录成功后，修改初始化密码
 *
 *  @param          userId          用户ID
 *
 *  @param          passwordStr     登录密码
 *
 *  @see            pageSize        默认为15
 *
 */
- (AFHTTPRequestOperation *)userPersonalLoginFinishResetPwdWithUseId:(NSString *)userId
                                                            password:(NSString *)passwordStr
                                                          completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  根据用户ID获取用户个人账户信息
/**
 *  @method
 *
 *  @brief          根据用户ID获取用户个人账户信息
 *
 *  @param          userId          用户ID
 *
 *  @see            该账户需要登录状态
 *
 */
- (AFHTTPRequestOperation *)userPersonalCheckPersonalAccountInforWithUserId:(NSString *)userId
                                                                 completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 根据不同类别发送验证码信息
/**
 *  @method
 *
 *  @brief          根据不同类别发送验证码信息
 *
 *  @param          userId          当前用户ID
 *
 *  @param          phoneStr        手机号
 *
 *  @param          type            发送验证码类别
 *
 *  @see            type"0";//管理员邀请员工 "1";//找回密码 "2";//绑定手机号码 "3";//解除绑定手机号码
 *
 */
- (AFHTTPRequestOperation *)userSentMessageCodeWithUserId:(NSString *)userId
                                                 withType:(NSString *)typeStr
                                          withPhoneNumber:(NSString *)phoneStr
                                               completion:(WebAPIRequestCompletionBlock)completionBlock;




#pragma mark -
#pragma mark -  根据用户ID，验证当前验证码是否正确（用于找回密码、绑定手机号、解绑手机号操作）
/**
 *  @method
 *
 *  @brief          根据用户ID，验证当前验证码是否正确（用于找回密码、绑定手机号、解绑手机号操作）
 *
 *  @param          codeStr         验证码
 *
 *  @param          userId          用户ID
 *
 *  @see            根据用户ID，验证当前验证码是否正确
 *
 */
- (AFHTTPRequestOperation *)userPersonalCheckVerCodeWithUserId:(NSString *)userId
                                                       verCode:(NSString *)codeStr
                                                    completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  用户忘记密码，通过手机号找回密码, 第二步，重置新密码
/**
 *  @method
 *
 *  @brief          用户忘记密码，通过手机号找回密码, 第二步，重置新密码
 *
 *  @param          passwordStr     用户新密码
 *
 *  @param          userId          用户ID
 *
 *  @see            用户忘记密码，通过手机号找回密码, 第二步，重置新密码
 *
 */
- (AFHTTPRequestOperation *)userForgetPwdResetNewPassword:(NSString *)passwordStr
                                                   userId:(NSString *)userId
                                            completion:(WebAPIRequestCompletionBlock)completionBlock;
#pragma mark -
#pragma mark -  线路列表信息
/**
 *  @method
 *
 *  @brief          线路列表信息
 *
 *  @param          pageNumber      当前页码
 *
 *  @param          pageSize        每页数据量
 *
 *  @see            pageSize        默认为15
 *
 */
- (AFHTTPRequestOperation *)userPersonalCheckTravelRountListInforWithPageNumber:(NSInteger)pageNumber
                                                                       pageSize:(NSInteger)pageSize
                                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;
#pragma mark -
#pragma mark - 上传用户个人位置信息
/**
 *  @method
 *
 *  @brief          上传用户个人位置信息
 *
 *  @param          coordinate      用户当前位置
 *
 *  @param          userId          用户ID
 *
 *  @see            每次启动时需要定位操作
 *
 */
- (AFHTTPRequestOperation *)uploadUserPersonalLocation:(CLLocationCoordinate2D)coordinate
                                                userId:(NSString *)userId
                                               cityStr:(NSString *)cityNameStr
                                            completion:(WebAPIRequestCompletionBlock)completionBlock;
#pragma mark -
#pragma mark - 用户修改个人密码操作（在个人设置中修改密码）
/**
 *  @method
 *
 *  @brief          用户修改个人密码操作（在个人设置中修改密码）
 *
 *  @param          password        用户个人最新密码
 *
 *  @param          userId          用户ID
 *
 *  @see            用户须登录后进行密码修改
 *
 */
- (AFHTTPRequestOperation *)userResetupPassword:(NSString *)password
                                         userId:(NSString *)userId
                                     completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户个人退出登录操作
/**
 *  @method
 *
 *  @brief          用户个人退出登录操作
 *
 *  @param          userId          用户ID
 *
 *  @see            用户退出登录操作请求处理
 *
 */
- (AFHTTPRequestOperation *)userLogoutRequestWithUserId:(NSString *)userId
                                             completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户个人绑定手机号操作
/**
 *  @method
 *
 *  @brief          用户个人绑定手机号操作
 *
 *  @param          userId          用户ID
 *
 *  @param          phoneStr        手机号
 *
 *  @param          verCodeStr      验证码
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userBundlePhoneWithUserId:(NSString *)userId
                                             phoneStr:(NSString *)phoneStr
                                              verCode:(NSString *)verCodeStr
                                           completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户个人解除绑定手机号操作
/**
 *  @method
 *
 *  @brief          用户个人解除绑定手机号操作
 *
 *  @param          userId          用户ID
 *
 *  @param          phoneStr        手机号
 *
 *  @param          verCodeStr      验证码
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userCancelBundlePhoneWithUserId:(NSString *)userId
                                                   phoneStr:(NSString *)phoneStr
                                                    verCode:(NSString *)verCodeStr
                                                 completion:(WebAPIRequestCompletionBlock)completionBlock;



#pragma mark -
#pragma mark - 获取全部员工信息内容（包括管理员及员工信息）
/**
 *  @method
 *
 *  @brief          获取全部员工信息内容（包括管理员及员工信息）
 *
 *  @param          userId          当前用户ID
 *
 *  @param          companyId       用户所在公司ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userGetAllWorkerUserInforWithUserId:(NSString *)userId
                                                       userRole:(NSInteger)userRole
                                                     pageNumber:(NSInteger)pageNumber
                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;
#pragma mark -
#pragma mark - 用户添加员工信息内容
/**
 *  @method
 *
 *  @brief          用户添加员工信息内容
 *
 *  @param          userId          当前用户ID
 *
 *  @param          companyId       用户所在公司ID
 *
 *  @param          workerInfo      新员工用户信息
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userAddWorkerUserInforWithUserId:(NSString *)userId
                                                   companyId:(NSString *)companyId
                                                   worker:(UserInformationClass *)workerInfo
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户删除某个员工信息
/**
 *  @method
 *
 *  @brief          用户删除某个员工信息
 *
 *  @param          userId          当前用户ID
 *
 *  @param          workerId        员工ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userDeleteWorkerUserInforWithUserId:(NSString *)userId
                                                       workerId:(NSString *)workerId
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户添加入住酒店人员信息
/**
 *  @method
 *
 *  @brief          用户添加入住酒店人员信息
 *
 *  @param          userId          当前用户ID
 *
 *  @param          userNameStr     用户名字
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userAddMoveIntoUserWithUserId:(NSString *)userId
                                                 username:(NSString *)userNameStr
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;


- (AFHTTPRequestOperation *)getUserListInforWithCompletion:(WebAPIRequestCompletionBlock)completionBlock;


- (AFHTTPRequestOperation *)userDeleteNotifyMessageWithUserId:(NSString *)userid
                                                       pushId:(NSString *)pushIdStr
                                                   completion:(WebAPIRequestCompletionBlock)completionBlock;


@end
