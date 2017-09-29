//
//  AppDelegate+ServeOperation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AppDelegate+ServeOperation.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"

@implementation AppDelegate (ServeOperation)
#pragma mark -
#pragma mark -  app配置服务信息参数
- (void)xcappAutomaticLayoutServeOperation{

    
    
//    [XCAPPHTTPClient getUserListInforWithCompletion:^(WebAPIResponse *response) {
//        dispatch_async(dispatch_get_main_queue(), ^(void){
////            if (response.code == WebAPIResponseCodeSuccess) {
//            
//            NSLog(@"response.responseObject is %@",response.responseObject);
//        });
//    }];
    ///自动登录操作
    [self automaticLoginRequest];
    
    
    
//    BabyInfo *baby = [[BabyInfo alloc]init];
//    [baby setBabyName:@"张 - - "];
//    [baby setBabyGender:GenderForUnknownStyle];
//    [baby setBabyBirthday:@""];
//    [baby setWillBabyBirthday:@"2018-01-27 --- 2018-02-10"];
//    [baby setWillBabyWeight:@"14.5 g"];
//    [baby setBabyLength:@"6.7 cm"];
    
    BabyInfo *baby = [[BabyInfo alloc]init];
    baby.babyName = @"zhang - - ";
    baby.babyGender = GenderForUnknownStyle;
    baby.willBabyBirthday = @"2018-01-27 --- 2018-02-10";
}

#pragma mark -
#pragma mark -  自动登录操作
/**
 *  @method
 *
 *  @brief          自动登录操作
 *
 */
- (void)automaticLoginRequest{
    
    
    
    if ((!IsStringEmptyOrNull(KXCShareFMSetting.userLoginPasswordStr)) && (!IsStringEmptyOrNull(KXCShareFMSetting.userLoginPhoneNumberStr))){
        
        NSString *userPasswrodStr = KXCShareFMSetting.userLoginPasswordStr;
        NSString *userPhoneStr = KXCShareFMSetting.userLoginPhoneNumberStr;
        [XCAPPHTTPClient userPersonalLoginWithPhoneStr:userPhoneStr password:userPasswrodStr completion:^(WebAPIResponse *response) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                
                if (response.code == WebAPIResponseCodeSuccessForHundred) {
              
                    NSLog(@"response.responseObject is %@",response.responseObject);
                    
                    NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    if (responeDic.count > 0) {
                        [KXCAPPCurrentUserInformation initUserLoginFinishInfor:responeDic];
                    }
                    
                    ///持久化保存数据
                    [KXCShareFMSetting setUserLoginPhoneNumberStr:KXCShareFMSetting.userLoginPhoneNumberStr];
                    [KXCShareFMSetting setUserLoginPasswordStr:KXCShareFMSetting.userLoginPasswordStr];
                }
                
                else if (response.code == WebAPIResponseCodeFailed) {
                    NSLog(@"登录失败；");
                    
                }
                
                else if (response.code == WebAPIResponseCodeForceUpdateError){
                    if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                        NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                        FailedMBProgressHUD(HUIKeyWindow,msg);
                    }
                    
                    //MARK:.重新登录操作逻辑
                }else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            });
            
        }];
    }
}
@end
