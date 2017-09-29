//
//  XCAPPThemeColor.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef XCAPPThemeColor_h
#define XCAPPThemeColor_h




///自行处理颜色信息
#define HUIRGBColor(r, g, b, a)             [UIColor colorWithRed:(r)/255.00 green:(g)/255.00 blue:(b)/255.00 alpha:(a)]


#define kColorTextColorClay                 [UIColor colorWithRed:127.0/255.0 green:125.0/255.0 blue:127.0/255.0 alpha:1.0]


///导航头部背景色
#define  KDefaultNavigationWhiteBackGroundColor  HUIRGBColor(5.0f, 54.0f, 126.0f, 1.0f)


/////按键默认颜色内容
#define KDefineNavigationItemBtnColor       [UIColor colorWithRed:157.0f/255.0 green:85.0/255.0 blue:184.0/255.0 alpha:1.0]
#define KDefineUIButtonTitleNormalColor     [UIColor whiteColor]
#define KDefineUIButtonBorderColor          KDefineNavigationItemBtnColor


///TableViewCell 选中的颜色
#define KTableViewCellSelectedColor          HUIRGBColor(225.0f, 225.0f, 225.0f, 1.0f)



#define KDefaultViewBackGroundColor    [UIColor colorWithRed:236.0f/255.0 green:237.0/255.0 blue:239.0/255.0 alpha:1.0]


//内容文本颜色
#define KContentTextColor                   [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]

////UIImageView的默认背景颜色内容
#define KUIImageViewDefaultColor        [UIColor colorWithRed:158/255.0f green:158/255.0f blue:158/255.0f alpha:0.15f]
#define KUIImageViewDefaultImage        createImageWithColor(KUIImageViewDefaultColor)

///边框颜色设置
#define KBorderColorSetup               [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]
///分割线颜色设置
#define KSepLineColorSetup              [UIColor colorWithRed:237.0f/255.0f green:239.0f/255.0f blue:240.0f/255.0f alpha:1.0f]

///副标题颜色
#define KSubTitleTextColor              [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1]


#define KFunNextArrowColor              [UIColor colorWithRed:093.0f/255.0f green:149.0f/255.0f blue:214.0f/255.0f alpha:1.0f]


#define KFunContentColor                [UIColor colorWithRed:150.0f/255.0f green:160.0f/255.0f blue:169.0f/255.0f alpha:1.0f]


////设置蒙层背景色
#define KLayerViewBackGroundColor       HUIRGBColor(0.0, 0.0f, 0.0f, 0.70f)


#define KStateNormalContentColor        HUIRGBColor(41.0f, 70.0f, 101.0f, 1.0f)


#define KUnitPriceContentColor          [UIColor colorWithRed:236.0f/255.0f green:082.0f/255.0f blue:015.0f/255.0f alpha:1.0f]


#endif /* XCAPPThemeColor_h */
