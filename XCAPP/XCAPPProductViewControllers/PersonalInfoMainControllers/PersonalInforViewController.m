//
//  PersonalInforViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "PersonalInforViewController.h"
#import "AppDelegate.h"
#import "HTTPClient.h"
#import "FontAwesome.h"
#import "FAImageView.h"
#import "SetupViewController.h"
#import "BundlePhoneController.h"
#import "HTTPClient+PersonalInfor.h"
#import "SetPasswordViewController.h"
#import "AddNewWorkerViewController.h"
#import "PaySuccessfulViewController.h"
#import "WorkerManageSettingController.h"
#import "BundlePhoneFinishViewController.h"




#define KBtnForWorkerButtonTag              (1740111)
#define KBtnForSetPWDButtonTag              (1740112)
#define KBtnForSetPhoneButtonTag            (1740113)
#define KBtnForSetupButtonTag               (1740114)
#define KBtnForCustomerTelButtonTag         (1740115)


#define KBtnForLogoutButtonTag              (1740211)

#define KImgPhotoImageViewHeight            (KXCUIControlSizeWidth(60.0f))

#define KAlertForLogoutAlertTag             (1740311)

@interface PersonalInforViewController ()<UIAlertViewDelegate>



/*!
 * @breif 用户头像信息
 * @See
 */
@property (nonatomic , weak)    UIImageView         *userPersonalPhotoImageView;

/*!
 * @breif 用户名字
 * @See
 */
@property (nonatomic , weak)    UILabel             *userPersonalNameLabel;

/*!
 * @breif 担保账户余额
 * @See
 */
@property (nonatomic , weak)      UILabel           *userPersonalSurplusMoneyLabel;

/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)    UILabel             *userPersonalPhoneNumberLabel;
@end

@implementation PersonalInforViewController
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
    [self settingNavTitle:@"我的"];
    [self setupPersonalInforViewControllerFrame];
    // Do any additional setup after loading the view.
    //用户修改密码成功操作通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BundleAndUnbundlePhoneOperationNotification:) name:KXCAPPUserBundleAndUnbundlePhoneSuccessFinishNotification object:nil];
    
    ///用户从其他模块进入“我的”模块时，刷新界面数据内容
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userIntoPersonalFromOtherRefreshDataNotification:) name:KXCAPPUserIntoPersonalFromOtherRefreshDataNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userPersonalCheckPersonalAccountInforOperationNotification:) name:KXCAPPUserPersonalCheckPersonalAccountInforNotification object:nil];
}



- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPersonalInforViewControllerFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 10.0f)];
    

    
    
    UIView *currentUserBGView = [[UIView alloc]init];
    [currentUserBGView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
    [currentUserBGView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(120.0f))];
    [mainView addSubview:currentUserBGView];
    
    UIImageView *photoImageView = [[UIImageView alloc]init];
    [photoImageView setBackgroundColor:[UIColor clearColor]];
    [photoImageView setImage:createImageWithColor(KUIImageViewDefaultColor)];
    [photoImageView setFrame:CGRectMake(KInforLeftIntervalWidth, (KInforLeftIntervalWidth +20.0f),
                                        KImgPhotoImageViewHeight, KImgPhotoImageViewHeight)];
    [photoImageView.layer setCornerRadius:KImgPhotoImageViewHeight/2];
    [photoImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [photoImageView.layer setBorderWidth:3.0f];
    [photoImageView.layer setMasksToBounds:YES];
    self.userPersonalPhotoImageView = photoImageView;

    [currentUserBGView addSubview:self.userPersonalPhotoImageView ];
    
    NSURL *url = [NSURL URLWithString:@"http://7xryr0.com2.z0.glb.qiniucdn.com/RegisterUserImage/6A708DFF-0379-495A-8456-5E2BDE352BAD"];
    [self.userPersonalPhotoImageView setImageWithURL:url placeholderImage:KUIImageViewDefaultImage];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setTextAlignment:NSTextAlignmentLeft];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setFont:KXCAPPUIContentDefautFontSize(22.0f)];
    [nameLabel setFrame:CGRectMake((photoImageView.right + KInforLeftIntervalWidth), (photoImageView.top), KXCUIControlSizeWidth(180.0f), KXCUIControlSizeWidth(35.0f))];
    self.userPersonalNameLabel = nameLabel;
    [currentUserBGView addSubview:self.userPersonalNameLabel];
    /// 158 011 80762 红英
    [self.userPersonalNameLabel setText:KXCAPPCurrentUserInformation.userNickNameStr];
    
    UILabel  *titleInforLabel = [[UILabel alloc]init];
    [titleInforLabel setBackgroundColor:[UIColor clearColor]];
    [titleInforLabel setTextAlignment:NSTextAlignmentLeft];
    [titleInforLabel setTextColor:[UIColor whiteColor]];
    [titleInforLabel setFont:KXCAPPUIContentDefautFontSize(15.0f)];
    [titleInforLabel setText:@"担保账户:"];
    [titleInforLabel setFrame:CGRectMake((photoImageView.right + KInforLeftIntervalWidth), nameLabel.bottom,
                                         KXCUIControlSizeWidth(80.0f),
                                         KXCUIControlSizeWidth(30.0f))];
    [currentUserBGView addSubview:titleInforLabel];
    
    UILabel *surplusMoneyLabel = [[UILabel alloc]init];
    [surplusMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [surplusMoneyLabel setTextAlignment:NSTextAlignmentLeft];
    [surplusMoneyLabel setTextColor:KUnitPriceContentColor];
    [surplusMoneyLabel setFont:KXCAPPUIContentDefautFontSize(22.0f)];
    
    [surplusMoneyLabel setText:[NSString stringWithFormat:@"%.1lf 元",KXCAPPCurrentUserInformation.userAccountBalanceFloat]];
    [surplusMoneyLabel setFrame:CGRectMake((titleInforLabel.right), nameLabel.bottom,
                                         KXCUIControlSizeWidth(190.0f),
                                         KXCUIControlSizeWidth(30.0f))];
    self.userPersonalSurplusMoneyLabel = surplusMoneyLabel;
    [currentUserBGView addSubview:self.userPersonalSurplusMoneyLabel];
    
    NSRange moneyRange=[surplusMoneyLabel.text rangeOfString:@"元"];
    NSMutableAttributedString *moneyContent=[[NSMutableAttributedString alloc]initWithString:surplusMoneyLabel.text];
    [moneyContent addAttribute:NSFontAttributeName value:KXCAPPUIContentFontSize(14.0f) range:moneyRange];
    [moneyContent addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:moneyRange];
    [self.userPersonalSurplusMoneyLabel setAttributedText:moneyContent];
    
    [currentUserBGView setHeight:(titleInforLabel.bottom + KInforLeftIntervalWidth)];
    
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setBackgroundColor:[UIColor clearColor]];
    [logoutBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                             forState:UIControlStateNormal];
    [logoutBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                             forState:UIControlStateHighlighted];
    [logoutBtn setTitle:@"退 出" forState:UIControlStateNormal];
    [logoutBtn.titleLabel setFont:KXCAPPUIContentDefautFontSize(20.0f)];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setTitleColor:HUIRGBColor(225.0f, 225.0f, 225.0f, 1.0f)
                    forState:UIControlStateHighlighted];
    [logoutBtn setShowsTouchWhenHighlighted:YES];
    [logoutBtn setTag:KBtnForLogoutButtonTag];
    [logoutBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(80.0f)), 20.0f,
                                   KXCUIControlSizeWidth(80.0f),(currentUserBGView.height - 40.0f))];
    [logoutBtn addTarget:self action:@selector(buttonOperationEventClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    [currentUserBGView addSubview:logoutBtn];
 
    NSArray *titleNameArray = @[@"员工管理",
                                @"密码修改",
                                @"手机号码",
                                @"设置",
                                @"联系客服",];
    CGFloat buttonTopFloat = currentUserBGView.bottom + KInforLeftIntervalWidth*1.5;
    for (NSInteger index = 0; index < titleNameArray.count; index++) {
        
        
        
        //MARK:账户管理
        UIButton *accountSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [accountSetBtn setBackgroundColor:[UIColor clearColor]];
        [accountSetBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                                 forState:UIControlStateNormal];
        [accountSetBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                                 forState:UIControlStateHighlighted];
        [accountSetBtn setTag:(KBtnForWorkerButtonTag + index)];
        [accountSetBtn setFrame:CGRectMake(0.0f, buttonTopFloat, KProjectScreenWidth,
                                           KFunctionModulButtonHeight)];
        [accountSetBtn addTarget:self action:@selector(buttonOperationEventClicked:)
                forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:accountSetBtn];
        
        UILabel  *titleInforLabel = [[UILabel alloc]init];
        [titleInforLabel setBackgroundColor:[UIColor clearColor]];
        [titleInforLabel setTextAlignment:NSTextAlignmentLeft];
        [titleInforLabel setTextColor:KFunctionModuleContentColor];
        [titleInforLabel setFont:KFunctionModuleContentFont];
        [titleInforLabel setText:[titleNameArray objectAtIndex:index]];
        [titleInforLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth, 0.0f, 90.0f,
                                             KFunctionModulButtonHeight)];
        [accountSetBtn addSubview:titleInforLabel];
        
        UILabel *nextLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                     size:KUserPersonalRightButtonArrowFontSize
                                                    color:KFunNextArrowColor];
        [nextLabel setFrame:CGRectMake((KProjectScreenWidth - 25.0f), (KFunctionModulButtonHeight - 20.0f)/2,
                                       20.0f, 20.0f)];
        [nextLabel setBackgroundColor:[UIColor clearColor]];
        [nextLabel setContentMode:UIViewContentModeCenter];
        //        [nextLabel setCenter:CGPointMake((KProjectScreenWidth - 15.0f), 10)];
        [accountSetBtn addSubview:nextLabel];

        buttonTopFloat = (buttonTopFloat + KInforLeftIntervalWidth + KFunctionModulButtonHeight);
    }
    
    ///手机号
    UIButton *phoneBtn = (UIButton *)[mainView viewWithTag:KBtnForSetPhoneButtonTag];
    UILabel *phoneNumberLabel = [[UILabel alloc]init];
    [phoneNumberLabel setTextColor:KContentTextColor];
    [phoneNumberLabel setTextAlignment:NSTextAlignmentRight];
    [phoneNumberLabel setFrame:CGRectMake((phoneBtn.width - 125.0f - KInforLeftIntervalWidth),0.0f,
                                          100.0f,phoneBtn.height)];
    [phoneNumberLabel setFont:KXCAPPUIContentFontSize(15.0f)];
    [phoneNumberLabel setBackgroundColor:[UIColor clearColor]];
    
    self.userPersonalPhoneNumberLabel = phoneNumberLabel;
    [phoneBtn addSubview:self.userPersonalPhoneNumberLabel];
    
    if (IsNormalMobileNum(KXCAPPCurrentUserInformation.userPerPhoneNumberStr)) {
        [self.userPersonalPhoneNumberLabel setText:KXCAPPCurrentUserInformation.userPerPhoneNumberStr];
        NSString *tel = [self.userPersonalPhoneNumberLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [self.userPersonalPhoneNumberLabel setText:tel];
    }else{
        [self.userPersonalPhoneNumberLabel setText:@"绑定"];
    }

    ///客服电话
    UIButton *telBtn = (UIButton *)[mainView viewWithTag:KBtnForCustomerTelButtonTag];
    UILabel *telNumberLabel = [[UILabel alloc]init];
    [telNumberLabel setBackgroundColor:[UIColor clearColor]];
    [telNumberLabel setTextAlignment:NSTextAlignmentRight];
    [telNumberLabel setFrame:CGRectMake((telBtn.width - 205.0f - KInforLeftIntervalWidth),
                                        0.0f, 180.0f, telBtn.height)];
    [telNumberLabel setText:KAPPCustomerServiceTelephoneStr];
    [telNumberLabel setTextColor:KContentTextColor];
    [telNumberLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [telBtn addSubview:telNumberLabel];
}

- (void)buttonOperationEventClicked:(UIButton *)button{
    ///未出行订单
    if (KBtnForLogoutButtonTag == button.tag){
        
        UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                            message:@"您确定要退出登录么?" delegate:self
                                                  cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [alertView setTag:KAlertForLogoutAlertTag];
        [alertView setDelegate:self];
        [alertView show];
    }
    
    ///员工管理
    else if (KBtnForWorkerButtonTag == button.tag){
        WorkerManageSettingController*viewController = [[WorkerManageSettingController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
//    ///优惠劵
//    else if (KBtnForPreferentialButtonTag == button.tag){
//        
//        UserPersonalOrderInformation *orderInfor = [[UserPersonalOrderInformation alloc]init];
//        [orderInfor setUserOrderStyle:XCAPPOrderHotelForStyle];
//        
//        PaySuccessfulViewController *viewController =[[PaySuccessfulViewController alloc]initWithOderInfor:orderInfor];
//        [viewController setHidesBottomBarWhenPushed:YES];
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
    
    ///密码修改
    else if (KBtnForSetPWDButtonTag == button.tag){
        SetPasswordViewController  *viewController = [[SetPasswordViewController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    ///手机号码
    else if (KBtnForSetPhoneButtonTag == button.tag){
        
        
        if (IsNormalMobileNum(KXCAPPCurrentUserInformation.userPerPhoneNumberStr)) {
            BundlePhoneFinishViewController *viewController = [[BundlePhoneFinishViewController alloc]initWithUserPhoneStr:KXCAPPCurrentUserInformation.userPerPhoneNumberStr];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:viewController animated:YES];

        }else{
            BundlePhoneController *viewController = [[BundlePhoneController alloc]initWithUserHasBundlePhone:NO];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:viewController animated:YES];
        }
//        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",KAPPCustomerServiceTelephoneStr];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    ///设置
    else if (KBtnForSetupButtonTag == button.tag){
        
        
        SetupViewController *viewController = [[SetupViewController alloc]init];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
//    ///新功能介绍
//    else if (KBtnForNewFunctionButtonTag == button.tag){
//        BundlePhoneController *viewController = [[BundlePhoneController alloc]initWithUserHasBundlePhone:YES];
//        [viewController setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
    
    ///联系客服
    else if (KBtnForCustomerTelButtonTag == button.tag){
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",KAPPCustomerServiceTelephoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        
        

    }
}


- (void)userIntoPersonalFromOtherRefreshDataNotification:(NSNotification *)notification{
    
    
    ////处理刷新界面数据内容
    NSLog(@"处理刷新界面数据内容 ");
    
    NSURL *url = [NSURL URLWithString:@"http://7xryr0.com2.z0.glb.qiniucdn.com/DynamicImage/30DABB01-98E6-4674-8B62-CBD9C42E8105"];
    [self.userPersonalPhotoImageView setImageWithURL:url placeholderImage:KUIImageViewDefaultImage];
    [self.userPersonalNameLabel setText:KXCAPPCurrentUserInformation.userNickNameStr];
    [self.userPersonalSurplusMoneyLabel setText:[NSString stringWithFormat:@"%.0lf 元",KXCAPPCurrentUserInformation.userAccountBalanceFloat]];
    NSRange moneyRange=[self.userPersonalSurplusMoneyLabel.text rangeOfString:@"元"];
    NSMutableAttributedString *moneyContent=[[NSMutableAttributedString alloc]initWithString:self.userPersonalSurplusMoneyLabel.text];
    [moneyContent addAttribute:NSFontAttributeName value:KXCAPPUIContentFontSize(14.0f) range:moneyRange];
    [moneyContent addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:moneyRange];
    [self.userPersonalSurplusMoneyLabel setAttributedText:moneyContent];
    
    if (IsNormalMobileNum(KXCAPPCurrentUserInformation.userPerPhoneNumberStr)) {
        [self.userPersonalPhoneNumberLabel setText:KXCAPPCurrentUserInformation.userPerPhoneNumberStr];
        NSString *tel = [self.userPersonalPhoneNumberLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [self.userPersonalPhoneNumberLabel setText:tel];
    }else{
        [self.userPersonalPhoneNumberLabel setText:@"绑定"];
    }
}

- (void)BundleAndUnbundlePhoneOperationNotification:(NSNotification *)notification{
    
    if (IsNormalMobileNum(KXCAPPCurrentUserInformation.userPerPhoneNumberStr)) {
        [self.userPersonalPhoneNumberLabel setText:KXCAPPCurrentUserInformation.userPerPhoneNumberStr];
        NSString *tel = [self.userPersonalPhoneNumberLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [self.userPersonalPhoneNumberLabel setText:tel];
        
        NSLog(@"绑定手机号成功，并将手机号模糊化处理");
    }else{
        
        NSLog(@"解除绑定手机号操作成功，用户可宠幸进行绑定操作");
        [self.userPersonalPhoneNumberLabel setText:@"绑定"];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == KAlertForLogoutAlertTag) {
        
        if (buttonIndex != 0) {
            [self userPersonalLogoOutOperationRequestion];
        }
    }
}

- (void)userPersonalLogoOutOperationRequestion{
    
    WaittingMBProgressHUD(HUIKeyWindow, @"正在退出...");
    [XCAPPHTTPClient userLogoutRequestWithUserId:KXCAPPCurrentUserInformation.userPerId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                FinishMBProgressHUD(HUIKeyWindow);
                ///清空数据，
                [KXCAPPCurrentUserInformation initUserLogOutFinishAndClearUserInfor];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserLogoutSuccessFinishNotification
                                                                    object:nil];
            }
        });
    }];
}



- (void)userPersonalCheckPersonalAccountInforOperationNotification:(NSNotification *)notification{
    [self userPersonalCheckPersonalAccountInforWithUserIdRequestion];
}
#pragma mark -
#pragma mark -  用户查找个人账户信息
///用户查找个人账户信息
- (void)userPersonalCheckPersonalAccountInforWithUserIdRequestion{
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userPersonalCheckPersonalAccountInforWithUserId:KXCAPPCurrentUserInformation.userPerId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject,KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDictionary = ObjForKeyInUnserializedJSONDic(response.responseObject,KDataKeyData);
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"account_amt") isKindOfClass:[NSNumber class]]) {
                        
                        CGFloat accountAmt = FloatForKeyInUnserializedJSONDic(dataDictionary,@"account_amt");
                        NSLog(@"【最后账户内容，】最新账户余额为 %.1lf 元",accountAmt);
                        [KXCAPPCurrentUserInformation setUserAccountBalanceFloat:accountAmt];
                        [weakSelf resetUserPersonalAccountInfor];
                    }
                }
            }
        });
    }];
}


- (void)resetUserPersonalAccountInfor{
    [self.userPersonalSurplusMoneyLabel setText:[NSString stringWithFormat:@"%.1lf 元",KXCAPPCurrentUserInformation.userAccountBalanceFloat]];
    NSRange moneyRange=[self.userPersonalSurplusMoneyLabel.text rangeOfString:@"元"];
    NSMutableAttributedString *moneyContent=[[NSMutableAttributedString alloc]initWithString:self.userPersonalSurplusMoneyLabel.text];
    [moneyContent addAttribute:NSFontAttributeName value:KXCAPPUIContentFontSize(14.0f) range:moneyRange];
    [moneyContent addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:moneyRange];
    [self.userPersonalSurplusMoneyLabel setAttributedText:moneyContent];
}
@end
