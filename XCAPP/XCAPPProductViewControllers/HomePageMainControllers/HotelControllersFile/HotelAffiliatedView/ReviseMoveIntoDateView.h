//
//  ReviseMoveIntoDateView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/24.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KBtnForMoveIntoButtonTag                (1820111)
#define KBtnForLeaveRoomButtonTag               (1820112)
#define KBtnForDoneReviseButtonTag              (1820113)

#define KBtnForClearInforButtonTag              (1820114)


@protocol ReviseMoveIntoDateDelegate <NSObject>

- (void)userReviseMoveIntoDateOperationButtonEvent:(UIButton *)button;

@end

///修改入住信息
@interface ReviseMoveIntoDateView : UIButton


- (id)initWithFrame:(CGRect)frame;

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<ReviseMoveIntoDateDelegate>  delegate;
/*!
 * @breif 入住时间
 * @See
 */
@property (nonatomic , weak)      UILabel                   *userMoveIntoDateLabel;
/*!
 * @breif 离店时间
 * @See
 */
@property (nonatomic , weak)      UILabel                   *userLeaveDateLabel;

/*!
 * @breif 用户居住时间间隔天数
 * @See
 */
@property (nonatomic , weak)      UILabel                   *userStayRoomDayInteger;


- (void)setTextMoveInto:(NSString *)text;
- (void)setTextLeaveDate:(NSString *)text;
- (void)setTextStayRoomDay:(NSString *)text;
@end
