//
//  PriceStarSearchLayerView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PriceStarSearchDelegate <NSObject>

/**
 *  @method
 *
 *  @brief          价格星级搜索操作控制协议方法
 *
 *  @param          priceFloat          价格数值，一般为整数显示
 *
 *  @param          starStyle           搜索星级设置
 *
 */
- (void)userPriceStarSearchWithMinPice:(NSString *)minPrice maxPrice:(NSString *)maxPrice starStyle:(NSString *)starStyle;

@end
///价格星级筛选
@interface PriceStarSearchLayerView : UIButton

/*!
 * @breif 设置操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<PriceStarSearchDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;
@end
