//
//  DefaultotelRecommendSearchLayerView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "DefaultotelRecommendSearchLayerView.h"

#define KBtnForSearchButtonTag          (1850111)
#define KViewForSelectedLabelTag        (1870111)

//UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nr_selected"]];
//[imageView setFrame:CGRectMake(100.0f, searchBtn.bottom + KXCUIControlSizeWidth(30.0f), KXCUIControlSizeWidth(30.0f), KXCUIControlSizeWidth(30.0f))];
//[mainView addSubview:imageView];

@interface DefaultotelRecommendSearchLayerView ()

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

@implementation DefaultotelRecommendSearchLayerView

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
        
        
        
        [self setupDefaultotelRecommendSearchLayerViewFrame];
        
    }
    
    return self;
}

- (void)setupDefaultotelRecommendSearchLayerViewFrame{

    NSInteger selectedCount = self.userSelectedNameArray.count;
    CGFloat buttonTopFloat = self.height - (KFunctionModulButtonHeight*1.2 + 0.5)*selectedCount +0.5;
    
    for (NSInteger index = 0; index < selectedCount; index++) {

        UIButton *accountSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [accountSetBtn setBackgroundColor:[UIColor clearColor]];
        [accountSetBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                 forState:UIControlStateNormal];
        [accountSetBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                 forState:UIControlStateHighlighted];
        [accountSetBtn setTag:(KBtnForSearchButtonTag + index)];
        [accountSetBtn setFrame:CGRectMake(0.0f, buttonTopFloat, KProjectScreenWidth,
                                           KFunctionModulButtonHeight*1.2)];
        [accountSetBtn addTarget:self action:@selector(userPersonalOperationButtonEventClicked:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:accountSetBtn];
        [accountSetBtn setTitle:[self.userSelectedNameArray objectAtIndex:index] forState:UIControlStateNormal];
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

    buttonTopFloat = self.height - (KFunctionModulButtonHeight*1.2 + 0.5)*selectedCount + 0.5;
    UIImageView *selectedImageV = [[UIImageView alloc]init];
    [selectedImageV setImage:[UIImage imageNamed:@"nr_selected.png"]];
    [selectedImageV setBackgroundColor:[UIColor clearColor]];
    self.userSelectedImageView = selectedImageV;
    [self addSubview:self.userSelectedImageView];
    
    [self.userSelectedImageView setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(60.0f)),
                                                    (buttonTopFloat +(KFunctionModulButtonHeight*1.2 - KXCUIControlSizeWidth(22.0f))/2),
                                                    KXCUIControlSizeWidth(22.0f),
                                                    KXCUIControlSizeWidth(22.0f))];
    
    
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
        NSString *titleNameStr = (NSString *)[self.userSelectedNameArray objectAtIndex:index];
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(userSelectedDefaultotelRecommendSearchStyle:styleName:)]) {
                [self.delegate userSelectedDefaultotelRecommendSearchStyle:index styleName:titleNameStr];
                ///隐藏视图
                [self userHiddentViewEvent];
            }
        }
    }
}

- (void)userHiddentViewEvent{
//    [self setHidden:YES];
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:layerViewRect];
    }];
}
@end
