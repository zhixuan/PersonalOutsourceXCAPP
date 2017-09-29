//
//  TrainticketOrderInformation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainticketOrderInformation.h"
#import "JSONKit.h"

@implementation TrainticketOrderInformation


- (id)init{
    self = [super init];
    if (self) {
        self.ttOrderTrainticketInfor = [[TrainticketInformation alloc]init];
        self.ttOrderBuyTicketUserMutArray = [[NSMutableArray alloc]init];
        self.ttOrderReserveUserInfor = [[UserInformationClass alloc]init];
        self.ttOrderBookUserInfor = [[UserInformationClass alloc]init];
        
        
    }
    
    return self;
}



#pragma mark -
#pragma mark -  创建火车票订单，格式化上传参数信息
- (NSMutableDictionary *)createTrainticketOrderInformationParameter{

    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    /**
     
     from           String          出发站
     to             String          终到站	Y
     date           String          出发日期	Y	格式yyyy-MM-dd
     trainStartTime	String          出发日期时间	Y	格式yyyyMMddHHmm
     trainEndTime	String          到达日期时间	Y	格式yyyyMMddHHmm
     trainSeat      String          坐席	Y
     contactName	String          联系人	Y
     contactPhone	String          手机	Y
     ticketPrice	float           票价	Y
     passengers     Passenger[]     乘客	Y	其参数使用passengers[0].ticketType形式
     
     **/
    
    /**
     [weakSelf.ticketOrderInfor.ttOrderTrainticketInfor setTraCabinModelStr:traCabinModelStr];
     [weakSelf.ticketOrderInfor.ttOrderTrainticketInfor setTraUnitPrice:priceStr];
     
     **/
    
    AddObjectForKeyIntoDictionary(KXCAPPCurrentUserInformation.userPerId, @"userid", param);
    
    ///出发站
    AddObjectForKeyIntoDictionary(self.ttOrderTrainticketInfor.traTakeOffSite, @"from", param);
    ///终到站
    AddObjectForKeyIntoDictionary(self.ttOrderTrainticketInfor.traArrivedSite, @"to", param);
    ///出发日期
    AddObjectForKeyIntoDictionary(self.ttOrderDepartDate, @"date", param);
    ////出发日期时间	Y	格式yyyyMMddHHmm
    AddObjectForKeyIntoDictionary(self.ttOrderTrainticketInfor.traTakeOffTimeSealStr, @"trainStartTime", param);
    ///到达日期时间	Y	格式yyyyMMddHHmm
    AddObjectForKeyIntoDictionary(self.ttOrderTrainticketInfor.traArrivedTimeSealStr, @"trainEndTime", param);
    ///trainSeat      String          坐席	Y
    AddObjectForKeyIntoDictionary(self.ttOrderTrainticketInfor.traCabinModelStr,@"trainSeat", param);
    
    ///trainNo     车次名字
    AddObjectForKeyIntoDictionary(self.ttOrderTrainticketInfor.traCodeNameStr,@"trainNo", param);
    ////========================
    ////暂用用户邮箱作为订购人用户名
    ////contactName	String          联系人	Y
    ////========================
    AddObjectForKeyIntoDictionary(self.ttOrderReserveUserInfor.userNickNameStr, @"contactName", param);
    
    AddObjectForKeyIntoDictionary(self.ttOrderReserveUserInfor.userPerEmailStr, @"contactEmail", param);
    ///contactPhone	String          手机	Y
    AddObjectForKeyIntoDictionary(self.ttOrderReserveUserInfor.userPerPhoneNumberStr, @"contactPhone", param);
    ///ticketPrice	float           票价	Y
    AddObjectForKeyIntoDictionary([NSNumber numberWithFloat:self.ttTicketTotalVolume ],@"ticketPrice", param);
    
    if (self.ttOrderBuyTicketUserMutArray.count > 0) {
        
        NSMutableArray *travellerArray = [NSMutableArray array];
        
        ///将每个人员拿出来
        for (UserInformationClass *itemUser in self.ttOrderBuyTicketUserMutArray) {
            
            ///格式化
            NSDictionary *userDic = [itemUser setupInitWithUserTravellerReserveParameterWithItemPrice:self.ttOrderTrainticketInfor.traUnitPrice seatType:self.ttOrderTrainticketInfor.traCabinModelStr];
            [travellerArray addObject:userDic];
        }
        ///JSON数据
        NSString *jsonUserStr = [travellerArray JSONString];
        AddObjectForKeyIntoDictionary(jsonUserStr, @"passengers", param);
    }
    
    return param;
}

/*!
 * @breif 初始化用户退票操作参数信息
 * @See
 */

#pragma mark -
#pragma mark - 初始化用户退票操作参数信息
- (NSMutableDictionary *)userPersonalSetupRefundTrainticketOrderInformationParameter{

     NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    AddObjectForKeyIntoDictionary(KXCAPPCurrentUserInformation.userPerId, @"userid", param);
    
    AddObjectForKeyIntoDictionary(self.ttOrderTradeNumberCodeForQuNaErStr, @"qunarOrderNo", param);
    
    AddObjectForKeyIntoDictionary(self.ttOrderIdStr, @"orderNo",param);
    
    if (self.ttOrderBuyTicketUserMutArray.count > 0) {
        
        NSMutableArray *travellerArray = [NSMutableArray array];
        for (UserInformationClass *itemUser in self.ttOrderBuyTicketUserMutArray) {
            NSDictionary *userDic = @{@"name":itemUser.userNameStr,
                                      @"certNo":itemUser.userPerCredentialContent
                                      };
            [travellerArray addObject:userDic];
        }
        ///JSON数据
        NSString *jsonUserStr = [travellerArray JSONString];
        AddObjectForKeyIntoDictionary(jsonUserStr, @"passengers", param);
    }
    
    
    AddObjectForKeyIntoDictionary(@"中国商旅国际有限公司退票", @"comment",param);
    return param;
}


#pragma mark -
#pragma mark -  初始化用户火车票订单信息
+ (id)initializaionWithUserTrainticketInfoListWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    
    TrainticketOrderInformation *item = [[TrainticketOrderInformation alloc]init];
    
    
    /**
     "contact_name" = "zhangliguang1@hotamil.com";
     "contact_phone" = 18615459060;
     "create_time" = 1476117821000;
     "end_city" = "\U6d4e\U5357";
     "order_id" = T0000000420;
     "order_name" = 1461;
     price = 63;
     "qunar_order_no" = xcslw16101100434114e;
     "start_city" = "\U5317\U4eac";
     status = 1;
     "time_end" = 201610131819;
     "time_start" = 201610131154;
     type = train;
     userid = d834723c8bcf436798a5dd5e98dff035;
     
     ***/
//    
//    
//    NSLog(@"\n\n==================\n\n");
//    

    ///订单号
    [item setTtOrderIdStr:StringForKeyInUnserializedJSONDic(dicInfor,@"orderNo")];
    ///交易流水号
    [item setTtOrderTradeNumber:StringForKeyInUnserializedJSONDic(dicInfor,@"orderNo")];
    
    ///订单状态信息
    [item setTtOrderStateStyle:IntForKeyInUnserializedJSONDic(dicInfor,@"status")];
    ///去哪儿网交易流水号
    [item setTtOrderTradeNumberCodeForQuNaErStr:StringForKeyInUnserializedJSONDic(dicInfor,@"qunar_order_no")];
    
    ///预订人信息
    [item.ttOrderReserveUserInfor setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"username")];
    [item.ttOrderReserveUserInfor setUserNickNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"username")];
    [item.ttOrderReserveUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"mobile")];
//    [item.ttOrderReserveUserInfor setuserp];
    
    [item.ttOrderBookUserInfor setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contact_name")];
    [item.ttOrderBookUserInfor setUserNickNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contact_name")];
    [item.ttOrderBookUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contact_phone")];
//
    
    NSString *time_startStr = StringForKeyInUnserializedJSONDic(dicInfor, @"time_start");
    NSString *time_endStr = StringForKeyInUnserializedJSONDic(dicInfor, @"time_end");
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSDate *starDate = [dataFormatter dateFromString:time_startStr];
    NSDate *endDate = [dataFormatter dateFromString:time_endStr];
    
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *startDateStr = [NSString stringWithFormat:@"%@",[dataFormatter stringFromDate:starDate]];
    
    [item setTtOrderDepartDate:startDateStr];
    
    [item.ttOrderTrainticketInfor setTraTakeOffTimeSealStr:[dataFormatter stringFromDate:starDate]];
    [item.ttOrderTrainticketInfor setTraArrivedTimeSealStr:[dataFormatter stringFromDate:endDate]];
    
    [dataFormatter setDateFormat:@"HH:mm"];
    [item.ttOrderTrainticketInfor setTraTakeOffTime:[dataFormatter stringFromDate:starDate]];
    [item.ttOrderTrainticketInfor setTraArrivedTime:[dataFormatter stringFromDate:endDate]];
    
    [item.ttOrderTrainticketInfor setTraTakeOffSite:StringForKeyInUnserializedJSONDic(dicInfor, @"start_city")];
    
    
    [item.ttOrderTrainticketInfor setTraArrivedSite:StringForKeyInUnserializedJSONDic(dicInfor, @"end_city")];
    
    [item setTtTicketTotalVolume:FloatForKeyInUnserializedJSONDic(dicInfor,@"price")];
    
    [item.ttOrderTrainticketInfor setTraCodeNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"order_name")];
    
    ///创建时间
    double createDateStamp = DoubleForKeyInUnserializedJSONDic(dicInfor, @"create_time")/1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:createDateStamp];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [item setTtOrderCreateDate:[dataFormatter stringFromDate:createDate]];
    

    return item;
}

#pragma mark -
#pragma mark -  补充用户火车票订单相信信息
- (void)supplementUserTrainticketOrderDetailInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    
    
    NSString *orderString = @"";
    NSInteger keyItem = 1;
    for (NSString *keyStr in dicInfor.allKeys) {
        
        
        orderString = [NSString stringWithFormat:@"%@ %zi key is %@ \t\t  value is %@\n\n",orderString,keyItem,keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr)];
//        NSLog(@"key is %@ \t\t  value is %@",keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr));
        keyItem+=1;
    }
    //
    NSLog(@"\norderString is\n%@",orderString);

    [self setTtOrderStateStyle:OrderStateForTTicketAlreadySoldAndPay];
    ///预订人信息
    [self.ttOrderReserveUserInfor setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"bookName")];
    [self.ttOrderReserveUserInfor setUserNickNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"bookName")];
    [self.ttOrderReserveUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"bookPhone")];
    
    ///联系人信息
    [self.ttOrderBookUserInfor setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contactName")];
    [self.ttOrderBookUserInfor setUserNickNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contactName")];
    [self.ttOrderBookUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contactPhone")];
    [self.ttOrderBookUserInfor setUserPerEmailStr:StringForKeyInUnserializedJSONDic(dicInfor, @"contactEmail")];
    
    if ([ObjForKeyInUnserializedJSONDic(dicInfor,@"passengers") isKindOfClass:[NSArray class]]) {

        NSArray *userArray = (NSArray *)ObjForKeyInUnserializedJSONDic(dicInfor,@"passengers");
        NSMutableArray *userMutableArray = [NSMutableArray array];
        for (NSDictionary *userDic in userArray) {
            UserInformationClass *user = [UserInformationClass initializaionWithOrderForUserTrainTicketWithJSONDic:userDic];
            [userMutableArray addObject:user];
        }
        
        [self setTtOrderBuyTicketUserMutArray:userMutableArray];
    }
    
    
    [self.ttOrderTrainticketInfor setTraCodeNameStr:StringForKeyInUnserializedJSONDic(dicInfor,@"trainNo")];
//    [self.ttOrderTrainticketInfor setTraTypeStr:StringForKeyInUnserializedJSONDic(dicInfor,@"trainType")];
    [self.ttOrderTrainticketInfor setTraCabinModelStr:StringForKeyInUnserializedJSONDic(dicInfor,@"trainSeat")];
    
//    [self.ttOrderTrainticketInfor setTraTakeOffSite:StringForKeyInUnserializedJSONDic(dicInfor,@"dptStation")];
//    [self.ttOrderTrainticketInfor setTraTakeOffTime:StringForKeyInUnserializedJSONDic(dicInfor,@"dptTime")];
//    [self.ttOrderTrainticketInfor setTraTakeOffTimeSealStr:StringForKeyInUnserializedJSONDic(dicInfor, @"dptDateTime")];
//    
//    
//    [self.ttOrderTrainticketInfor setTraArrivedSite:StringForKeyInUnserializedJSONDic(dicInfor,@"arrStation")];
//    [self.ttOrderTrainticketInfor setTraArrivedTime:StringForKeyInUnserializedJSONDic(dicInfor,@"arrTime")];
//    [self.ttOrderTrainticketInfor setTraArrivedTimeSealStr:StringForKeyInUnserializedJSONDic(dicInfor, @"arrDateTime")];
    
//    [self.ttOrderTrainticketInfor setTraTimeInterval:StringForKeyInUnserializedJSONDic(dicInfor,@"interval")];
//    [self.ttOrderTrainticketInfor setTraTimeIntervalInteger:IntForKeyInUnserializedJSONDic(dicInfor,@"intervalSort")];
    [self.ttOrderTrainticketInfor setTraUnitPrice:StringForKeyInUnserializedJSONDic(dicInfor,@"ticketPrice")];
}
@end
