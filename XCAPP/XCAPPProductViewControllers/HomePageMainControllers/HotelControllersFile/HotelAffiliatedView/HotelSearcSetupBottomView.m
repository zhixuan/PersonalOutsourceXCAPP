//
//  HotelSearcSetupBottomView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/1.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelSearcSetupBottomView.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"



@interface HotelSearcSetupBottomView ()

@end

@implementation HotelSearcSetupBottomView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 0.90f)];
        [self setupHotelSearcSetupBottomViewFrame];
    }
    
    return self;
}


- (void)setupHotelSearcSetupBottomViewFrame{
    
    CGFloat btnWidth = (KProjectScreenWidth/3);

    
    NSArray *siftArray = @[@"推荐排序",
                           @"价格星级筛选",
                           @"更多筛选"];
    for (int index = 0; index < siftArray.count; index ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(btnWidth*index, 0.0f, btnWidth,KHotelSearcSetupBottomViewHeight)];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(255.0f, 255.0f, 255.0f, 0.0f))
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setTitle:[siftArray objectAtIndex:index] forState:UIControlStateNormal];
        [button setTag:(KBtnForDistanceButtonTag+index)];
        [button addTarget:self action:@selector(userSearchOperationButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
//        UILabel *siftTitle = [[UILabel alloc]init];
//        [siftTitle setBackgroundColor:[UIColor clearColor]];
//        [siftTitle setTextAlignment:NSTextAlignmentCenter];
//        [siftTitle setFont:KXCAPPUIContentFontSize(14)];
//        [siftTitle setTextColor:[UIColor whiteColor]];
//        [siftTitle setFrame:CGRectMake(0.0f, KHotelSearcSetupBottomViewHeight - 18.0f,
//                                       button.width, 18.0f)];
//        [siftTitle setText:[siftArray objectAtIndex:index]];
//        [button addSubview:siftTitle];
    }
}


- (void)userSearchOperationButtonEvent:(UIButton *)button{
    if ((button.tag >=  KBtnForDistanceButtonTag) && (button.tag <= KBtnForMoreButtonTag)) {
        
        if ([self.delegate respondsToSelector:@selector(setupWithOperationButtonClickedEvent:)]) {
            [self.delegate setupWithOperationButtonClickedEvent:button];
        }
    }
}
@end
