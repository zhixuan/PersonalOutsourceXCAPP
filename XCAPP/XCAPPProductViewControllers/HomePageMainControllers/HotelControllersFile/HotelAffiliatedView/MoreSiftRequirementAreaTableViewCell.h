//
//  MoreSiftRequirementAreaTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/20.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"

#define KAreaTableViewCellHeight        (KXCUIControlSizeWidth(55.0f))

@interface MoreSiftRequirementAreaTableViewCell : XCBaseUITableViewCell


/*!
 * @breif 指示视图图片
 * @See
 */
@property (nonatomic , weak)      UIImageView               *userSelectedImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupTableViewDataSource:(NSString *)areaNameStr indexPath:(NSIndexPath *)indexPath;
@end
