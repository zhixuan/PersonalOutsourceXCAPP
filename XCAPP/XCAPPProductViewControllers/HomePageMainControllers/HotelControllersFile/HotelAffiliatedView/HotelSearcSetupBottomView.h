//
//  HotelSearcSetupBottomView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/1.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearcBottomButton : UIButton
//@property   ()
@end

#define KHotelSearcSetupBottomViewHeight                        (KXCUIControlSizeWidth(50.0f))

#define KBtnForDistanceButtonTag                    (1740111)
#define KBtnForPriceButtonTag                       (1740112)
#define KBtnForMoreButtonTag                        (1740113)

@protocol HotelSearcSetupDelegate <NSObject>

- (void)setupWithOperationButtonClickedEvent:(UIButton *)button;

@end

/**
 *  @method
 *
 *  @brief          酒店列表底部搜索界面
 *
 */
@interface HotelSearcSetupBottomView : UIView

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<HotelSearcSetupDelegate>     delegate;

- (id)initWithFrame:(CGRect)frame;
@end
