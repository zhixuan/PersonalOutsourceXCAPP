//
//  CityInforForTrainTicketTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"


#define KCityForTrainTicketCellHeight           (KXCUIControlSizeWidth(42.0f) + 1.0f)
@interface CityInforForTrainTicketTableViewCell : XCBaseUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupDataSourceCityName:(NSString *)cityNameStr indexPath:(NSIndexPath *)indexPath;
@end
