//
//  SetupViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "SetupViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


#define KBtnForClearCacheButtonTag          (2680111)
#define KAlertForClearCacheButtonTag        (2680112)
#define KAlertForOpenWeixinTag              (2680113)
#define kHUIMegaByte     (1024.00 * 1024.00)
@interface SetupViewController ()<UIAlertViewDelegate>

/*!
 * @breif 缓存大小内容
 * @See
 */
@property (nonatomic , weak)      UILabel               *appCacheSizeLabel;
@end

@implementation SetupViewController
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
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
    [self settingNavTitle:@"设置"];
    // Do any additional setup after loading the view.
    [self setupSetupViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.appCacheSizeLabel setText:[NSString stringWithFormat:@"%.02fM", (double)([[[SDWebImageManager sharedManager] imageCache] getSize]) / kHUIMegaByte]];
}

- (void)setupSetupViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 60.0f)];
    
    ///
    UIView *showDisplayView = [[UIView alloc]init];
    [showDisplayView setBackgroundColor:[UIColor whiteColor]];
    [showDisplayView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                         KProjectScreenWidth, KFunctionModulButtonHeight)];
    [mainView addSubview:showDisplayView];
    UILabel *displayTitle = [[UILabel alloc]init];
    [displayTitle setBackgroundColor:[UIColor clearColor]];
    [displayTitle setFont:KFunctionModuleContentFont];
    [displayTitle setTextAlignment:NSTextAlignmentLeft];
    [displayTitle setTextColor:KContentTextColor];
    [displayTitle setText:@"当前版本"];
    [displayTitle setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, 120.0f, KFunctionModulButtonHeight)];
    [showDisplayView addSubview:displayTitle];
    
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    
    UILabel *displayVersion = [[UILabel alloc]init];
    [displayVersion setBackgroundColor:[UIColor clearColor]];
    [displayVersion setFont:KFunctionModuleContentFont];
    [displayVersion setTextAlignment:NSTextAlignmentRight];
    [displayVersion setTextColor:KContentTextColor];
    [displayVersion setText:[NSString stringWithFormat:@"V %@",[dicInfo objectForKey:@"CFBundleShortVersionString"]]];
    [displayVersion setFrame:CGRectMake((KProjectScreenWidth - 120.0f- KInforLeftIntervalWidth), 0.0f, 120.0f, KFunctionModulButtonHeight)];
    [showDisplayView addSubview:displayVersion];
    
    
//    ///
//    UIView *showLauangeView = [[UIView alloc]init];
//    [showLauangeView setBackgroundColor:[UIColor whiteColor]];
//    [showLauangeView setFrame:CGRectMake(0.0f, (showDisplayView.bottom + KInforLeftIntervalWidth),
//                                         KProjectScreenWidth, KFunctionModulButtonHeight)];
//    [mainView addSubview:showLauangeView];
//    UILabel *languageTitle = [[UILabel alloc]init];
//    [languageTitle setBackgroundColor:[UIColor clearColor]];
//    [languageTitle setFont:KFunctionModuleContentFont];
//    [languageTitle setTextAlignment:NSTextAlignmentLeft];
//    [languageTitle setTextColor:KContentTextColor];
//    [languageTitle setText:@"语言"];
//    [languageTitle setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, 80.0f, KFunctionModulButtonHeight)];
//    [showLauangeView addSubview:languageTitle];
    
    
    ///1.3.清空缓存
    UIButton *clearCacheButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearCacheButton.tag = KBtnForClearCacheButtonTag;
    clearCacheButton.frame =CGRectMake(0.0f, (showDisplayView.bottom + KInforLeftIntervalWidth),
                                       KProjectScreenWidth, KFunctionModulButtonHeight);
    [clearCacheButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                forState:UIControlStateNormal];
    [clearCacheButton setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                forState:UIControlStateHighlighted];
    [clearCacheButton addTarget:self action:@selector(clearCacheButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:clearCacheButton];
    ////清空缓存key Label
    UILabel *clearCacheKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0, 100, 47)];
    clearCacheKeyLabel.text = @"清空缓存";
    clearCacheKeyLabel.textColor = KContentTextColor;
    clearCacheKeyLabel.backgroundColor = [UIColor clearColor];
    clearCacheKeyLabel.font = KFunctionModuleContentFont;
    [clearCacheButton addSubview:clearCacheKeyLabel];
    ////清空缓存value Label
    UILabel *clearCacheValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120.0f,0,KProjectScreenWidth-30-120, 47)];
    [clearCacheValueLabel setBackgroundColor:[UIColor clearColor]];
    
    [clearCacheValueLabel setText:[NSString stringWithFormat:@"%.02fM", (double)([[[SDWebImageManager sharedManager] imageCache] getSize]) / kHUIMegaByte]];
    clearCacheValueLabel.font = KFunctionModuleContentFont;
    clearCacheValueLabel.textColor =KContentTextColor;
    [clearCacheValueLabel setTextAlignment:NSTextAlignmentRight];
    [clearCacheButton addSubview:clearCacheValueLabel];
    self.appCacheSizeLabel = clearCacheValueLabel;
    
    
    
    /*≤
    
////    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
//    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
//    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
//    
//    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]];
//    NSLog(@"安装微信 %zi\n\n安装QQ %zi\n\n 安装微博 %zi",hadInstalledWeixin,hadInstalledQQ,hadInstalledWeibo);
////    alipay://
//    
//    if (hadInstalledWeixin) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"您已安装了微信客户端，是否打开微信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开微信", nil];
//        [alertView setTag:KAlertForOpenWeixinTag];
//        [alertView show];
//    }

    
//    ////清空缓存箭头
//    UIImageView *clearCacheArrowImageView = [[UIImageView alloc]initWithFrame:
//                                             CGRectMake(KProjectScreenWidth-25, 17, 8.5f, 13.0f)];
//    [clearCacheArrowImageView setImage:[UIImage imageNamed:@"More_CellArrow.png"]];
//    [clearCacheArrowImageView setUserInteractionEnabled:YES];
//    [clearCacheButton addSubview:clearCacheArrowImageView];
//    [firstPartView addSubview:clearCacheButton];
//    [firstPartView setUserInteractionEnabled:YES];
    
    
//    ///
//    UIView *cleanView = [[UIView alloc]init];
//    [cleanView setBackgroundColor:[UIColor whiteColor]];
//    [cleanView setFrame:CGRectMake(0.0f, (showLauangeView.bottom + KInforLeftIntervalWidth),
//                                         KProjectScreenWidth, KFunctionModulButtonHeight)];
//    [mainView addSubview:cleanView];
//    UILabel *cleanTitle = [[UILabel alloc]init];
//    [cleanTitle setBackgroundColor:[UIColor clearColor]];
//    [cleanTitle setFont:KFunctionModuleContentFont];
//    [cleanTitle setTextAlignment:NSTextAlignmentLeft];
//    [cleanTitle setTextColor:KContentTextColor];
//    [cleanTitle setText:@"清除缓存"];
//    [cleanTitle setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, 80.0f, KFunctionModulButtonHeight)];
//    [cleanView addSubview:cleanTitle];
//    
//    //MARK:账户管理
//    UIButton *accountSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [accountSetBtn setBackgroundColor:[UIColor clearColor]];
//    [accountSetBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
//                             forState:UIControlStateNormal];
//    [accountSetBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
//                             forState:UIControlStateHighlighted];
//    [accountSetBtn setTag:(KBtnForOrderButtonTag + index)];
//    [accountSetBtn setFrame:CGRectMake(0.0f, KFunctionModulSeparateHeight, KProjectScreenWidth,
//                                       KFunctionModulButtonHeight)];
//    [accountSetBtn addTarget:self action:@selector(buttonOperationEventClicked:)
//            forControlEvents:UIControlEventTouchUpInside];
//    [mainView addSubview:accountSetBtn];
//    
//    UILabel  *titleInforLabel = [[UILabel alloc]init];
//    [titleInforLabel setBackgroundColor:[UIColor clearColor]];
//    [titleInforLabel setTextAlignment:NSTextAlignmentLeft];
//    [titleInforLabel setTextColor:KFunctionModuleContentColor];
//    [titleInforLabel setFont:KFunctionModuleContentFont];
//    [titleInforLabel setText:@"近期形成展示"];
//    [titleInforLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth, 0.0f, 90.0f, KFunctionModulButtonHeight)];
//    [accountSetBtn addSubview:titleInforLabel];
//    
//    UILabel *nextLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
//                                                 size:KUserPersonalRightButtonArrowFontSize
//                                                color:KSubTitleTextColor];
//    [nextLabel setFrame:CGRectMake((KProjectScreenWidth - 25.0f), (KFunctionModulButtonHeight - 20.0f)/2, 20.0f, 20.0f)];
//    [nextLabel setBackgroundColor:[UIColor clearColor]];
//    [nextLabel setContentMode:UIViewContentModeCenter];
//    //        [nextLabel setCenter:CGPointMake((KProjectScreenWidth - 15.0f), 10)];
//    [accountSetBtn addSubview:nextLabel];
    
    
    
//    UIDevice *device = [[UIDevice alloc] init];
//    NSLog(@"设备所有者名称  %@  ",device.name);//设备所有者名称
//    NSLog(@"设备类别  %@",device.model);//设备leibie
//    NSLog(@"本地化版本  %@",device.localizedModel);//本地化版本
//    NSLog(@"当前系统版本  %@",device.systemVersion);//当期版本
//    NSLog(@"当前系统  %@",device.systemName);//当前系统
//    NSLog(@"系统唯一标示符  %@",[[[UIDevice currentDevice ] identifierForVendor] UUIDString]);//唯一标示
//    NSLog(@"电量   %f",[[UIDevice currentDevice] batteryLevel]);//输出-1为模拟器  输出0-1为真机
//    
//    NSArray *languageArray = [NSLocale preferredLanguages];
//    NSString *language = [languageArray objectAtIndex:0];
//    NSLog(@"语言：%@", language);//语言
//    NSLocale *locale = [NSLocale currentLocale];
//    NSString *country = [locale localeIdentifier];
//    NSLog(@"国家：%@", country); //国别
//    
//    //获得运营商信息
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    
//    //  获取运行商的名称
//    CTCarrier *carrier = [info subscriberCellularProvider];
//    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
//    NSLog(@"%@", mCarrier);
//   
//    NSLog(@"应用所有信息 %@",dicInfo);
//    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
//    NSLog(@"App应用名称：%@", strAppName);
//    NSString *strAppVersion =  [dicInfo objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"App应用版本：%@", strAppVersion);
//    NSString *strAppBuild = [dicInfo objectForKey:@"CFBundleVersion"];
//    NSLog(@"App应用Build版本：%@", strAppBuild);
//    NSString *strAppBundleIdentifier = [dicInfo objectForKey:@"CFBundleIdentifier"];
//    NSLog(@"App应用唯一标示符：%@", strAppBundleIdentifier);
    
     */

}

- (void)clearCacheButtonClicked{
    
    if ([self.appCacheSizeLabel.text isEqualToString:@"0.00M"]) {
        
        ShowImportErrorAlertView(@"已没有缓存可清理！");
         return;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要清空缓存么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView setTag:KAlertForClearCacheButtonTag];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == KAlertForClearCacheButtonTag) {
        if (buttonIndex != 0) {
            [[[SDWebImageManager sharedManager] imageCache] clearDisk];
            [self.appCacheSizeLabel setText:@"0.00M"];
        }
    }
    
    else if (alertView.tag == KAlertForOpenWeixinTag){
        if (buttonIndex != 0) {
//           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipay://"]];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }
    }
}
@end
