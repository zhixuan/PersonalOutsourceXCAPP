//
//  XCAPPNotificationNameUIKit.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef XCAPPNotificationNameUIKit_h
#define XCAPPNotificationNameUIKit_h

#pragma mark -
#pragma mark -  ----------------------
#pragma mark -  【注】内容信息传递通知--通知名字
#pragma mark -  -----------------------
#pragma mark -
///MARK:用户从其他模块进入“我的”模块时，刷新界面数据内容
#define KXCAPPUserIntoPersonalFromOtherRefreshDataNotification  @"USERINTOPERSONALFROMOTHERREFRESHDATANOTIFICATION"
///MARK:用户修改个人密码成功通知
#define KXCAPPUserResetPasswrodFinishNotification               @"UserResetPasswrodFinishNotification"
///MARK:用户添加员工信息成功通知
#define KXCAPPUserAddNewWorkerSuccessFinishNotification         @"USERADDNEWWORKERSUCCESSFINISHNOTIFICATION"
///MARK:用户绑定或者解除手机号操作结束后通知其他界面
#define KXCAPPUserBundleAndUnbundlePhoneSuccessFinishNotification   @"USERBUDLEANDUNBUNDLEPHONESUCCESSFINISHNOTIFICATION"
///MARK:用户退出登录操作通知
#define KXCAPPUserLogoutSuccessFinishNotification               @"USERLOGOUTSUCCESSFINISHNOTIFICATION"
///MARK:刷新订单列表界面信息
#define KXCAPPUserRefreshUserOrderDataNotification              @"XCAPPUSERREFRESHUSERORDERDATANOTIFICATION"
///MARK:用户支付订单或者退单后主动查询客户余额
#define KXCAPPUserPersonalCheckPersonalAccountInforNotification @"XCAPPUSERPERSONALCHECKPERSONALACCOUNTINFORNOTIFICATION"

#endif /* XCAPPNotificationNameUIKit_h */
