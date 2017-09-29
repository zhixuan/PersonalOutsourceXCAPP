//
//  HotelRoomDetailView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserReserveHotelRoomDelegate <NSObject>

- (void)userReserveHotelOperationClickedEvent;

@end
////酒店对应的房间信息内容
@interface HotelRoomDetailView : UIButton

/*!
 * @breif 预订按键
 * @See
 */
@property (nonatomic , assign)      id<UserReserveHotelRoomDelegate>        delegate;

- (id)initWithFrame:(CGRect)frame;


- (void)setRoomTitle:(NSString *)title;
- (void)setRoomDetailContent:(NSString *)content attribute:(NSArray *)array;
@end
