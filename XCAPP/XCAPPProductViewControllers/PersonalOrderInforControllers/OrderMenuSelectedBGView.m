//
//  OrderMenuSelectedBGView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "OrderMenuSelectedBGView.h"



@interface OrderMenuSelectedBGView ()
/*!
 * @breif 操作菜单信息
 * @See
 */
@property (nonatomic , strong)      NSArray                     *menuTitleArray;
@end

@implementation OrderMenuSelectedBGView

- (id)initWithFrame:(CGRect)frame withMenuArray:(NSArray *)titleArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.menuTitleArray = [[NSArray alloc]initWithArray:titleArray];
        
        [self setBackgroundImage:createImageWithColor(HUIRGBColor(0.0, 0.0f, 0.0f, 0.50f))
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(HUIRGBColor(0.0, 0.0f, 0.0f, 0.50f))
                        forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(userHiddentViewEvent)
       forControlEvents:UIControlEventTouchUpInside];
        [self setupOrderMenuSelectedBGViewFrame];
    }
    
    return self;
}

- (void)setupOrderMenuSelectedBGViewFrame{
    
    
    NSInteger titleIntger = self.menuTitleArray.count;
    
    
    CGRect bGViewRect = CGRectMake( (KProjectScreenWidth - KXCUIControlSizeWidth(140.0f))/2,
                                   KXCUIControlSizeWidth(70.0f),KXCUIControlSizeWidth(140.0f),
                                   (KFunctionModulButtonHeight*titleIntger + titleIntger));
    
    UIView *buttonBGView = [[UIView alloc]initWithFrame:bGViewRect];
    [buttonBGView setBackgroundColor:HUIRGBColor(240.0f, 240.0f, 240.0f, 0.9)];
    [buttonBGView.layer setCornerRadius:KXCUIControlSizeWidth(8.0f)];
    [buttonBGView.layer setMasksToBounds:YES];
    [self addSubview:buttonBGView];
    
    
    CGFloat buttonBeginY = 0;
    for (int index = 0; index < titleIntger; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button  setBackgroundImage:createImageWithColor([UIColor clearColor])
                           forState:UIControlStateNormal];
        [button  setBackgroundImage:createImageWithColor([UIColor whiteColor])
                           forState:UIControlStateHighlighted];
        [button setTag:(KBtnOperationButtonBaseTag + index)];
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setTitle:[self.menuTitleArray objectAtIndex:index] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0.0f, buttonBeginY,
                                    buttonBGView.width, KFunctionModulButtonHeight)];
        [button addTarget:self action:@selector(userOperationButtonEventClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        [buttonBGView addSubview:button];
        
         UIView  *separator = [[UIView alloc]init];
        [separator setBackgroundColor:HUIRGBColor(190.0f, 190.0f, 190.0f, 1.0f)];
        [separator setFrame:CGRectMake(0.0f, button.bottom, buttonBGView.width, 1.0f)];
        if ((index+1) < titleIntger ) {
            [buttonBGView addSubview:separator];
        }
        buttonBeginY = separator.bottom;
    }
}


- (void)userHiddentViewEvent{

    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(dismissViewOrderMenuSelectedAnimatedButtonEvent)]) {
            [self.delegate dismissViewOrderMenuSelectedAnimatedButtonEvent];
        }
    }
}


- (void)userOperationButtonEventClicked:(UIButton *)button{

    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userSelectedShowOrderWithTitle:withTag:)]) {
            
            NSInteger btnTag = button.tag - KBtnOperationButtonBaseTag;
            
            if (btnTag < self.menuTitleArray.count) {
                
                [self.delegate userSelectedShowOrderWithTitle:[self.menuTitleArray objectAtIndex:btnTag] withTag:button.tag];
            }
        }
    }
}
@end
