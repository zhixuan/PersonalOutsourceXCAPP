//
//  CityInforViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/17.
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



//typedef NS_ENUM
@protocol SelectedCityInforDelegate <NSObject>


/**
 *  @method
 *
 *  @brief          用户选择出发地/目的地后得到的数据信息
 *
 *  @param          citynameStr         城市名字
 *
 *  @param          cityCodeStr         城市编号
 *
 */
- (void)userSelectedCityName:(NSString *)citynameStr cityCode:(NSString *)cityCodeStr style:(UserSelectedCityStyle)style;

@end
/**
 *  @method
 *
 *  @brief
 */
@interface CityInforViewController : XCAPPUIViewController


/*!
 * @breif 选择操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<SelectedCityInforDelegate>       delegate;
- (id)initWithTitleStr:(NSString *)titleStr style:(UserSelectedCityStyle)style;
@end
//:-D QQ 10990  28580