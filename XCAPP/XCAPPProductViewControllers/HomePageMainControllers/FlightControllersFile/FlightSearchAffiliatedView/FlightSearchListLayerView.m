//
//  FlightSearchListLayerView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/16.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightSearchListLayerView.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

@implementation FlightSearchListLayerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 0.90f)];
        [self setupFlightSearchListLayerViewFrame];
    }
    
    return self;
}


- (void)setupFlightSearchListLayerViewFrame{
    
    CGFloat btnWidth = (KProjectScreenWidth/3);
    
    
    NSArray *siftArray = @[@"时间排序",
                           @"价格排序",
                           @"筛选"];
    
    for (int index = 0; index < siftArray.count; index ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(btnWidth*index, 0.0f, btnWidth,KHotelSearcSetupBottomViewHeight)];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(255.0f, 255.0f, 255.0f, 0.0f))
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setTag:(KBtnForDateSequenceButtonTag+index)];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(14.0)];

        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitle:[siftArray objectAtIndex:index] forState:UIControlStateNormal];
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

    
    UIButton *dateButon = (UIButton *)[self viewWithTag:KBtnForDateSequenceButtonTag];
    if (dateButon) {
        self.dateSequenceButton = dateButon;
    }
    
    UIButton *priceButton = (UIButton *)[self viewWithTag:KBtnForPricSequenceeButtonTag];
    if (priceButton) {
        self.priceSequenceButton = priceButton;
    }
}


- (void)userSearchOperationButtonEvent:(UIButton *)button{
    
    if ((button.tag >=  KBtnForDateSequenceButtonTag) && (button.tag <= KBtnForMoreSequenceButtonTag)) {
        
        if ([self.delegate respondsToSelector:@selector(userSelectedDefaultotelSearchWithSequenceButton:)]) {
            [self.delegate userSelectedDefaultotelSearchWithSequenceButton:button];
        }
    }
}
@end
