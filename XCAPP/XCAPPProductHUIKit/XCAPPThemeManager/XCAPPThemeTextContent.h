//
//  XCAPPThemeTextContent.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#ifndef XCAPPThemeTextContent_h
#define XCAPPThemeTextContent_h

#define LOADMORE_LOADING                        @"正在加载..."
#define LOADMORE_LOADOVER                       @"加载完毕"
#define LOADMORE_LOADFAILD                      @"加载失败"



#define KKeyForUmemgAPPKeyString                @"57708d24e0f55a8976001251"



#define APLocalizedString(key,comment) [[AiPuLocalizableControllerManager bundle] localizedStringForKey:(key) value:@"" table:nil]
#define APLanguageLocalizedForLanguage(language) [AiPuLocalizableControllerManager setUserlanguage:(language)]
#define APLocalizedFormatString(keyStr) APLocalizedString(keyStr,@"")

#define kFontAwesomeFamilyName                  @"LvyeFontAwesome"


///APP系统客服电话
#define KAPPCustomerServiceTelephoneStr         @"027-87818666"















///模拟器里的内容
#ifndef __OPTIMIZE__

#define NSLog(fmt, ...) NSLog((@"%s [Line %d] \n " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


///真机里的内容
#else

#define NSLog(...) {}

#endif

#endif /* XCAPPThemeTextContent_h */
