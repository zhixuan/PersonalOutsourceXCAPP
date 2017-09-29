//
//  FlightSearchListLayerView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/16.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KHotelSearcSetupBottomViewHeight                        (KXCUIControlSizeWidth(50.0f))

#define KBtnForDateSequenceButtonTag                        (1750111)
#define KBtnForPricSequenceeButtonTag                       (1750112)
#define KBtnForMoreSequenceButtonTag                        (1750113)

@protocol FlightSearchListSequenceDelegate <NSObject>

- (void)userSelectedDefaultotelSearchWithSequenceButton:(UIButton *)button;

@end

@interface FlightSearchListLayerView : UIView

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<FlightSearchListSequenceDelegate>    delegate;

/*!
 * @breif 时间顺序设置
 * @See
 */
@property (nonatomic , weak)      UIButton              *dateSequenceButton;

/*!
 * @breif 价格顺序设置
 * @See
 */
@property (nonatomic , weak)      UIButton              *priceSequenceButton;

- (id)initWithFrame:(CGRect)frame;
@end
