//
//  HotelMoveIntoDateController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/19.
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


@protocol HotelMoveIntoDateSelectedDelegate <NSObject>

- (void)userMoveIntoDateSelectedDateStr:(NSString *)dateStr;

@end

#import "XCAPPUIViewController.h"
/**
 *  @method
 *
 *  @brief  入住酒店日期选择
 */
@interface HotelMoveIntoDateController : XCAPPUIViewController
/*!
 * @breif 用户操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<HotelMoveIntoDateSelectedDelegate> delegate;
@end
//:-D QQ 10990  28580