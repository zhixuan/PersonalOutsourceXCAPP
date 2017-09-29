//
//  HotelDetailTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"
#import "HotelInformation.h"
#define KHotelDetailTableViewCellHeight     (KXCUIControlSizeWidth(90.0f) + 1.0f)


@protocol HotelDetailTableViewCellDelegate <NSObject>

- (void)userPersonalReserveRoomOperationWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface HotelDetailTableViewCell : XCBaseUITableViewCell

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<HotelDetailTableViewCellDelegate>        delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

///初始化Cell数据信息
- (void)setupDataSourceForIndexCell:(HotelInformation *)itemData indexPath:(NSIndexPath *)indexPath;

- (void)setupDataSouceForHeaerCell:(HotelInformation *)itemData indexPath:(NSIndexPath *)indexPath;
@end
