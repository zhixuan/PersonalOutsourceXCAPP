//
//  XCCurrentUserInfo.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UserInformationClass.h"

#define KXCAPPCurrentUserInformation [XCCurrentUserInfo shareCurrentUserInformation]


@interface XCCurrentUserInfo : NSObject

/*!
 * @breif 用户ID
 * @See
 */
@property (nonatomic , copy)      NSString              *userPerId;

/*!
 * @breif 用户登录状态设置
 * @See 默认为NO，未登录状态；YES，为登录状态；NO，为未登录状态；
 */
@property (nonatomic , assign)      BOOL                userLoginState;


/*!
 * @breif 账户余额信息
 * @See
 */
@property (nonatomic , assign)      CGFloat             userAccountBalanceFloat;
/*!
 * @breif 用户名(真实姓名)
 * @See 证件上对应的名字
 */
@property (nonatomic , copy)      NSString              *userNameStr;

/*!
 * @breif 用户昵称 （显示名字）
 * @See
 */
@property (nonatomic , copy)      NSString              *userNickNameStr;

/*!
 * @breif 用户所持证件类型
 * @See
 */
@property (nonatomic , copy)      NSString              *userPerCredentialStyle;

/*!
 * @breif 用户所持证件编号
 * @See
 */
@property (nonatomic , copy)      NSString              *userPerCredentialContent;

/*!
 * @breif 用户头像URL地址
 * @See
 */
@property (nonatomic , copy)      NSString              *userHeaderImageURLStr;

/*!
 * @breif 用户个人年龄信息
 * @See 默认为15岁
 */
@property (nonatomic , assign)      NSInteger           userAgeInteger;

/*!
 * @breif 用户个人性别
 * @See 1表示男，2表示女，0表示未知；默认为1，即男
 */
@property (nonatomic , assign)      XCAPPUserGenderStyle userGenderInteger;

/*!
 * @breif 用户个人手机号
 * @See
 */
@property (nonatomic , copy)      NSString              *userPerPhoneNumberStr;

/*!
 * @breif 用户个人邮箱信息
 * @See
 */
@property (nonatomic , copy)      NSString              *userPerEmailStr;

/*!
 * @breif 用户所在公司ID
 * @See
 */
@property (nonatomic , copy)      NSString              *userPerAtCompanyId;


/*!
 * @breif 用户当前位置信息
 * @See
 */
@property (nonatomic , assign)      CLLocationCoordinate2D      userCoordinate;

/*!
 * @breif 用户基本信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass        *userInfor;

/*!
 * @breif 用户个人身份说明
 * @See
 */
@property (nonatomic , assign)      XCAPPUserOptionRoleStyle        userOptionRoleStyle;

/*!
 * @breif 用户订购的票务类型数据
 * @See     成人票，儿童票  0：儿童票；1：成人票， 默认 为成人票
 */
@property (nonatomic , copy)      NSString                  *userTrakTickedStyle;


/**
 *  初始化当前用户信息单例数据
 **/
+(XCCurrentUserInfo *)shareCurrentUserInformation;

/**
 *  初始化当前登录用户信息
 **/
- (void)initUserLoginFinishInfor:(NSDictionary *)userDic;


/**
 *  用户退出登录后，清空用户个人信息内容
 **/
- (void)initUserLogOutFinishAndClearUserInfor;
@end
