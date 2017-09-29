//
//  OrderExpenseDetailView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHotelOrderInformation.h"


/**
 *  @method
 *
 *  @brief          费用明细说明
 *
 */
@interface OrderExpenseDetailView : UIButton
- (id)initWithFrame:(CGRect)frame order:(UserHotelOrderInformation *)orderInfor;
@end
