//
//  BundlePhoneController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "BundlePhoneController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"

#define KBtnForPushVerCodeBtnTag                (1860111)
#define KBtnForFinishButtonTag                  (1860112)
#define KBtnForCallPhoneBtnTag                  (1860113)
//bottom
#define KBottomContentFontSize                  (12.0f)


#define KTextForPhoneContentTag                 (1210411)
#define KTextForVerCodeTag                      (1210412)

@interface BundlePhoneController ()<UITextFieldDelegate>

/*!
 * @breif 用户是否已经绑定了手机号了
 * @See 默认为NO，即未绑定手机号；=YES，则表示，已绑定手机号
 */
@property (nonatomic , assign)              BOOL            hasBundlePhoneBool;
/*!
 * @breif 界面信息提示
 * @See
 */
@property (nonatomic , weak)                UILabel         *alertShowDisplayLabel;

/*!
 * @breif 手机号头部信息
 * @See
 */
@property (nonatomic , weak)                UILabel         *phoneCountryCodeLabel;

/*!
 * @breif 手机号输入框
 * @See
 */
@property (nonatomic , weak)                UITextField         *phoneContentField;

/*!
 * @breif 验证码输入框
 * @See
 */
@property (nonatomic , weak)                UITextField         *phoneVerCodeField;

/*!
 * @breif 完成按键
 * @See
 */
@property (nonatomic , weak)                UIButton        *phoneFinishButton;

/*!
 * @breif 验证码按键
 * @See
 */
@property (nonatomic , weak)                UIButton        *phoneVerifyButton;

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

@implementation BundlePhoneController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithUserHasBundlePhone:(BOOL)hasBool{
    self = [super init];
    if (self) {
        self.hasBundlePhoneBool = hasBool;
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
    
    if (self.hasBundlePhoneBool) {
        [self settingNavTitle:@"解绑手机号码"];
    }else{
        [self settingNavTitle:@"绑定手机号"];
    }
    // Do any additional setup after loading the view.
    
    [self setupBundlePhoneControllrFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBundlePhoneControllrFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 60.0f)];
    
    
    UILabel *displayLabel = [[UILabel alloc]init];
    [displayLabel setBackgroundColor:[UIColor clearColor]];
    [displayLabel setFont:KXCAPPUIContentFontSize(12)];
    [displayLabel setTextColor:KSubTitleTextColor];
    [displayLabel setText:@"解除绑定后你将无法再使用手机号登录"];
    [displayLabel setTextAlignment:NSTextAlignmentLeft];
    self.alertShowDisplayLabel = displayLabel;
    [mainView addSubview:self.alertShowDisplayLabel];
    
    UIView *operationBGView = [[UIView alloc]init];
    [operationBGView setBackgroundColor:[UIColor clearColor]];
    [operationBGView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(300.0f))];
    [mainView addSubview:operationBGView];
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KFunctionModulButtonHeight*2+0.5)];
    [operationBGView addSubview:contentBGView];
    UILabel *countryCode = [[UILabel alloc]init];
    [countryCode setBackgroundColor:[UIColor clearColor]];
    [countryCode setTextColor:KSubTitleTextColor];
    [countryCode setFont:KFunctionModuleContentFont];
    [countryCode setTextAlignment:NSTextAlignmentLeft];
    [countryCode setText:@"+86"];
    [countryCode setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                     KXCUIControlSizeWidth(30.0f), KFunctionModulButtonHeight)];
    [contentBGView addSubview:countryCode];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KFunContentColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForPhoneContentTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"请输入手机号"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake((countryCode.right + KXCUIControlSizeWidth(30.0f)),
                                         0.0f, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
//    [phoneTextField setFont:KFunctionModuleContentFont];
    self.phoneContentField = phoneTextField;
    [contentBGView addSubview:self.phoneContentField];
    
    if (self.hasBundlePhoneBool) {
        [self.phoneContentField setText:KXCAPPCurrentUserInformation.userPerPhoneNumberStr];
        [self.phoneContentField setTextColor:KFunctionModuleContentColor];
        [self.phoneContentField setAllowsEditingTextAttributes:NO];
    }
    
    
    UIButton *verCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verCodeBtn setBackgroundColor:[UIColor clearColor]];
    [verCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [verCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verCodeBtn.titleLabel setFont:KFunctionModuleContentFont];
    [verCodeBtn addTarget:self action:@selector(buttonOperationEventClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [verCodeBtn setTag:KBtnForPushVerCodeBtnTag];
    [verCodeBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                          forState:UIControlStateNormal];
    [verCodeBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(90.0f) - KInforLeftIntervalWidth),
                                    KXCUIControlSizeWidth(7.0f), KXCUIControlSizeWidth(90.0f),
                                    (KFunctionModulButtonHeight - KXCUIControlSizeWidth(14.0f)))];
    [verCodeBtn.layer setCornerRadius:6.0f];
    [verCodeBtn.layer setMasksToBounds:YES];
    self.phoneVerifyButton = verCodeBtn;
    [contentBGView addSubview:self.phoneVerifyButton];
    
    
    UIView *sepView = [[UIView alloc]init];
    [sepView setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight, KProjectScreenWidth, 0.5f)];
    [sepView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepView];
    
    UITextField *verCodeTextField = [[UITextField alloc]init];
    [verCodeTextField setTextAlignment:NSTextAlignmentLeft];
    [verCodeTextField setTextColor:KFunContentColor];
    [verCodeTextField setKeyboardType:UIKeyboardTypePhonePad];
    [verCodeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [verCodeTextField setDelegate:self];
    [verCodeTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [verCodeTextField setTag:KTextForVerCodeTag];
    [verCodeTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [verCodeTextField setPlaceholder:@"请输入验证码"];
    verCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [verCodeTextField setFrame:CGRectMake(KInforLeftIntervalWidth,(sepView.bottom),
                                          (KProjectScreenWidth - KInforLeftIntervalWidth*3),
                                          KFunctionModulButtonHeight)];
//    [phoneTextField setFont:KFunctionModuleContentFont];
    self.phoneVerCodeField = verCodeTextField;
    [contentBGView addSubview:self.phoneVerCodeField];

    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setBackgroundColor:[UIColor clearColor]];
    [finishBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [finishBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [finishBtn setTag:KBtnForFinishButtonTag];
    [finishBtn setTitle:@"完   成" forState:UIControlStateNormal];
    [finishBtn.layer setCornerRadius:5.0f];
    [finishBtn addTarget:self action:@selector(buttonOperationEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [finishBtn.layer setMasksToBounds:YES];
    [finishBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (contentBGView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [operationBGView addSubview:finishBtn];
    
    
    NSString *bottomStr = [NSString stringWithFormat:@"无法收到验证码？请联系商旅客服：%@",KAPPCustomerServiceTelephoneStr];
    CGSize bottomSize = [bottomStr sizeWithFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    
    CGSize telPhoneSize = [KAPPCustomerServiceTelephoneStr sizeWithFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    [bottomLabel setBackgroundColor:[UIColor clearColor]];
    [bottomLabel setFont:KXCAPPUIContentFontSize(KBottomContentFontSize)];
    [bottomLabel setTextAlignment:NSTextAlignmentLeft];
    [bottomLabel setTextColor:KSubTitleTextColor];
    [bottomLabel setText:@"无法收到验证码？请联系商旅客服："];
    [bottomLabel setFrame:CGRectMake(((KProjectScreenWidth - bottomSize.width)/2),
                                     (finishBtn.bottom + KXCUIControlSizeWidth(40.0f)),
                                     (bottomSize.width - telPhoneSize.width), KXCUIControlSizeWidth(18))];
    [operationBGView addSubview:bottomLabel];
    
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
    [phoneBtn addTarget:self action:@selector(buttonOperationEventClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [phoneBtn setTitle:KAPPCustomerServiceTelephoneStr forState:UIControlStateNormal];
    [phoneBtn setFrame:CGRectMake(bottomLabel.right,
                                   (bottomLabel.top - 20.0f),
                                   telPhoneSize.width,
                                   (bottomLabel.height + 40.0f))];
    [operationBGView addSubview:phoneBtn];
    

    ///若已绑定手机号，则显示头部信息
    if (self.hasBundlePhoneBool) {
        [self.alertShowDisplayLabel setHidden:NO];
        [self.alertShowDisplayLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(8), (KProjectScreenWidth - KInforLeftIntervalWidth*2), KXCUIControlSizeWidth(18))];
        [operationBGView setTop:self.alertShowDisplayLabel.bottom + KXCUIControlSizeWidth(8.0f)];
    }
    ///若未绑定手机号，则隐藏头部信息
    else{
        [self.alertShowDisplayLabel setHidden:YES];
        [self.alertShowDisplayLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(5), (KProjectScreenWidth - KInforLeftIntervalWidth*2), 0.0f)];
        [operationBGView setTop: KInforLeftIntervalWidth];
    }
}



- (void)buttonOperationEventClicked:(UIButton *)button{

    ///发送验证码
    if (KBtnForPushVerCodeBtnTag == button.tag) {
        
        if (IsStringEmptyOrNull(self.phoneContentField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号不能为空!");
            return;
        }
        
        if (!IsNormalMobileNum(self.phoneContentField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号格式不正确！");
            return;
        }

        [self userSentMessageRequestion];
    }
    ///完成操作设置
    else if (KBtnForFinishButtonTag == button.tag){
    
        
        
        
        if (IsStringEmptyOrNull(self.phoneContentField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号不能为空!");
            return;
        }
        
        if (!IsNormalMobileNum(self.phoneContentField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"手机号格式不正确！");
            return;
        }
        
        if (IsStringEmptyOrNull(self.phoneVerCodeField.text)) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"验证码不能为空!");
            return;
        }
        
        if ([self.phoneVerCodeField.text length] != 6) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"验证码格式不正确！");
            return;
        }

        
        ///若存在手机号，进行解除操作
        if (self.hasBundlePhoneBool) {
            [self userPersonalFreeBundlePhoneOperationRequestion];
        }
        ///若不存在进行绑定操作
        else{
           [self userPersonalBundlePhoneRequestion];
        }
        
        

    }
    
    ///拨打电话
    else if (KBtnForCallPhoneBtnTag == button.tag){

        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",KAPPCustomerServiceTelephoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
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
    
    if (textField.tag == KTextForPhoneContentTag) {
        BOOL txtlength = NO;
        if ([textField.text length] <= 10) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }
    
    else if (textField.tag == KTextForVerCodeTag) {
        BOOL txtlength = NO;
        if ([textField.text length] <= 5) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }
    return YES;
}

////绑定手机号操作
- (void)userPersonalBundlePhoneRequestion{
    
    
    __weak __typeof(&*self)weakSelf = self;
    WaittingMBProgressHUD(HUIKeyWindow, @"正在处理信息...");
    [XCAPPHTTPClient userBundlePhoneWithUserId:KXCAPPCurrentUserInformation.userPerId
                                      phoneStr:self.phoneContentField.text
                                       verCode:self.phoneVerCodeField.text completion:^(WebAPIResponse *response) {
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^(void){
                                               
                                               NSLog(@"response.responseObject is %@",response.responseObject);
                                               
                                               if (response.code == WebAPIResponseCodeSuccessForHundred) {
                                                   
                                                   SuccessMBProgressHUD(HUIKeyWindow, @"绑定成功！");
                                                   
                                                   NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                                                   NSLog(@"responeDic 解析后的数据是%@",responeDic);
                                                   [KXCAPPCurrentUserInformation setUserPerPhoneNumberStr:weakSelf.phoneContentField.text];
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserBundleAndUnbundlePhoneSuccessFinishNotification
                                                                                                       object:nil];
//                                                   [weakSelf.navigationController popViewControllerAnimated:YES];
                                               }else{
                                                   if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                                                       NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                                                       FailedMBProgressHUD(HUIKeyWindow,msg);
                                                       NSLog(@"msg is %@",msg);
                                                   }
                                                   else{
                                                       FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                                                   }
                                               }
                                           });
                                       }];
}

////解除绑定手机号操作
- (void)userPersonalFreeBundlePhoneOperationRequestion{
    
    __weak __typeof(&*self)weakSelf = self;
    WaittingMBProgressHUD(HUIKeyWindow, @"正在解除绑定...");
    [XCAPPHTTPClient userCancelBundlePhoneWithUserId:KXCAPPCurrentUserInformation.userPerId
                                      phoneStr:self.phoneContentField.text
                                       verCode:self.phoneVerCodeField.text completion:^(WebAPIResponse *response) {
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^(void){
                                               NSLog(@"response.responseObject is %@",response.responseObject);
                                               
                                               if (response.code == WebAPIResponseCodeSuccessForHundred) {
                                                   
                                                   SuccessMBProgressHUD(HUIKeyWindow, @"解除绑定成功！");
                                                   
                                                   NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                                                   NSLog(@"responeDic 解析后的数据是%@",responeDic);
                                                   [KXCAPPCurrentUserInformation setUserPerPhoneNumberStr:@""];
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserBundleAndUnbundlePhoneSuccessFinishNotification
                                                                                                       object:nil];
                                                   [weakSelf.navigationController popToRootViewControllerAnimated:YES];
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


- (void)userSentMessageRequestion{
    
    if (IsStringEmptyOrNull(KXCAPPCurrentUserInformation.userPerId)) {
        return;
    }
    [self getCheckCode];
    
    NSString *msgTypeStr = @"3";
    
    ////当前已绑定，需要解绑验证码操作
    if (self.hasBundlePhoneBool) {
        msgTypeStr = @"3";
    }
    ////当前未绑定，需要发绑定验证码
    else{
        msgTypeStr = @"2";
    }
    
    WaittingMBProgressHUD(HUIKeyWindow, @"发送验证码...");
    __weak __typeof(&*self)weakSelf = self;
    [XCAPPHTTPClient userSentMessageCodeWithUserId:KXCAPPCurrentUserInformation.userPerId withType:msgTypeStr withPhoneNumber:self.phoneContentField.text completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"response.responseObject is %@",response.responseObject);
            
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                FinishMBProgressHUD(HUIKeyWindow);
                [weakSelf getCheckCode];
            }
            else{
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                    NSLog(@"msg is %@",msg);
                }else{
                    FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                }
            }
        });
    }];
}

- (void)getCheckCode {
    
    [self.phoneVerCodeField becomeFirstResponder];
    self.phoneVerifyButton.userInteractionEnabled=NO;
    
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
        [self.phoneVerifyButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.phoneVerifyButton.userInteractionEnabled=YES;
    }
    else
    {
        [self.phoneVerifyButton setTitle:[NSString stringWithFormat:@"%ld后重发",(long)self.currentSec] forState:UIControlStateNormal];
    }
    
    
}
@end
