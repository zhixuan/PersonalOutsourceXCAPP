//
//  UIDevice+HUIAddtion.h
//  NetWorkingDemo
//
//  Created by 张利广 on 15/3/17.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (HUIAddtion)

#define HUIIsIPAD()                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//System version
#define HUISystemVersionIs(v)           ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
== NSOrderedSame)
#define HUISystemVersionAbove(v)        ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
== NSOrderedDescending)
#define HUISystemVersionAboveOrIs(v)    ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
!= NSOrderedAscending)
#define HUISystemVersionBelow(v)        ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
== NSOrderedAscending)
#define HUISystemVersionBelowOrIs(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] \
!= NSOrderedDescending)
#define kHUISystemVersion_4_3           @"4.3"
#define kHUISystemVersion_5_0           @"5.0"
#define kHUISystemVersion_5_1           @"5.1"
#define kHUISystemVersion_6_0           @"6.0"
#define kHUISystemVersion_6_1           @"6.1"
#define kHUISystemVersion_7_0           @"7.0"
#define kHUISystemVersion_7_1           @"7.1"
#define kHUISystemVersion_8_0           @"8.0"
#define kHUISystemVersion_8_1           @"8.1"
#define kHUISystemVersion_9_0           @"9.0"


#define KSysytemN   ([[[UIDevice currentDevice] systemVersion] intValue] >= 9)


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 657.0)

@end
