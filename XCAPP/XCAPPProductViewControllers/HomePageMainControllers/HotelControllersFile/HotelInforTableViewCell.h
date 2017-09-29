//
//  HotelInforTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"
#import "HotelInformation.h"



#define KHotelInforTableViewCellHeight          (KXCUIControlSizeWidth(80.0f)+1.0)
/**
 *  @method
 *
 *  @brief          酒店数据列表内容
 *
 */
@interface HotelInforTableViewCell : XCBaseUITableViewCell

///初始化酒店列表Cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

///初始化酒店查询列表数据内容
- (void)setupHotelInforTableViewCellDataSource:(HotelInformation *)itemData indexPath:(NSIndexPath *)indexPath;

//- ()


























































@end
