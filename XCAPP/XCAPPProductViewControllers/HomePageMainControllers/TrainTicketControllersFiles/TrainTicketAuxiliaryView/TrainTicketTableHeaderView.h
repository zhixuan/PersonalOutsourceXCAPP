//
//  TrainTicketTableHeaderView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TrainTicketTableHeaderDelegate <NSObject>

- (void)userSelectedTrainTicketDate:(NSString *)searchDate;

@end
@interface TrainTicketTableHeaderView : UIView

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<TrainTicketTableHeaderDelegate>  delegate;
- (id)initWithFrame:(CGRect)frame;
@end
