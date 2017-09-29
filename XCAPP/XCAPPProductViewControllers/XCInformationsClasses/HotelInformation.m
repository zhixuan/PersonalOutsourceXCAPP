//
//  HotelInformation.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelInformation.h"

@implementation HotelInformation

- (id)init{
    self =[super init];
    if (self) {
        self.hotelServiceContentArray = [[NSArray alloc]init];
    }
    
    return self;
}


#pragma mark -
#pragma mark -  初始化酒店列表数据内容
+ (id)initializaionWithHotelListInformationWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    
    HotelInformation *itemHotel = [[HotelInformation alloc]init];
    if (dicInfor == nil || dicInfor.count == 0) {
        
        return itemHotel;
    }
//    
//    CGFloat distance = FloatForKeyInUnserializedJSONDic(dicInfor,@"distance");
//    [itemHotel setHotelDistanceStr:[NSString stringWithFormat:@"%.0lf米",distance]];
//    CGFloat distanceMax = distance/1e3;
//    if ( distanceMax> 1) {
//        [itemHotel setHotelDistanceStr:[NSString stringWithFormat:@"%.2lf公里",distanceMax]];
//    }
//    
//    [itemHotel setHotelNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor,@"name")];
//    
//    [itemHotel setHotelRankContentStr:StringForKeyInUnserializedJSONDic(dicInfor,@"jibie")];
//    
//    [itemHotel setHotelMarkRecordContentStr:StringForKeyInUnserializedJSONDic(dicInfor,@"rank")];
//    
//    [itemHotel setHotelImageDisplayURLStr:StringForKeyInUnserializedJSONDic(dicInfor,@"image")];
//    
//    [itemHotel setHotelMinUnitPriceFloat:FloatForKeyInUnserializedJSONDic(dicInfor,@"price")];
//    
    
    NSString *orderString = @"";
    NSInteger keyItem = 1;
    for (NSString *keyStr in dicInfor.allKeys) {
        
        
        orderString = [NSString stringWithFormat:@"%@ %zi %@ \t\t\t\t\t\t\t\t\t:%@\n",orderString,keyItem,keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr)];
        keyItem+=1;
    }
    //
    NSLog(@"\norderString is\n%@",orderString);
    
    
    ///酒店ID或者产品（房间）ID
    [itemHotel setHotelIdStr:StringForKeyInUnserializedJSONDic(dicInfor,@"hid")];
    
    ///酒店名字
    [itemHotel setHotelNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor,@"ahotel_name")];
    
    ///酒店错略地址
    [itemHotel setHotelAddressRoughStr:StringForKeyInUnserializedJSONDic(dicInfor,@"address")];

    [itemHotel setHotelMarkRecordContentStr:@"5.0"];
    
    [itemHotel setHotelMinUnitPriceFloat:FloatForKeyInUnserializedJSONDic(dicInfor,@"price")];
    
    [itemHotel setHotelImageDisplayURLStr:StringForKeyInUnserializedJSONDic(dicInfor, @"main_pic")];
    
    NSInteger hotelStarInteger = IntForKeyInUnserializedJSONDic(dicInfor, @"hotel_star");
    if (hotelStarInteger == 0) {
        [itemHotel setHotelRankContentStr:@"无星"];
    }else if (hotelStarInteger == 1){
        [itemHotel setHotelRankContentStr:@"经济型"];
    }
    else if (hotelStarInteger == 2){
        [itemHotel setHotelRankContentStr:@"二星级"];
    }
    else if (hotelStarInteger == 3){
        [itemHotel setHotelRankContentStr:@"三星级"];
    }
    else if (hotelStarInteger == 4){
        [itemHotel setHotelRankContentStr:@"四星级"];
    }
    else if (hotelStarInteger == 5){
        [itemHotel setHotelRankContentStr:@"五星级"];
    }
    else if (hotelStarInteger == 6){
        [itemHotel setHotelRankContentStr:@"豪华型"];
    }
    else if (hotelStarInteger == 7){
        [itemHotel setHotelRankContentStr:@"七星级"];
    }
    else{
        [itemHotel setHotelRankContentStr:@"豪华型"];
    }
    
    
    //CLLocationCoordinate2DMake(40.03481674194336, 116.3718872070312)
    
    CLLocationDegrees latitude = FloatForKeyInUnserializedJSONDic(dicInfor, @"coor_y");
    CLLocationDegrees longitude = FloatForKeyInUnserializedJSONDic(dicInfor, @"coor_x");
    [itemHotel setHotelCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
    
    [itemHotel setHotelIntroductionInfor:StringForKeyInUnserializedJSONDic(dicInfor, @"intro")];
    
    NSString *facilityStr = StringForKeyInUnserializedJSONDic(dicInfor, @"facility");
    if (!IsStringEmptyOrNull(facilityStr)) {
        if ([facilityStr length] == 3) {
            NSArray *facilityArray = [facilityStr componentsSeparatedByString:@"|"];

            
            if (facilityArray.count >0) {
                
                NSMutableArray *serviceImageArray = [NSMutableArray array];
                
                NSString *firstImage =facilityArray.firstObject;
                if ([firstImage isEqualToString:@"1"]) {
                    [serviceImageArray addObject:@"hotelParkImage.jpg"];

                }else {
                    [serviceImageArray addObject:@""];
                }
                
                if (facilityArray.count == 2) {
                    NSString *secondImage =facilityArray.lastObject;
                    if ([secondImage isEqualToString:@"1"]) {
                        [serviceImageArray addObject:@"hotelWifiImage.jpg"];
                    }else {
                        [serviceImageArray addObject:@""];
                    }
                }
                [itemHotel setHotelServiceContentArray:serviceImageArray];
            }
        }
    }
    /***
     
     1 main_pic 									:
     2 breakfast 									:0
     3 room_name_intl 									:
     4 hotel_star 									:5
     5 hid 									:98
     6 city_name 									:武汉市
     7 purchase 									:10
     8 intro 									:
     9 ahotel_name_intl 									:New Beacon Luguang International Hotel
     10 room_name 									:商务双床房
     11 facility 									:1|1
     12 price_type 									:2
     13 phone_number 									:027-59361111
     14 p_name 									:不含早可取消
     15 start_time 									:1475164800000
     16 pid 									:59
     17 end_time 									:1475164800000
     18 price 									:10
     19 ahotel_name 									:武汉纽宾凯鲁广国际酒店
     20 address 									:东湖高新技术开发区民院路38号
     21 rid 									:249
     ***/
    return itemHotel;
}


#pragma mark -
#pragma mark -  初始化酒店房间数据（聚合一级数据）
+ (id)initializaionWithItemHotelRoomInformationForPolymerizeHeaderCellWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    
    HotelInformation *itemHotel = [[HotelInformation alloc]init];
    if (dicInfor == nil || dicInfor.count == 0) {
        
        return itemHotel;
    }
    
    
    /**
     address = "\U53cb\U8c0a\U5927\U9053506\U53f7\Uff08\U624d\U534e\U8857\U516c\U4ea4\U8f66\U7ad9\Uff09";
     "ahotel_name" = "\U6b66\U6c49\U7ebd\U5bbe\U51ef\U5f90\U4e1c\U56fd\U9645\U9152\U5e97";
     hid = 1002;
     price = 550;
     rid = 248;
     "room_name" = "\U884c\U653f\U9ad8\U7ea7\U5927\U5e8a\U623f";
     
     **/
    
    [itemHotel setHotelIdStr:StringForKeyInUnserializedJSONDic(dicInfor, @"hid")];
    [itemHotel setHotelRoomClassIdStr:StringForKeyInUnserializedJSONDic(dicInfor, @"rid")];
    [itemHotel setHotelRoomClassNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor, @"room_name")];
    [itemHotel setHotelMinUnitPriceFloat:FloatForKeyInUnserializedJSONDic(dicInfor, @"price")];
    [itemHotel setHotelAddressDetailedStr:StringForKeyInUnserializedJSONDic(dicInfor, @"address")];
    [itemHotel setHotelNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor, @"ahotel_name")];
    
    
    NSString *orderString = @"";
    NSInteger keyItem = 1;
    for (NSString *keyStr in dicInfor.allKeys) {
        
        
        orderString = [NSString stringWithFormat:@"%@ %zi %@ \t\t\t\t\t\t\t\t\t:%@\n",orderString,keyItem,keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr)];
        keyItem+=1;
    }
    //
    NSLog(@"\norderString is\n%@",orderString);
    
    return itemHotel;
}

#pragma mark -
#pragma mark -  初始化酒店房间产品数据（聚合二级数据）
+ (id)initializaionWithItemHotelRoomInformationForProductIndexCellWithUnserializedJSONDic:(NSDictionary *)dicInfor{
    
    HotelInformation *itemHotel = [[HotelInformation alloc]init];
    if (dicInfor == nil || dicInfor.count == 0) {
        
        return itemHotel;
    }
    
    /**
     
     "p_name": "不含早",//产品名
     "remark": "",//酒店房间备注
     "breakfast": 0,//早餐类型（0无早，1单早，2双早，3三早，4四早，5五早，6六早）
     "add_bed_price": "",//加床加价
     "high_lights": "",//房间特色
     "book_astrict_rule": "1|0|23:59|0",//预订限制规则 格式字段以|分割 售卖昨日房(0无限制，1设置预订限制）|提前天|时间|前后可预订（0之前，1之后）
     "min_day": 1,//最小居住天数（最小为1）
     "deduct_rule": "0|23:59|0|",//扣除费用可退产品规则 格式字段以|分割 天|时间|扣除规则（0首晚，1按百分比） |百分比 如 15|01:00|1|80
     "add_bed": "",//加床信息
     "id": 125,//房价id
     "stock": null,//库存
     "area": "28",//面积
     "rt_bed_type": 1,//床型 1大床 2双床 3大床或双床 4三床 5一双一单 6单人床 7圆床 8榻榻米 9水床 10上下铺 11其他
     "cpsid": 253,//
     "bath": "",//
     卫浴 "home_share": 0,//共享房型库存 0 否 1是
     "sell_rule": "00|00|0|23|59",//售卖时段规则 格式字段以|分割 开始小时|开始分钟|是否当日（0当日，1次日）|结束小时|结束分钟
     "work_off": 0,//已售
     "rt_broad_band": "1",//宽带(1:有，2：无 默认1)
     "rt_bed_width": "2",//床宽 单位为m，允许录入并显示小数后1位
     "pid": 47,//产品id
     "valid_week": "2|3|4|5|6|7|1",//有效周
     "smoke": 1,//无烟房(1:是，2：否 默认1)
     "open_state": 1,//0关房 1开房
     "wifi": "1",//宽带(1:有，2：无 默认1)
     "price": 220,//价格
     "WINDOW": 1,//有无窗户(1:是，2：否 默认1)
     "floor": "9-16",//楼层
     "no_dedct_rule": "1|23:59",//不扣除费用规则 格式字段以|分割 天|时间 如 15|01:00
     "end_time": "1477843200000",//
     "min_room": 1,//最小预定间数(最小1)
     "rid": 242,//房型id
     "room_name": "高级大床房",//房型名称
     "max_day": 28,//最大居住天数（最大100）
     "max_customers": "",//最大入住人
     "start_time": "1472832000000",//价格开始时间
     "valid_date": "1476892800000",//价格结束时间
     "max_room": 8//最大预定间数（最大100）
     **/
    
    
    NSString *orderString = @"";
    NSInteger keyItem = 1;
    for (NSString *keyStr in dicInfor.allKeys) {
        
        
        orderString = [NSString stringWithFormat:@"%@ %zi key is %@ \t\t  value is %@\n",orderString,keyItem,keyStr,StringForKeyInUnserializedJSONDic(dicInfor, keyStr)];
        keyItem+=1;
    }
    //
    NSLog(@"\norderString is\n%@",orderString)
    
    [itemHotel setHotelRoomProductIdStr:StringForKeyInUnserializedJSONDic(dicInfor, @"pid")];
    [itemHotel setHotelRoomClassIdStr:StringForKeyInUnserializedJSONDic(dicInfor, @"rid")];
    [itemHotel setHotelRoomClassNameContentStr:StringForKeyInUnserializedJSONDic(dicInfor, @"room_name")];
    [itemHotel setHotelRoomStyleExplanationContent:@"华滨景观房"];
    
    NSString *roomName = @"";
    if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(dicInfor, @"room_name"))) {
        roomName = StringForKeyInUnserializedJSONDic(dicInfor, @"room_name");
    }
    
    if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(dicInfor, @"p_name"))) {
        roomName = [NSString stringWithFormat:@"%@（%@）",roomName,StringForKeyInUnserializedJSONDic(dicInfor, @"p_name")];
    }
    [itemHotel setHotelRoomStyleExplanationContent:roomName];


    ///hotelRoomResidueCountInteger房间剩余量
    [itemHotel setHotelRoomResidueCountInteger:100];
    
    [itemHotel setHotelRealityUnitPriceFloat:FloatForKeyInUnserializedJSONDic(dicInfor, @"price")];
    
    NSInteger breakfastInteger = IntForKeyInUnserializedJSONDic(dicInfor,@"breakfast");

    ///早餐类型（0无早，1单早，2双早，3三早，4四早，5五早，6六早）
    if (breakfastInteger == 0) {
        [itemHotel setHotelMorningMealContent:@"无早"];
    }else if (breakfastInteger == 1){
        [itemHotel setHotelMorningMealContent:@"单早"];
    }
    else if (breakfastInteger == 2){
        [itemHotel setHotelMorningMealContent:@"双早"];
    }
    else if (breakfastInteger == 3){
        [itemHotel setHotelMorningMealContent:@"三早"];
    }
    else if (breakfastInteger == 4){
        [itemHotel setHotelMorningMealContent:@"四早"];
    }
    else if (breakfastInteger == 5){
        [itemHotel setHotelMorningMealContent:@"五早"];
    }
    else if (breakfastInteger == 6){
        [itemHotel setHotelMorningMealContent:@"六早"];
    }else{
        [itemHotel setHotelMorningMealContent:@"其他"];
    }
    
//    //床型 1大床 2双床 3大床或双床 4三床 5一双一单 6单人床 7圆床 8榻榻米 9水床 10上下铺 11其他
    NSInteger roomBerthContent = IntForKeyInUnserializedJSONDic(dicInfor, @"rt_bed_type");
    if (roomBerthContent == 1) {
        [itemHotel setHotelRoomBerthContent:@"大床"];
    }else if (roomBerthContent == 2){
        [itemHotel setHotelRoomBerthContent:@"双床"];
    }
    else if (roomBerthContent == 3){
        [itemHotel setHotelRoomBerthContent:@"大床或双床"];
    }
    else if (roomBerthContent == 4){
        [itemHotel setHotelRoomBerthContent:@"三床"];
    }
    else if (roomBerthContent == 5){
        [itemHotel setHotelRoomBerthContent:@"一双一单"];
    }
    else if (roomBerthContent == 6){
        [itemHotel setHotelRoomBerthContent:@"单人床"];
    }
    else if (roomBerthContent == 7){
        [itemHotel setHotelRoomBerthContent:@"圆床"];
    }
    else if (roomBerthContent == 8){
        [itemHotel setHotelRoomBerthContent:@"榻榻米"];
    }
    else if (roomBerthContent == 9){
        [itemHotel setHotelRoomBerthContent:@"水床"];
    }
    else if (roomBerthContent == 10){
        [itemHotel setHotelRoomBerthContent:@"上下铺"];
    }else if (roomBerthContent == 11){
        [itemHotel setHotelRoomBerthContent:@"其他"];
    }else{
        [itemHotel setHotelRoomBerthContent:@"其他"];
    }
    
    ///是否存在网络
    BOOL isWifiBool = IntForKeyInUnserializedJSONDic(dicInfor, @"rt_broad_band");
    if (isWifiBool) {
        [itemHotel setHotelHasWiFiStr:@"宽带Wi-Fi"];
    }else{
        [itemHotel setHotelHasWiFiStr:@"无网络"];
    }
    
    ///房间面积
    NSString *hotelRoomArea = @"未知";
    if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(dicInfor,@"area"))) {
        hotelRoomArea = [NSString stringWithFormat:@"%@ ㎡",StringForKeyInUnserializedJSONDic(dicInfor,@"area")];
    }
    [itemHotel setHotelRoomAreaStr:hotelRoomArea];
    
    return itemHotel;
}
@end
