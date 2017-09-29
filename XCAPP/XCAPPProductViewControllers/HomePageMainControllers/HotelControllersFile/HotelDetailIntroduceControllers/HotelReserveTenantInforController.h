//
//  HotelReserveTenantInforController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/19.
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


@protocol HotelReserveTenantOperationDelegate <NSObject>

- (void)userSelectedTenantUserArray:(NSArray *)userArray isDeleteSelectedBool:(BOOL)deleteBool;

@end

#import "XCAPPUIViewController.h"

/**
 *  @method     酒店房客信息（所有房客信息内容）
 *
 *  @brief
 */
@interface HotelReserveTenantInforController : XCAPPUIViewController

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<HotelReserveTenantOperationDelegate> delegate;
- (id)initWithTitleStr:(NSString *)title withSelected:(NSArray *)userArray;
@end
//:-D QQ 10990  28580