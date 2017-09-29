//
//  HotelReserveOrderDetailView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/26.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelReserveOrderDetailView : UIButton


- (id)initWithFrame:(CGRect)frame;

- (void)detailForHotelReserveOrderDataInfor:(UserHotelOrderInformation *) willOrderInfor;
@end
