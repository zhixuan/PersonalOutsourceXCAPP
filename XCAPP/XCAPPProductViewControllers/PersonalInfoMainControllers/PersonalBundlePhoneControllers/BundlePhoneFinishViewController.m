//
//  BundlePhoneFinishViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "BundlePhoneFinishViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"
#import "BundlePhoneController.h"

#define KBtnForUnBundleButtonTag                (1580111)

@interface BundlePhoneFinishViewController ()
/*!
 * @breif 已绑定的手机号内容
 * @See
 */
@property (nonatomic , strong)      NSString                *userPersonalPhoneStr;
@end

@implementation BundlePhoneFinishViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}
#pragma mark -
#pragma mark -  初始化绑定手机号完成界面
- (id)initWithUserPhoneStr:(NSString *)phoneStr{
    self = [super init];
    if (self) {
        self.userPersonalPhoneStr = [[NSString alloc]initWithFormat:@"%@",phoneStr];
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
    [self settingNavTitle:@"绑定手机号"];
//    [self setLeftNavButtonFA: withFrame:<#(CGRect)#> actionTarget:<#(id)#> action:<#(SEL)#>];

    
    [self setupBundlePhoneFinishViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftButtonOperationEvent{
    
}

- (void)setupBundlePhoneFinishViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 60.0f)];
    
    
    
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    [phoneLabel setBackgroundColor:[UIColor clearColor]];
    [phoneLabel setFont:KXCAPPUIContentDefautFontSize(22)];
    [phoneLabel setTextColor:KContentTextColor];
    [phoneLabel setTextAlignment:NSTextAlignmentCenter];
    [phoneLabel setFrame:CGRectMake(0.0f, 200.0f, KProjectScreenWidth, KXCUIControlSizeWidth(30))];
    [mainView addSubview:phoneLabel];
    [phoneLabel setText:self.userPersonalPhoneStr];
    
    UILabel *phoneShowExplanLabel = [[UILabel alloc]init];
    [phoneShowExplanLabel setBackgroundColor:[UIColor clearColor]];
    [phoneShowExplanLabel setFont:KXCAPPUIContentFontSize(12.0f)];
    [phoneShowExplanLabel setTextColor:KSubTitleTextColor];
    [phoneShowExplanLabel setTextAlignment:NSTextAlignmentCenter];
    [phoneShowExplanLabel setFrame:CGRectMake(0.0f, (phoneLabel.bottom + 10.0f),
                                              KProjectScreenWidth, KXCUIControlSizeWidth(18))];
    [mainView addSubview:phoneShowExplanLabel];
    [phoneShowExplanLabel setText:@"手机号已绑定，您可以使用手机号登录"];
    
    
    UIButton *unbundleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [unbundleBtn setBackgroundColor:[UIColor clearColor]];
    [unbundleBtn setTitle:@"解绑手机" forState:UIControlStateNormal];
    [unbundleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [unbundleBtn addTarget:self action:@selector(userUnBundlePhoneButtonOperationClicked)
          forControlEvents:UIControlEventTouchUpInside];
    [unbundleBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                           forState:UIControlStateNormal];
    [unbundleBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(180.0f))/2, (phoneShowExplanLabel.bottom + KXCUIControlSizeWidth(50.0f)), KXCUIControlSizeWidth(180.0f), KFunctionModulButtonHeight)];
    [unbundleBtn.layer setCornerRadius:5.0f];
    [unbundleBtn.layer setMasksToBounds:YES];
    [unbundleBtn setTag:KBtnForUnBundleButtonTag];
    [mainView addSubview:unbundleBtn];
}



- (void)userUnBundlePhoneButtonOperationClicked{
    
    BundlePhoneController *viewController = [[BundlePhoneController alloc]initWithUserHasBundlePhone:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
