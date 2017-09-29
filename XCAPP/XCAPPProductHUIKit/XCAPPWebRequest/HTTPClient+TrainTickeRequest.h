//
//  HTTPClient+TrainTickeRequest.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/10.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient.h"




#pragma mark -
#pragma mark -  请求火车票数据信息
///请求火车票数据信息
@interface HTTPClient (TrainTickeRequest)

#pragma mark -
#pragma mark - 获取选择火车票出发地及到达目的城市内容
/**
 *  @method
 *
 *  @brief          获取选择火车票出发地及到达目的城市内容
 *
 *  @see            无
 *
 */
- (AFHTTPRequestOperation *)requestTrainTicketCitiesInformationCompletion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 火车票订购--通过搜索关键字搜索推荐城市信息
/**
 *  @method
 *
 *  @brief          火车票订购--通过搜索关键字搜索推荐城市信息
 *
 *  @param          searchKeyStr    城市搜索关键字
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestTrainTicketRecommendCitiesInforWithSearchKey:(NSString *)searchKeyStr
                                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 查询火车票（From - To）
/**
 *  @method
 *
 *  @brief          查询火车票（From - To）
 *
 *  @param          fromStr         出发地
 *
 *  @param          toStr           到达地
 *
 *  @param          departDate      出发时间
 *
 *  @param          isHsBool        是否只看高速动车
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestTrainTickeListFrom:(NSString *)fromStr
                                                   to:(NSString *)toStr
                                                 date:(NSString *)departDate
                                             isHSBool:(BOOL)isHsBool
                                              orderby:(NSString *)orderbyStr
                                              descend:(NSInteger)isDescend
                                             seatType:(NSString *)seatTypeStr
                                            trainType:(NSString *)trainTypeStr
                                             fromType:(NSString *)fromTypeStr
                                               toType:(NSString *)toTypeStr
                                           completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 关联12306账户
/**
 *  @method
 *
 *  @brief          关联12306账户
 *
 *  @param          userId          当前用户ID
 *
 *  @param          nameStr         账户名
 *
 *  @param          password        账户密码
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestRelatedAccountUserId:(NSString *)userId
                                                   name:(NSString *)nameStr
                                                   pswd:(NSString *)password
                                             completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 查看用户是否已经进行关联12306账户操作
/**
 *  @method
 *
 *  @brief          查看用户是否已经进行关联12306账户操作
 *
 *  @param          userId          当前用户ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestCheckUserIsRelatedAccountWithUserId:(NSString *)userId
                                                            completion:(WebAPIRequestCompletionBlock)completionBlock;



#pragma mark -
#pragma mark - 火车票中验证用户个人信息
/**
 *  @method
 *
 *  @brief          火车票中验证用户个人信息    （即添加用户个人信息)
 *
 *  @param          userInfor               用户信息
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestAddMemberUserInfor:(UserInformationClass *)userInfor
                                           completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 预订时判断该选择的座位是否合法
/**
 *  @method
 *
 *  @brief          预订时判断该选择的座位是否合法
 *
 *  @param          trainNoStr              车次
 
 *  @param          fromStr                 出发地
 
 *  @param          toStr                   到达地
 
 *  @param          dateStr                 出发时间
 
 *  @param          seatTypeStr             坐席类型
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestVerifyTrainTickeValidAndReserveWithTrainNo:(NSString *)trainNoStr
                                                                         from:(NSString *)fromStr
                                                                           to:(NSString *)toStr
                                                                         date:(NSString *)dateStr
                                                                     seatType:(NSString *)seatTypeStr
                                                                   completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 用户创建火车票订单提交操作请求
/**
 *  @method
 *
 *  @brief          用户创建火车票订单提交操作请求
 *
 *  @param          orderParam 订单数据信息内容
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestUserCreateTrainTickeOrderWithOrderParam:(TrainticketOrderInformation *)orderParam
                                                                completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户确认担保支付操作接口
/**
 *  @method
 *
 *  @brief          用户确认担保支付操作接口
 *
 *  @param          userId              用户ID
 *
 *  @param          orderNoStr          订单ID
 *
 *  @param          qunarOrderNoStr     去哪网订单ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestUserProceedGuaranteePayWithUserId:(NSString *)userId
                                                             orderNo:(NSString *)orderNoStr
                                                        qunarOrderNo:(NSString *)qunarOrderNoStr
                                                          completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户取消订单操作接口《取消订单》
/**
 *  @method
 *
 *  @brief          用户取消订单操作接口《取消订单》对应的接口为 Get方式的 train/order/cancel \ref区别于train/order/refund【申请退款】
 *
 *  @param          userId              用户ID
 *
 *  @param          orderNoStr          订单ID
 *
 *  @param          qunarOrderNoStr     去哪网订单ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 *  @waring         对应的接口为 Get方式的 train/order/cancel \ref区别于train/order/refund【申请退款】
 *
 */
- (AFHTTPRequestOperation *)requestUserPersonalCancelOrderWithUserId:(NSString *)userId
                                                             orderNo:(NSString *)orderNoStr
                                                        qunarOrderNo:(NSString *)qunarOrderNoStr
                                                          completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 请求查看退票手续查询
/**
 *  @method
 *
 *  @brief          请求查看退票手续查询
 *
 *  @param          userId              用户ID
 *
 *  @param          orderNoStr          订单ID
 *
 *  @param          qunarOrderNoStr     去哪网订单ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestUserCheckTrainTicketOrderRefundPrepareWithUserId:(NSString *)userId
                                                                            orderNo:(NSString *)orderNoStr
                                                                       qunarOrderNo:(NSString *)qunarOrderNoStr
                                                                         completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 用户申请退票接口
/**
 *  @method
 *
 *  @brief          【无用接口】用户申请退票接口
 *
 *  @param          userId              用户ID
 *
 *  @param          orderNoStr          订单ID
 *
 *  @param          qunarOrderNoStr     去哪网订单ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestUserApplyForRefundOrderTrainTicketWithUserId:(NSString *)userId
                                                                        orderNo:(NSString *)orderNoStr
                                                                   qunarOrderNo:(NSString *)qunarOrderNoStr
                                                                        comment:(NSString *)commentStr
                                                                     passengers:(NSString *)passengersStr
                                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户申请退票接口(从订单列表中操作)
/**
 *  @method
 *
 *  @brief          用户申请退票接口(从订单列表中操作)
 *
 *  @param          orderParam          订单信息
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestUserApplyForRefundOrderTrainTicketWithOrderInfor:(TrainticketOrderInformation *)orderParam
                                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 新增火车票预订票联系人
/**
 *  @method
 *
 *  @brief          新增火车票预订票联系人
 *
 *  @param          userInfor       用户信息
 *
 *  @see            userid  当前登录用户ID	 \ref idType 证件类型，0身份证，4护照，6港澳通行证，7台胞证	Y   \ref idNumber   证件号码	Y   \ref linkName 联系人名字
 *
 */
- (AFHTTPRequestOperation *)requestAddTrainUserDirectoryInforWithUser:(UserInformationClass *)userInfor
                                                           completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  编辑 - 火车票预订联系人编辑
/**
 *  @method
 *
 *  @brief          编辑 - 火车票预订联系人编辑
 *
 *  @param          userInfor       用户信息
 *
 *  @see            userid  当前登录用户ID	 \ref idType 证件类型，0身份证，4护照，6港澳通行证，7台胞证	Y \ref idNumber   证件号码	Y   \ref linkName 联系人名字
 *
 */
- (AFHTTPRequestOperation *)requestUpdateTrainUserDirectoryInforWithUser:(UserInformationClass *)userInfor
                                                           completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  删除 - 火车票预订联系人删除
/**
 *  @method
 *
 *  @brief          删除 - 火车票预订联系人删除
 *
 *  @param          userID      将要被删除联系人的ID
 *
 *  @see            【注意】：不是当前登录人的ID，而是将要被删除联系人的ID
 *
 */
- (AFHTTPRequestOperation *)requestDeleteTrainUserDirectoryInforItemWithUserID:(NSString *)userID
                                                              completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  查询全部联系人信息 --- 查询预订过火车票的全部联系人信息内容
/**
 *  @method
 *
 *  @brief          查询全部联系人信息 --- 查询预订过火车票的全部联系人信息内容 
 *
 *  @param          userId          当前登录者的用户ID
 *
 *  @param          pageNumber      当前请求数据的当前显示页面nextPage
 *
 *  @see            【注意】：userId是当前登录人的ID
 *
 */
- (AFHTTPRequestOperation *)requestAllTrainUserDirectoryInforWithUserId:(NSString *)userId
                                                               nextPage:(NSInteger)nextPage
                                                             completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  根据订单ID查询火车票订单详细信息内容
/**
 *  @method
 *
 *  @brief          根据订单ID查询火车票订单详细信息内容
 *
 *  @param          orderID         火车票订单ID
 *
 *  @see
 *
 */
//KReqUserTTOrderItemDetailURL
- (AFHTTPRequestOperation *)requestTrainTicketItemOrderDetailInforWtihOrderId:(NSString *)orderID
                                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;



@end
