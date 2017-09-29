//
//  AppDelegate+ServeOperation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AppDelegate.h"

/**
 *  @method
 *
 *  @brief          程序运行开始时初始化数据内容
 *
 *  @see            包括自动登录、获取其他默认数据信息等。
 *
 */
@interface AppDelegate (ServeOperation)
/**
 *  @method
 *
 *  @brief          app配置服务信息参数
 *
 *  @see            包括自动登录、获取其他默认数据信息等
 *
 */
- (void)xcappAutomaticLayoutServeOperation;
@end
