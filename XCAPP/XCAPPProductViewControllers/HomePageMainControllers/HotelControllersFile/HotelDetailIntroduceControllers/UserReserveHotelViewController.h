//
//  UserReserveHotelViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//
/*
 *
 *   ╭＾＾★╮╭＾＾☆╮
 *  {/ ． ．\}{/ ． ．\}
 *  (　 (oo) )(　 (oo) )  总是加班会死人的的....
 *
 *
 *
 */

#import "XCAPPUIViewController.h"
#import "UserHotelOrderInformation.h"
/**
 *  @method
 *
 *  @brief  用户预订酒店操作界面（填写订单界面）
 *
 *  @See
 */
@interface UserReserveHotelViewController : XCAPPUIViewController
/*!
 * @breif 用户选中的酒店信息订单信息
 * @See
 */
- (id)initWithUserOrderInfor:(UserHotelOrderInformation *) willOrderInfor;
@end
//:-D QQ 10990  28580