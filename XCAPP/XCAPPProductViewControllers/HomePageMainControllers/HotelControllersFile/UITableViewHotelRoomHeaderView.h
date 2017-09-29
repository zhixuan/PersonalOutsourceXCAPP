//
//  UITableViewHotelRoomHeaderView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelInformation.h"
#define KUITableViewHotelRoomHeaderCellHeight     (KXCUIControlSizeWidth(60.0f) + 1.0f)

@protocol UITableViewHotelRoomHeaderViewDelegate <NSObject>

- (void)didSelectedHeaerViewWithPathIndex:(NSInteger)indexPath;

@end

@interface UITableViewHotelRoomHeaderView : UITableViewHeaderFooterView

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<UITableViewHotelRoomHeaderViewDelegate>     delegate;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupDataSouceForHeaerCell:(HotelInformation *)itemData indexPath:(NSInteger)indexPath;
@end
