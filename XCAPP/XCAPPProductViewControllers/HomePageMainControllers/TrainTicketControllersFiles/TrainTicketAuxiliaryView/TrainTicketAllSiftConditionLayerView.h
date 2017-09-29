//
//  TrainTicketAllSiftConditionLayerView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/26.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol TrainTicketAllSiftConditionDelegate <NSObject>

- (void)userSelectedConditionWithSeat:(NSString *)seatStr
                          trainNumber:(NSString *)numberStr
                         beginStatuse:(NSString *)beginStr
                           endStatuse:(NSString *)endStr;

@end
/**
 *  @method
 *
 *  @brief          火车票筛选条件设置(坐席、车次、出发车站、到达车站)
 *
 *  @see           火车票列表筛选条件右侧
 *
 */
///火车票筛选条件设置(坐席、车次、出发车站、到达车站)
@interface TrainTicketAllSiftConditionLayerView : UIView


/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<TrainTicketAllSiftConditionDelegate>         delegate;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame withSeatArray:(NSArray *)seatArray trainNumber:(NSArray *)trainNumberArray beginArray:(NSArray *)beginArray endArray:(NSArray *)endArray;

- (void)setupFrameWithSeatArray:(NSArray *)seatArray trainNumber:(NSArray *)trainNumberArray beginArray:(NSArray *)beginArray endArray:(NSArray *)endArray;
@end
