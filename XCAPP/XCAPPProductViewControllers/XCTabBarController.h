//
//  XCTabBarController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface XCTabBarController : UITabBarController
@property (nonatomic , assign) NSInteger    selectedTabBarTag;

- (id)initWithNavigationController:(UINavigationController *)navigationController;
@end
