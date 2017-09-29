//
//  MoreSiftRequirementController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/3.
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


@protocol MoreSiftRequirementDelegate <NSObject>

- (void)moreSiftRequirementButtonOperationEventWithAreaCode:(NSString *)areaCodeStr;

@end

/**
 *  @method 酒店更多筛选条件
 *
 *  @brief
 */
@interface MoreSiftRequirementController : XCAPPUIViewController


- (id)initWithCityCodeStr:(NSString *)cityCode;
/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<MoreSiftRequirementDelegate>         delegate;

@end
//:-D QQ 10990  28580