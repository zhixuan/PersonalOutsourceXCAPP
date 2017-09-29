//
//  WorkerManageTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"
#import "UserInformationClass.h"

@protocol WorkerManageTableViewCellDelegate <NSObject>

- (void)deleteUserWithIndexPath:(NSIndexPath *)indexPath;

@end

#define KWorkerManageTableViewCellHeight        (KXCUIControlSizeWidth(60) + 1.0f)
@interface WorkerManageTableViewCell : XCBaseUITableViewCell

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<WorkerManageTableViewCellDelegate> delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupUserInforDataSource:(UserInformationClass *)itemDate indexPath:(NSIndexPath *)indexPath;
@end
