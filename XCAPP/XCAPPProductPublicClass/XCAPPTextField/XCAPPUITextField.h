//
//  XCAPPUITextField.h
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/8.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCAPPUITextField : UITextField
@property(nonatomic, strong) UILabel *xcPlaceHolderLabel;

@property(nonatomic, strong) NSString *placeholder;

@property(nonatomic, strong) UIColor *xcPlaceholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
