//
//  HotelMainListInforViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
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


/**
 *  @method 酒店列表信息
 *
 *  @brief
 */
@interface HotelMainListInforViewController : XCAPPUIViewController


/**
 *  @method
 *
 *  @brief          初始化酒店搜索界面信息
 *
 *  @param          stateStyle 说明用户是因公，还是因私
 *
 */
- (id)initWithMatterStateStyle:(UserMatterStateStyle)stateStyle locationInfor:(XCLocationAPIResponse *)locationInfor searchInfor:(UserHotelOrderInformation*)orderInfor;


@end
//:-D QQ 10990  28580