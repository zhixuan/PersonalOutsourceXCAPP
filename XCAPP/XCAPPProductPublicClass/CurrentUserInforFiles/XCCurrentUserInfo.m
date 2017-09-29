//
//  XCCurrentUserInfo.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCCurrentUserInfo.h"

#define KUserAgeDefaut          (15)

@implementation XCCurrentUserInfo
- (id)init{
    self = [super init];
    
    if (self) {
        
        self.userAgeInteger = 15;
        self.userGenderInteger = GenderStyleForDefautStyle;
        
        self.userOptionRoleStyle = OptionRoleStyleForDefautStyle;
        [self setUserPerCredentialStyle:@"0"];
        [self setUserTrakTickedStyle:@"1"];
        
    }
    
    return self;
}

//声明静态实例
static XCCurrentUserInfo       *userInfor = nil;
+ (XCCurrentUserInfo *)shareCurrentUserInformation{
    @synchronized(self){
        if (!userInfor) {
            userInfor = [[self alloc]init];
        }
    }
    return userInfor;
}

#pragma mark -
#pragma mark -  初始化当前登录用户信息
- (void)initUserLoginFinishInfor:(NSDictionary *)userDic{
    
    if (userDic == nil || userDic.count < 1) {
        return;
    }
    
    XCCurrentUserInfo *userInfor = KXCAPPCurrentUserInformation;
    ///登录状态
    [userInfor setUserLoginState:YES];
    
    [userInfor setUserPerId:StringForKeyInUnserializedJSONDic(userDic, @"id")];
    [userInfor setUserNameStr:StringForKeyInUnserializedJSONDic(userDic, @"givenName")];
    [userInfor setUserPerEmailStr:StringForKeyInUnserializedJSONDic(userDic, @"email")];
    [userInfor setUserNickNameStr:StringForKeyInUnserializedJSONDic(userDic, @"username")];
    [userInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(userDic, @"mobile")];
    
    ///用户角色 返回数据说明：roles对应的value是数组，且只有一个，数组的item是个字典，然后可找到角色信息
    if ([ObjForKeyInUnserializedJSONDic(userDic, @"roles") isKindOfClass:[NSArray class]]) {
        
        NSArray *rolesArray = (NSArray *)ObjForKeyInUnserializedJSONDic(userDic, @"roles");
        if (rolesArray.count > 0) {
            
            NSDictionary *rolesDic = (NSDictionary *)[rolesArray firstObject];
            
            if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(rolesDic, @"role"))) {
                
                [userInfor setUserOptionRoleStyle:IntForKeyInUnserializedJSONDic(rolesDic, @"role")];
            }else{
                [userInfor setUserOptionRoleStyle:OptionRoleStyleForGuestStyle];
            }
            
        }else{
            [userInfor setUserOptionRoleStyle:OptionRoleStyleForGuestStyle];
        }
        
    }else{
        [userInfor setUserOptionRoleStyle:OptionRoleStyleForGuestStyle];
    }
    
    
    ///账户余额 返回数据说明：accounts对应的value是数组，且只有一个，数组的item是个字典，然后可找到accountAmt信息，即账户余额信息
    if ([ObjForKeyInUnserializedJSONDic(userDic, @"accounts") isKindOfClass:[NSArray class]]) {
        
        
        NSArray *accountsArray = (NSArray *)ObjForKeyInUnserializedJSONDic(userDic, @"accounts");
        
        
        if (accountsArray.count > 0) {
            
            NSDictionary *rolesDic = (NSDictionary *)[accountsArray firstObject];
            if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(rolesDic, @"accountAmt"))) {
                
                [userInfor setUserAccountBalanceFloat:FloatForKeyInUnserializedJSONDic(rolesDic, @"accountAmt")];
            }else{
                [userInfor setUserAccountBalanceFloat:0.0f];
            }
        }else{
            [userInfor setUserAccountBalanceFloat:0.0f];
        }
    }else{
        [userInfor setUserAccountBalanceFloat:0.0f];
    }
    
    
    
    NSLog(@"userOptionRoleStyle is %zi\n OptionRoleStyleForAdministration is %zi \nOptionRoleStyleForGuestStyle is %zi",userInfor.userOptionRoleStyle, OptionRoleStyleForGuestStyle, OptionRoleStyleForAdministration);
    
    NSLog(@"用户类别，%zi ,用户账户余额信息%.1lf",userInfor.userOptionRoleStyle,userInfor.userAccountBalanceFloat);
    [userInfor setUserPerAtCompanyId:StringForKeyInUnserializedJSONDic(userDic, @"usercompanydi")];
}


#pragma mark -
#pragma mark -  用户退出登录后，清空用户个人信息内容
- (void)initUserLogOutFinishAndClearUserInfor{
    XCCurrentUserInfo *userInfor = KXCAPPCurrentUserInformation;
    ///登录状态
    [userInfor setUserLoginState:NO];
    
    [userInfor setUserPerId:@""];
    [userInfor setUserNameStr:@""];
    [userInfor setUserPerEmailStr:@""];
    [userInfor setUserNickNameStr:@""];
    [userInfor setUserPerPhoneNumberStr:@""];
    [userInfor setUserPerAtCompanyId:@""];
    [userInfor setUserAccountBalanceFloat:0.0f];
    [userInfor setUserPerCredentialStyle:@"0"];
    [userInfor setUserTrakTickedStyle:@"1"];
    [userInfor setUserOptionRoleStyle:OptionRoleStyleForGuestStyle];
    
    [KXCShareFMSetting setUserLoginPasswordStr:@""];
    [KXCShareFMSetting setUserLoginPhoneNumberStr:@""];
}
@end
