//
//  XCAPPNavigationController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCAPPNavigationController.h"

@interface XCAPPNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation XCAPPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [super viewDidLoad];
    
    //去掉底部阴影条
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
        [self.navigationBar setShadowImage:[UIImage imageNamed:@"TabItem_SelectionIndicatorImage"]];
    }
    
    
    //设置背景
    UIImage* img = createImageWithColor(KDefaultNavigationWhiteBackGroundColor);
    if(img){
        if(HUISystemVersionBelow(kHUISystemVersion_7_0)){
            [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        }else{
            [self.navigationBar setBackgroundImage:img
                                    forBarPosition:UIBarPositionTopAttached
                                        barMetrics:UIBarMetricsDefault];
            
        }
        //        [UIColor whiteColor];
    }else{
        UIColor* color = KDefaultNavigationWhiteBackGroundColor;
        if (color) {
            if(HUISystemVersionBelow(kHUISystemVersion_7_0)){
                self.navigationBar.tintColor = color;
            }else{
                self.navigationBar.barTintColor = color;
            }
            
        }
    }
    
    //设置返回按钮颜色
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){
        [self.navigationBar setTintColor:KDefaultNavigationWhiteBackGroundColor];
    }
//    UIStatusBarStyleBlackOpaque
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
    
    //支持滑动返回
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0))
    {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    if (HUISystemVersionBelow(kHUISystemVersion_6_0))
        [super viewDidUnload];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
