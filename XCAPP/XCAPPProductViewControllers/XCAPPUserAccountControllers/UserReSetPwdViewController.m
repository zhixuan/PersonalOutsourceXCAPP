//
//  UserReSetPwdViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UserReSetPwdViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"

#define KUserTextFieldNewPwdTag                 (1890112)

#define KUserTextFieldEnsurePwdTag              (1890113)

@interface UserReSetPwdViewController ()<UITextFieldDelegate>

/*!
 * @breif 新密码输入框
 * @See
 */
@property (nonatomic , weak)      UITextField                   *userNewPwdField ;

/*!
 * @breif 确认密码输入框
 * @See
 */
@property (nonatomic , weak)      UITextField                   *userEnsurePwdField ;
@end

@implementation UserReSetPwdViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE;
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
    
    [self settingNavTitle:@"密码修改"];
    
    [self setRightNavButtonTitleStr:@"完成" withFrame:kNavBarButtonRect
                       actionTarget:self action:@selector(rightButtonOperationEvent)];
    
    [self setupUserReSetPwdViewControllerFrame];
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

- (void)setupUserReSetPwdViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    UILabel *alertLabel = [[UILabel alloc]init];
    [alertLabel setBackgroundColor:[UIColor clearColor]];
    [alertLabel setFont:KXCAPPUIContentFontSize(12.0f)];
    [alertLabel setTextAlignment:NSTextAlignmentCenter];
    [alertLabel setTextColor:KSubTitleTextColor];
    [alertLabel setText:@"首次进入 请修改密码"];
    [alertLabel setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth, KProjectScreenWidth, KFunctionModulButtonHeight)];
    [mainView addSubview:alertLabel];
    
    ///新密码信息
    UIView *newPwdView = [[UIView alloc]init];
    [newPwdView setBackgroundColor:[UIColor whiteColor]];
    [newPwdView setFrame:CGRectMake(0.0f, (alertLabel.bottom + KInforLeftIntervalWidth),
                                    KProjectScreenWidth,
                                    (KFunctionModulButtonHeight*2+0.5))];
    [mainView addSubview:newPwdView];
    UILabel *newPsword = [[UILabel alloc]init];
    [newPsword setBackgroundColor:[UIColor clearColor]];
    [newPsword setFont:KFunctionModuleContentFont];
    [newPsword setTextAlignment:NSTextAlignmentLeft];
    [newPsword setTextColor:KContentTextColor];
    [newPsword setText:@"新密码"];
    [newPsword setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, 80.0f, KFunctionModulButtonHeight)];
    [newPwdView addSubview:newPsword];
    
    UITextField *newPswdField = [[UITextField alloc]init];
    [newPswdField setFrame:CGRectMake(KXCUIControlSizeWidth(128.0f), 0.0f,
                                      KXCUIControlSizeWidth(220.0f), KFunctionModulButtonHeight)];
    [newPswdField setTag:KUserTextFieldNewPwdTag];
    [newPswdField setDelegate:self];
    [newPswdField setSecureTextEntry:YES];
    [newPswdField setFont:KFunctionModuleContentFont];
    [newPswdField setTextAlignment:NSTextAlignmentLeft];
    [newPswdField setTextColor:KFunContentColor];
    [newPswdField setReturnKeyType:UIReturnKeyNext];
    [newPswdField setPlaceholder:@"必须为6~20位字母或数字"];
    newPswdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"必须为6~20位字母或数字" attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [newPswdField setClearButtonMode:UITextFieldViewModeAlways];
    self.userNewPwdField = newPswdField;
    [newPwdView addSubview:self.userNewPwdField];
    
    UIView *sepView = [[UIView alloc]init];
    [sepView setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight, KProjectScreenWidth, 0.5f)];
    [sepView setBackgroundColor:KSepLineColorSetup];
    [newPwdView addSubview:sepView];
    
    UILabel *ensurePsword = [[UILabel alloc]init];
    [ensurePsword setBackgroundColor:[UIColor clearColor]];
    [ensurePsword setFont:KFunctionModuleContentFont];
    [ensurePsword setTextAlignment:NSTextAlignmentLeft];
    [ensurePsword setTextColor:KContentTextColor];
    [ensurePsword setText:@"确认新密码"];
    [ensurePsword setFrame:CGRectMake(KInforLeftIntervalWidth, (sepView.bottom), 120.0f, KFunctionModulButtonHeight)];
    [newPwdView addSubview:ensurePsword];
    
    UITextField *ensurePswdField = [[UITextField alloc]init];
    [ensurePswdField setFrame:CGRectMake(KXCUIControlSizeWidth(128.0f), (sepView.bottom),
                                         KXCUIControlSizeWidth(220.0f), KFunctionModulButtonHeight)];
    [ensurePswdField setTag:KUserTextFieldEnsurePwdTag];
    [ensurePswdField setDelegate:self];
    [ensurePswdField setSecureTextEntry:YES];
    [ensurePswdField setFont:KFunctionModuleContentFont];
    [ensurePswdField setTextAlignment:NSTextAlignmentLeft];
    [ensurePswdField setTextColor:KFunContentColor];
    [ensurePswdField setReturnKeyType:UIReturnKeyDone];
    [ensurePswdField setPlaceholder:@"请再次输入密码"];
    ensurePswdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入密码" attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [ensurePswdField setClearButtonMode:UITextFieldViewModeAlways];
    self.userEnsurePwdField = ensurePswdField;
    [newPwdView addSubview:self.userEnsurePwdField];
}


- (void)rightButtonOperationEvent{

    
    if (IsStringEmptyOrNull(self.userNewPwdField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"新密码不能为空");
        return;
    }
    
    NSUInteger pswdSize = [self.userNewPwdField.text length];
    if (pswdSize < 6 ||pswdSize > 20) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"必须为6~20位字母或数字");
        return;
    }
    
    if (IsStringEmptyOrNull(self.userEnsurePwdField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"确认密码不能为空");
        return;
    }
    
    if (![self.userEnsurePwdField.text isEqualToString:self.userNewPwdField.text]) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"两次输入的密码不同");
        [self.userEnsurePwdField setText:@""];
        return;
    }
    
    [self.view endEditing:YES];
    [self resetPasswordRequestOperation];
}



- (void)resetPasswordRequestOperation{
    
     WaittingMBProgressHUD(HUIKeyWindow, @"修改中...");
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userPersonalLoginFinishResetPwdWithUseId:KXCAPPCurrentUserInformation.userPerId password:self.userEnsurePwdField.text completion:^(WebAPIResponse *response) {
        
        
        NSLog(@"response.responseObject is %@",response.responseObject);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                
                FinishMBProgressHUD(HUIKeyWindow);
                [KXCShareFMSetting setUserLoginPasswordStr:weakSelf.userEnsurePwdField.text];
                [KXCShareFMSetting setUserPersonalOnceLoginSuccessBool:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserResetPasswrodFinishNotification
                                                                    object:nil];
                
                ///MARK:用户从其他模块进入“我的”模块时，刷新界面数据内容
                [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserIntoPersonalFromOtherRefreshDataNotification
                                                                    object:nil];
                //MARK:.初始化用户数据
            }
            
            else if (response.code == WebAPIResponseCodeFailed) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                
            }
            
            else if (response.code == WebAPIResponseCodeForceUpdateError){
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                
                //MARK:.重新登录操作逻辑
            }else{
                
//                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
//                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
//                    FailedMBProgressHUD(HUIKeyWindow,msg);
//                }
                
                FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                
            }
        });

    }];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == KUserTextFieldNewPwdTag){
        [self.userEnsurePwdField becomeFirstResponder];
    }
    else if (textField.tag == KUserTextFieldEnsurePwdTag){
        [self rightButtonOperationEvent];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
    BOOL txtlength = NO;
    if ([textField.text length] <= 20) {
        txtlength = YES;
    }
    BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
    return canChange;
}

@end
