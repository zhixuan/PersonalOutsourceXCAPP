//
//  UIUserOperationButton.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/12/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInformationClass.h"
@interface UIUserOperationButton : UIButton

/*!
 * @breif 被操作的用户信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass *userOperation;
@end
