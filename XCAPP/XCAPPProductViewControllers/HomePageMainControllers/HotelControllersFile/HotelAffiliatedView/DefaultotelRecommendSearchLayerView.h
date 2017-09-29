//
//  DefaultotelRecommendSearchLayerView.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DefaultotelRecommendDelegate <NSObject>

/**
 *  @method
 *
 *  @brief          默认用户推荐搜索操作控制协议方法
 *
 *  @param          Searchstyle         搜索种类编号
 *
 *  @param          styleNameStr        搜索名字
 *
 */
- (void)userSelectedDefaultotelRecommendSearchStyle:(NSInteger)Searchstyle styleName:(NSString *)styleNameStr;

@end

///默认的推荐查询类别设置
@interface DefaultotelRecommendSearchLayerView : UIButton
/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<DefaultotelRecommendDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withSearchContent:(NSArray *)array;
@end
