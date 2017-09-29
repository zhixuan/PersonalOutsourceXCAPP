//
//  HTTPClient+HotelsRequest.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/29.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HTTPClient+HotelsRequest.h"

@implementation HTTPClient (HotelsRequest)


#pragma mark -
#pragma mark -  用户获取酒店所在的城市信息
- (AFHTTPRequestOperation *)userRequestCityInforForHotelCompletion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    return [self getPath:KReqHotelAllCityListURL
              parameters:nil
              completion:completionBlock];
}

#pragma mark -
#pragma mark -  用户根据城市编号获取该市下对应的行政区域信息
- (AFHTTPRequestOperation *)userRequestAdministrativeAreaInforForHotelWithCityCode:(NSString *)cityCode
                                                                        completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([cityCode length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"city_id":cityCode};
    return [self postPath:KReqHotelCityAreaInforURL
              parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark -  用户通过位置或者酒店名模糊查找信息
- (AFHTTPRequestOperation *)userRoughSearchHotelListInforWithCityName:(NSString *)cityStr
                                                               areaId:(NSString *)areIdStr
                                                                hName:(NSString *)hnameStr
                                                             maxPrice:(NSString *)maxPrice
                                                             minPrice:(NSString *)minPriceStr
                                                                hStar:(NSString *)starStyle
                                                              pageRow:(NSInteger)pageRow
                                                                field:(NSString *)SequenceStr
                                                               upDown:(NSInteger)updownType
                                                           completion:(WebAPIRequestCompletionBlock)completionBlock{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if (!IsStringEmptyOrNull(cityStr)) {
        NSLog(@"cityStr is %@",cityStr);
        AddObjectForKeyIntoDictionary(cityStr,@"city",param);
    }
    
    if (!IsStringEmptyOrNull(areIdStr)) {
        AddObjectForKeyIntoDictionary(areIdStr,@"area_id",param);
    }
    
    if (!IsStringEmptyOrNull(hnameStr)) {
        AddObjectForKeyIntoDictionary(hnameStr,@"hName",param);
    }
    
    if (!IsStringEmptyOrNull(minPriceStr)) {
        AddObjectForKeyIntoDictionary(minPriceStr,@"l_price",param);
    }
    
    if (!IsStringEmptyOrNull(maxPrice)) {
        AddObjectForKeyIntoDictionary(maxPrice,@"h_price",param);
    }
    
    if (!IsStringEmptyOrNull(starStyle)) {
        AddObjectForKeyIntoDictionary(starStyle,@"hotel_star",param);
    }

    AddObjectForKeyIntoDictionary([NSNumber numberWithInteger:pageRow], @"pageNo", param);
    AddObjectForKeyIntoDictionary([NSNumber numberWithInteger:updownType], @"sort", param);
    AddObjectForKeyIntoDictionary(SequenceStr, @"field", param);
    
    return [self postPath:KReqHotelQueryLikeHotelListURL
               parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark -  通过用户输入的位置或者酒店名字信息进行筛选操作【酒店名分词模糊查询 】
- (AFHTTPRequestOperation *)userRoughSearchHotelListInforWithHotelName:(NSString *)hnameStr
                                                                 pageRow:(NSInteger)pageRow
                                                            completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([hnameStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"hName":hnameStr,
                            @"pageNo":[NSNumber numberWithInteger:pageRow]};
    return [self postPath:KReqHotellListForuserSearchKeyURL
               parameters:param
               completion:completionBlock];
}


#pragma mark -
#pragma mark -  通过酒店ID，获取酒店聚合房型信息（聚合房型信息一级界面数据）
- (AFHTTPRequestOperation *)userRequestHotelDetailInforWithHotelID:(NSString *)hotelID
                                                        completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([hotelID length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"hid":hotelID};
    return [self getPath:KReqHotelRoomClassInforURL
              parameters:param
              completion:completionBlock];
}

#pragma mark -
#pragma mark -  用户根据房型信息获取全部该房型下的所有房间信息（酒店预订房型聚合二级列表数据请求）
- (AFHTTPRequestOperation *)userRequestDetailRoomsInforWithRoomId:(NSString *)roomId
                                                        beginDate:(NSString *)beginDate
                                                          endDate:(NSString *)endDate
                                                       completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([roomId length] < 1     ||
        [beginDate length] < 1  ||
        [endDate length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"rid":roomId,
                            @"startTime":beginDate,
                            @"endTime":endDate};
    return [self postPath:KReqHotelRoomDetailInforURL
              parameters:param
              completion:completionBlock];
}


#pragma mark -
#pragma mark -  获取全部房客信息内容（主要是姓名等信息）
- (AFHTTPRequestOperation *)userRequestReserveTenantUserInforListWithUserId:(NSString *)userID
                                                                        row:(NSInteger)pageRow
                                                                 completion:(WebAPIRequestCompletionBlock)completionBlock{

    if ([userID length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param =@{@"userid":userID,
                           @"pageNo":[NSNumber numberWithInteger:pageRow],
                           @"type":@"1"};
    
    return [self getPath:ReqSelectedTrainTicketAllUsersURL parameters:param
              completion:completionBlock];
}


#pragma mark -
#pragma mark - 添加酒店预订房客人员（主要是姓名信息）
- (AFHTTPRequestOperation *)userRequestAddReserveTenantUserInforWithUserID:(NSString *)userId
                                                                  userName:(NSString *)nameStr
                                                                completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1             ||
        [nameStr length] < 1    ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    
    NSDictionary *param =@{@"userid":userId,
                           @"linkName":nameStr,
                           @"type":@"1",};
    
    return [self postPath:KReqAddTrainTicketUserURL parameters:param
               completion:completionBlock];

}


#pragma mark -
#pragma mark - 登录用户预订酒店创建订单
- (AFHTTPRequestOperation *)userRequestCreateHotelReserveOrderWithOrderInfor:(UserHotelOrderInformation *)hotelOrder completion:(WebAPIRequestCompletionBlock)completionBlock{

    NSDictionary *param = [hotelOrder createHotelOrderInformationParameter];
    
    NSLog(@"param is %@",param);
    if (param.count < 9) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    return [self postPath:KReqHotelCreateOrderURL parameters:param
               completion:completionBlock];

}


#pragma mark -
#pragma mark -  用户酒店预订成功，进行担保支付操作
- (AFHTTPRequestOperation *)userRequestGotoProceedGuaranteePayForPayCheck:(NSString *)userId orderId:(NSString *)orderIdStr completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    if ([userId length] < 1 ||
        [orderIdStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"userId":userId,
                            @"oid":orderIdStr,
                            };
    
    return [self postPath:KReqHotelProceedGuaranteePayURL parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户通过个人订单号，取消订单
- (AFHTTPRequestOperation *)userOperationHotelOrderForCancelOrderWithOrderID:(NSString *)orderID
                                                                  completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    if ([orderID length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"orderNo":orderID,
                            };
    
    return [self postPath:KReqUserCancelHotelOrderURL parameters:param
               completion:completionBlock];

}



























#pragma mark -
#pragma mark -  用户通过位置或者酒店名模糊查找信息
- (AFHTTPRequestOperation *)userSearchHotelWithSearchKeyStr:(NSString *)searchKeyStr
                                                 completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([searchKeyStr length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return  nil;
    }
    
    NSDictionary *param = @{@"searchKey":searchKeyStr};
   return [self getPath:KReqSeekHotelForKeyURL
       parameters:param
       completion:completionBlock];
}

#pragma mark -
#pragma mark -   获取用户个人出行差旅标准
- (AFHTTPRequestOperation *)userBusinessTravelExplainWithUserID:(NSString *)userID
                                                     completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userID length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userID};
    return [self getPath:KReqBundlePhoneURL
       parameters:param
       completion:completionBlock];
}
#pragma mark -
#pragma mark - 用户个人收藏的酒店信息
- (AFHTTPRequestOperation *)userCollectHotelInforWithUserId:(NSString *)userId
                                                 completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId};
    return [self getPath:KReqCollectHotelesURL
       parameters:param
       completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户个人添加收藏酒店信息
- (AFHTTPRequestOperation *)userAddCollectItemHotelWithUserId:(NSString *)userId
                                                      hotelId:(NSString *)hotelId
                                                   completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1 ||
        [hotelId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            KDataKeyHotelId:hotelId};
    return [self postPath:KReqAddCollectHotelURL
       parameters:param
       completion:completionBlock];
}

#pragma mark -
#pragma mark - 用户个人删除某条已收藏的酒店信息
- (AFHTTPRequestOperation *)userDeleteCollectItemHotelWithUserId:(NSString *)userId
                                                         hotelId:(NSString *)hotelId
                                                      completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([userId length] < 1 ||
        [hotelId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyUserId:userId,
                            KDataKeyHotelId:hotelId};
    return [self postPath:KReqDeleteCollectHotelURL
        parameters:param
        completion:completionBlock];
}

#pragma mark -
#pragma mark -  查询酒店介绍信息
- (AFHTTPRequestOperation *)hotelIntroductionWithHotelId:(NSString *)hotelid
                                              completion:(WebAPIRequestCompletionBlock)completionBlock{
    if ([hotelid length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyHotelId:hotelid};
    return [self getPath:KReqHotelIntroductionURL
               parameters:param
               completion:completionBlock];
}

#pragma mark -
#pragma mark -  查询某个酒店里所有房间信息
- (AFHTTPRequestOperation *)hotelAllRoomInforListWithHotelId:(NSString *)hotelid pageSize:(NSInteger)pageSize pageRow:(NSInteger)pageRow completion:(WebAPIRequestCompletionBlock)completionBlock{
    
    if ([hotelid length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        
        return  nil;
    }
    
    NSDictionary *param = @{KDataKeyHotelId:hotelid,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyCurrentPage:[NSNumber numberWithInteger:pageRow],
                            };
    return [self getPath:KReqHotelRoomListURL
              parameters:param
              completion:completionBlock];
}
@end
