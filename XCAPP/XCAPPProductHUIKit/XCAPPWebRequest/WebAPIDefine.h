//
//  WebAPIDefine.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef WebAPIDefine_h
#define WebAPIDefine_h

////////测试环境
#define KWebAPIURL                              @"http://121.42.29.208:8081/"
#define KWebResponseURL                         KWebAPIURL@""
//
//http://121.42.29.208:8081




////返回数据内容KEY
#pragma mark -
#pragma mark - 返回数据内容KEY
#define KDataKeyData                            @"data"
#define KDataKeyMsg                             @"desc"
#define KDataKeyCode                            @"code"
#define KDataKeyStateFlag                       @"flag"

///分页设置
#define KDataKeyCurrentPage                     @"pageNo"
#define KDataKeyPageSize                        @"pagesize"
#define KDataKeyPageTotal                       @"pages"
#define KDataKeyList                            @"list"

////常用参数信息
#pragma mark -
#pragma mark - 常用参数信息
#define KDataKeyUserId                          @"userId"
#define KDataKeyUserName                        @"name"
#define KDataKeyPassword                        @"password"
#define KDataKeyPhoneNumber                     @"mobile"
#define KDataKeyEmail                           @"email"
#define KDateKeyCityStr                         @"city"
#define KDataKeyLongitude                       @"longitude"
#define KDataKeyLatitude                        @"latitude"


#define KDataKeyHotelId                         @"hotelId"

#define KDataKeyHotelName                       @"hotelName"



#define KDataKeyVerCode                         @"vercode"

#define KDataKeyCompanyId                       @"companyid"

#define KDataKeyDateStr                         @"date"

///订单信息
#define KDataKeyOrderId                         @"orderid"


///火车票参数
#define KDataKeyFromStr                         @"from"
#define KDataKeyToCityStr                       @"to"



////用户个人信息接口
#pragma mark -
#pragma mark -  用户个人信息接口

///用户登录
#define KReqUserLoginURL                        @"login"
///更新经纬度请求URL
#define KReqResetLocationURL                    @"uploadUserPersonalLocation"
///用户登录成功后，修改密码
#define KReqLoginFinishResetPwdURL              @"userResetupPassword"
///查询用户个人账户信息
#define KReqCheckUserAccountURL                 @"user/query/userAccount"
///修改密码请求URL
#define KReqResetPwdURL                         @"userResetupPassword"
////用户推出登录
#define KReqUserLogoOutRequestURL               @"userLogoutRequestWithUserId"

#pragma mark -
#pragma mark -  更改手机
///用户绑定手机号请求URL
#define KReqBundlePhoneURL                      @"userBundlePhoneWithUserId"
///用户解除绑定手机号请求URL
#define KReqUnBundlePhoneURL                    @"userCancelBundlePhoneWithUserId"

#pragma mark -
#pragma mark -  员工信息
///用户添加员工信息内容
#define KReqAddWorkerUserURL                    @"userAddWorkerUserInfoWithUserId"
///删除某个员工信息
#define KReqDeleteItemWorkerUserURL             @"userDeleteWorkerUserInfoWithUserId"
///获取全部员工信息
#define KReqGetAllWorkerURL                     @"userGetAllWorkerUserInfoWithUserId"

///用户找回密码请求验证码
#define KReqSendVerCodeURL                      @"user/sendCode"
///用户忘记密码，验证验证码
#define KReqForgetPwdVerVerCodeURL              @"user/checkCode"
///用户忘记密码，重设新密码
#define KReqForgetPwdResetPwdURL                KReqLoginFinishResetPwdURL






///查找用户为出行的订单信息请求URL
#define KReqSearchUnGoOrderURL                  @"search/order"

///用户添加入住新用户信息（区别于员工信息）
#define KReqAddMoveIntoUserURL                  @"user/addmoveintouser"

///用户忘记密码，验证手机
#define KReqForgetPwdVerPhoneURL                @"user/forgetverphone"






//////////
////begin【无用】的接口名字

//酒店信息接口
#pragma mark -
#pragma mark -  酒店信息接口
///查找用户收藏酒店请求
#define KReqCollectHotelesURL                   @"hotel/collect"
///添加收藏酒店请求接口
#define KReqAddCollectHotelURL                  @"hotel/addcollect"
///删除某条收藏的酒店操作请求接口
#define KReqDeleteCollectHotelURL               @"hotel/deleteCollect"
///通过关键字筛选酒店请求接口
#define KReqSeekHotelForKeyURL                  @"hotel/seekforkey"
///酒店介绍接口
#define KReqHotelIntroductionURL                @"hotel/introduction"
///获取酒店房间信息
#define KReqHotelRoomListURL                    @"hotel/roomlist"

////end 【无用】的接口名字
//////////










#pragma mark -
#pragma mark - 酒店城市信息
/////酒店城市信息
#define KReqHotelAllCityListURL                 @"provList"
#pragma mark -
#pragma mark - 酒店城市对应的行政区域信息信息
/////酒店城市信息
#define KReqHotelCityAreaInforURL               @"areaList"

#pragma mark -
#pragma mark -  酒店模糊查询
/////酒店模糊查询
#define KReqHotelQueryLikeHotelListURL          @"hotel/queryLikeHotelList"

#pragma mark -
#pragma mark -  酒店模糊查询【酒店名分词模糊查询】
/////酒店模糊查询【酒店名分词模糊查询】
#define KReqHotellListForuserSearchKeyURL       @"hotel/queryLikeHotelNameList"

///查询酒店信息明细(按房型聚合)
#define KReqHotelRoomClassInforURL              @"hotel/userGetHotelDetailByKey"

///查询酒店信息明细(按房型聚合)
#define KReqHotelRoomDetailInforURL             @"hotel/userGetRoomListByKey"
////创建酒店预订订单
#define KReqHotelCreateOrderURL                 @"hotel/order"

////创建酒店预订订单
#define KReqHotelProceedGuaranteePayURL         @"pay/payCheck"

///用户取消酒店订单
#define KReqUserCancelHotelOrderURL             @"hotel/cancelorder"




////火车票接口内容
#pragma mark -
#pragma mark - 火车票接口内容
///绑定12306账户信息
#define KReqRelated12306AccountURL              @"user/12306/save"
///绑定12306账户信息
#define KReqQueryRelated12306AccountURL         @"user/12306/query"
///火车票订购常用城市请求接口
#define KReqXCTrainTicketCommonCitiesURL        @"train/citys"
///火车票订购推荐城市请求接口
#define KReqXCTrainTicketSearchSuggestCitiesURL @"train/suggest"
///请求火车票列表内容
#define KReqTrainTicketListURL                  @"train/search"
///验证用户信息
#define KXCAPPReqAddUserURL                     @"train/order/id/validate"

////添加火车票联系人
#define KReqAddTrainTicketUserURL               @"train/linkman/add"
////修改预订火车票联系人
#define KReqUpdateTrainTicketUserURL            @"train/linkman/update"
///删除火车票联系人
#define KReqDeleteTrainTicketUserURL            @"train/linkman/del"
///差选全部火车票联系人信息
#define ReqSelectedTrainTicketAllUsersURL       @"train/linkman/query"
///选座预定
#define KXCAPPReqTrainOrderBookingURL           @"train/order/booking"
///创建火车票订单，即下单操作接口
#define KReqTrainTicketCreateOrderURL           @"train/order/save"
///用户确认担保支付接口
#define KReqTrainTiketPayOrderURL               @"train/order/deal"
///用户取消订单操作接口
#define KReqUserCancleTrainTicketOrderURL       @"train/order/cancel"
///用户申请退款接口
#define KReqUserApplyForRefundURL               @"train/order/refund"
///退票手续查询
#define KReqUserCheckRefundProcedureURL         @"train/order/refund/prepare"

///火车票订单详情信息
#define KReqUserTTOrderItemDetailURL            @"train/order/orderDetail"



#pragma mark ///----------------
#pragma mark ///-----订单信息
#pragma mark ///----------------
#pragma mark -
#pragma mark - 订单信息
///请求用户个人订单列表
#define KReqOrderListURL                        @"pay/orderList"
///酒店订单详情信息接口
#define KReqOrderDetailForHotelURL              @"hotel/order/orderDetail"
















///请求用户个人订单列表
#define KReqOrderItemDetailURL                  @"order/detail"
///用户取消订单操作请求
#define KReqOrderCancelOperationURL             @"order/cancel"



///绑定12306账户信息
#define KReqRelatedAccountURL                   @"train/account"
///预订火车票
#define KReqReserveTrainTicketURL               @"train/reserve"




///测试推送接口信息
#define KReqNotifyDeleteURL                     @"notify/deleteNotifyMsg"




////////////测试环境--本机环境
//#define KWebAPIURL                              @"http://121.42.29.208:8081"
//#define KWebResponseURL                         KWebAPIURL@""
//
/////////////正式环境
//#define KWebAPIURL                              @"https://mobile.lvye.cn/"
//#define KWebResponseURL                         KWebAPIURL@""
/////////用于网页信息分享设置
#define KWebShareResponseURL                    @"http://mobile.lvye.cn/"



#define KAiPuPayForZFBPayURL                KWebResponseURL@"/calback/zfb/pay"
#define KAiPuPayForWeChatPayURL             KWebResponseURL@"/calback/wx/pay"

#define KLYQiYunHeaderURL                   @"http://mobile-res.lvye.cn/"

#endif /* WebAPIDefine_h */
