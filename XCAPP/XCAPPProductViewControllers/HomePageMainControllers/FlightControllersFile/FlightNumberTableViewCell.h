//
//  FlightNumberTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"

#define KFlightNumberTableViewHeight            (KXCUIControlSizeWidth(68.0f) + 5.0f)


@protocol FlightNumberCellDelegate <NSObject>
///用户查看航班退改费信息
- (void)userCheckReturnCostInfor:(NSIndexPath *)indexPath;

///用户预订航班操作
- (void)userPersonalReserveFlightWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface FlightNumberTableViewCell : XCBaseUITableViewCell

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<FlightNumberCellDelegate>    delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupCellWithDataSource:(FlightInformation *)itemData indexPath:(NSIndexPath *)indexPath;
@end
