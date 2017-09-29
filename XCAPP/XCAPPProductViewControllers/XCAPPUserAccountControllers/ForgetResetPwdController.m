//
//  ForgetResetPwdController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "ForgetResetPwdController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"


#define KUserTextFieldNewPwdTag                 (1890112)

@interface ForgetResetPwdController ()<UITextFieldDelegate>

/*!
 * @breif 用户个人密码输入框
 * @See
 */
@property (nonatomic , weak)            UITextField                 *userPerPasswrodTextField;

/*!
 * @breif 用户个人手机号
 * @See
 */
@property (nonatomic , strong)          NSString                    *userPersonalPhoneStr;

/*!
 * @breif 用户个人获取的验证码信息
 * @See
 */
@property (nonatomic , strong)          NSString                    *userPersonalVerCodeStr;

/*!
 * @breif 用户个人ID信息
 * @See
 */
@property (nonatomic , strong)          NSString                    *userPersonalID;
@end

@implementation ForgetResetPwdController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithPhoneStr:(NSString *)phoneStr verCode:(NSString *)codeStr userID:(NSString *)userIdStr{
    self = [super init];
    if (self) {
        self.userPersonalPhoneStr = [[NSString alloc]initWithFormat:@"%@",phoneStr];
        self.userPersonalVerCodeStr  = [[NSString alloc]initWithFormat:@"%@",codeStr];
        self.userPersonalID = [[NSString alloc]initWithFormat:@"%@",userIdStr];
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
    
    [self settingNavTitle:@"重置密码2/2"];
    
    [self setupForgetResetPwdControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupForgetResetPwdControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];

    
    ///新密码信息
    UIView *newPwdView = [[UIView alloc]init];
    [newPwdView setBackgroundColor:[UIColor whiteColor]];
    [newPwdView setFrame:CGRectMake(KInforLeftIntervalWidth,KInforLeftIntervalWidth,
                                    (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                    (KFunctionModulButtonHeight))];
    [mainView addSubview:newPwdView];
    
    UITextField *newPswdField = [[UITextField alloc]init];
    [newPswdField setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                      (newPwdView.width - KInforLeftIntervalWidth*2),
                                      KFunctionModulButtonHeight)];
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
    self.userPerPasswrodTextField = newPswdField;
    [newPwdView addSubview:self.userPerPasswrodTextField];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundColor:[UIColor clearColor]];
    [nextBtn setTitle:@"重  置" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                       forState:UIControlStateNormal];
    [nextBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                 (newPwdView.bottom + KXCUIControlSizeWidth(30.0f)),
                                 (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                 KFunctionModulButtonHeight)];
    [nextBtn.layer setCornerRadius:5.0f];
    [nextBtn addTarget:self action:@selector(userPersonalResetPasswordEventClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [nextBtn.layer setMasksToBounds:YES];
    [mainView addSubview:nextBtn];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self userPersonalResetPasswordEventClicked];
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


- (void)userPersonalResetPasswordEventClicked{
    
    [self.view endEditing:YES];
    
    if (IsStringEmptyOrNull(self.userPerPasswrodTextField.text)) {
        
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"密码不能为空");
        return;
    }
    
    if ([self.userPerPasswrodTextField.text length] < 6) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"密码位数不能小于6位");
        return;
    }
    
    if ([self.userPerPasswrodTextField.text length] > 20) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"密码位数不能大于20位");
        return;
    }
    [self.view endEditing:YES];

    __weak __typeof(&*self)weakSelf = self;
    WaittingMBProgressHUD(HUIKeyWindow, @"正在设置密码...");
    [XCAPPHTTPClient userForgetPwdResetNewPassword:self.userPerPasswrodTextField.text userId:self.userPersonalID completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){

            
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                SuccessMBProgressHUD(HUIKeyWindow,@"重置成功，请重新登录！");
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
            
        });

    }];
}


@end
