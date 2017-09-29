//
//  FlightAccurateSiftController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/16.
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



@protocol FlightAccurateSiftDelegate <NSObject>

- (void)userSelectedSiftInforStartDate:(NSString *)dateStr type:(NSString *)typeStr
                                 cabin:(NSString *)cabinStr company:(NSString *)companyStr;

@end
/**
 *  @method 航班信息精确筛选
 *
 *  @brief  起飞时间/机型/舱位/航空公司等4类信息
 */
@interface FlightAccurateSiftController : XCAPPUIViewController


/*!
 * @breif 用户操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<FlightAccurateSiftDelegate>      delegate;
@end
//:-D QQ 10990  28580