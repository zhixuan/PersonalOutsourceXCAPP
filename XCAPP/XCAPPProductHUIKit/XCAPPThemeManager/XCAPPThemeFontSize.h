//
//  XCAPPThemeFontSize.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef XCAPPThemeFontSize_h
#define XCAPPThemeFontSize_h


#define KNavSize                                (KXCUIControlSizeWidth(18.0f))
#define KTabBarItemBtnSize                      22.0f


#define kFontSTHeitiSCLightName                 @"STHeitiSC-Light"              //细字体
#define kFontHelveticaNeueLightName             @"HelveticaNeue-Light"
#define kFontHelveticaNeueName                  @"HelveticaNeue"
//MARK:加粗字体，用于我的收藏、我的参与里沙龙发起人的名字
#define kFontHelveticaNeueBold                  @"HelveticaNeue-Bold"

#define KXCAPPContentFontSize                   [UIFont systemFontOfSize:(14*KXCAdapterSizeWidth)]
#define KXCAPPUIContentFontSize(f)              [UIFont fontWithName:kFontHelveticaNeueLightName size:((f)*KXCAdapterSizeWidth)]
#define KXCAPPUIContentDefautFontSize(f)        [UIFont systemFontOfSize:((f)*KXCAdapterSizeWidth)]
//#define KXCAPPUIContentFontSize(f)              [UIFont fontWithName:@"HelveticaNeueInterface-Regular" size:((f)*KXCAdapterSizeWidth)]


//[uifon]
#endif /* XCAPPThemeFontSize_h */
