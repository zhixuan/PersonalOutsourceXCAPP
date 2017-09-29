//
//  SelectedUserInforViewController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/19.
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


@protocol SelectedUsersDelegate <NSObject>

- (void)userSelectedUserArray:(NSArray *)userArray isDeleteSelectedBool:(BOOL)deleteBool;

@end

#import "XCAPPUIViewController.h"
/**
 *  @method         酒店/航班/火车选择加入人员信息
 *
 *  @brief
 */
@interface SelectedUserInforViewController : XCAPPUIViewController


- (id)initWithTitleStr:(NSString *)title withSelected:(NSArray *)userArray;

/*!
 * @breif 用户操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<SelectedUsersDelegate>   delegate;

@end
//:-D QQ 10990  28580