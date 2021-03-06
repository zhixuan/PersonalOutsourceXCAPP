//
//  NSString+FontAwesome.h
//
//  Copyright (c) 2012 Alex Usbergo. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger,FMIconFont){
    FMIconHomePage,             /**< 00 首页模块信息*/
    FMIconFond,                 /**< 01 发现模块信息*/
    FMIconTakeCamera,           /**< 02 拍照模块信息*/
    FMIconPersonlMsg,           /**< 03 个人消息模块信息*/
    FMIconPersonalInfo,         /**< 04 个人模块信息*/
    FMIconPersonalDNA,          /**< 05 个人DNA*/
    FMIconAttention,            /**< 06 关注（心型，实心）*/
    FMIconLocation,             /**< 07 定位操作(下面没有信息)*/
    FMIconSkim,                 /**< 08 浏览(眼睛小图标)*/
    FMIconComment,              /**< 09 评论*/
    FMIconNULL,                 /**< 0A 空信息，没有任何数据内容*/
    FMIconOrder,                /**< 0B 订单*/
    FMIconLock,                 /**< 0C 锁（密码信息）*/
    FMIconVerifyCode,           /**< 0D 验证码*/
    FMIconLeftReturn,           /**< 0E 向左返回*/
    FMIconCloseEdit,            /**< 0F 关闭编辑 */
    FMIconSelected,             /**< 10 对号选择（没有圆圈，仅有对号） */
    FMIconUpDownSelected,       /**< 11 上下信息选择 */
    FMIconAdd,                  /**< 12 圆形添加，即加号*/
    FMIconRightLineArrow,       /**< 13 向右的横向箭头（横线+向右箭头）*/
    FMIconSelectedBorder,       /**< 14 对号选择（有圆圈，有对号） */
    FMIconChat,                 /**< 15 聊天操作 */
    FMIconLowerArrow,           /**< 16 向下箭头*/
    FMIconRightArrow,           /**< 17 向右箭头*/
    FMIconRightReturn,          /**< 18 向右操作*/
    FMIconSubtract,             /**< 19 圆形见好，即减号*/
    FMIconStarAttention,        /**< 1A 关注（默认状态,星星空心）*/
    FMIconEidt,                 /**< 1B 编辑（铅笔形状）*/
    FMIconStarSolidAttention,   /**< 1C 关注（高亮状态,星星实心）*/
    FMIconDelete,               /**< 1D 删除 */
    FMIconAttentionSolidHeart,  /**< 1E 关注（心型，空心）*/
    FMIconShare,                /**< 1F 分享 */
    FMIconAddMedia,             /**< 20 添加多媒体信息 */
    FMIconSmileExpression,      /**< 21 微笑表情 */
    FMIconVoice,                /**< 22 声音媒体 */
    FMIconGenderMale,           /**< 23 性别男 */
    FMIconGenderFemale,         /**< 24 性别女 */
    FMIconUserSendInfor,        /**< 25 发布信息 */
    FMIconCamera,               /**< 26 拍照*/
    FMIconPraiseBorder,         /**< 27 赞（空心的，只有边框手势）*/
    FMIconPraise,               /**< 28 赞（实心的，）*/
    FMIconSelectedAct,          /**< 29 选则沙龙*/
    FMIconPic,                  /**< 2A 图片设置*/
    FMIconSetting,              /**< 2B 设置*/
    FMIconPhoneNumber,          /**< 2C 手机号*/
    FMIconRMBIcon,              /**< 2D 人民币*/
    FMIconThreePointIcon,       /**< 2E 三个点*/
    FMNewPeopleIcon,            /**< 2F 2.10.0版本中人模块*/
    FMNewMessageIcon,           /**< 30 2.10.0版本中消息模块*/
    FMNewDynamicIcon,           /**< 31 2.10.0版本中动态模块*/
    FMNewHomeIcon,              /**< 32 2.10.0版本中首页模块*/
};


@interface NSString (FontAwesome)

/**
 @abstract Returns the correct enum for a font-awesome icon.
 @discussion The list of identifiers can be found here: http://fortawesome.github.com/Font-Awesome/#all-icons 
 */
+ (FMIconFont)fontAwesomeEnumForIconIdentifier:(NSString*)string;

/**
 @abstract Returns the font-awesome character associated to the icon enum passed as argument 
 */
+ (NSString*)fontAwesomeIconStringForEnum:(FMIconFont)value;

/* 
 @abstract Returns the font-awesome character associated to the font-awesome identifier.
 @discussion The list of identifiers can be found here: http://fortawesome.github.com/Font-Awesome/#all-icons
 */
+ (NSString*)fontAwesomeIconStringForIconIdentifier:(NSString*)identifier;

@end
