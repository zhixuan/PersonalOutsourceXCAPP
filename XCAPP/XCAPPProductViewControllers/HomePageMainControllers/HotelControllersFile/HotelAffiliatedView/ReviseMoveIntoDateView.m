//
//  ReviseMoveIntoDateView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/24.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "ReviseMoveIntoDateView.h"

@implementation ReviseMoveIntoDateView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(userHiddentViewEvent)
       forControlEvents:UIControlEventTouchUpInside];
        
        [self setupReviseMoveIntoDateViewFrame];
    }
    
    return self;
}

- (void)userHiddentViewEvent{
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:layerViewRect];
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:KBtnForClearInforButtonTag];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userReviseMoveIntoDateOperationButtonEvent:)]) {
            [self.delegate userReviseMoveIntoDateOperationButtonEvent:button];
        }
    }
}

- (void)setupReviseMoveIntoDateViewFrame{
    
    UIView *whiteColorBGView = [[UIView alloc]init];
    [whiteColorBGView setFrame:CGRectMake(0.0, (KProjectScreenHeight - (KFunctionModulButtonHeight*4.8 + 3.0f)),
                                          KProjectScreenWidth, (KFunctionModulButtonHeight*4.8 + 3.0f))];
    [whiteColorBGView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:whiteColorBGView];
    
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                        forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                        forState:UIControlStateHighlighted];
    [beginBtn setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KFunctionModulButtonHeight*1.1)];
    [beginBtn setTag:KBtnForMoveIntoButtonTag];
    [beginBtn addTarget:self action:@selector(userButtonEvent:)
       forControlEvents:UIControlEventTouchUpInside];
    [whiteColorBGView addSubview:beginBtn];
    
    UILabel *beginDate = [[UILabel alloc]init];
    [beginDate setBackgroundColor:[UIColor clearColor]];
    [beginDate setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KFunctionModulButtonHeight*1.1)];
    [beginDate setTextColor:KContentTextColor];
    [beginDate setTextAlignment:NSTextAlignmentCenter];
    [beginDate setFont:KXCAPPUIContentFontSize(18.0f)];
    self.userMoveIntoDateLabel = beginDate;
    [beginBtn addSubview:self.userMoveIntoDateLabel];
    
    UIView  *separator = [[UIView alloc]init];
    [separator setBackgroundColor:KSepLineColorSetup];
    [separator setFrame:CGRectMake(0.0f, beginBtn.bottom, KProjectScreenWidth, 1.0f)];
    [whiteColorBGView addSubview:separator];
    
    UIButton *endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDateBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                        forState:UIControlStateNormal];
    [endDateBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                        forState:UIControlStateHighlighted];
    [endDateBtn setFrame:CGRectMake(0.0f, separator.bottom, KProjectScreenWidth, KFunctionModulButtonHeight*1.1)];
    [endDateBtn setTag:KBtnForLeaveRoomButtonTag];
    [endDateBtn addTarget:self action:@selector(userButtonEvent:)
       forControlEvents:UIControlEventTouchUpInside];
    [whiteColorBGView addSubview:endDateBtn];
    
    UILabel *endDate = [[UILabel alloc]init];
    [endDate setBackgroundColor:[UIColor clearColor]];
    [endDate setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                 KFunctionModulButtonHeight*1.1)];
    [endDate setTextColor:KContentTextColor];
    [endDate setTextAlignment:NSTextAlignmentCenter];
    [endDate setFont:KXCAPPUIContentFontSize(18.0f)];
    self.userLeaveDateLabel = endDate;
    [endDateBtn addSubview:self.userLeaveDateLabel];
    
    UIView  *separatorEnd = [[UIView alloc]init];
    [separatorEnd setBackgroundColor:KSepLineColorSetup];
    [separatorEnd setFrame:CGRectMake(0.0f, endDateBtn.bottom, KProjectScreenWidth, 1.0f)];
    [whiteColorBGView addSubview:separatorEnd];
    
    UILabel *stayDateLabel = [[UILabel alloc]init];
    [stayDateLabel setBackgroundColor:[UIColor clearColor]];
    [stayDateLabel setFrame:CGRectMake(0.0f, separatorEnd.bottom, KProjectScreenWidth,
                                       KFunctionModulButtonHeight*1.1)];
    [stayDateLabel setTextColor:KContentTextColor];
    [stayDateLabel setTextAlignment:NSTextAlignmentCenter];
    [stayDateLabel setFont:KXCAPPUIContentFontSize(18.0f)];
    self.userStayRoomDayInteger = stayDateLabel;
    [whiteColorBGView addSubview:self.userStayRoomDayInteger];
    
    UIView  *separatorStayDate = [[UIView alloc]init];
    [separatorStayDate setBackgroundColor:KSepLineColorSetup];
    [separatorStayDate setFrame:CGRectMake(0.0f, stayDateLabel.bottom, KProjectScreenWidth, 1.0f)];
    [whiteColorBGView addSubview:separatorStayDate];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [doneBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [doneBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [doneBtn setTag:KBtnForDoneReviseButtonTag];
    [doneBtn setTitle:@"确   定" forState:UIControlStateNormal];
    [doneBtn.layer setCornerRadius:5.0f];
    [doneBtn addTarget:self action:@selector(userButtonEvent:)
        forControlEvents:UIControlEventTouchUpInside];
    [doneBtn.layer setMasksToBounds:YES];
    [doneBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (separatorStayDate.bottom + KFunctionModulButtonHeight*0.2),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [whiteColorBGView addSubview:doneBtn];
}


- (void)userButtonEvent:(UIButton *)button{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userReviseMoveIntoDateOperationButtonEvent:)]) {
            [self.delegate userReviseMoveIntoDateOperationButtonEvent:button];
        }
    }
}

- (void)setTextMoveInto:(NSString *)text{

    NSString *dateStr = [NSString stringWithFormat:@"%@ 入住",text];
    NSRange benginDate = [dateStr rangeOfString:text];
    NSMutableAttributedString *roomStayContent=[[NSMutableAttributedString alloc]initWithString:dateStr];
    [roomStayContent addAttribute:NSForegroundColorAttributeName value:KFunNextArrowColor range:benginDate];
    [self.userMoveIntoDateLabel setAttributedText:roomStayContent];
    
}
- (void)setTextLeaveDate:(NSString *)text{
    NSString *dateStr = [NSString stringWithFormat:@"%@ 离店",text];
    NSRange benginDate = [dateStr rangeOfString:text];
    NSMutableAttributedString *roomStayContent=[[NSMutableAttributedString alloc]initWithString:dateStr];
    [roomStayContent addAttribute:NSForegroundColorAttributeName value:KFunNextArrowColor range:benginDate];
    [self.userLeaveDateLabel setAttributedText:roomStayContent];
}
- (void)setTextStayRoomDay:(NSString *)text{
    NSString *dateStr = [NSString stringWithFormat:@"住 %@ 晚",text];
    NSRange benginDate = [dateStr rangeOfString:text];
    NSMutableAttributedString *roomStayContent=[[NSMutableAttributedString alloc]initWithString:dateStr];
    [roomStayContent addAttribute:NSForegroundColorAttributeName value:KFunNextArrowColor range:benginDate];
    [self.userStayRoomDayInteger setAttributedText:roomStayContent];

}

@end
