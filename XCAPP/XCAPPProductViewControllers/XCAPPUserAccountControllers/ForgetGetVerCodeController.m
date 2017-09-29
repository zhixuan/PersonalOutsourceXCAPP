//
//  ForgetGetVerCodeController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "ForgetGetVerCodeController.h"
#import "ForgetResetPwdController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"

#define KTextForUserVerCodeTag              (1820111)

#define KBtnForNextButtonTag                (1820112)
#define KBtnForVerCodeButtonTag             (1820113)
#define KBtnForCallPhoneButtonTag           (1820114)


#define KBottomContentFontSize              (12.0f)

@interface ForgetGetVerCodeController ()<UITextFieldDelegate>
/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField                   *userVerCodeField;


/*!
 * @breif 用户发送验证码操作按键
 * @See
 */
@property (nonatomic , weak)      UIButton                      *userVerCodeBtn;


/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , strong)      NSString                *userPersonalPhoneStr;
@end

@implementation ForgetGetVerCodeController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

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
    
    [self settingNavTitle:@"重置密码2/3"];
    [self setupForgetGetVerCodeControllerFrame];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupForgetGetVerCodeControllerFrame{
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    UILabel *alertPhoneLabel = [[UILabel alloc]init];
    [alertPhoneLabel setBackgroundColor:[UIColor clearColor]];
    [alertPhoneLabel setFont:KXCAPPUIContentFontSize(12.0f)];
    [alertPhoneLabel setTextColor:KContentTextColor];
    [alertPhoneLabel setTextAlignment:NSTextAlignmentLeft];
    [alertPhoneLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, KProjectScreenWidth - KInforLeftIntervalWidth*2, KXCUIControlSizeWidth(20))];
    [alertPhoneLabel setText:[NSString stringWithFormat:@"验证短信发送至%@",self.userPersonalPhoneStr]];
    [mainView addSubview:alertPhoneLabel];
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(KInforLeftIntervalWidth,(alertPhoneLabel.bottom + KInforLeftIntervalWidth),
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KFunctionModulButtonHeight)];
    [mainView addSubview:contentBGView];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KFunContentColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForUserVerCodeTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"短信验证码"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"短信验证码"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                        KXCUIControlSizeWidth(180.0f),
                                        KFunctionModulButtonHeight)];
    self.userVerCodeField = phoneTextField;
    [contentBGView addSubview:self.userVerCodeField];
    
    UIButton *verCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verCodeBtn setBackgroundColor:[UIColor clearColor]];
    [verCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [verCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verCodeBtn.titleLabel setFont:KFunctionModuleContentFont];
    [verCodeBtn addTarget:self action:@selector(userPersonalOperationButtonClickedEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [verCodeBtn setTag:KBtnForVerCodeButtonTag];
    [verCodeBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                          forState:UIControlStateNormal];
    [verCodeBtn setFrame:CGRectMake((contentBGView.width - KXCUIControlSizeWidth(90.0f)),
                                    0.0f, KXCUIControlSizeWidth(90.0f),
                                    (KFunctionModulButtonHeight))];
    self.userVerCodeBtn = verCodeBtn;
    [contentBGView addSubview:self.userVerCodeBtn];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundColor:[UIColor clearColor]];
    [nextBtn setTitle:@"下一步，验证手机" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                       forState:UIControlStateNormal];
    [nextBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                 (contentBGView.bottom + KXCUIControlSizeWidth(30.0f)),
                                 (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                 KFunctionModulButtonHeight)];
    [nextBtn.layer setCornerRadius:5.0f];
    [nextBtn setTag:KBtnForNextButtonTag];
    [nextBtn addTarget:self action:@selector(userPersonalOperationButtonClickedEvent:)
      forControlEvents:UIControlEventTouchUpInside];
    [nextBtn.layer setMasksToBounds:YES];
    [mainView addSubview:nextBtn];
    
    
    NSString *bottomStr = [NSString stringWithFormat:@"未绑定手机号无法找回密码？请致电商旅专线：%@",KAPPCustomerServiceTelephoneStr];
    CGSize bottomSize = [bottomStr sizeWithFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    
    CGSize telPhoneSize = [KAPPCustomerServiceTelephoneStr sizeWithFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    [bottomLabel setBackgroundColor:[UIColor clearColor]];
    [bottomLabel setFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    [bottomLabel setTextAlignment:NSTextAlignmentLeft];
    [bottomLabel setTextColor:KSubTitleTextColor];
    [bottomLabel setText:@"未绑定手机号无法找回密码？请致电商旅专线："];
    [bottomLabel setFrame:CGRectMake(((KProjectScreenWidth - bottomSize.width)/2),
                                     (nextBtn.bottom + KXCUIControlSizeWidth(40.0f)),
                                     (bottomSize.width - telPhoneSize.width), KXCUIControlSizeWidth(18))];
    [mainView addSubview:bottomLabel];
    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn setBackgroundColor:[UIColor clearColor]];
    [phoneBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                        forState:UIControlStateNormal];
    [phoneBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                        forState:UIControlStateHighlighted];
    [phoneBtn.titleLabel setFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    [phoneBtn setTitleColor:HUIRGBColor(50.0f, 113.0f, 230.0f, 1.0f) forState:UIControlStateNormal];
    [phoneBtn setTitleColor:HUIRGBColor(10.0f, 073.0f, 190.0f, 1.0f) forState:UIControlStateHighlighted];
    [phoneBtn setTag:KBtnForCallPhoneButtonTag];
    [phoneBtn addTarget:self action:@selector(userPersonalOperationButtonClickedEvent:)
       forControlEvents:UIControlEventTouchUpInside];
    [phoneBtn setTitle:KAPPCustomerServiceTelephoneStr forState:UIControlStateNormal];
    [phoneBtn setFrame:CGRectMake(bottomLabel.right,
                                  (bottomLabel.top - 20.0f),
                                  telPhoneSize.width,
                                  (bottomLabel.height + 40.0f))];
    [mainView addSubview:phoneBtn];

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
    
    NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
    if (textField.tag == KTextForUserVerCodeTag) {
        BOOL txtlength = NO;
        if ([textField.text length] <= 5) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }
    return YES;
}

- (void)userPersonalOperationButtonClickedEvent:(UIButton *)button{
    if (KBtnForVerCodeButtonTag == button.tag) {
        
    }
    
    else if (KBtnForNextButtonTag == button.tag){
        
        [self.view endEditing:YES];
        if (IsStringEmptyOrNull(self.userVerCodeField.text)) {
            
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"验证码不能为空");
            return;
        }
        
        if ([self.userVerCodeField.text length] != 6) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"验证码格式不正确");
            return;
        }

        
        ForgetResetPwdController *viewController = [[ForgetResetPwdController alloc]initWithPhoneStr:self.userPersonalPhoneStr verCode:self.userVerCodeField.text userID:@""];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    else if (KBtnForCallPhoneButtonTag == button.tag){
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",KAPPCustomerServiceTelephoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

@end
