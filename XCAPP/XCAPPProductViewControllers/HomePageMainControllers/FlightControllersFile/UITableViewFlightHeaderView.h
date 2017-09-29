//
//  UITableViewFlightHeaderView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KUITableViewFlightHeaderHeight          (KXCUIControlSizeWidth(88.0f) + 1.0f)


@protocol UITableViewFlightHeaderDelegate <NSObject>

///用户选择行程出发时间操作
- (void)userSelectedIndexPath:(NSInteger)indexPath;

@end
@interface UITableViewFlightHeaderView : UITableViewHeaderFooterView

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<UITableViewFlightHeaderDelegate>     delegate;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupFlightHeaderViewDataSource:(FlightInformation *)itemData indexPath:(NSInteger)indexPath;
@end

