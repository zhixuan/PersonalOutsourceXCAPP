//
//  BusinessTravelExplainController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/30.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "BusinessTravelExplainController.h"

@interface BusinessTravelExplainController ()

@end

@implementation BusinessTravelExplainController

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
    
    [self settingNavTitle:@"差旅标准"];
    // Do any additional setup after loading the view.
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect actionTarget:self action:@selector(closeControllerOperation)];
    
    [self setupBusinessTravelExplainFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeControllerOperation{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setupBusinessTravelExplainFrame{
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, (self.view.bounds.size.height + 40.0f))];
    [self.view addSubview:mainView];
    
    
    CGFloat btnWidth = (KProjectScreenWidth/3);
    
    
    NSArray *siftArray = @[@"推荐排序",
                           @"价格星级筛选",
                           @"更多筛选"];
    for (int index = 0; index < siftArray.count; index ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(btnWidth*index, 80.0f, btnWidth,50.0f)];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(105.0f, 105.0f, 105.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setTag:(10+index)];
        [button addTarget:self action:@selector(userSearchOperationButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:button];
        
        UILabel *siftTitle = [[UILabel alloc]init];
        [siftTitle setBackgroundColor:[UIColor clearColor]];
        [siftTitle setTextAlignment:NSTextAlignmentCenter];
        [siftTitle setFont:KXCAPPUIContentFontSize(14)];
        [siftTitle setTextColor:[UIColor whiteColor]];
        [siftTitle setFrame:CGRectMake(0.0f, 50.0f - 18.0f - 16.0f,
                                       button.width, 18.0f)];
        [siftTitle setText:[siftArray objectAtIndex:index]];
        [button addSubview:siftTitle];
        
    }

    
    
    
    
    
}

- (void)userSearchOperationButtonEvent:(UIButton *)btn{

    
}
@end
