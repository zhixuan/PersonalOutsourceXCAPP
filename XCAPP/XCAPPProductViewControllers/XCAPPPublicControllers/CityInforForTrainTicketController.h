//
//  CityInforForTrainTicketController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/21.
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

@protocol CityInforForTrainTicketDelegate <NSObject>

- (void)userSelectedCityInforCityName:(NSString *)citynameStr cityCode:(NSString *)cityCodeStr style:(UserSelectedCityStyle)style;
@end
/**
 *  @method
 *
 *  @brief
 */
@interface CityInforForTrainTicketController : XCAPPUIViewController

/*!
 * @breif 选择操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<CityInforForTrainTicketDelegate>       delegate;
- (id)initWithTitleStr:(NSString *)titleStr style:(UserSelectedCityStyle)style;
@end
//:-D QQ 10990  28580