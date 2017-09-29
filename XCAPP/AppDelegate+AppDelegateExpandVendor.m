//
//  AppDelegate+AppDelegateExpandVendor.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AppDelegate+AppDelegateExpandVendor.h"
#import "UMMobClick/MobClick.h"
//#import "UMMobClick/Mobclick.h"

@implementation AppDelegate (AppDelegateExpandVendor)

#pragma mark -
#pragma mark -  加载第三方SDK数据信息
- (void)setupOtherExpandVendorInfor{

    [self setupUmengSDKInfor];
}

/**
 *  @method
 *
 *  @brief          设置友盟SDK信息，并初始化统计信息
 *
 */
- (void)setupUmengSDKInfor{
    
#ifndef __OPTIMIZE__
    [MobClick setLogEnabled:YES];
    NSLog(@"哈哈哈");
#else
    NSLog(@"唏嘘");
    [MobClick setLogEnabled:NO];
#endif
    
    [UMConfigInstance setAppKey:KKeyForUmemgAPPKeyString];
    [UMConfigInstance setChannelId:@"App Store"];
    [UMConfigInstance setEPolicy:REALTIME];
    
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setCrashReportEnabled:YES];
    NSLog(@"真的初始化进来了");
}
@end
