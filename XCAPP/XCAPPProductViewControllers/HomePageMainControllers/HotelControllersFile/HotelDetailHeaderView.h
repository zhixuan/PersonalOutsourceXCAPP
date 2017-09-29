//
//  HotelDetailHeaderView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KHotelDetailHeaderViewHeight            (KXCUIControlSizeWidth(160.0f) + KFunctionModulButtonHeight*3.2+KInforLeftIntervalWidth*4)

@protocol HotelDetailHeaderDelegate <NSObject>

- (void)userCheckHotelDetailButtonClickedEvent;
- (void)userCheckHotelAtMapButtonClickedEvent;
- (void)userUpdateStayDayesInforButtonClickedEvent;

@end
@interface HotelDetailHeaderView : UIView
- (id)initWithFrame:(CGRect)frame withOderInfor:(UserHotelOrderInformation *)hotelInfor;
/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<HotelDetailHeaderDelegate>       delegate;

/*!
 * @breif 酒店宣传图片信息
 * @See
 */
@property (nonatomic , weak)      UIImageView                           *hotelImageView;


/*!
 * @breif 酒店宣传图片上的地址
 * @See
 */
@property (nonatomic , weak)      UILabel                               *hotelAddressAtImageLabel;

/*!
 * @breif 酒店详情信息
 * @See
 */
@property (nonatomic , weak)        UIView                              *hotelDetailBGView;

/*!
 * @breif 地址信息
 * @See
 */
@property (nonatomic , weak)        UILabel                             *hotelAddressLabel;

/*!
 * @breif 酒店入住信息
 * @See
 */
@property (nonatomic , weak)        UILabel                             *hotelStayDayInforLabel;



@end
