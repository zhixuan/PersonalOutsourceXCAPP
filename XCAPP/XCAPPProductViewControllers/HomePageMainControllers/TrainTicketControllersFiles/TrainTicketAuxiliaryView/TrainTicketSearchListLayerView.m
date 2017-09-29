//
//  TrainTicketSearchListLayerView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/12.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketSearchListLayerView.h"

@implementation TrainTicketSearchListLayerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 0.90f)];
        [self setupTrainTicketSearchListLayerViewFrame];
        
    }
    
    return self;
}

- (void)setupTrainTicketSearchListLayerViewFrame{
    
    
    CGFloat btnWidth = (KProjectScreenWidth/4);
    
    
    NSArray *siftArray = @[@"出发",
                           @"到达",
                           @"耗时",
                           @"筛选"];
    
    for (int index = 0; index < siftArray.count; index ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(btnWidth*index, 0.0f, btnWidth,KTrainTicketSearchSetupBottomViewHeight)];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(255.0f, 255.0f, 255.0f, 0.0f))
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setTag:(KBtnForDepartButton+index)];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(14.0)];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitle:[siftArray objectAtIndex:index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(userSearchOperationButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    
    UIButton *dateButon = (UIButton *)[self viewWithTag:KBtnForDepartButton];
    if (dateButon) {
        self.btnForDepartButton = dateButon;
    }
    
    UIButton *priceButton = (UIButton *)[self viewWithTag:KBtnForAchieveButton];
    if (priceButton) {
        self.btnForAchieveButton = priceButton;
    }
    
    UIButton *timeIntervalButton = (UIButton *)[self viewWithTag:KBtnForTimeIntervalButton];
    if (timeIntervalButton) {
        self.btnForTimeIntervalButton = timeIntervalButton;
    }
}

- (void)userSearchOperationButtonEvent:(UIButton *)button{
    
    if ((button.tag >=  KBtnForDepartButton) && (button.tag <= KBtnForSiftRequirementButton)) {
        
        if ([self.delegate respondsToSelector:@selector(userSelectedTrainTicketSearchDefaultotelSearchWithSequenceButton:)]) {
            [self.delegate userSelectedTrainTicketSearchDefaultotelSearchWithSequenceButton:button];
        }
    }
}

@end
