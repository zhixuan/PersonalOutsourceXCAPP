//
//  HotelReserveMainViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCAPPUIViewController.h"


/**
 *  @method
 *
 *  @brief          酒店预订主页
 *
 */
@interface HotelReserveMainViewController : XCAPPUIViewController

/**
 *  @method
 *
 *  @brief          初始化酒店搜索条件设置
 *
 *  @param          stateStyle 说明用户是因公，还是因私
 *
 */
- (id)initWithMatterStateStyle:(UserMatterStateStyle)stateStyle;
@end
