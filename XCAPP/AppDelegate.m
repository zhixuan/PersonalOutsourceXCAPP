//
//  AppDelegate.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AppDelegate.h"
#import "XCTabBarController.h"
#import "AppDelegate+AppDelegateExpandVendor.h"
#import "AppDelegate+ServeOperation.h"
#import "XCLocationManager.h"
#import "HomeMainViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"


@interface AppDelegate ()<XCLocationManagerDelegate>
/*!
 * @breif Tab视图信息
 * @See
 */
@property (nonatomic , strong)XCTabBarController *tabBarController;
/*!
 * @breif 定位设置
 * @See
 */
@property (nonatomic , strong)      XCLocationManager           *xcAppLocationManager;

/*!
 * @breif 是否上传了经纬度信息
 * @See
 */
@property (nonatomic , assign)      BOOL        isUploadLocationBool;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDate *currentDate = [NSDate new];
    NSLog(@"currentDate is %@",currentDate);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:KDefaultNavigationWhiteBackGroundColor];
    ///加载第三方SDK数据信息
    [self setupOtherExpandVendorInfor];
    [self xcappAutomaticLayoutServeOperation];
    
    self.tabBarController = [[XCTabBarController alloc]init];
    self.tabBarController.selectedIndex = 0;
    [self.window setRootViewController:self.tabBarController];
    ///设置定位信息
    self.xcAppLocationManager= [[XCLocationManager alloc]init];
    [self.xcAppLocationManager starXCLocation];
    [self.xcAppLocationManager setDelegate:self];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogoutFinishSuccessNotification:) name:KXCAPPUserLogoutSuccessFinishNotification object:nil];
    
    
    
//    ///性能测试操作
//    
//    
//    int whileCountInt = 10e3;
////    for(int begin = 1; begin < whileCountInt; begin++){
////        NSLog(@"begin is %zi",begin);
////    }
////    
//    int begin = 1;
////    while (begin < whileCountInt) {
////        begin+=1;
////        NSLog(@"begin is %zi",begin);
////    }
//    
//    while (begin < whileCountInt) {
//        begin++;
//        NSLog(@"begin is %zi",begin);
//    }

    return YES;
   
}
- (void)userLogoutFinishSuccessNotification:(NSNotification *)notification{
     self.tabBarController.selectedIndex = 0;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//
////TODO: 注册deviceToken
//#pragma mark - 注册deviceToken
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    
//}
//
//
////TODO: 接收通知失败
//#pragma mark - 接收通知失败
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    
//    
//    NSLog(@"接收通知失败");
//    ///接收通知失败，则注销设置
//    
//    
//}
//
//#
////TODO: 接收通知
//#pragma mark - 接收通知
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    NSLog(@"notification is %@",notification.description);
//    
//    if (!IsStringEmptyOrNull([notification.userInfo objectForKey:@"LocalKey"])) {
//        //判断应用程序当前的运行状态，如果是激活状态，则进行提醒，否则不提醒
//        if (application.applicationState == UIApplicationStateActive) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:notification.alertAction, nil];
//            [alert show];
//        }
//    }
//}


- (void)locationDidFinishResponse:(XCLocationAPIResponse *)locationResult{
    
    if (locationResult.isSuccess) {
//        NSString *province =  StringForKeyInUnserializedJSONDic(locationResult.responseObject,KKeyProvince);
        NSString *cityname =  StringForKeyInUnserializedJSONDic(locationResult.responseObject,KKeyCityName);
//        NSString *address = StringForKeyInUnserializedJSONDic(locationResult.responseObject, KKeyAddress);
        CLLocationCoordinate2D   locationCoordinate = locationResult.locationCoordinate;
        if (locationCoordinate.latitude > 0 && locationCoordinate.longitude > 0) {
            
            [KXCAPPCurrentUserInformation setUserCoordinate:locationCoordinate];
            [KXCShareFMSetting setUserPerLocationCooridate:locationCoordinate];
//            [KXCShareFMSetting setuser];
            
//            NSLog(@"cityname is %@",cityname);
            if (!IsStringEmptyOrNull(cityname)) {
                cityname = [cityname stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
//            NSLog(@"cityname is %@",cityname);
            
            if (!IsStringEmptyOrNull(KXCAPPCurrentUserInformation.userPerId)) {
                
                if (self.isUploadLocationBool) {
                    return;
                }
                
                self.isUploadLocationBool = YES;
                [XCAPPHTTPClient uploadUserPersonalLocation:locationCoordinate userId:KXCAPPCurrentUserInformation.userPerId cityStr:cityname completion:^(WebAPIResponse *response) {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        NSLog(@"response.responseObject is %@",response.responseObject);
                    });
                }];
            }
        }

    }else{
        
        /**
         http://121.42.29.208:8081/userGetHotelByCityAndhName?
         ***/
    }
}
@end
