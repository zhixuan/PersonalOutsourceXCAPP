//
//  XCBaseUITableViewCell.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCBaseUITableViewCell : UITableViewCell

///用户头像设置
@property (nonatomic , weak)    UIImageView             *userPhotoImageView;

///消息用户名
@property (nonatomic , weak)    UILabel                 *userPersonalNameLabel;
///分割线
@property (nonatomic , weak)    UIView                  *separatorView;

///用户头像点击事件
- (void)userOperationUserPhoto:(UIGestureRecognizer*) recognizer;
@end
