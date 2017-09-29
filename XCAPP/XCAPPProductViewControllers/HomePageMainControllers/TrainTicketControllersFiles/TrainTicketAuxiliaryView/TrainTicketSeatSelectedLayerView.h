//
//  TrainTicketSeatSelectedLayerView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol TrainTicketSeatSelectedDelegate <NSObject>

- (void)userSelectedSearchStyle:(NSInteger)Searchstyle;

@end
@interface TrainTicketSeatSelectedLayerView : UIButton


/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<TrainTicketSeatSelectedDelegate>     delegate;


/*!
 * @breif 初始化界面
 * @See
 */
- (id)initWithFrame:(CGRect)frame withSearchContent:(NSArray *)array;
@end
