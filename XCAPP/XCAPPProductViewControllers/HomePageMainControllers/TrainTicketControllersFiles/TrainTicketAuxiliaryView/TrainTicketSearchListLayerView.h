//
//  TrainTicketSearchListLayerView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/12.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KTrainTicketSearchSetupBottomViewHeight     (KXCUIControlSizeWidth(50.0f))

#define KBtnForDepartButton                         (1860411)

#define KBtnForAchieveButton                        (1860412)

#define KBtnForTimeIntervalButton                   (1860413)

#define KBtnForSiftRequirementButton                (1860414)


@protocol TrainTicketSearchListDelegate <NSObject>

- (void)userSelectedTrainTicketSearchDefaultotelSearchWithSequenceButton:(UIButton *)button;

@end

@interface TrainTicketSearchListLayerView : UIView

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<TrainTicketSearchListDelegate>       delegate;

/*!
 * @breif 出发按键
 * @See
 */
@property (nonatomic , weak)      UIButton          *btnForDepartButton;

/*!
 * @breif 到达按键
 * @See
 */
@property (nonatomic , weak)      UIButton          *btnForAchieveButton;

/*!
 * @breif 到达按键
 * @See
 */
@property (nonatomic , weak)      UIButton          *btnForTimeIntervalButton;

- (id)initWithFrame:(CGRect)frame;

@end
