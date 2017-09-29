//
//  RelatedCNTViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "RelatedCNTViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"

#define KTextForRailwayAccountTextTag           (1380111)
#define KTextForRailwayAccountPwdTextTag        (1380112)

#define KBtnForRelatedButtonTag                 (1380113)

@interface RelatedCNTViewController ()<UITextFieldDelegate>


/*!
 * @breif 12306账户输入框
 * @See
 */
@property (nonatomic , weak)                UITextField         *railwayAccountContentField;

/*!
 * @breif 12306账户密码
 * @See
 */
@property (nonatomic , weak)                UITextField         *railwayAccountPasswordField;

@end

@implementation RelatedCNTViewController
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
    
    [self settingNavTitle:@"关联12306"];
    [self setupRelatedCNTViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRelatedCNTViewControllerFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    UILabel *showLabel = [[UILabel alloc]init];
    [showLabel setBackgroundColor:[UIColor clearColor]];
    [showLabel setText:@"请确保12306账号和密码的有效性，否则可能导致出票失败。"];
    [showLabel setTextColor:KContentTextColor];
    [showLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [showLabel setNumberOfLines:0];
    [showLabel setTextAlignment:NSTextAlignmentLeft];
    [showLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize showSize = [showLabel.text sizeWithFont:showLabel.font
                                 constrainedToSize:CGSizeMake(KProjectScreenWidth - KInforLeftIntervalWidth*2,
                                                              CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    [showLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, (KProjectScreenWidth - KInforLeftIntervalWidth*2),showSize.height)];
    [mainView addSubview:showLabel];
    
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, (KInforLeftIntervalWidth + showLabel.bottom),
                                       (KProjectScreenWidth),
                                       (KFunctionModulButtonHeight*3+KInforLeftIntervalWidth*2))];
    [contentBGView.layer setCornerRadius:5.0f];
    [contentBGView.layer setMasksToBounds:YES];
    [mainView addSubview:contentBGView];
    
    UITextField *accountTextField = [[UITextField alloc]init];
    [accountTextField setTextAlignment:NSTextAlignmentLeft];
    [accountTextField setTextColor:KFunContentColor];
    [accountTextField setKeyboardType:UIKeyboardTypeDefault];
    [accountTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [accountTextField setDelegate:self];
    [accountTextField setTag:KTextForRailwayAccountTextTag];
    [accountTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [accountTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [accountTextField setPlaceholder:@"请输入12306账户"];
    [accountTextField setReturnKeyType:UIReturnKeyNext];
    accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入12306账户"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [accountTextField setFrame:CGRectMake((KXCUIControlSizeWidth(80.0f)),
                                        0.0f, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
    self.railwayAccountContentField = accountTextField;
    [contentBGView addSubview:self.railwayAccountContentField];
    
    [self.railwayAccountPasswordField becomeFirstResponder];
    

    
    UIView *sepNearbyView = [[UIView alloc]init];
    [sepNearbyView setFrame:CGRectMake(0.0f, accountTextField.bottom, KProjectScreenWidth, 1.0f)];
    [sepNearbyView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepNearbyView];
    
    UITextField *accountPwdField = [[UITextField alloc]init];
    [accountPwdField setTextAlignment:NSTextAlignmentLeft];
    [accountPwdField setTextColor:KFunContentColor];
    [accountPwdField setKeyboardType:UIKeyboardTypeDefault];
    [accountPwdField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [accountPwdField setDelegate:self];
    [accountPwdField setSecureTextEntry:YES];
    [accountPwdField setTag:KTextForRailwayAccountPwdTextTag];
    [accountPwdField setFont:KXCAPPUIContentFontSize(18.0f)];
    [accountPwdField setReturnKeyType:UIReturnKeyDone];
    [accountPwdField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [accountPwdField setPlaceholder:@"请输入12306密码"];
    accountPwdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入12306密码"
                                                                             attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [accountPwdField setFrame:CGRectMake((KXCUIControlSizeWidth(80.0f)),
                                          sepNearbyView.bottom, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
    self.railwayAccountPasswordField = accountPwdField;
    [contentBGView addSubview:self.railwayAccountPasswordField];
    
    if (KXCShareFMSetting.userPersonalIsRelatedAccountBool) {
        if (!IsStringEmptyOrNull(KXCShareFMSetting.userPersonalRelatedAccountNameStr)) {
            [self.railwayAccountContentField setText:KXCShareFMSetting.userPersonalRelatedAccountNameStr];
        }
        
        [self.railwayAccountPasswordField becomeFirstResponder];
    }
    
    UIView *sepRelatedView = [[UIView alloc]init];
    [sepRelatedView setFrame:CGRectMake(0.0f, accountPwdField.bottom,
                                       KProjectScreenWidth, 1.0f)];
    [sepRelatedView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepRelatedView];
    
    UIButton *relatedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [relatedBtn setBackgroundColor:[UIColor clearColor]];
    [relatedBtn setBackgroundImage:createImageWithColor(KDefaultNavigationWhiteBackGroundColor)
                         forState:UIControlStateNormal];
    [relatedBtn setTag:KBtnForRelatedButtonTag];
    [relatedBtn setTitle:@"关联12306" forState:UIControlStateNormal];
    [relatedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [relatedBtn.layer setCornerRadius:5.0f];
    [relatedBtn addTarget:self action:@selector(userPersonalRelatedOperationEvent:)
        forControlEvents:UIControlEventTouchUpInside];
    [relatedBtn.layer setMasksToBounds:YES];
    [relatedBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (sepRelatedView.bottom + KInforLeftIntervalWidth),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [contentBGView addSubview:relatedBtn];
}


- (void)userPersonalRelatedOperationEvent:(UIButton *)button{
    
    
    if (IsStringEmptyOrNull(self.railwayAccountContentField.text)) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"12306账户不能为空");
        return;
    }
    
    if (IsStringEmptyOrNull(self.railwayAccountPasswordField.text)) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"12306账户密码不能为空");
        return;
    }
    
    [self userPersonalRelatedOperaionRequestion];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == KTextForRailwayAccountTextTag) {
        [self.railwayAccountPasswordField becomeFirstResponder];
    }
    else if (textField.tag == KTextForRailwayAccountPwdTextTag){
        [self userPersonalRelatedOperationEvent:nil];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    return YES;
}

- (void)userPersonalRelatedOperaionRequestion{
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.view endEditing:YES];
    WaittingMBProgressHUD(HUIKeyWindow,@"正在绑定...");
    [XCAPPHTTPClient requestRelatedAccountUserId:KXCAPPCurrentUserInformation.userPerId name:self.railwayAccountContentField.text pswd:self.railwayAccountPasswordField.text completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                SuccessMBProgressHUD(HUIKeyWindow, @"绑定成功！");
                
                [KXCShareFMSetting setUserPersonalIsRelatedAccountBool:YES];
                [KXCShareFMSetting setUserPersonalRelatedAccountNameStr:weakSelf.railwayAccountContentField.text];
                NSLog(@"WebAPIResponseCodeSuccess is 关联成功 %@",response.responseObject);
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
