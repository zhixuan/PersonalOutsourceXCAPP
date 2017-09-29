//
//  ForgetPasswordViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetGetVerCodeController.h"
#import "ForgetResetPwdController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"


#define KTextForUserPhoneFieldTag           (1820111)
#define KTextForUserVerCodeTag              (1820112)
#define KBtnForVerCodeButtonTag             (1820113)
#define KBtnForNextButtonTag                (1820114)
#define KBtnForCallPhoneBtnTag              (1820115)



#define KBottomContentFontSize              (12.0f)


@interface ForgetPasswordViewController ()<UITextFieldDelegate>
/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField                   *userPhoneField;
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
 * @breif 找回密码者用户ID
 * @See
 */
@property (nonatomic , copy)      NSString                      *userPersonalReqId;

/*!
 * @breif 倒计时处理
 * @See
 */
@property (nonatomic,strong)           NSTimer               *timer;

/*!
 * @breif 倒计时读秒
 * @See
 */
@property (nonatomic,assign)           NSInteger             currentSec;

@end

@implementation ForgetPasswordViewController


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
    
    [self settingNavTitle:@"重置密码1/2"];
    [self setupForgetPasswordViewControllerFrame];
    // Do any additional setup after loading the view.
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

- (void)setupForgetPasswordViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];

    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KFunctionModulButtonHeight)];
    [mainView addSubview:contentBGView];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KFunContentColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForUserPhoneFieldTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"注册或者绑定的手机号"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"注册或者绑定的手机号"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake((KInforLeftIntervalWidth), 0.0f,
                                        (contentBGView.width - KInforLeftIntervalWidth*2),
                                        KFunctionModulButtonHeight)];
    self.userPhoneField = phoneTextField;
    [contentBGView addSubview:self.userPhoneField];
    
    UIView *verCodeBGView = [[UIView alloc]init];
    [verCodeBGView setBackgroundColor:[UIColor whiteColor]];
    [verCodeBGView setFrame:CGRectMake(KInforLeftIntervalWidth,(contentBGView.bottom + KInforLeftIntervalWidth),
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                       KFunctionModulButtonHeight)];
    [mainView addSubview:verCodeBGView];
    
    UITextField *verCodeTextField = [[UITextField alloc]init];
    [verCodeTextField setTextAlignment:NSTextAlignmentLeft];
    [verCodeTextField setTextColor:KFunContentColor];
    [verCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [verCodeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [verCodeTextField setDelegate:self];
    [verCodeTextField setTag:KTextForUserVerCodeTag];
    [verCodeTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [verCodeTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [verCodeTextField setPlaceholder:@"短信验证码"];
    verCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"短信验证码"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [verCodeTextField setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                        KXCUIControlSizeWidth(180.0f),
                                        KFunctionModulButtonHeight)];
    self.userVerCodeField = verCodeTextField;
    [verCodeBGView addSubview:self.userVerCodeField];
    
    UIButton *verCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verCodeBtn setBackgroundColor:[UIColor clearColor]];
    [verCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [verCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verCodeBtn.titleLabel setFont:KFunctionModuleContentFont];
    [verCodeBtn addTarget:self action:@selector(userPersonalBtnOperationEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [verCodeBtn setTag:KBtnForVerCodeButtonTag];
    [verCodeBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                          forState:UIControlStateNormal];
    [verCodeBtn setFrame:CGRectMake((contentBGView.width - KXCUIControlSizeWidth(90.0f)),
                                    0.0f, KXCUIControlSizeWidth(90.0f),
                                    (KFunctionModulButtonHeight))];
    self.userVerCodeBtn = verCodeBtn;
    [verCodeBGView addSubview:self.userVerCodeBtn];

    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundColor:[UIColor clearColor]];
    [nextBtn setTitle:@"下一步，验证手机" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                           forState:UIControlStateNormal];
    [nextBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                     (verCodeBGView.bottom + KXCUIControlSizeWidth(30.0f)),
                                     (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                     KFunctionModulButtonHeight)];
    [nextBtn.layer setCornerRadius:5.0f];
    [nextBtn setTag:KBtnForNextButtonTag];
    [nextBtn addTarget:self action:@selector(userPersonalBtnOperationEvent:)
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
    [phoneBtn setTag:KBtnForCallPhoneBtnTag];
    [phoneBtn addTarget:self action:@selector(userPersonalBtnOperationEvent:)
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
    
    if (textField.tag == KTextForUserPhoneFieldTag) {
        BOOL txtlength = NO;
        if ([textField.text length] <= 10) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }
    else  if (textField.tag == KTextForUserVerCodeTag) {
        BOOL txtlength = NO;
        if ([textField.text length] <= 5) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }

    return YES;
}


- (void)userPersonalBtnOperationEvent:(UIButton *)button{
    
    if (KBtnForVerCodeButtonTag == button.tag){

        if (IsStringEmptyOrNull(self.userPhoneField.text)) {
            
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号不能为空");
            return;
        }
        
        if (!IsNormalMobileNum(self.userPhoneField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号格式不正确");
            return;
        }
        NSLog(@"获取验证码信息");
        
        ///找回密码中，验证手机，并发送验证码
        [self forgetPasswordVerPhoneAndSendVerCodeRequest];

    }else if(KBtnForNextButtonTag == button.tag){
        NSLog(@"go to Next Operation");
        
        
        if (IsStringEmptyOrNull(self.userPhoneField.text)) {
            
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号不能为空");
            return;
        }
        
        if (!IsNormalMobileNum(self.userPhoneField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号格式不正确");
            return;
        }
        
        if (IsStringEmptyOrNull(self.userVerCodeField.text)) {
            
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"验证码不能为空");
            return;
        }
        
        if ([self.userVerCodeField.text length] != 6) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"验证码格式不正确");
            return;
        }

        
        [self.view endEditing:YES];
        ///验证验证码操作
        [self userChecVerCodeRequestAndNext];
        
    }
    
    else if (KBtnForCallPhoneBtnTag == button.tag){
        
        [self.view endEditing:YES];
        NSLog(@"call Phone Operation");
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",KAPPCustomerServiceTelephoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}

////找回密码中，验证手机，并发送验证码
- (void)forgetPasswordVerPhoneAndSendVerCodeRequest{
    
    WaittingMBProgressHUD(HUIKeyWindow, @"发送验证码...");
     __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userSentMessageCodeWithUserId:@"" withType:@"1" withPhoneNumber:self.userPhoneField.text completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                
                FinishMBProgressHUD(HUIKeyWindow);
                NSLog(@"response.responseObject is %@",response.responseObject);
                [weakSelf getCheckCode];
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"userid") isKindOfClass:[NSString class]]) {
                        NSString *userIdStr = StringForKeyInUnserializedJSONDic(dataDictionary, @"userid");
                        weakSelf.userPersonalReqId = [[NSString alloc]initWithFormat:@"%@",userIdStr];
                    }
                    ///没有用户ID时出错
                    else{
                        FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                    }

                }
                ///没有data数据时出错
                else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
            
            ///出现错误数据返回时
            else{
                ///有错误内容反馈时
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
                ///默认数据错误
                else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
        });
    }];
}

///验证验证码操作
- (void)userChecVerCodeRequestAndNext{
    WaittingMBProgressHUD(HUIKeyWindow, @"验证中...");
    __weak __typeof(&*self)weakSelf = self;
    
    [XCAPPHTTPClient userPersonalCheckVerCodeWithUserId:self.userPersonalReqId verCode:self.userVerCodeField.text completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                
                FinishMBProgressHUD(HUIKeyWindow);
                
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                ForgetResetPwdController *viewController = [[ForgetResetPwdController alloc]initWithPhoneStr:weakSelf.userPhoneField.text verCode:weakSelf.userVerCodeField.text userID:weakSelf.userPersonalReqId];
                [weakSelf.navigationController pushViewController:viewController animated:YES];
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


- (void)getCheckCode {
    
    [self.userVerCodeField becomeFirstResponder];
    self.userVerCodeBtn.userInteractionEnabled=NO;
    
    self.currentSec=60;
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timeChange
{
    
    NSLog(@"self.currentSec is %zi",self.currentSec);
    self.currentSec--;
    if (self.currentSec<=0) {
        [self.timer invalidate];
        [self.userVerCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.userVerCodeBtn.userInteractionEnabled=YES;
    }
    else
    {
        [self.userVerCodeBtn setTitle:[NSString stringWithFormat:@"%ld后重发",(long)self.currentSec] forState:UIControlStateNormal];
    }
}
@end
