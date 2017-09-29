//
//  UserHotelOrderInformation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/4.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UserHotelOrderInformation.h"
#import "JSONKit.h"

@implementation UserHotelOrderInformation
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.orderStayDayesQuantityInteger= 1;
        self.orderRoomQuantityInteger= 1;
        self.orderMoveIntoUsersArray = [[NSArray alloc]init];
        self.orderCreateUserInfor = [[UserInformationClass alloc]init];
        self.orderContactUserInfor = [[UserInformationClass alloc]init];
        
        self.orderHotelInforation = [[HotelInformation alloc]init];
        self.orderHotelRoomInforation = [[HotelInformation alloc]init];
    }
    return self;
}


#pragma mark -
#pragma mark -  创建预订酒店订单，格式化上传参数信息
- (NSMutableDictionary *)createHotelOrderInformationParameter{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    
    /**
     userId	String	当前登录用户ID	Y
     hId	String	酒店ID	Y
     pId	String	产品ID	Y
     startTime	String	预定起始时间(yyyy-MM-dd)	Y
     endTime	String	预定结束时间(yyyy-MM-dd)	Y
     linkMan	String	联系人	Y
     linkManTel	String	联系人手机号	Y
     price	float	总价	Y
     roomNum	int	房间数量	Y
     checkMan	String	入住 人	Y	多人请以数组形式上传

     **/
    ///用户ID
    AddObjectForKeyIntoDictionary(KXCAPPCurrentUserInformation.userPerId, @"userId", param);
    
    ///酒店ID
    AddObjectForKeyIntoDictionary(self.orderHotelInforation.hotelIdStr, @"hId", param);
    
    ///产品ID
    AddObjectForKeyIntoDictionary(self.orderHotelRoomInforation.hotelRoomProductIdStr, @"pId", param);
    
    ///预订开始时间
    AddObjectForKeyIntoDictionary(self.orderUserMoveIntoDate, @"startTime", param);
    
    ///预订结束时间
    AddObjectForKeyIntoDictionary(self.orderForHotelEndDate, @"endTime", param);
    
    ///联系人姓名
    AddObjectForKeyIntoDictionary(self.orderContactUserInfor.userNameStr, @"linkMan", param);
    
    ///联系人邮箱
    AddObjectForKeyIntoDictionary(self.orderContactUserInfor.userPerPhoneNumberStr, @"linkManTel", param);
    
    ///联系人手机号
    AddObjectForKeyIntoDictionary(self.orderContactUserInfor.userPerEmailStr, @"linkEmail", param);
    
    ///总价
    AddObjectForKeyIntoDictionary(self.orderPaySumTotal, @"price", param);
    
    ///房间数量
    AddObjectForKeyIntoDictionary([NSNumber numberWithInteger:self.orderRoomQuantityInteger], @"roomNum", param);
    
    ///入住人信息
    if (self.orderMoveIntoUsersArray.count > 0) {
        
        NSMutableArray *travellerArray = [NSMutableArray array];
        for (UserInformationClass *itemUser in self.orderMoveIntoUsersArray) {
            [travellerArray addObject:itemUser.userNameStr];
        }
        ///JSON数据
        NSString *jsonUserStr = [travellerArray JSONString];
        AddObjectForKeyIntoDictionary(jsonUserStr, @"checkMan", param);
    }
    
//    AddObjectForKeyIntoDictionary(jsonUserStr, @"checkMan", param);
    return param;
}


#pragma mark -
#pragma mark -  初始化用户订单列信息
+ (id)initializaionWithUserHotelOrderListInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    UserHotelOrderInformation *item = [[UserHotelOrderInformation alloc]init];
    if (dicInfor == nil || dicInfor.count == 0) {
        return item;
    }
    
    NSString *orderString = @"";
    NSInteger keyItem = 1;
    for (NSString *keyStr in dicInfor.allKeys) {
        
        
        orderString = [NSString stringWithFormat:@"%@ %zi key is %@ \t\t  value is %@\n\n",orderString,keyItem,keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr)];
                NSLog(@"key is %@ \t\t  value is %@",keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr));
        keyItem+=1;
    }
    //
    NSLog(@"\norderString is\n%@",orderString);
    
    
    /****
     
     
     1 key is contact_phone 		  value is 1556678-------------------写入
     
     2 key is time_start 		  value is 2016-10-04
     
     3 key is order_name 		  value is 武汉纽宾凯徐东国际酒店-------------------写入
     
     4 key is userid 		  value is d834723c8bcf436798a5dd5e98dff035-------------------写入
     
     5 key is qunar_order_no 		  value is
     
     6 key is time_end 		  value is 2016-10-05
     
     7 key is type 		  value is console
     
     8 key is orderNo 		  value is H0000000419-------------------写入
     
     9 key is price 		  value is 220
     
     10 key is start_city 		  value is 武汉市-------------------写入
     
     11 key is create_time 		  value is 1475431193000-------------------写入
     
     12 key is end_city 		  value is-------------------无
     
     13 key is status 		  value is 0
     
     14 key is contact_name 		  value is 121-------------------写入
     
     ***/
    
    [item setOrderId:StringForKeyInUnserializedJSONDic(dicInfor, @"orderNo")];
    [item setOrderNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"orderNo")];
    
    [item setOrderHotelPayState:IntForKeyInUnserializedJSONDic(dicInfor,@"o_status")];
    
    [item setOrderUserMoveIntoDate:StringForKeyInUnserializedJSONDic(dicInfor, @"time_start")];
    
    [item.orderCreateUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"mobile")];
    [item.orderCreateUserInfor setUserNickNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"username")];
    
    
    [item.orderHotelInforation setHotelNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor, @"order_name")];
    
    [item setOrderPaySumTotal:[NSString stringWithFormat:@"%.1lf",DoubleForKeyInUnserializedJSONDic(dicInfor, @"price")]];
    
    ///创建时间
    double createDateStamp = DoubleForKeyInUnserializedJSONDic(dicInfor, @"create_time")/1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:createDateStamp];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [item setOrderCreateDate:[dataFormatter stringFromDate:createDate]];

    
    return item;
}

#pragma mark -
#pragma mark -  初始化用户每个酒店订单详细信息
- (void)initializaionWithUserItemHotelOrderDetailInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    

    
    ////TODO1：初始化酒店详情详细信息内容；
    
    
    NSString *orderString = @"";
    NSInteger keyItem = 1;
    for (NSString *keyStr in dicInfor.allKeys) {
        orderString = [NSString stringWithFormat:@"%@ %zi key is %@ \t\t  value is %@\n\n",orderString,keyItem,keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr)];
        keyItem+=1;
    }
    NSLog(@" %@",orderString);
    
    ///订单号
    [self setOrderId:StringForKeyInUnserializedJSONDic(dicInfor, @"o_num")];
    [self setOrderNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"o_num")];
    
    ///订单状态
    [self setOrderHotelPayState:IntForKeyInUnserializedJSONDic(dicInfor, @"o_status")];
    
    ///订单总价
    [self setOrderPaySumTotal:StringForKeyInUnserializedJSONDic(dicInfor, @"totoal_price")];
    
    ///联系人信息
    [self.orderContactUserInfor setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"linkman")];
    [self.orderContactUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"linkman_tel")];
    [self.orderContactUserInfor setUserPerEmailStr:StringForKeyInUnserializedJSONDic(dicInfor, @"linkman_email")];
    
    ///预订人
    [self.orderCreateUserInfor setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"username")];
    [self.orderCreateUserInfor setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor, @"mobile")];
    
  
    
    [self.orderHotelInforation setHotelNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor, @"ahotel_name")];
    [self.orderHotelInforation setHotelAddressRoughStr:StringForKeyInUnserializedJSONDic(dicInfor, @"address")];
    [self.orderHotelInforation setHotelRealityUnitPriceFloat:FloatForKeyInUnserializedJSONDic(dicInfor,@"price")];
    
    [self.orderHotelInforation setHotelRoomBerthContent:StringForKeyInUnserializedJSONDic(dicInfor, @"room_name")];
    [self.orderHotelInforation setHotelMorningMealContent:StringForKeyInUnserializedJSONDic(dicInfor, @"p_name")];
    
    
    
    
    [self setOrderForHotelBeginDate:StringForKeyInUnserializedJSONDic(dicInfor, @"check_in_time")];
    [self setOrderForHotelEndDate: StringForKeyInUnserializedJSONDic(dicInfor, @"check_out_time")];
    
    if ([ObjForKeyInUnserializedJSONDic(dicInfor,@"checkman") isKindOfClass:[NSString class]]) {
        NSString *checkManStr = StringForKeyInUnserializedJSONDic(dicInfor, @"checkman");
        
        if (!IsStringEmptyOrNull(checkManStr)) {
            NSArray *userArray = (NSArray *)[checkManStr objectFromJSONString];
            NSLog(@"userArray is %@",userArray);
            NSMutableArray *userMutableArray = [NSMutableArray array];
            for (NSString  *userNameStr in userArray) {
//                UserInformationClass *user = [[UserInformationClass alloc]init];
//                [user setUserNameStr:userNameStr];
                [userMutableArray addObject:userNameStr];
            }
            
            [self setOrderMoveIntoUsersArray:userMutableArray];
        }
        
    }
//    ///房间数
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *beginDate = [dateFormatter dateFromString:self.orderForHotelBeginDate];
    NSDate *endDate = [dateFormatter dateFromString:self.orderForHotelEndDate];
    //计算两个中间差值(秒)
    NSTimeInterval time = [endDate timeIntervalSinceDate:beginDate];
    
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(kHUITimeIntervalDay);  //一天是24小时*3600秒
    
    [self setOrderStayDayesQuantityInteger:days];
    
    [self setOrderRoomQuantityInteger:IntForKeyInUnserializedJSONDic(dicInfor, @"amount")];
    
    ///创建时间
    double createDateStep = DoubleForKeyInUnserializedJSONDic(dicInfor, @"make_time");
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:createDateStep];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [self setOrderCreateDate:[dateFormatter stringFromDate:createDate]];
    
    
    CLLocationDegrees latitude = FloatForKeyInUnserializedJSONDic(dicInfor, @"coor_y");
    CLLocationDegrees longitude = FloatForKeyInUnserializedJSONDic(dicInfor, @"coor_x");
    [self.orderHotelInforation setHotelCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
    
    
    
    ///若订单状态是已确认，未支付（状态2）或待确认待支付（状态0），就进行倒计时操作；
    if (self.orderHotelPayState == OrderStateForHotelNullConfirmNullPay ||
        self.orderHotelPayState == OrderStateForHotelAlreadyConfirmNullPay) {
        
        NSDate *currentDate = [NSDate new];

        //计算两个中间差值(秒)
        NSTimeInterval time = [currentDate timeIntervalSinceDate:createDate];
        
        time =ABS(time);
        
        [self setOrderPayDownCalculateTimeInterval:time];
        
    }
    
    
}
@end
