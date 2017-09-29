//
//  AddMoveIntoPersonnelViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/12.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//
/*
 *
 *   ╭＾＾★╮╭＾＾☆╮
 *  {/ ． ．\}{/ ． ．\}
 *  (　 (oo) )(　 (oo) )  总是加班会死人的的....
 *
 *
 *
 */

#import "XCAPPUIViewController.h"

/**
 *  @method 新增入住人员（非公司员工）操作控制协议
 *
 *  @brief
 */
@protocol AddMoveIntoPersonnelFinishDelegate <NSObject>
/**
 *  @method
 *
 *  @brief          新增入住人员信息内容
 *
 *  @param          userNameStr 人员名字
 *
 */
- (void)userAddFinishUserName:(NSString *)userNameStr;

@end

/**
 *  @method 新增入住人员
 *
 *  @brief
 */
@interface AddMoveIntoPersonnelViewController : XCAPPUIViewController

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<AddMoveIntoPersonnelFinishDelegate> delegate;

@end
//:-D QQ 10990  28580