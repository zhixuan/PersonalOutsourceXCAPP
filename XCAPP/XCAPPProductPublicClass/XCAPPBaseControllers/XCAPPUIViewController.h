//
//  XCAPPUIViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCAPPUIViewController : UIViewController

//TODO: PROPERTY

///默认YES，显示自定义的导航栏返回按钮
@property (nonatomic, assign) BOOL enableCustomNavbarBackButton;
///字体的大小，即ICON图片的大小
@property (nonatomic, assign) CGFloat navButtonSize;
///Nothing
@property (nonatomic, copy) void(^navBackButtonRespondBlock)(void);

//TODO: METHOD
///设置导航栏标题
- (void) settingNavTitle:(NSString *)title;
- (void) settingNavTitleWithTitle:(NSString *)title colour:(UIColor *)titleColor;
///设置导航栏左侧按钮（普通按键）
- (void) setLeftNavButton:(UIImage* )btImage
                withFrame:(CGRect) frame
             actionTarget:(id)target action:(SEL) action;


///使用字体设置左侧按钮图片
- (void) setLeftNavButtonFA:(NSInteger)buttonType
                  withFrame:(CGRect) frame
               actionTarget:(id)target
                     action:(SEL) action;


///设置导航栏右侧按钮（普通按键）
- (void) setRightNavButton:(UIImage* )btImage
                 withFrame:(CGRect) frame
              actionTarget:(id)target
                    action:(SEL) action;


///使用字体设置右侧按钮图片
- (void)setRightNavButtonFA:(NSInteger)buttonType
                  withFrame:(CGRect) frame
               actionTarget:(id)target
                     action:(SEL) action;

///使用字符设置右侧按键
- (void)setRightNavButtonTitleStr:(NSString *)titleStr
                        withFrame:(CGRect) frame
                     actionTarget:(id)target
                           action:(SEL) action;


- (void)setLeftNavButtonTitleStr:(NSString *)titleStr
                       withFrame:(CGRect)frame
                    actionTarget:(id)target
                          action:(SEL)action;

- (void)setRightNavButtonFA:(NSArray <NSNumber *> *)buttonTypeArray
                  buttonTag:(NSArray <NSNumber *> *)tagArray
        buttonSelectedColor:(NSArray <UIColor *> *)colorArray
          buttonDefautColor:(NSArray <UIColor *> *)colorDefaultArray
               actionTarget:(id)target
                     action:(SEL)action;

@end
