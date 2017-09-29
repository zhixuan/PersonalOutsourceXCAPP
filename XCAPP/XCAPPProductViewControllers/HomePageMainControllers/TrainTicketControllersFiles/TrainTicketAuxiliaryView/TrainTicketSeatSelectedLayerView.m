//
//  TrainTicketSeatSelectedLayerView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketSeatSelectedLayerView.h"
#define KBtnForSearchButtonTag          (1850118)
#define KViewForSelectedLabelTag        (1870119)

@interface TrainTicketSeatSelectedLayerView ()
/*!
 * @breif 用户默认选中的搜索类别
 * @See
 */
@property (nonatomic , assign)      NSInteger           userSelectedIndex;

/*!
 * @breif 用户使用的搜索类别内容
 * @See
 */
@property (nonatomic , strong)      NSArray             *userSelectedNameArray;

/*!
 * @breif 选中指示视图
 * @See
 */
@property (nonatomic , weak)      UIImageView           *userSelectedImageView;

@end
@implementation TrainTicketSeatSelectedLayerView

- (id)initWithFrame:(CGRect)frame withSearchContent:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(userHiddentViewEvent)
       forControlEvents:UIControlEventTouchUpInside];
        self.userSelectedIndex = KBtnForSearchButtonTag;
        
        self.userSelectedNameArray = [[NSArray alloc]initWithArray:array];
        
        
        
        [self setupTrainTicketSeatSelectedLayerViewFrame];
    }
    
    return self;
}

- (void)setupTrainTicketSeatSelectedLayerViewFrame{
    NSInteger selectedCount = self.userSelectedNameArray.count;
    CGFloat buttonTopFloat = self.height - (KFunctionModulButtonHeight*1.2 + 0.5)*selectedCount +0.5;
    
    
    NSInteger validIndexInteger = 0;
    for (NSInteger index = 0; index < selectedCount; index++) {
        
        
        if ([self.userSelectedNameArray[index] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *seatDictionary = (NSDictionary *)self.userSelectedNameArray[index];
            
            
            NSString *titleString = [NSString stringWithFormat:@"%@ ￥%@",StringForKeyInUnserializedJSONDic(seatDictionary,@"seatType"),StringForKeyInUnserializedJSONDic(seatDictionary,@"seatPrice")];
            
            NSInteger number = IntForKeyInUnserializedJSONDic(seatDictionary, @"remains");
            if (validIndexInteger == 0) {
                validIndexInteger = index;
            }
            
            UIButton *accountSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [accountSetBtn setBackgroundColor:[UIColor clearColor]];
            
            [accountSetBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                     forState:UIControlStateNormal];
            [accountSetBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                     forState:UIControlStateHighlighted];
            if (number < 1) {
                [accountSetBtn setBackgroundImage:createImageWithColor(HUIRGBColor(230.0f, 230.0f, 230.0f, 1.0f))
                                         forState:UIControlStateNormal];
                [accountSetBtn setBackgroundImage:createImageWithColor(HUIRGBColor(230.0f, 230.0f, 230.0f, 1.0f))
                                         forState:UIControlStateHighlighted];
            }
           
            [accountSetBtn setTag:(KBtnForSearchButtonTag + index)];
            [accountSetBtn setFrame:CGRectMake(0.0f, buttonTopFloat, KProjectScreenWidth,
                                               KFunctionModulButtonHeight*1.2)];
            [accountSetBtn addTarget:self action:@selector(userPersonalOperationButtonEventClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:accountSetBtn];
            [accountSetBtn setTitle:titleString forState:UIControlStateNormal];
            [accountSetBtn setTitleColor:KSubTitleTextColor forState:UIControlStateNormal];
            if (index == 0) {
                [accountSetBtn setTitleColor:HUIRGBColor(249.0f, 70.0f, 25.0f, 1.0f) forState:UIControlStateNormal];
                
            }
            [accountSetBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
            
            
            if ((index+1) < selectedCount) {
                UIView *sepView = [[UIView alloc]init];
                [sepView setFrame:CGRectMake(0.0f, (accountSetBtn.bottom), KProjectScreenWidth, 0.5f)];
                [sepView setBackgroundColor:KSepLineColorSetup];
                [self addSubview:sepView];
            }
            buttonTopFloat = (buttonTopFloat + 0.5+ KFunctionModulButtonHeight*1.2);
        }
        
    }
    
    buttonTopFloat = self.height - (KFunctionModulButtonHeight*1.2 + 0.5)*selectedCount + 0.5;
    
    
    UIImageView *selectedImageV = [[UIImageView alloc]init];
    [selectedImageV setImage:[UIImage imageNamed:@"nr_selected.png"]];
    [selectedImageV setBackgroundColor:[UIColor clearColor]];
    self.userSelectedImageView = selectedImageV;
    [self addSubview:self.userSelectedImageView];
//    
//    [self.userSelectedImageView setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(60.0f)),
//                                                    (buttonTopFloat +(KFunctionModulButtonHeight*1.2 - KXCUIControlSizeWidth(22.0f))/2),
//                                                    KXCUIControlSizeWidth(22.0f),
//                                                    KXCUIControlSizeWidth(22.0f))];
}

- (void)userPersonalOperationButtonEventClicked:(UIButton *)button{
    
    
    
    ///若是相同的，则不处理
    if (self.userSelectedIndex == button.tag) {
        return;
    }
    
    ///更改界面
    UIButton *beforeBtn = (UIButton *)[self viewWithTag:self.userSelectedIndex];
    [beforeBtn setTitleColor:KSubTitleTextColor forState:UIControlStateNormal];
    [button setTitleColor:HUIRGBColor(249.0f, 70.0f, 25.0f, 1.0f) forState:UIControlStateNormal];
    
    [self.userSelectedImageView setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(60.0f)),
                                                    (button.top + (KFunctionModulButtonHeight*1.2 - KXCUIControlSizeWidth(22.0f))/2),
                                                    KXCUIControlSizeWidth(22.0f),
                                                    KXCUIControlSizeWidth(22.0f))];
    
    self.userSelectedIndex = button.tag;
    NSInteger index = self.userSelectedIndex - KBtnForSearchButtonTag;
    
    if (index < self.userSelectedNameArray.count) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(userSelectedSearchStyle:)]) {
                [self.delegate userSelectedSearchStyle:index];
                ///隐藏视图
                [self userHiddentViewEvent];
            }
        }
    }
}

- (void)userHiddentViewEvent{
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:layerViewRect];
    }];
}

@end
