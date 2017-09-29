//
//  AddTrainTicketUserInforController.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
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


@protocol AddTrainTicketUserInforDelegate <NSObject>

- (void)addFinishUserInfor:(UserInformationClass *)userInfor;


- (void)editFinishUserInfor:(UserInformationClass *)userInfor withIndex:(NSInteger)index;

@end
/**
 *  @method  添加乘客
 *
 *  @brief
 */
@interface AddTrainTicketUserInforController : XCAPPUIViewController

/*!
 * @breif 操作控制协议
 * @See
 */
@property (nonatomic , assign)      id<AddTrainTicketUserInforDelegate>     delegate;
- (id)initWithUserInfor:(UserInformationClass *)userInfor withIndex:(NSInteger)index;
@end
//:-D QQ 10990  28580