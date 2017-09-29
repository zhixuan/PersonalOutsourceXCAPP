//
//  RCStandardController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/10.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "RCStandardController.h"
#import "WriteOutFlightOrderController.h"


#define KBtnForBaseButtonTag        (1420111)
#define KBtnForDoneButtonTag        (1430211)

@interface RCStandardController ()


/*!
 * @breif 订单信息内容
 * @See
 */
@property (nonatomic , strong)          FlightOrderInformation *orderInformation;
@end

@implementation RCStandardController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithFlightOrderInfor:(FlightOrderInformation *)orderInfor{
    self = [super init];
    if (self) {
        self.orderInformation = orderInfor;
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
    
    [self settingNavTitle:@"RC标准"];
    // Do any additional setup after loading the view.
    [self setupRCStandardControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRCStandardControllerFrame{
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    

}

@end
