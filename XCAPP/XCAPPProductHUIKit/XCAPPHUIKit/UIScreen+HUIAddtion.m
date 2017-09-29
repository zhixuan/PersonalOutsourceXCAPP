//
//  UIScreen+HUIAddtion.m
//  NetWorkingDemo
//
//  Created by 张利广 on 15/3/17.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import "UIScreen+HUIAddtion.h"


@implementation UIScreen (HUIAddtion)

- (BOOL)isRetinaDisplay
{
    static BOOL _isRetina;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _isRetina = ([self respondsToSelector:@selector(scale)] && [self scale] == 2.0);
    });
    return _isRetina;
}

- (BOOL)isIPhone5
{
    static BOOL _isIPhone5 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _isIPhone5 = self.bounds.size.height >= 568.00;
    });
    return _isIPhone5;
}

@end
