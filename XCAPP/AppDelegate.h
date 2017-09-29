//
//  AppDelegate.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XCTabBarController.h"


#define  KXCShareAppDelegate ((AppDelegate* )[[UIApplication sharedApplication] delegate])


@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;


/**************
 
 
 
 
 
 iOS10相册相机闪退bug
 http://www.jianshu.com/p/5085430b029f
 iOS 10 因苹果健康导致闪退 crash
 http://www.jianshu.com/p/545bd1bf5a23
 麦克风、多媒体、地图、通讯录
 ios10相机等崩溃
 http://www.jianshu.com/p/ec15dadd38f3
 iOS10 配置须知
 http://www.jianshu.com/p/65f21dc5c556
 iOS开发 适配iOS10以及Xcode8
 http://www.jianshu.com/p/9756992a35ca
 iOS 10 的适配问题
 http://www.jianshu.com/p/f8151d556930
 
 
 **********************/

@end

