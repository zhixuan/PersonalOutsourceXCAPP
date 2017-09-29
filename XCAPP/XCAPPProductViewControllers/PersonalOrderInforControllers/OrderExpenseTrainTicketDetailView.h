//
//  OrderExpenseTrainTicketDetailView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/17.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainticketOrderInformation.h"


/**
 *  @method
 *
 *  @brief          火车票明细信息内容
 *
 */
@interface OrderExpenseTrainTicketDetailView : UIButton
- (id)initWithFrame:(CGRect)frame order:(TrainticketOrderInformation *)orderInfor;

- (id)initWithFrame:(CGRect)frame order:(TrainticketOrderInformation *)orderInfor beginPay:(BOOL)beginPay;
@end
