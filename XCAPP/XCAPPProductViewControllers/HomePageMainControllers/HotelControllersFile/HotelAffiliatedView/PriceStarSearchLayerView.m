//
//  PriceStarSearchLayerView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "PriceStarSearchLayerView.h"


#define KBtnForPriceButtonTag       (1820111)

#define KBtnForStarButtonTag        (1840111)


@interface PriceStarSearchLayerView ()

/*!
 * @breif 价格数据信息
 * @See
 */
@property (nonatomic , strong)      NSArray             *userPriceArrayInfor;

/*!
 * @breif 星级数据信息
 * @See
 */
@property (nonatomic , strong)      NSArray             *userHotelStarArrayInfor;

/*!
 * @breif 用户选择最低价格tag
 * @See
 */
@property (nonatomic , assign)      NSInteger           userPriceForMinButtonTag;

/*!
 * @breif 用户选择最高价格tag
 * @See
 */
@property (nonatomic , assign)      NSInteger           userPriceForMaxButtonTag;

/*!
 * @breif 用户选择星级操作
 * @See
 */
@property (nonatomic , assign)      NSInteger           userHotelForStarButtonTag;


/*!
 * @breif 用户选择最低价格tag
 * @See
 */
@property (nonatomic , strong)     NSString             *userPriceForMinContentStr;

/*!
 * @breif 用户选择最高价格tag
 * @See
 */
@property (nonatomic , strong)     NSString             *userPriceForMaxContentStr;

/*!
 * @breif 用户选择星级操作
 * @See
 */
@property (nonatomic , strong)     NSString             *userHotelForStarContentStr;
@end

@implementation PriceStarSearchLayerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(userHiddentViewEvent)
       forControlEvents:UIControlEventTouchUpInside];
        
        [self setupPriceStarSearchLayerViewFrame];
        
    }
    
    return self;
}



- (void)setupPriceStarSearchLayerViewFrame{
    
    
    UIView *backWhiteColorBGView = [[UIView alloc]init];
    [backWhiteColorBGView setBackgroundColor:[UIColor whiteColor]];
    
    
    [self addSubview:backWhiteColorBGView];
    
    CGFloat whiteColorBGHeight = 0.0f;
    
    ///价格标注
    UILabel *priceTitleLabel = [[UILabel alloc]init];
    [priceTitleLabel setBackgroundColor:[UIColor clearColor]];
    [priceTitleLabel setTextColor:KContentTextColor];
    [priceTitleLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
    [priceTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [priceTitleLabel setText:@"价格（￥）"];
    [priceTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    [backWhiteColorBGView addSubview:priceTitleLabel];
    
    whiteColorBGHeight += (KInforLeftIntervalWidth + KXCUIControlSizeWidth(20.0f));
    
    self.userPriceArrayInfor = @[@"0",
                            @"150",
                            @"300",
                            @"450",
                            @"600",
                            @"1000",
                            @"以上",];
    
    NSInteger priceCount = self.userPriceArrayInfor .count ;
    
    
    CGFloat buttonSizeFloat = KXCUIControlSizeWidth(25.0f);
    CGFloat priceTitleWidth = KProjectScreenWidth/priceCount;
    
    
    UIView *lineBGView = [[UIView alloc]init];
    [lineBGView setBackgroundColor:HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f)];
    [lineBGView setFrame:CGRectMake(priceTitleWidth/2,
                                    (priceTitleLabel.bottom+KXCUIControlSizeWidth(30.0f) + (buttonSizeFloat - KXCUIControlSizeWidth(6.0f))/2),
                                    (KProjectScreenWidth - priceTitleWidth),
                                    (KXCUIControlSizeWidth(6.0f)))];
    [backWhiteColorBGView addSubview:lineBGView];
    
    for (int index = 0; index < priceCount; index++) {
        UILabel *priceTitle = [[UILabel alloc]init];
        [priceTitle setBackgroundColor:[UIColor clearColor]];
        [priceTitle setTextColor:KSubTitleTextColor];
        [priceTitle setFont:KXCAPPUIContentDefautFontSize(16.0f)];
        [priceTitle setTextAlignment:NSTextAlignmentCenter];
        [priceTitle setText:[NSString stringWithFormat:@"%@",[self.userPriceArrayInfor  objectAtIndex:index]]];
        [priceTitle setFrame:CGRectMake(priceTitleWidth*index, priceTitleLabel.bottom+KXCUIControlSizeWidth(5.0f),priceTitleWidth, KXCUIControlSizeWidth(20.0f))];
        [backWhiteColorBGView addSubview:priceTitle];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(243.0f, 243.0f, 243.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setTag:(KBtnForPriceButtonTag + index)];
        if (index <= 3) {
            [button addTarget:self action:@selector(buttonForPriceForMinOperationButton:)
             forControlEvents:UIControlEventTouchUpInside];
        }else{
            [button addTarget:self action:@selector(buttonForPriceForMAXOperationButton:)
                 forControlEvents:UIControlEventTouchUpInside];
        }

        [button setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                             forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake((priceTitle.left + (priceTitleWidth - buttonSizeFloat)/2),
                                    priceTitle.bottom+KXCUIControlSizeWidth(5.0f),buttonSizeFloat, buttonSizeFloat)];
        [button.layer setCornerRadius:buttonSizeFloat/2 ];
        [button.layer setMasksToBounds:YES];
        [backWhiteColorBGView addSubview:button];
        
        if (index == 0 || (index +1) == priceCount) {
            [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
        }
        
    }
    
    
    UIView *sepPriceView = [[UIView alloc]init];
    [sepPriceView setBackgroundColor:KSepLineColorSetup];
    [sepPriceView setFrame:CGRectMake(0.0f, (priceTitleLabel.bottom+KXCUIControlSizeWidth(65.0f)+KInforLeftIntervalWidth), KProjectScreenWidth, 1.0f)];
    [backWhiteColorBGView addSubview:sepPriceView];
    
    whiteColorBGHeight = (sepPriceView.bottom);
    
    
    ///价格标注
    UILabel *starLabel = [[UILabel alloc]init];
    [starLabel setBackgroundColor:[UIColor clearColor]];
    [starLabel setTextColor:KContentTextColor];
    [starLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
    [starLabel setTextAlignment:NSTextAlignmentLeft];
    [starLabel setText:@"星级"];
    [starLabel setFrame:CGRectMake(KInforLeftIntervalWidth, (sepPriceView.bottom + KInforLeftIntervalWidth + KXCUIControlSizeWidth(5.0f)), KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    [backWhiteColorBGView addSubview:starLabel];
    
    whiteColorBGHeight = (starLabel.bottom);
    self.userHotelStarArrayInfor = @[@"不限",
                            @"五星",
                            @"四星",
                            @"三星",
                            @"二星",
                            @"经济型",
                            @"无星",];
    
    NSInteger starCount = self.userHotelStarArrayInfor.count;
    
    
    CGFloat bgeinX = KInforLeftIntervalWidth;
    CGFloat beginY = starLabel.bottom + KInforLeftIntervalWidth;
    CGFloat starWidth = (KProjectScreenWidth -KInforLeftIntervalWidth*2)/3;
    CGFloat starButtonHeight = KXCUIControlSizeWidth(40.0f);
    
    //三列
    int totalloc=3;
    for (int index=0; index<starCount; index++) {
        
        int row=index/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=index%totalloc;//列号
        
        CGFloat appviewx=bgeinX+(starWidth)*loc;
        CGFloat appviewy=(beginY)+(starButtonHeight + KXCUIControlSizeWidth(6.0f))*row;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(15.0f)];
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setTitle:[self.userHotelStarArrayInfor objectAtIndex:index] forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setTag:(KBtnForStarButtonTag + index)];
        [button addTarget:self action:@selector(buttonForHotelStarOperationButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(appviewx,appviewy, starWidth,starButtonHeight)];
        [button.layer setBorderColor:KTableViewCellSelectedColor.CGColor];
        [button.layer setBorderWidth:1.0f];
        [button.layer setMasksToBounds:YES];
        [backWhiteColorBGView addSubview:button];
        
        if (index == 0 ) {
            [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }
    }
    
    
    whiteColorBGHeight += (KInforLeftIntervalWidth + KXCUIControlSizeWidth(40.0f)*3+4.0f + KXCUIControlSizeWidth(18.0f));

    
    
    UIView *sepStarView = [[UIView alloc]init];
    [sepStarView setBackgroundColor:KSepLineColorSetup];
    [sepStarView setFrame:CGRectMake(0.0f, (whiteColorBGHeight + KXCUIControlSizeWidth(8.0f)), KProjectScreenWidth, 1.0f)];
    [backWhiteColorBGView addSubview:sepStarView];
    
    whiteColorBGHeight = sepStarView.bottom;
    
    whiteColorBGHeight += (KInforLeftIntervalWidth*1.5);
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [doneBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [doneBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [doneBtn setTag:(234)];
    [doneBtn setTitle:@"确认" forState:UIControlStateNormal];
    [doneBtn.layer setCornerRadius:5.0f];
    [doneBtn addTarget:self action:@selector(buttonDoneClickedOperation)
        forControlEvents:UIControlEventTouchUpInside];
    [doneBtn.layer setMasksToBounds:YES];
    [doneBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (whiteColorBGHeight),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [backWhiteColorBGView addSubview:doneBtn];
    
    [backWhiteColorBGView setFrame:CGRectMake(0.0f, (KProjectScreenHeight - (doneBtn.bottom + KInforLeftIntervalWidth*1.5)), KProjectScreenWidth, (doneBtn.bottom + KInforLeftIntervalWidth*1.5))];

    
    self.userPriceForMinButtonTag = (KBtnForPriceButtonTag + 0);
    self.userPriceForMaxButtonTag = (KBtnForPriceButtonTag + 6);
    self.userHotelForStarButtonTag = KBtnForStarButtonTag;
    self.userPriceForMinContentStr = @"0";
    self.userPriceForMaxContentStr = @"";
    self.userHotelForStarContentStr = @"";
}
- (void)userHiddentViewEvent{
//    [self setHidden:YES];
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:layerViewRect];
    }];
}


- (void)buttonForPriceForMinOperationButton:(UIButton *)button{

    if (button.tag == self.userPriceForMinButtonTag) {
        return;
    }
    
    ///更改原先的button
    UIButton *beforButton = (UIButton *)[self viewWithTag:self.userPriceForMinButtonTag];
    [beforButton setBackgroundImage:createImageWithColor(HUIRGBColor(243.0f, 243.0f, 243.0f, 1.0f))
                           forState:UIControlStateNormal];
    ///更改当前的button
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    
    NSString *starTitleContent = (NSString *)[self.userPriceArrayInfor objectAtIndex:(button.tag - KBtnForPriceButtonTag)];
    self.userPriceForMinContentStr = starTitleContent;
    self.userPriceForMinButtonTag = button.tag;
    
}

- (void)buttonForPriceForMAXOperationButton:(UIButton *)button{
    
    if (button.tag == self.userPriceForMaxButtonTag) {
        return;
    }
    ///更改原先的button
    UIButton *beforButton = (UIButton *)[self viewWithTag:self.userPriceForMaxButtonTag];
    [beforButton setBackgroundImage:createImageWithColor(HUIRGBColor(243.0f, 243.0f, 243.0f, 1.0f))
                           forState:UIControlStateNormal];
    ///更改当前的button
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    
    NSString *starTitleContent = (NSString *)[self.userPriceArrayInfor objectAtIndex:(button.tag - KBtnForPriceButtonTag)];
    
    self.userPriceForMaxContentStr = starTitleContent;
    if ([starTitleContent isEqualToString:@"以上"]) {
        self.userPriceForMaxContentStr = @"";
    }
    self.userPriceForMaxButtonTag = button.tag;
  
}

- (void)buttonForHotelStarOperationButtonEvent:(UIButton *)button{
    if (button.tag == self.userHotelForStarButtonTag) {
        return;
    }
    ///更改原先的button
    UIButton *beforButton = (UIButton *)[self viewWithTag:self.userHotelForStarButtonTag];
    [beforButton setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                           forState:UIControlStateNormal];
    [beforButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    
    ///更改当前的button
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    NSString *starTitleContent = (NSString *)[self.userHotelStarArrayInfor objectAtIndex:(button.tag - KBtnForStarButtonTag)];
    if ([starTitleContent isEqualToString:@"不限"]) {
        self.userHotelForStarContentStr = @"";
    }
    else if ([starTitleContent isEqualToString:@"五星"]){
        self.userHotelForStarContentStr = @"5";
    }
    
    else if ([starTitleContent isEqualToString:@"四星"]){
        self.userHotelForStarContentStr = @"4";
    }
    
    else if ([starTitleContent isEqualToString:@"三星"]){
        self.userHotelForStarContentStr = @"3";
    }
    
    else if ([starTitleContent isEqualToString:@"二星"]){
        self.userHotelForStarContentStr = @"2";
    }
    
    else if ([starTitleContent isEqualToString:@"经济型"]){
        self.userHotelForStarContentStr = @"1";
    }
    
    else if ([starTitleContent isEqualToString:@"无星"]){
        self.userHotelForStarContentStr = @"0";
    }
    
    self.userHotelForStarButtonTag = button.tag;
}

- (void)buttonDoneClickedOperation{
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userPriceStarSearchWithMinPice:maxPrice:starStyle:)]) {
            [self.delegate userPriceStarSearchWithMinPice:self.userPriceForMinContentStr maxPrice:self.userPriceForMaxContentStr starStyle:self.userHotelForStarContentStr];
            [self userHiddentViewEvent];
        }
    }
}

@end
