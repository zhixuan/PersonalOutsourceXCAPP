//
//  HTTPClient+HotelsRequest.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/29.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient.h"


/**
 *  @method
 *
 *  @brief          酒店信息查询
 *
 */
@interface HTTPClient (HotelsRequest)

#pragma mark -
#pragma mark -  用户获取酒店所在的城市信息
/**
 *  @method
 *
 *  @brief          用户获取酒店所在的城市信息
 *
 *  @see            无参数
 *
 */
- (AFHTTPRequestOperation *)userRequestCityInforForHotelCompletion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  用户根据城市编号获取该市下对应的行政区域信息
/**
 *  @method
 *
 *  @brief          用户根据城市编号获取该市下对应的行政区域信息
 *
 *  @param          cityCode
 *
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userRequestAdministrativeAreaInforForHotelWithCityCode:(NSString *)cityCode
                                                                        completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  用户通过位置或者酒店名模糊查找信息
/**
 *  @method
 *
 *  @brief          用户通过位置或者酒店名模糊查找信息
 *
 *  @param          cityStr             酒店所在城市名(模糊查询
 *
 *  @param          areIdStr            行政区域id
 *
 *  @param          hnameStr            酒店名(模糊查)
 
 *  @param          maxPrice            最低价
 
 *  @param          minPriceStr         最高价
 
 *  @param          starStyle           酒店星级
 
 *  @param          pageRow             页码
 *
 *  @see            searchKeyStr 可以是酒店名或者是位置，\ref eg.北京天坛、七天，宜家，如家等
 *
 */
- (AFHTTPRequestOperation *)userRoughSearchHotelListInforWithCityName:(NSString *)cityStr
                                                               areaId:(NSString *)areIdStr
                                                                hName:(NSString *)hnameStr
                                                             maxPrice:(NSString *)maxPrice
                                                             minPrice:(NSString *)minPriceStr
                                                                hStar:(NSString *)starStyle
                                                              pageRow:(NSInteger)pageRow
                                                                field:(NSString *)SequenceStr
                                                               upDown:(NSInteger)updownType
                                                           completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  通过用户输入的位置或者酒店名字信息进行筛选操作【酒店名分词模糊查询】
/**
 *  @method
 *
 *  @brief          通过用户输入的位置或者酒店名字信息进行筛选操作【酒店名分词模糊查询 】
 *
 *  @param          hnameStr            酒店名(模糊查)

 *  @param          pageRow             页码
 *
 *  @see            searchKeyStr 可以是酒店名或者是位置，\ref eg.北京天坛、七天，宜家，如家等
 *
 */
- (AFHTTPRequestOperation *)userRoughSearchHotelListInforWithHotelName:(NSString *)hnameStr
                                                                pageRow:(NSInteger)pageRow
                                                           completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  获取酒店聚合房型信息（聚合房型信息一级界面数据）
/**
 *  @method
 *
 *  @brief          通过酒店ID，获取酒店聚合房型信息（聚合房型信息一级界面数据）
 *
 *  @param          hotelID             酒店ID
 *
 *  @see            查询酒店信息明细(按房型聚合)
 *
 */
- (AFHTTPRequestOperation *)userRequestHotelDetailInforWithHotelID:(NSString *)hotelID
                                                        completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark -  用户根据房型信息获取全部该房型下的所有房间信息（酒店预订房型聚合二级列表数据请求）
/**
 *  @method
 *
 *  @brief          用户根据房型信息获取全部该房型下的所有房间信息（酒店预订房型聚合二级列表数据请求）
 *
 *  @param          roomId      聚合房型一级界面中房型ID
 *
 *  @param          beginDate   酒店预订开始时间
 *
 *  @param          endDate     酒店预订结束时间
 *
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userRequestDetailRoomsInforWithRoomId:(NSString *)roomId
                                                        beginDate:(NSString *)beginDate
                                                          endDate:(NSString *)endDate
                                                       completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -  获取全部房客信息内容（主要是姓名等信息）
/**
 *  @method
 *
 *  @brief          获取全部房客信息内容（主要是姓名等信息）
 *
 *  @param          userID          当前登录者ID
 *
 *  @param          pageRow         页码
 *
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userRequestReserveTenantUserInforListWithUserId:(NSString *)userID
                                                                        row:(NSInteger)pageRow
                                                                 completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 添加酒店预订房客人员（主要是姓名信息）
/**
 *  @method
 *
 *  @brief          添加酒店预订房客人员（主要是姓名信息）
 *
 *  @param          userID          当前登录者ID
 *
 *  @param          nameStr         房客姓名
 *
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userRequestAddReserveTenantUserInforWithUserID:(NSString *)userId
                                                                  userName:(NSString *)nameStr
                                                                completion:(WebAPIRequestCompletionBlock)completionBlock;


#pragma mark -
#pragma mark - 登录用户预订酒店创建订单
/**
 *  @method
 *
 *  @brief          登录用户预订酒店创建订单
 *
 *  @param          hotelOrder      订单信息
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userRequestCreateHotelReserveOrderWithOrderInfor:(UserHotelOrderInformation *)hotelOrder
                                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户酒店预订成功，进行担保支付操作
/**
 *  @method
 *
 *  @brief          用户酒店预订成功，进行担保支付操作
 *
 *  @param          userId          用户ID
 *
 *  @param          orderIdStr      订单ID
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userRequestGotoProceedGuaranteePayForPayCheck:(NSString *)userId
                                                                  orderId:(NSString *)orderIdStr
                                                               completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 用户通过个人订单号，取消订单
/**
 *  @method
 *
 *  @brief          用户通过个人订单号，取消订单
 *
 *  @param          orderID      订单ID
 *  @see
 *
 */
- (AFHTTPRequestOperation *)userOperationHotelOrderForCancelOrderWithOrderID:(NSString *)orderID
                                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;


































#pragma mark -
#pragma mark -
#pragma mark -  =================================
#pragma mark -  一下是无用的内容【无用】
#pragma mark -  =================================
#pragma mark -







#pragma mark -
#pragma mark - 【无用】 用户通过位置或者酒店名模糊查找信息
/**
 *  @method
 *
 *  @brief          【无用】用户通过位置或者酒店名模糊查找信息
 *
 *  @param          searchKeyStr    搜索关键字
 *
 *  @see            searchKeyStr 可以是酒店名或者是位置，\ref eg.北京天坛、七天，宜家，如家等
 *
 */
- (AFHTTPRequestOperation *)userSearchHotelWithSearchKeyStr:(NSString *)searchKeyStr
                                                 completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark -   【无用】获取用户个人出行差旅标准
/**
 *  @method
 *
 *  @brief          【无用】获取用户个人出行差旅标准
 *
 *  @param          userID          用户ID
 *
 *  @see            不同用户对应的差旅标准不一定相同
 *
 */
- (AFHTTPRequestOperation *)userBusinessTravelExplainWithUserID:(NSString *)userID
                                                     completion:(WebAPIRequestCompletionBlock)completionBlock;
#pragma mark -
#pragma mark - 【无用】用户个人收藏的酒店信息
/**
 *  @method
 *
 *  @brief          【无用】用户个人收藏的酒店信息
 *
 *  @param          userId          用户ID
 *
 *  @see            用户需要登录状态下查找用户个人收藏的酒店信息
 *
 */
- (AFHTTPRequestOperation *)userCollectHotelInforWithUserId:(NSString *)userId
                                                 completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 【无用】用户个人添加收藏酒店信息
/**
 *  @method
 *
 *  @brief          【无用】用户个人添加收藏酒店信息
 *
 *  @param          userId          用户ID
 *
 *  @param          hotelId         酒店ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userAddCollectItemHotelWithUserId:(NSString *)userId
                                                      hotelId:(NSString *)hotelId
                                                   completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 【无用】用户个人删除某条已收藏的酒店信息
/**
 *  @method
 *
 *  @brief          【无用】用户个人删除某条已收藏的酒店信息
 *
 *  @param          userId          用户ID
 *
 *  @param          hotelId         酒店ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)userDeleteCollectItemHotelWithUserId:(NSString *)userId
                                                         hotelId:(NSString *)hotelId
                                                      completion:(WebAPIRequestCompletionBlock)completionBlock;
#pragma mark -
#pragma mark - 【无用】查询酒店介绍信息
/**
 *  @method
 *
 *  @brief          【无用】查询酒店介绍信息
 *
 *  @param          hotelId         酒店ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)hotelIntroductionWithHotelId:(NSString *)hotelid
                                              completion:(WebAPIRequestCompletionBlock)completionBlock;

#pragma mark -
#pragma mark - 【无用】查询某个酒店里所有房间信息
/**
 *  @method
 *
 *  @brief          【无用】查询某个酒店里所有房间信息
 *
 *  @param          hotelId         酒店ID
 *
 *  @param          pageSize        页面大小
 *
 *  @param          pageRow         当前页面
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)hotelAllRoomInforListWithHotelId:(NSString *)hotelid
                                                    pageSize:(NSInteger)pageSize
                                                     pageRow:(NSInteger)pageRow
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock;



@end
