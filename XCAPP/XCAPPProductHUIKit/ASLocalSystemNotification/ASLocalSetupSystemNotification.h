//
//  ASLocalSetupSystemNotification.h
//  AiShouAPP
//
//  Created by 张利广 on 15/5/27.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KASRecordCalorietInforLocalNotificationKey      @"ASRECORDCALORIETINFORLOCALNOTIFICATIONKEY"
#define KASShareASASLocalSetupSystemNotification [ASLocalSetupSystemNotification shareASASLocalSetupSystemNotification]

/** 本地系统通知操作集合
 
 *
 **/
@interface ASLocalSetupSystemNotification : NSObject


/** 本地通知单例
 
 *
 **/
+(ASLocalSetupSystemNotification *)shareASASLocalSetupSystemNotification;

/** 创建本地通知**/
-(void)createLocalNotificationWithTitleInfor:(NSString *)titleStr
                                 withDateStr:(NSString *)dateStr
                                  withKeyStr:(NSString *)keyStr;

////第三步：解除本地推送
- (void) removeLocalNoticationWithKeyStr:(NSString *)keyStr;
@end
