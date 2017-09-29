//
//  UIUserOperationButton.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/12/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UIUserOperationButton.h"

@implementation UIUserOperationButton

- (id)init{

    self = [super init];
    if (self) {
        self.userOperation = [[UserInformationClass alloc] init];
    }
    
    return self;
}

@end
