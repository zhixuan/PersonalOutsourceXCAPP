//
//  SetupInforForTrainViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "SetupInforForTrainViewController.h"

@interface SetupInforForTrainViewController ()

/*!
 * @breif 用户信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass        *willEditUserInfor;

@end

@implementation SetupInforForTrainViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.willEditUserInfor = [[UserInformationClass alloc]init];
    }
    return self;
}

- (id)initWithUserInfor:(UserInformationClass *)itemUser{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.willEditUserInfor= itemUser;
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
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
