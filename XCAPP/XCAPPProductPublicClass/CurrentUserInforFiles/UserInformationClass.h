//
//  UserInformationClass.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformationClass : NSObject

/*!
 * @breif 用户ID
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPerId;

/*!
 * @breif 用户登录状态设置
 * @See 默认为NO，未登录状态；YES，为登录状态；NO，为未登录状态；
 */
@property (nonatomic , assign)      BOOL                        userLoginState;
/*!
 * @breif 用户名(真实姓名)
 * @See 证件上对应的名字
 */
@property (nonatomic , copy)      NSString                      *userNameStr;

/*!
 * @breif 用户昵称 （显示名字）
 * @See
 */
@property (nonatomic , copy)      NSString                      *userNickNameStr;

/*!
 * @breif 用户头像URL地址
 * @See
 */
@property (nonatomic , copy)      NSString                      *userHeaderImageURLStr;

/*!
 * @breif 用户个人年龄信息
 * @See 默认为15岁
 */
@property (nonatomic , assign)      NSInteger                   userAgeInteger;

/*!
 * @breif 用户个人性别
 * @See 1表示男，2表示女，0表示未知；默认为1，即男
 */
@property (nonatomic , assign)      XCAPPUserGenderStyle        userGenderInteger;

/*!
 * @breif 用户个人手机号
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPerPhoneNumberStr;

/*!
 * @breif 用户个人邮箱信息
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPerEmailStr;

/*!
 * @breif 用户所在公司ID
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPerAtCompanyId;
/*!
 * @breif 用户所持证件类型
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPerCredentialStyle;

/*!
 * @breif 用户所持证件编号
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPerCredentialContent;

/*!
 * @breif 用户当前位置信息
 * @See
 */
@property (nonatomic , assign)      CLLocationCoordinate2D      userCoordinate;

/*!
 * @breif 用户个人身份说明
 * @See
 */
@property (nonatomic , assign)      XCAPPUserOptionRoleStyle        userOptionRoleStyle;



/**
 *  @method
 *
 *  @brief          初始化员工管理中员工及管理员信息内容
 *
 *  @param          dicInfor    JSON数据
 *
 *  @see            null
 *
 */
+ (id)initializaionWithUserForWorkerAndAdminInforWithJSONDic:(NSDictionary *)dicInfor;

/**
 *  @method
 *
 *  @brief          初始化火车票订购中乘客信息数据
 *
 *  @param          dicInfor    JSON数据
 *
 *  @see            null
 *
 */
+ (id)initializaionWithUserForTrainTicketUserInforWithJSONDic:(NSDictionary *)dicInfor;


/**
 *  @method
 *
 *  @brief          解析火车票订单详情中，乘客用户数据信息
 *
 *  @param          dicInfor    JSON数据
 *
 *  @see            null
 *
 */
+ (id)initializaionWithOrderForUserTrainTicketWithJSONDic:(NSDictionary *)dicInfor;

//+ (id)ini

/**
 *  @method
 *
 *  @brief          初始化添加员工信息参数内容
 *
 *  @discussion     <#discussion#>\ref
 *
 *  @return         <#return#>
 *
 */
- (NSMutableDictionary *)addNewWorkerInforReqParam;

/**
 *  @method
 *
 *  @brief          初始化火车票验证用户信息接口参数信息
 *
 *  @discussion     <#discussion#>\ref
 *
 *  @return         <#return#>
 *
 */
- (NSMutableDictionary *)setupTrainTicketUserInforReqParam;


/**
 *  @method
 *
 *  @brief          初始化添加火车票预订联系人参数信息内容
 *
 *  @discussion     这里的用户ID，是当前登录用户ID，需要填写\ref
 *
 *  @return         <#return#>
 *
 */
- (NSMutableDictionary *)setupAddTrainTicketUserInforReqParam;

/**
 *  @method
 *
 *  @brief          初始化更新修改火车票预订联系人参数信息内容
 *
 *  @discussion     这里的用户ID，是需要修改的预订联系人的用户ID，需要填写\ref
 *
 *  @return         <#return#>
 *
 */
- (NSMutableDictionary *)setupUpdateTrainTicketUserInforReqParam;

/**
 *  初始化订购火车票乘客用户信息
 **/
- (NSMutableDictionary *)setupInitWithUserTravellerReserveParameterWithItemPrice:(NSString *)priceStr seatType:(NSString *)typeStr;

/**
 *  初始化预订酒店入住人员信息
 **/
- (NSMutableDictionary *)setupInitWithUserHotelReserveParameter;

/**
 *  初始化用户退票操作用户信息
 **/
- (NSMutableDictionary *)setupUserPersonalForTrainUserRefundParameter;
@end
