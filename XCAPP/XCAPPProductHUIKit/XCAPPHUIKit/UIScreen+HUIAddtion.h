//
//  UIScreen+HUIAddtion.h
//  NetWorkingDemo
//
//  Created by 张利广 on 15/3/17.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HUIKeyWindow                ([UIApplication sharedApplication].keyWindow)
#define HUITopWindow                ([[[UIApplication sharedApplication] windows] lastObject])
#define HUIApplicationFrame()		([[UIScreen mainScreen] applicationFrame])
#define HUIIsRetinaScreen()         ([[UIScreen mainScreen] isRetinaDisplay])
#define HUIIsIPhone5()              ([[UIScreen mainScreen] isIPhone5])

@interface UIScreen (HUIAddtion)
- (BOOL)isRetinaDisplay;
- (BOOL)isIPhone5;
@end
