//
//  HotelReserveTenantInforTableCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"

#define KHotelReserveTenantInforTableCellHeight           (KXCUIControlSizeWidth(56.0f)+1.0f)

@protocol HotelReserveTenantInforTableCellDelegate <NSObject>

- (void)userSelectedReserveTenantUserToEditWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface HotelReserveTenantInforTableCell : XCBaseUITableViewCell
/*!
 * @breif 用户操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<HotelReserveTenantInforTableCellDelegate>       delegate;

/*!
 * @breif 指示视图图片
 * @See
 */
@property (nonatomic , weak)      UIImageView               *userSelectedImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupDataSource:(UserInformationClass *)itemDate indexPaht:(NSIndexPath *)indexPath;
@end
