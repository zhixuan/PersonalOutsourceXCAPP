//
//  TrainTicketTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"
#import "TrainticketInformation.h"

#define KTrainTicketTableViewCellHeight         (KXCUIControlSizeWidth(110.0f)+1.0)

@interface TrainTicketTableViewCell : XCBaseUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


/**
 *  @method
 *
 *  @brief          初始化火车票数据内容
 *
 *  @param          itemDate    数据源
 *
 *  @param          indexPath   操作定位
 *
 *  @see            null
 *
 */
- (void)setuprainTicketTableViewCellDataSource:(TrainticketInformation *)itemDate
                                     indexPath:(NSIndexPath *)indexPath;
@end
