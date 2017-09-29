//
//  ReturnedMoneyInstructionsController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/8.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "ReturnedMoneyInstructionsController.h"

@interface ReturnedMoneyInstructionsController ()

@end

@implementation ReturnedMoneyInstructionsController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNavTitle:@"退取票说明和预订须知"];
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect actionTarget:self action:@selector(leftDismissClickedEvent)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftDismissClickedEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
