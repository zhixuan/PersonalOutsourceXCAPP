//
//  UserLoginViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserReSetPwdViewController.h"
#import "ForgetPasswordViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"

#define KTextForPhoneFieldTag               (1390111)
#define KTextForPasswordFieldTag            (1390112)
#define KBtnForForgetPwdButtonTag           (1390113)
#define KBtnForLoginButtonTag               (1390114)

@interface UserLoginViewController ()<UITextFieldDelegate>
/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField                   *userPhoneField;

/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField                   *userPasswordField;
@end

@implementation UserLoginViewController


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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view.
    
    [self setupUserLoginViewControllerFrame];

    //用户修改密码成功操作通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userFinishResetPasswordNotification:) name:KXCAPPUserResetPasswrodFinishNotification object:nil];
}

- (void)userFinishResetPasswordNotification:(NSNotification *)notification{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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

- (void)setupUserLoginViewControllerFrame{
 
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(150.0f),
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KFunctionModulButtonHeight*2+0.5)];
    [contentBGView.layer setCornerRadius:3.0f];
    [contentBGView.layer setMasksToBounds:YES];
    [self.view addSubview:contentBGView];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KFunContentColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeDefault];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForPhoneFieldTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"请输入账户或者手机号"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入账户或者手机号"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake((KInforLeftIntervalWidth*2), 0.0f,
                                        (contentBGView.width - KInforLeftIntervalWidth*3),
                                        KFunctionModulButtonHeight)];
    self.userPhoneField = phoneTextField;
    [contentBGView addSubview:self.userPhoneField];


    UIView *sepView = [[UIView alloc]init];
    [sepView setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight, contentBGView.width, 0.5f)];
    [sepView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepView];
    
    UITextField *newPswdField = [[UITextField alloc]init];
    [newPswdField setFrame:CGRectMake(KInforLeftIntervalWidth*2, sepView.bottom,
                                      (contentBGView.width - KInforLeftIntervalWidth*3),
                                      KFunctionModulButtonHeight)];
    [newPswdField setTag:KTextForPasswordFieldTag];
    [newPswdField setDelegate:self];
    [newPswdField setSecureTextEntry:YES];
    [newPswdField setFont:KFunctionModuleContentFont];
    [newPswdField setTextAlignment:NSTextAlignmentLeft];
    [newPswdField setTextColor:KFunContentColor];
    [newPswdField setReturnKeyType:UIReturnKeyDone];
    [newPswdField setPlaceholder:@"请输入密码"];
    newPswdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [newPswdField setClearButtonMode:UITextFieldViewModeAlways];
    self.userPasswordField = newPswdField;
    [contentBGView addSubview:self.userPasswordField];
    
    
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setBackgroundColor:[UIColor clearColor]];
    [forgetPwdBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                        forState:UIControlStateNormal];
    [forgetPwdBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                        forState:UIControlStateHighlighted];
    [forgetPwdBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [forgetPwdBtn setTag:KBtnForForgetPwdButtonTag];
    [forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(userButtonOperationEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(90.0f) - KInforLeftIntervalWidth),
                                  (contentBGView.bottom + KXCUIControlSizeWidth(5.0f)),
                                  (KXCUIControlSizeWidth(90.0f)),
                                  KFunctionModulButtonHeight)];
    [self.view addSubview:forgetPwdBtn];

    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[UIColor clearColor]];
    [loginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [loginBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [loginBtn setTag:KBtnForLoginButtonTag];
    [loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
    [loginBtn.layer setCornerRadius:5.0f];
    [loginBtn addTarget:self action:@selector(userButtonOperationEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (forgetPwdBtn.bottom + KXCUIControlSizeWidth(5.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [self.view addSubview:loginBtn];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
   
//    
//    if (textField.tag == KTextForPhoneFieldTag) {
//        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
//        BOOL txtlength = NO;
//        if ([textField.text length] <= 10) {
//            txtlength = YES;
//        }
//        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
//        return canChange;
//    }
//    
//    else
    
        if (textField.tag == KTextForPasswordFieldTag) {
        
        BOOL txtlength = NO;
        if ([textField.text length] <= 19) {
            txtlength = YES;
        }
        return txtlength;
    }
    return YES;
}

- (void)userButtonOperationEventClicked:(UIButton *)button{
    
    
    
    if (KBtnForForgetPwdButtonTag == button.tag) {
        ForgetPasswordViewController *viewController = [[ForgetPasswordViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    else if (KBtnForLoginButtonTag){
        
        
        if (IsStringEmptyOrNull(self.userPhoneField.text)) {
            
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"账户或手机号不能为空");
            return;
        }
        
        if (IsStringEmptyOrNull(self.userPasswordField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"密码不能为空");
            return;
        }
        
        [self.view endEditing:YES];
        [self userLoginRequestOperation];
    }
}


- (void)userLoginRequestOperation{
 
    __weak __typeof(&*self)weakSelf = self;
    WaittingMBProgressHUD(HUIKeyWindow, @"正在登录...");
    [XCAPPHTTPClient userPersonalLoginWithPhoneStr:self.userPhoneField.text password:self.userPasswordField.text completion:^(WebAPIResponse *response) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
             NSLog(@"response.responseObject is %@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                
                FinishMBProgressHUD(HUIKeyWindow);

                NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                if (responeDic.count > 0) {
                    [KXCAPPCurrentUserInformation initUserLoginFinishInfor:responeDic];
                }
                
                ///持久化保存数据
                [KXCShareFMSetting setUserLoginPhoneNumberStr:weakSelf.userPhoneField.text];
                [KXCShareFMSetting setUserLoginPasswordStr:weakSelf.userPasswordField.text];
                
                
                
                if (KXCShareFMSetting.userPersonalOnceLoginSuccessBool) {
                    ///MARK:用户从其他模块进入“我的”模块时，刷新界面数据内容
                    [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserIntoPersonalFromOtherRefreshDataNotification
                                                                        object:nil];
                    [weakSelf dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }else{
                    //MARK:.初始化用户数据
                    UserReSetPwdViewController *viewController = [[UserReSetPwdViewController alloc]init];
                    [weakSelf.navigationController pushViewController:viewController animated:YES];
                }
            }
            
            else if (response.code == WebAPIResponseCodeFailed) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                ///持久化保存数据
                [KXCShareFMSetting setUserLoginPhoneNumberStr:weakSelf.userPhoneField.text];
                [KXCShareFMSetting setUserLoginPasswordStr:weakSelf.userPasswordField.text];
                //MARK:.初始化用户数据
                UserReSetPwdViewController *viewController = [[UserReSetPwdViewController alloc]init];
                [weakSelf.navigationController pushViewController:viewController animated:YES];
                
            }
            
            else if (response.code == WebAPIResponseCodeForceUpdateError){
//                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
//                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
//                    FailedMBProgressHUD(HUIKeyWindow,msg);
//                }
//                ///持久化保存数据
//                [KXCShareFMSetting setUserLoginPhoneNumberStr:weakSelf.userPhoneField.text];
//                [KXCShareFMSetting setUserLoginPasswordStr:weakSelf.userPasswordField.text];
//                //MARK:.初始化用户数据
//                UserReSetPwdViewController *viewController = [[UserReSetPwdViewController alloc]init];
//                [weakSelf.navigationController pushViewController:viewController animated:YES];
//                
//                //MARK:.重新登录操作逻辑
            }else{
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
        });

    }];
}

@end
