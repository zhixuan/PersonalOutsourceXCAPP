//
//  TrainticketOrderInformation.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.

//

#import <Foundation/Foundation.h>
#import "TrainticketInformation.h"


/**
 *  @method
 *
 *  @brief          火车票订单信息内容
 *
 */
@interface TrainticketOrderInformation : NSObject


/*!
 * @breif 订单ID
 * @See
 */
@property (nonatomic , copy)            NSString            *ttOrderIdStr;

/*!
 * @breif 订单创建时间
 * @See
 */
@property (nonatomic , copy)            NSString            *ttOrderCreateDate;

/*!
 * @breif 订单号
 * @See 用户用于查找信息的唯一凭证
 */
@property (nonatomic , copy)            NSString            *ttOrderTradeNumber;

/*!
 * @breif 火车票交易编码(与去哪网对接获取的交易编码)
 * @See 订单号
 */
@property (nonatomic , copy)            NSString            *ttOrderTradeNumberCodeForQuNaErStr;


/*!
 * @breif 火车票订单对应的火车票信息
 * @See
 */
@property (nonatomic , strong)          TrainticketInformation  *ttOrderTrainticketInfor;

/*!
 * @breif 车票出发时间
 * @See e.g.        2016/08/06 周六 ， 2016/08/09 周一
 */
@property (nonatomic , copy)            NSString            *ttOrderDepartDate;

/*!
 * @breif 服务费用信息
 * @See e.g.        ￥ 20/人，，40元
 */
@property (nonatomic , copy)            NSString            *ttOrderServiceCostStr;


/*!
 * @breif 订单中人员信息（若登录者购票，则包含登录者信息；若登录者没有购票，则不包含当前用户）
 * @See
 */
@property (nonatomic , strong)          NSMutableArray      *ttOrderBuyTicketUserMutArray;

/*!
 * @breif 是否是高铁票
 * @See
 */
@property (nonatomic , assign)          BOOL                tticketIsHighspeedBool;

/*!
 * @breif 订购火车票张数
 * @See 默认为0
 */
@property (nonatomic , assign)          NSInteger           ttTicketCountInteger;

/*!
 * @breif 订购火车票总得花费信息
 * @See 保留小数点儿2位
 */
@property (nonatomic , assign)          CGFloat              ttTicketTotalVolume;


/*!
 * @breif 预订人信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass    *ttOrderReserveUserInfor;

/*!
 * @breif 联系人信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass    *ttOrderBookUserInfor;


///*!
// * @breif 订单状态信息
// * @See
// */
//@property (nonatomic , copy)          NSString              *ttOrderStateStyle;

/*!
 * @breif 订单状态信息
 * @See
 */
@property (nonatomic , assign)         XCAPPOrderForTrainTicketPayStyle ttOrderStateStyle;


/*!
 * @breif 创建火车票订单，格式化上传参数信息
 * @See
 */
- (NSMutableDictionary *)createTrainticketOrderInformationParameter;

/*!
 * @breif 初始化用户退票操作参数信息
 * @See
 */
- (NSMutableDictionary *)userPersonalSetupRefundTrainticketOrderInformationParameter;


/**
 *  @method
 *
 *  @brief          初始化用户火车票订单信息
 *
 */
+ (id)initializaionWithUserTrainticketInfoListWithUnserializedJSONDic:(NSDictionary *)dicInfor;

/**
 *  @method
 *
 *  @brief          补充用户火车票订单相信信息
 *
 */
- (void)supplementUserTrainticketOrderDetailInfoWithUnserializedJSONDic:(NSDictionary *)dicInfor;

@end
//+_+QQ 10990 28580
