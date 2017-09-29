//
//  UserInformationClass.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UserInformationClass.h"

@implementation UserInformationClass
- (id)init{
    self = [super init];
    if (self) {
        
        self.userOptionRoleStyle = OptionRoleStyleForDefautStyle;
    }
    
    return self;
}

#pragma mark -
#pragma mark - 初始化添加员工信息参数内容
- (NSMutableDictionary *)addNewWorkerInforReqParam{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    AddObjectForKeyIntoDictionary(self.userPerPhoneNumberStr, @"mobile", param);
    AddObjectForKeyIntoDictionary(self.userNameStr, @"name", param);
    AddObjectForKeyIntoDictionary(self.userNickNameStr, @"username", param);
    
    return param;
}


+ (id)initializaionWithUserForWorkerAndAdminInforWithJSONDic:(NSDictionary *)dicInfor{

    
    
    
    UserInformationClass *item = [[UserInformationClass alloc]init];
    if (dicInfor == nil || dicInfor.count < 1) {
        return item;
    }
    
    
    [item setUserPerId:StringForKeyInUnserializedJSONDic(dicInfor,@"id")];
    [item setUserPerEmailStr:StringForKeyInUnserializedJSONDic(dicInfor,@"email")];
    [item setUserNickNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"username")];
    [item setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"givenName")];
    
    [item setUserPerPhoneNumberStr:StringForKeyInUnserializedJSONDic(dicInfor,@"mobile")];
    
    CGFloat lat = FloatForKeyInUnserializedJSONDic(dicInfor,@"laty");
    CGFloat lot = FloatForKeyInUnserializedJSONDic(dicInfor,@"lotx");
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, lot);
    [item setUserCoordinate:coor];
    
//    [item setUserPerId:<#(NSString *)#>];
    
    
    /**
     id： 用户主键，唯一区别一用户
     givenName：我暂时拿来存用户姓名了
     parentUid：用户的上级用户ID，目前管理员的这个字段为空
     jobNumber：工号
     username：用户的登录账号，一般也不会重复的
     mobile：手机号
     email：用户邮箱
     status：用户状态，1启用，2禁用
     registerTime：工号
     registerIp：工号
     lastLoginTime：工号
     lastLoginIp：工号
     loginCount：工号
     passwordCount：用户登录时密码输入次数统计
     lotx：经度
     laty：纬度
     userKey：用户登录时的token
     city：所在城市
     gender：姓别 1男2女
     
     ***/
    
    return item;
    
}

+ (id)initializaionWithUserForTrainTicketUserInforWithJSONDic:(NSDictionary *)dicInfor{
    
    UserInformationClass *item = [[UserInformationClass alloc]init];
    if (dicInfor == nil || dicInfor.count < 1) {
        return item;
    }
    

    [item setUserPerId:StringForKeyInUnserializedJSONDic(dicInfor, @"id")];
    
    NSString *cerKeyStyle = StringForKeyInUnserializedJSONDic(dicInfor, @"id_type");
    
    [item setUserPerCredentialStyle:@"其他证件"];
    
    if (! IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(KXCShareFMSetting.userCredentialsCompareDictionary , cerKeyStyle))) {
        [item setUserPerCredentialStyle:[KXCShareFMSetting.userCredentialsCompareDictionary valueForKey:cerKeyStyle]];
    }

    [item setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"link_name")];
    
    [item setUserPerCredentialContent:StringForKeyInUnserializedJSONDic(dicInfor, @"id_number")];
    
    
    return item;
}

+ (id)initializaionWithOrderForUserTrainTicketWithJSONDic:(NSDictionary *)dicInfor{
    UserInformationClass *item = [[UserInformationClass alloc]init];
    if (dicInfor == nil || dicInfor.count < 1) {
        return item;
    }
    
    
//    [item setUserPerId:StringForKeyInUnserializedJSONDic(dicInfor, @"id")];
//    
    NSString *cerKeyStyle = StringForKeyInUnserializedJSONDic(dicInfor, @"certType");
    
    [item setUserPerCredentialStyle:@"其他证件"];
    
    if (! IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(KXCShareFMSetting.userCredentialsCompareDictionary , cerKeyStyle))) {
        [item setUserPerCredentialStyle:[KXCShareFMSetting.userCredentialsCompareDictionary valueForKey:cerKeyStyle]];
    }
    
    [item setUserNameStr:StringForKeyInUnserializedJSONDic(dicInfor, @"name")];
    
    [item setUserPerCredentialContent:StringForKeyInUnserializedJSONDic(dicInfor, @"certNo")];
    
    
    return item;
}

#pragma mark -
#pragma mark -  初始化火车票验证用户信息接口参数信息
- (NSMutableDictionary *)setupTrainTicketUserInforReqParam{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    ///证件类型
    AddObjectForKeyIntoDictionary(self.userPerCredentialStyle, @"certType", param);
    ///证件编号
    AddObjectForKeyIntoDictionary(self.userPerCredentialContent,@"certNo",param);
    ///用户名
    AddObjectForKeyIntoDictionary(self.userNameStr, @"name", param);
    
    return param;

}

#pragma mark -
#pragma mark -  初始化添加火车票预订联系人参数信息内容
- (NSMutableDictionary *)setupAddTrainTicketUserInforReqParam{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    ///当前登录人用户ID
    AddObjectForKeyIntoDictionary(self.userPerId, @"userid", param);
    ///证件类型
    AddObjectForKeyIntoDictionary(@"0", @"idType", param);
    ///证件编号
    AddObjectForKeyIntoDictionary(self.userPerCredentialContent,@"idNumber",param);
    ///用户名
    AddObjectForKeyIntoDictionary(self.userNameStr, @"linkName", param);

    AddObjectForKeyIntoDictionary(@"2", @"type", param);
    
    return param;

}


#pragma mark -
#pragma mark -  初始化更新修改火车票预订联系人参数信息内容
- (NSMutableDictionary *)setupUpdateTrainTicketUserInforReqParam{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    ///当前登录人用户ID
    AddObjectForKeyIntoDictionary(self.userPerId, @"userid", param);
    ///证件类型
    AddObjectForKeyIntoDictionary(@"0", @"idType", param);
    ///证件编号
    AddObjectForKeyIntoDictionary(self.userPerCredentialContent,@"idNumber",param);
    ///用户名
    AddObjectForKeyIntoDictionary(self.userNameStr, @"linkName", param);
    
    
    return param;
}

/**
 *  初始化订购火车票乘客用户信息
 **/
- (NSMutableDictionary *)setupInitWithUserTravellerReserveParameterWithItemPrice:(NSString *)priceStr seatType:(NSString *)typeStr{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    
    ///证件类型------当前默认为身份证
    AddObjectForKeyIntoDictionary(@"0", @"certType", paramDic);
    ///票务类型------当前默认为成人票
    AddObjectForKeyIntoDictionary(@"1", @"ticketType", paramDic);
    ///证件编号
    AddObjectForKeyIntoDictionary(self.userPerCredentialContent,@"certNo",paramDic);
    ///用户名
    AddObjectForKeyIntoDictionary(self.userNameStr, @"name", paramDic);
    
    ///票价
    AddObjectForKeyIntoDictionary(priceStr, @"seatPrice", paramDic);
    ///票务种类
    AddObjectForKeyIntoDictionary(typeStr, @"seatType", paramDic);
    
    return paramDic;
}


/**
 *  初始化用户退票操作用户信息
 **/
- (NSMutableDictionary *)setupUserPersonalForTrainUserRefundParameter{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    ///证件编号
    AddObjectForKeyIntoDictionary(self.userPerCredentialContent,@"certNo",paramDic);
    ///用户名
    AddObjectForKeyIntoDictionary(self.userNameStr, @"name", paramDic);
    return paramDic;
}

/**
 *  初始化预订酒店入住人员信息
 **/
- (NSMutableDictionary *)setupInitWithUserHotelReserveParameter{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    
    ///证件类型------当前默认为身份证
    AddObjectForKeyIntoDictionary(@"0", @"certType", paramDic);
    ///证件编号
    AddObjectForKeyIntoDictionary(self.userPerCredentialContent,@"certNo",paramDic);
    ///用户名
    AddObjectForKeyIntoDictionary(self.userNameStr, @"name", paramDic);
    return paramDic;
}


@end
