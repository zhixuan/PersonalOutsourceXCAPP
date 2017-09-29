//
//  AddNewWorkerViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AddNewWorkerViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"


#define KTextForUserLoginNameTag        (1820111)
#define KTextForPhoneContentTag         (1820112)
#define KTextForUserNameStrTag          (1820113)

#define KBtnForAddUserTag               (1830111)

@interface AddNewWorkerViewController ()<UITextFieldDelegate>

/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField               *userPerLoginNameTextField;

/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField               *userPerMobileTextField;

/*!
 * @breif 用户姓名
 * @See
 */
@property (nonatomic , weak)      UITextField               *userPerNameTextField;
@end

@implementation AddNewWorkerViewController
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
    // Do any additional setup after loading the view.
    [self settingNavTitle:@"新增员工"];
    [self setupAddNewWorkerViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)setupAddNewWorkerViewControllerFrame{
 
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 60.0f)];

    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth, KProjectScreenWidth, KFunctionModulButtonHeight*3+1.0f)];
    [mainView addSubview:contentBGView];
    
    
    
    UILabel  *titleUserLoginNameLabel = [[UILabel alloc]init];
    [titleUserLoginNameLabel setBackgroundColor:[UIColor clearColor]];
    [titleUserLoginNameLabel setTextAlignment:NSTextAlignmentLeft];
    [titleUserLoginNameLabel setTextColor:KFunctionModuleContentColor];
    [titleUserLoginNameLabel setFont:KFunctionModuleContentFont];
    [titleUserLoginNameLabel setText:@"用户名"];
    [titleUserLoginNameLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 70.0f, KFunctionModulButtonHeight)];
    [contentBGView addSubview:titleUserLoginNameLabel];
    
    UITextField *userLoginNameField = [[UITextField alloc]init];
    [userLoginNameField setTextAlignment:NSTextAlignmentLeft];
    [userLoginNameField setTextColor:KFunContentColor];
    [userLoginNameField setReturnKeyType:UIReturnKeyNext];
    [userLoginNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userLoginNameField setDelegate:self];
    [userLoginNameField setTag:KTextForUserLoginNameTag];
    [userLoginNameField setFont:KXCAPPUIContentFontSize(17.0f)];
    [userLoginNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [userLoginNameField setPlaceholder:@"员工登录账户用户名"];
    userLoginNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"员工登录账户用户名"
                                                                          attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [userLoginNameField setFrame:CGRectMake((titleUserLoginNameLabel.right + KXCUIControlSizeWidth(10.0f)),
                                       0.0f,
                                       (KProjectScreenWidth - (titleUserLoginNameLabel.right + KXCUIControlSizeWidth(10.0f)) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    self.userPerLoginNameTextField = userLoginNameField;
    [contentBGView addSubview:self.userPerLoginNameTextField];
    
    
    UIView *sepView = [[UIView alloc]init];
    [sepView setFrame:CGRectMake(0.0f, userLoginNameField.bottom, KProjectScreenWidth, 0.5f)];
    [sepView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepView];

    
    UILabel  *titlePhoneLabel = [[UILabel alloc]init];
    [titlePhoneLabel setBackgroundColor:[UIColor clearColor]];
    [titlePhoneLabel setTextAlignment:NSTextAlignmentLeft];
    [titlePhoneLabel setTextColor:KFunctionModuleContentColor];
    [titlePhoneLabel setFont:KFunctionModuleContentFont];
    [titlePhoneLabel setText:@"手机号"];
    [titlePhoneLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth, sepView.bottom, 70.0f, KFunctionModulButtonHeight)];
    [contentBGView addSubview:titlePhoneLabel];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KFunContentColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForPhoneContentTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(17.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"请输入手机号"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake((titlePhoneLabel.right + KXCUIControlSizeWidth(10.0f)),
                                        
                                    sepView.bottom,
                                        (KProjectScreenWidth - (titlePhoneLabel.right + KXCUIControlSizeWidth(10.0f)) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    self.userPerMobileTextField = phoneTextField;
    [contentBGView addSubview:self.userPerMobileTextField];

    
    UIView *sepPhoeView = [[UIView alloc]init];
    [sepPhoeView setFrame:CGRectMake(0.0f, phoneTextField.bottom, KProjectScreenWidth, 0.5f)];
    [sepPhoeView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepPhoeView];
    
    UILabel  *titleUserNameLabel = [[UILabel alloc]init];
    [titleUserNameLabel setBackgroundColor:[UIColor clearColor]];
    [titleUserNameLabel setTextAlignment:NSTextAlignmentLeft];
    [titleUserNameLabel setTextColor:KFunctionModuleContentColor];
    [titleUserNameLabel setFont:KFunctionModuleContentFont];
    [titleUserNameLabel setText:@"姓名"];
    [titleUserNameLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,sepPhoeView.bottom, 70.0f, KFunctionModulButtonHeight)];
    [contentBGView addSubview:titleUserNameLabel];
    
    UITextField *userNameField = [[UITextField alloc]init];
    [userNameField setTextAlignment:NSTextAlignmentLeft];
    [userNameField setTextColor:KFunContentColor];
//    [userNameField setKeyboardType:UIKeyboard];
    [userNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userNameField setDelegate:self];
    [userNameField setReturnKeyType:UIReturnKeyDone];
    [userNameField setTag:KTextForUserNameStrTag];
    [userNameField setFont:KXCAPPUIContentFontSize(17.0f)];
    [userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [userNameField setPlaceholder:@"中文/英文名"];
    userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"中文/英文名"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [userNameField setFrame:CGRectMake((titleUserNameLabel.right + KXCUIControlSizeWidth(10.0f)),
                                        sepPhoeView.bottom,
                                        (KProjectScreenWidth - (titleUserNameLabel.right + KXCUIControlSizeWidth(10.0f)) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    self.userPerNameTextField = userNameField;
    [contentBGView addSubview:self.userPerNameTextField];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setBackgroundColor:[UIColor clearColor]];
    [finishBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                         forState:UIControlStateNormal];
//    [finishBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
//                         forState:UIControlStateHighlighted];
    [finishBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [finishBtn setTag:KBtnForAddUserTag];
    [finishBtn setTitle:@"新 增" forState:UIControlStateNormal];
    [finishBtn.layer setCornerRadius:5.0f];
    [finishBtn addTarget:self action:@selector(buttonOperationEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [finishBtn.layer setMasksToBounds:YES];
    [finishBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (contentBGView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [mainView addSubview:finishBtn];
}


#pragma mark -
#pragma mark -  Method For UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == KTextForUserLoginNameTag) {
        [self.userPerMobileTextField becomeFirstResponder];
    }
    else if (textField.tag == KTextForUserNameStrTag){
        [self buttonOperationEventClicked:nil];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    
    if (1 == range.length) {//按下回格键
        return YES;
    }

    if (textField.tag == KTextForPhoneContentTag) {
        
        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
        
        BOOL txtlength = NO;
        if ([textField.text length] <= 10) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }

    return YES;
}

- (void)buttonOperationEventClicked:(UIButton *)button{
    
    
    if (IsStringEmptyOrNull(self.userPerLoginNameTextField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow, @"用户登录名不能为空！");
        return;
    }

    
    if (IsStringEmptyOrNull(self.userPerMobileTextField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow, @"手机号不能为空！");
        return;
    }
    
    if (!IsNormalMobileNum(self.userPerMobileTextField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow, @"手机号格式不正确！");
        return;
    }
    
    if (IsStringEmptyOrNull(self.userPerNameTextField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow, @"名字不能为空！");
        return;
    }
    
    NSLog(@"对了呢");
    [self addWorkRequestOperation];
}

- (void)addWorkRequestOperation{
    
    WaittingMBProgressHUD(HUIKeyWindow, @"正在添加...");
    UserInformationClass *userinfor = [[UserInformationClass alloc]init];
    [userinfor setUserNameStr:self.userPerNameTextField.text];
    [userinfor setUserPerPhoneNumberStr:self.userPerMobileTextField.text];
    [userinfor setUserNickNameStr:self.userPerLoginNameTextField.text];
    
    [XCAPPHTTPClient userAddWorkerUserInforWithUserId:KXCAPPCurrentUserInformation.userPerId companyId:@"1038845" worker:userinfor completion:^(WebAPIResponse *response) {

        
        NSLog(@"response.responseObject is %@",response.responseObject);

        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                
                FinishMBProgressHUD(HUIKeyWindow);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserAddNewWorkerSuccessFinishNotification
                                                                    object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            else if (response.code == WebAPIResponseCodeFailed) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                
            }else{
                FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
            }
        });
    }];
}

@end
