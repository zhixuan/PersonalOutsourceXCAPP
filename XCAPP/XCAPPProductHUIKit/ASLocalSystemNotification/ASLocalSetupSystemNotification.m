//
//  ASLocalSetupSystemNotification.m
//  AiShouAPP
//
//  Created by 张利广 on 15/5/27.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import "ASLocalSetupSystemNotification.h"

@implementation ASLocalSetupSystemNotification


static ASLocalSetupSystemNotification *localNotification;

- (id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (ASLocalSetupSystemNotification *)shareASASLocalSetupSystemNotification{
    @synchronized(self){
        if (!localNotification) {
            localNotification = [[self alloc]init];
        }
    }
    return localNotification;
}

////第二步：创建本地推送
-(void)createLocalNotificationWithTitleInfor:(NSString *)titleStr
                                 withDateStr:(NSString *)dateStr
                                  withKeyStr:(NSString *)keyStr{
    
    
    [self removeLocalNoticationWithKeyStr:keyStr];
    // 创建一个本地推送
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
//    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *valentinesDay = [df dateFromString:dateStr];
    
    NSLog(@"valentinesDay is %@",valentinesDay);
    if (notification != nil) {
        
        // 设置推送时间
        notification.fireDate = valentinesDay;
        
        // 设置时区
        notification.timeZone = [NSTimeZone systemTimeZone];
        
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitMinute;
    
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        // 推送内容
        notification.alertBody = titleStr;
        
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber;
        
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:keyStr forKey:@"LocalKey"];

        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
    }
}

////第三步：解除本地推送
- (void) removeLocalNoticationWithKeyStr:(NSString *)keyStr{
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;

    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
  
            if (dict) {
                NSString *inKey = [dict objectForKey:@"LocalKey"];
                
                if ([inKey isEqualToString:keyStr]) {
                    
                    if (!localNotification){
                        localNotification = noti;
                    }
                    break;
                }
            }
        }
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
        }
        if (localNotification) {
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
            return;
        }
    }
}
@end
