//
//  PerOrderTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"
#import "UserHotelOrderInformation.h"
#import "UserPersonalOrderInformation.h"

//
//#define KPerOrderTableViewCellHeight            (KXCUIControlSizeWidth(135.0f))
//#define KPerOrderTableViewCellContentHeight     (KXCUIControlSizeWidth(135.0f) - KInforLeftIntervalWidth)

#define KPerOrderCellHeightForAdministration    (KXCUIControlSizeWidth(30.0f)*3.0+KInforLeftIntervalWidth+KFunctionModulButtonHeight)

#define KPerOrderCellHeightForGuest             (KXCUIControlSizeWidth(30.0f)*2.0+KInforLeftIntervalWidth+KFunctionModulButtonHeight)


#define KPerOrderCellContentHeightForAdministration    (KPerOrderCellHeightForAdministration - KInforLeftIntervalWidth)

#define KPerOrderCellContentHeightForGuest             (KPerOrderCellHeightForGuest - KInforLeftIntervalWidth)


/**
 *  @method
 *
 *  @brief          个人订单列表Cell
 *
 */
@interface PerOrderTableViewCell : XCBaseUITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupPerOrderTableViewCellDataSource:(UserPersonalOrderInformation *)itemData
                                   indexPath:(NSIndexPath *)indexPath;

@end
