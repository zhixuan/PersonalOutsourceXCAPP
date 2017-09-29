//
//  TrainTicketOrderDetailInforView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/25.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainTicketOrderDetailInforView : UIButton
- (id)initWithFrame:(CGRect)frame;
- (void)detailForTrainTicketOrderInfor:(TrainticketOrderInformation *)orderItem;;
@end
