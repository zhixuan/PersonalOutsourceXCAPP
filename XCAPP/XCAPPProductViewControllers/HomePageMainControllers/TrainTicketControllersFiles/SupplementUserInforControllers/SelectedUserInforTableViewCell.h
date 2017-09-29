//
//  SelectedUserInforTableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"
#import "UserInformationClass.h"


#define KSelectedUserInforTableViewCellHeight           (KXCUIControlSizeWidth(20.0f)*2+1.0f+KInforLeftIntervalWidth*2)

@protocol SelectedUserTableCellDelegate <NSObject>

- (void)userSelectedUserToEditWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface SelectedUserInforTableViewCell : XCBaseUITableViewCell

/*!
 * @breif 用户操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<SelectedUserTableCellDelegate>       delegate;

/*!
 * @breif 指示视图图片
 * @See
 */
@property (nonatomic , weak)      UIImageView               *userSelectedImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupDataSource:(UserInformationClass *)itemDate indexPaht:(NSIndexPath *)indexPath;
@end
