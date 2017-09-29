//
//  HTTPClient+TrainTickeRequest.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/10.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient+TrainTickeRequest.h"

@implementation HTTPClient (TrainTickeRequest)


#pragma mark -
#pragma mark - 获取选择火车票出发地及到达目的城市内容
- (AFHTTPRequestOperation *)requestTrainTicketCitiesInformationCompletion:(WebAPIRequestCompletionBlock)completionBlock{
    return [self getPath:KReqXCTrainTicketCommonCitiesURL parameters:nil
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 火车票订购--通过搜索关键字搜索推荐城市信息
- (AFHTTPRequestOperation *)requestTrainTicketRecommendCitiesInforWithSearchKey:(NSString *)searchKeyStr completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([searchKeyStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    //    NSDictionary *param = @{KDataKeyFromStr:searchKeyStr,};
    
    NSDictionary *param = @{@"keyword":searchKeyStr,};
    return [self getPath:KReqXCTrainTicketSearchSuggestCitiesURL parameters:param
              completion:completionBlock];
    
}
#pragma mark -
#pragma mark -  查询火车票（From - To）
- (AFHTTPRequestOperation *)requestTrainTickeListFrom:(NSString *)fromStr
                                                   to:(NSString *)toStr
                                                 date:(NSString *)departDate
                                             isHSBool:(BOOL)isHsBool
                                              orderby:(NSString *)orderbyStr
                                              descend:(NSInteger)isDescend
                                             seatType:(NSString *)seatTypeStr
                                            trainType:(NSString *)trainTypeStr
                                             fromType:(NSString *)fromTypeStr
                                               toType:(NSString *)toTypeStr
                                           completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([fromStr length] < 1    ||
        [toStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
    
    NSDictionary *param = @{KDataKeyFromStr:fromStr,
                            KDataKeyToCityStr:toStr,
                            KDataKeyDateStr:departDate,
                            @"onlyGaoTie":[NSNumber numberWithBool:isHsBool],};
    NSMutableDictionary *allParam = [[NSMutableDictionary alloc]initWithDictionary:param];
    
    if (!IsStringEmptyOrNull(orderbyStr)) {
        AddObjectForKeyIntoDictionary(orderbyStr,@"orderby",allParam);
    }
    
    if (!IsStringEmptyOrNull(seatTypeStr)) {
        AddObjectForKeyIntoDictionary(seatTypeStr,@"seatType",allParam);
    }
    if (!IsStringEmptyOrNull(trainTypeStr)) {
        AddObjectForKeyIntoDictionary(trainTypeStr,@"trainType",allParam);
    }
    if (!IsStringEmptyOrNull(fromTypeStr)) {
        AddObjectForKeyIntoDictionary(fromTypeStr,@"filterFrom",allParam);
    }
    if (!IsStringEmptyOrNull(toTypeStr)) {
        AddObjectForKeyIntoDictionary(toTypeStr,@"filterTo",allParam);
    }
    
    
    return [self getPath:KReqTrainTicketListURL parameters:allParam
              completion:completionBlock];
    
}


#pragma mark -
#pragma mark -  关联12306账户
- (AFHTTPRequestOperation *)requestRelatedAccountUserId:(NSString *)userId
                                                   name:(NSString *)nameStr
                                                   pswd:(NSString *)password
                                             completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1    ||
        [nameStr length] < 1    ||
        [password length] <1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param = @{@"userid":userId,
                            @"train_username":nameStr,
                            @"train_passowrd":password,
                            };
    
    
    return [self postPath:KReqRelated12306AccountURL parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark - 查看用户是否已经进行关联12306账户操作
/**
 *  @method
 *
 *  @brief          查看用户是否已经进行关联12306账户操作
 *
 *  @param          userId          当前用户ID
 *
 *  @see            用户需要登录状态下进行操作
 *
 */
- (AFHTTPRequestOperation *)requestCheckUserIsRelatedAccountWithUserId:(NSString *)userId completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1  ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param = @{@"userid":userId,
                            };
    
    return [self postPath:KReqQueryRelated12306AccountURL parameters:param
               completion:completionBlock];
}



#pragma mark -
#pragma mark -  火车票中验证用户个人信息 （即添加用户个人信息)
- (AFHTTPRequestOperation *)requestAddMemberUserInfor:(UserInformationClass *)userInfor completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userInfor.userPerCredentialStyle length] < 1       ||
        [userInfor.userPerCredentialContent length] < 4     ||
        [userInfor.userNameStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = [userInfor setupTrainTicketUserInforReqParam];
    
    
    return [self postPath:KReqRelatedAccountURL parameters:param
               completion:completionBlock];
    
}

#pragma mark -
#pragma mark - 预订时判断该选择的座位是否合法
- (AFHTTPRequestOperation *)requestVerifyTrainTickeValidAndReserveWithTrainNo:(NSString *)trainNoStr
                                                                         from:(NSString *)fromStr
                                                                           to:(NSString *)toStr
                                                                         date:(NSString *)dateStr
                                                                     seatType:(NSString *)seatTypeStr
                                                                   completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([trainNoStr length] < 1         ||
        [fromStr length] < 1            ||
        [toStr length] < 1              ||
        [dateStr length] < 1            ||
        [seatTypeStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{@"trainNo":trainNoStr,
                            @"from":fromStr,
                            @"to":toStr,
                            @"date":dateStr,
                            @"seatType":seatTypeStr,};
    
    
    return [self getPath:KXCAPPReqTrainOrderBookingURL parameters:param
              completion:completionBlock];
    
}

#pragma mark -
#pragma mark - 用户创建火车票订单提交操作请求
- (AFHTTPRequestOperation *)requestUserCreateTrainTickeOrderWithOrderParam:(TrainticketOrderInformation *)orderParam completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    NSDictionary *param = [orderParam createTrainticketOrderInformationParameter];
    
    NSLog(@"param is %@",param);
    if (param.count < 10) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    return [self postPath:KReqTrainTicketCreateOrderURL parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark - 用户确认担保支付操作接口
- (AFHTTPRequestOperation *)requestUserProceedGuaranteePayWithUserId:(NSString *)userId
                                                             orderNo:(NSString *)orderNoStr
                                                        qunarOrderNo:(NSString *)qunarOrderNoStr
                                                          completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1             ||
        [orderNoStr length] < 1         ||
        [qunarOrderNoStr length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
    NSDictionary *param = @{@"userid":userId,
                            @"orderNo":orderNoStr,
                            @"qunarOrderNo":qunarOrderNoStr,};
    return [self postPath:KReqTrainTiketPayOrderURL parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户取消订单操作接口《取消订单》对应的接口为 Get方式的 train/order/cancel 《《区别于train/order/refund【申请退款】》》
- (AFHTTPRequestOperation *)requestUserPersonalCancelOrderWithUserId:(NSString *)userId
                                                             orderNo:(NSString *)orderNoStr
                                                        qunarOrderNo:(NSString *)qunarOrderNoStr
                                                          completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    if ([userId length] < 1             ||
        [orderNoStr length] < 1         ||
        [qunarOrderNoStr length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
    NSDictionary *param = @{@"userid":userId,
                            @"orderNo":orderNoStr,
                            @"qunarOrderNo":qunarOrderNoStr,};
    
    return [self getPath:KReqUserCancleTrainTicketOrderURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark - 请求查看退票手续查询
- (AFHTTPRequestOperation *)requestUserCheckTrainTicketOrderRefundPrepareWithUserId:(NSString *)userId
                                                                            orderNo:(NSString *)orderNoStr
                                                                       qunarOrderNo:(NSString *)qunarOrderNoStr
                                                                         completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    if ([userId length] < 1             ||
        [orderNoStr length] < 1         ||
        [qunarOrderNoStr length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{@"userid":userId,
                            @"orderNo":orderNoStr,
                            @"qunarOrderNo":qunarOrderNoStr,};
    
    
    return [self getPath:KReqUserCheckRefundProcedureURL parameters:param
              completion:completionBlock];
    
}


#pragma mark -
#pragma mark -  用户申请退票接口
- (AFHTTPRequestOperation*)requestUserApplyForRefundOrderTrainTicketWithUserId:(NSString *)userId
                                                                       orderNo:(NSString *)orderNoStr
                                                                  qunarOrderNo:(NSString *)qunarOrderNoStr
                                                                       comment:(NSString *)commentStr
                                                                    passengers:(NSString *)passengersStr
                                                                    completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1             ||
        [orderNoStr length] < 1         ||
        [qunarOrderNoStr length] < 1    ||
        [passengersStr length] < 2) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    
        NSDictionary *param = @{@"userid":userId,
                                @"orderNo":orderNoStr,
                                @"qunarOrderNo":qunarOrderNoStr,
                                @"comment":commentStr,
                                @"passengers":passengersStr};
    
    return [self postPath:KReqUserApplyForRefundURL parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark -  用户申请退票接口(从订单列表中操作)
- (AFHTTPRequestOperation *)requestUserApplyForRefundOrderTrainTicketWithOrderInfor:(TrainticketOrderInformation *)orderParam
                                                                         completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    NSDictionary *param = [orderParam userPersonalSetupRefundTrainticketOrderInformationParameter];
    
    NSLog(@"param is %@",param);
    if (param.count < 3) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    

    
    return [self postPath:KReqUserApplyForRefundURL parameters:param
              completion:completionBlock];

}

#pragma mark -
#pragma mark - 新增火车票预订票联系人
- (AFHTTPRequestOperation *)requestAddTrainUserDirectoryInforWithUser:(UserInformationClass *)userInfor
                                                           completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userInfor.userPerId length] < 1             ||
        [userInfor.userNameStr length] < 1         ||
        [userInfor.userPerCredentialContent length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param =[userInfor setupAddTrainTicketUserInforReqParam];
    
    return [self postPath:KReqAddTrainTicketUserURL parameters:param
              completion:completionBlock];
    
}


#pragma mark -
#pragma mark -  编辑 - 火车票预订联系人编辑
- (AFHTTPRequestOperation *)requestUpdateTrainUserDirectoryInforWithUser:(UserInformationClass *)userInfor
                                                              completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userInfor.userPerId length] < 1             ||
        [userInfor.userNameStr length] < 1         ||
        [userInfor.userPerCredentialContent length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param =[userInfor setupAddTrainTicketUserInforReqParam];
    
    return [self postPath:KReqAddTrainTicketUserURL parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark -  删除 - 火车票预订联系人删除
- (AFHTTPRequestOperation *)requestDeleteTrainUserDirectoryInforItemWithUserID:(NSString *)userID
                                                                    completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userID length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        
//        张丽娜。。。
//        
        
        return  nil;
    }
    
    
    NSDictionary *param =@{@"id":userID};
    
    return [self getPath:KReqAddTrainTicketUserURL parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark -  查询全部联系人信息 --- 查询预订过火车票的全部联系人信息内容
- (AFHTTPRequestOperation *)requestAllTrainUserDirectoryInforWithUserId:(NSString *)userId
                                                               nextPage:(NSInteger)nextPage
                                                             completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param =@{@"userid":userId,
                           @"pageNo":[NSNumber numberWithInteger:nextPage],
                           @"type":@"2"};
    
    return [self getPath:ReqSelectedTrainTicketAllUsersURL parameters:param
              completion:completionBlock];

}


#pragma mark -
#pragma mark - 根据订单ID查询火车票订单详细信息内容
//KReqUserTTOrderItemDetailURL
- (AFHTTPRequestOperation *)requestTrainTicketItemOrderDetailInforWtihOrderId:(NSString *)orderID
                                                                  completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([orderID length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param =@{@"orderNo":orderID,};
    
    return [self getPath:KReqUserTTOrderItemDetailURL parameters:param
              completion:completionBlock];

}

@end
