//
//  TrainPassStationController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/8.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainPassStationController.h"

@interface TrainPassStationController ()


/*!
 * @breif 火车原始数据信息
 * @See
 */
@property (nonatomic , strong)                  TrainticketInformation      *itemDataSource;
@end

@implementation TrainPassStationController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
    }
    return self;
}

- (id)initWith:(TrainticketInformation *)trainItem{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.itemDataSource  = trainItem;
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
    
    [self settingNavTitle:[NSString stringWithFormat:@"%@经停站",self.itemDataSource.traCodeNameStr]];
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect
                      actionTarget:self action:@selector(setupLeftButtonDismissClickedEvent)];
    
    [self setupTrainPassStationControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLeftButtonDismissClickedEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setupTrainPassStationControllerFrame{

}

@end
