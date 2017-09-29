//
//  XCAPPThemeScreenSize.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef XCAPPThemeScreenSize_h
#define XCAPPThemeScreenSize_h



///屏幕内容
#define KProjectScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define KProjectScreenHeight                [UIScreen mainScreen].bounds.size.height

///列表界面加载更多 CellHeight
#define kSizeLoadMoreCellHeight             (30.0f)

//适配宽高
#define KXCAdapterSizeWidth                 (KProjectScreenWidth/375.0)
#define KXCAdapterSizeHeight                (KProjectScreenHeight/667.0)

//适配宽高计算
#define KXCUIControlSizeHeight(f)         (f*KXCAdapterSizeHeight)
#define KXCUIControlSizeWidth(f)          (f*KXCAdapterSizeWidth)

///默认间隔信息
#define KInforLeftIntervalWidth             (KXCUIControlSizeWidth(12.0f))


#define kNavBarButtonRect                       CGRectMake(0, 0.0f, 55, 44.0f)    //左右侧导航栏按钮大小




///设置中各式界面的界面布局设置
#define KFunctionModulSeparateHeight            (KXCUIControlSizeWidth(15.0))
#define KFunctionModulButtonHeight              (KXCUIControlSizeWidth(48.0f))
#define KFunctionModuleContentLeftWidth         (16.0f)
#define KFunctionModuleContentColor             KContentTextColor
#define KFunctionModuleContentFont              KXCAPPUIContentFontSize(15)

#define KCellViewLeftIntervalWidth              (KXCUIControlSizeWidth(20.0))

#define KUserPersonalRightButtonArrowFontSize   (16.0f)


#endif /* XCAPPThemeScreenSize_h */
