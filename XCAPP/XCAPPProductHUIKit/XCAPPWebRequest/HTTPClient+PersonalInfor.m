//
//  HTTPClient+PersonalInfor.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient+PersonalInfor.h"

@implementation HTTPClient (PersonalInfor)


#pragma mark -  用户登录操作请求数据
#pragma mark -
- (AFHTTPRequestOperation *)userPersonalLoginWithPhoneStr:(NSString *)phoneStr
                                                 password:(NSString *)passwordStr
                                               completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([phoneStr length] <1 ||
        [passwordStr length] < 1){
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    /**
     SELECT * FROM tktravelmerchantdb.appusertable WHERE userphone = '18615459060' AND userpassword = '123456';

     **/
    
    NSDictionary *param =@{@"username":phoneStr,
                           KDataKeyPassword:passwordStr,};
    
    
    return [self getPath:KReqUserLoginURL
              parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark -  用户登录成功后，修改初始化密码
- (AFHTTPRequestOperation *)userPersonalLoginFinishResetPwdWithUseId:(NSString *)userId
                                                            password:(NSString *)passwordStr
                                                          completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1 ||
        [passwordStr length] < 6){
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param =@{KDataKeyUserId:userId,
                           KDataKeyPassword:passwordStr,};
    
    
    return [self postPath:KReqLoginFinishResetPwdURL
               parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark -  根据用户ID获取用户个人账户信息
- (AFHTTPRequestOperation *)userPersonalCheckPersonalAccountInforWithUserId:(NSString *)userId completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1){
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param =@{@"userid":userId};
    
    
    return [self postPath:KReqCheckUserAccountURL
               parameters:param
               completion:completionBlock];

}

#pragma mark -
#pragma mark -  用户忘记密码，通过手机号找回密码, 第二步，重置新密码
- (AFHTTPRequestOperation *)userForgetPwdResetNewPassword:(NSString *)passwordStr
                                                   userId:(NSString *)userId
                                               completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([passwordStr length] < 6    ||
        [userId length] < 1){
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param =@{KDataKeyUserId:userId,
                           KDataKeyPassword:passwordStr};
    
    
    return [self postPath:KReqForgetPwdResetPwdURL
               parameters:param
               completion:completionBlock];

}
#pragma mark -
#pragma mark -  线路列表信息
- (AFHTTPRequestOperation *)userPersonalCheckTravelRountListInforWithPageNumber:(NSInteger)pageNumber
                                                                       pageSize:(NSInteger)pageSize completion:(WebAPIRequestCompletionBlock)completionBlock{

    
//    NSDictionary *param =@{@"pageno":[NSNumber numberWithInteger:pageNumber],
//                           @"pagesize":[NSNumber numberWithInteger:pageSize],};
    NSDictionary *param =@{@"cityname":@"sjd",};
    
    
    return [self getPath:KReqUserLoginURL
              parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 上传用户个人位置信息
- (AFHTTPRequestOperation *)uploadUserPersonalLocation:(CLLocationCoordinate2D)coordinate
                                                userId:(NSString *)userId
                                               cityStr:(NSString *)cityNameStr
                                            completion:(WebAPIRequestCompletionBlock)completionBlock{
    if (coordinate.longitude == 0 ||
        coordinate.latitude == 0 ||
        [userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyLongitude:[NSNumber numberWithFloat:coordinate.longitude],
                            KDataKeyLatitude:[NSNumber numberWithFloat:coordinate.latitude],
                            KDataKeyUserId:userId,
                            KDateKeyCityStr:cityNameStr};
    return [self postPath:KReqResetLocationURL
               parameters:param
               completion:completionBlock];
}
#pragma mark -
#pragma mark - 用户修改个人密码操作（在个人设置中修改密码）
- (AFHTTPRequestOperation *)userResetupPassword:(NSString *)password
                                         userId:(NSString *)userId
                                     completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([password length] < 1 ||
        [userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyPassword:password,
                            KDataKeyUserId:userId};
    return [self postPath:KReqResetPwdURL parameters:param
               completion:completionBlock];
    
}

#pragma mark -
#pragma mark - 用户个人退出登录操作
- (AFHTTPRequestOperation *)userLogoutRequestWithUserId:(NSString *)userId
                                             completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId};
    return [self getPath:KReqUserLogoOutRequestURL parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark - 用户个人绑定手机号操作
- (AFHTTPRequestOperation *)userBundlePhoneWithUserId:(NSString *)userId
                                             phoneStr:(NSString *)phoneStr
                                              verCode:(NSString *)verCodeStr
                                           completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1         ||
        [phoneStr length] < 10      ||
        [verCodeStr length] != 6) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            KDataKeyPhoneNumber:phoneStr,
                            @"code":verCodeStr};
    return [self postPath:KReqBundlePhoneURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户个人解除绑定手机号操作
- (AFHTTPRequestOperation *)userCancelBundlePhoneWithUserId:(NSString *)userId
                                                   phoneStr:(NSString *)phoneStr
                                                    verCode:(NSString *)verCodeStr
                                                 completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1         ||
        [phoneStr length] < 10      ||
        [verCodeStr length] != 6) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            KDataKeyPhoneNumber:phoneStr,
                            @"code":verCodeStr};
    return [self postPath:KReqUnBundlePhoneURL parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark -  获取全部员工信息内容（包括管理员及员工信息）
- (AFHTTPRequestOperation *)userGetAllWorkerUserInforWithUserId:(NSString *)userId
                                                      userRole:(NSInteger)userRole
                                                     pageNumber:(NSInteger)pageNumber
                                                     completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            @"role":[NSNumber numberWithInteger:userRole],
                            @"pageNo":[NSNumber numberWithInteger:pageNumber]};
    

    
    
    return [self getPath:KReqGetAllWorkerURL parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark -  用户删除某个员工信息
- (AFHTTPRequestOperation *)userDeleteWorkerUserInforWithUserId:(NSString *)userId workerId:(NSString *)workerId completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1         ||
        [workerId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
//    NSDictionary *param = @{KDataKeyUserId:workerId,
//                            @"workeruserId":workerId};
    
    NSDictionary *param = @{KDataKeyUserId:workerId,};
    return [self postPath:KReqDeleteItemWorkerUserURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户添加员工信息内容
- (AFHTTPRequestOperation *)userAddWorkerUserInforWithUserId:(NSString *)userId
                                                   companyId:(NSString *)companyId
                                                      worker:(UserInformationClass *)workerInfo
                                                  completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1         ||
        [companyId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSMutableDictionary *param = [workerInfo addNewWorkerInforReqParam];
    AddObjectForKeyIntoDictionary(userId, KDataKeyUserId, param);
    
    return [self postPath:KReqAddWorkerUserURL parameters:param
               completion:completionBlock];

}

#pragma mark -
#pragma mark - 用户添加入住酒店人员信息
- (AFHTTPRequestOperation *)userAddMoveIntoUserWithUserId:(NSString *)userId
                                                 username:(NSString *)userNameStr
                                               completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            @"userName":userNameStr,};

    
    return [self postPath:KReqAddMoveIntoUserURL parameters:param
               completion:completionBlock];
}

- (AFHTTPRequestOperation *)getUserListInforWithCompletion:(WebAPIRequestCompletionBlock)completionBlock{
//list
    
    
    
    return [self getPath:@"xcusers/list" parameters:nil
               completion:completionBlock];
}

- (AFHTTPRequestOperation *)userDeleteNotifyMessageWithUserId:(NSString *)userid
                                                       pushId:(NSString *)pushIdStr
                                                   completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userid length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param = @{@"userId":userid,
                            @"pushId":pushIdStr,};
    
    
    return [self postPath:KReqNotifyDeleteURL parameters:param
               completion:completionBlock];

}

#pragma mark -
#pragma mark -  根据不同类别发送验证码信息
//type"0";//管理员邀请员工 "1";//找回密码 "2";//绑定手机号码 "3";//解除绑定手机号码
- (AFHTTPRequestOperation *)userSentMessageCodeWithUserId:(NSString *)userId
                                                 withType:(NSString *)typeStr
                                          withPhoneNumber:(NSString *)phoneStr
                                               completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([typeStr length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param  = @{@"mobile":phoneStr,
                             @"userId":userId,
                             @"messageType":typeStr};

    if ([typeStr isEqualToString:@"1"]) {
        param = @{@"mobile":phoneStr,
                  @"messageType":typeStr};
    }
    
    return [self postPath:KReqSendVerCodeURL parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark -  根据用户ID，验证当前验证码是否正确（用于找回密码、绑定手机号、解绑手机号操作）
/**
 *  @method
 *
 *  @brief          根据用户ID，验证当前验证码是否正确（用于找回密码、绑定手机号、解绑手机号操作）
 *
 *  @param          codeStr         验证码
 *
 *  @param          userId          用户ID
 *
 *  @see            根据用户ID，验证当前验证码是否正确
 *
 */
- (AFHTTPRequestOperation *)userPersonalCheckVerCodeWithUserId:(NSString *)userId
                                                       verCode:(NSString *)codeStr
                                                    completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1     ||
        [codeStr length] < 6) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param  = @{@"code":codeStr,
                             @"userId":userId,};
    
    return [self postPath:KReqForgetPwdVerVerCodeURL parameters:param
               completion:completionBlock];

}
@end
