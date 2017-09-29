//
//  OrderMenuSelectedBGView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KBtnOperationButtonBaseTag              (1860111)
@protocol OrderMenuSelectedDelegate <NSObject>

- (void)dismissViewOrderMenuSelectedAnimatedButtonEvent;
- (void)userSelectedShowOrderWithTitle:(NSString *)title withTag:(NSInteger)tag;

@end
@interface OrderMenuSelectedBGView : UIButton

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<OrderMenuSelectedDelegate>           delegate;

- (id)initWithFrame:(CGRect)frame withMenuArray:(NSArray *)titleArray;
@end
