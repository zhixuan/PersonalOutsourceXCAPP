//
//  AddTrainTicketUserInforController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AddTrainTicketUserInforController.h"
#import "FontAwesome.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"
#import "UIFont+FontAwesome.h"
#import "DefaultotelRecommendSearchLayerView.h"

#define KTextForUserNameStrTag          (1620311)
#define KTextForCerNumberStrTag         (1620312)

#define KBtnForUserSelectStyleTag       (1620313)

#define KBtnForAddButtonTag             (1620411)
#define KBtnForUpdateButtonTag          (1620412)



@interface AddTrainTicketUserInforController ()<UITextFieldDelegate,DefaultotelRecommendDelegate>

/*!
 * @breif 用户信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass            *userPersonalInformation;

/*!
 * @breif 是否为新增用户
 * @See
 */
@property (nonatomic , assign)      BOOL                            isNewAddUserBool;


/*!
 * @breif 用户选择房间个数
 * @See
 */
@property (nonatomic , weak)      UILabel                           *userStaRoomCountLabel;

/*!
 * @breif 用户姓名
 * @See
 */
@property (nonatomic , assign)      UITextField                     *userPerNameTextField;

/*!
 * @breif 用户证件类型
 * @See
 */
@property (nonatomic , assign)      UILabel                         *userCredentialStyle;

/*!
 * @breif 用户证件号码
 * @See
 */
@property (nonatomic , assign)      UITextField                     *userCredentialsContent;


/*!
 * @breif 用户信息所在的位置
 * @See
 */
@property (nonatomic , assign)      NSInteger                       userInforIndex;

/*!
 * @breif 证件选择处理
 * @See
 */
@property (nonatomic , weak)      DefaultotelRecommendSearchLayerView *hotelRecommendSearchLayerView;


@end

@implementation AddTrainTicketUserInforController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
    }
    return self;
}

- (id)initWithUserInfor:(UserInformationClass *)userInfor withIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.userPersonalInformation = userInfor;
        self.userInforIndex = index;
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
    
    ///若需要的信息都为空，则说明需要新一条，否则是编辑
    if (IsStringEmptyOrNull(self.userPersonalInformation.userPerId)     &&
        IsStringEmptyOrNull(self.userPersonalInformation.userNameStr)   &&
        IsStringEmptyOrNull(self.userPersonalInformation.userPerCredentialStyle) &&
        IsStringEmptyOrNull(self.userPersonalInformation.userPerCredentialContent)) {
        self.isNewAddUserBool = YES;
        [self settingNavTitle:@"新增"];
    }else{
        self.isNewAddUserBool = NO;
        [self settingNavTitle:@"编辑"];

    }
    
    
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect actionTarget:self action:@selector(setLeftBarButtonClickeEvent)];
    
    [self setRightNavButtonTitleStr:@"完成" withFrame:kNavBarButtonRect actionTarget:self action:@selector(setRightBarButtonEventClicked)];
    [self setupAddTrainTicketUserInforControllerFrame];
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    
    NSArray *array =  KXCShareFMSetting.userCredentialsCompareDictionary.allValues;
    DefaultotelRecommendSearchLayerView *hotelRecommendView = [[DefaultotelRecommendSearchLayerView alloc]initWithFrame:layerViewRect withSearchContent:array];
    [hotelRecommendView setDelegate:self];
    self.hotelRecommendSearchLayerView = hotelRecommendView;
    [self.navigationController.view addSubview:self.hotelRecommendSearchLayerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setLeftBarButtonClickeEvent{
    [self.view endEditing:YES];
    [self.hotelRecommendSearchLayerView setDelegate:nil];
    [self.hotelRecommendSearchLayerView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setRightBarButtonEventClicked{
    
    if (IsStringEmptyOrNull(self.userPerNameTextField.text)) {
        
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"姓名不能为空！");
        return;
    }
    
    if (IsStringEmptyOrNull(self.userCredentialsContent.text)) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"证件号码不能为空！");
        return;
    }
    

    if (self.isNewAddUserBool) {
        if (self.delegate) {
            UserInformationClass *userInfor = [[UserInformationClass alloc]init];
            
            [userInfor setUserNameStr:self.userPerNameTextField.text];
            [userInfor setUserPerId:KXCAPPCurrentUserInformation.userPerId];
            [userInfor setUserPerCredentialStyle:@"0"];
            [userInfor setUserPerCredentialContent:self.userCredentialsContent.text];
            
            
            NSString *credentialCode = @"";
            for (NSString *keyStr in KXCShareFMSetting.userCredentialsCompareDictionary.allKeys) {
                
                
                NSString *cerNameStr = StringForKeyInUnserializedJSONDic(KXCShareFMSetting.userCredentialsCompareDictionary,keyStr);
                if ([cerNameStr isEqualToString:self.userCredentialStyle.text]) {
                    credentialCode =keyStr;
                    break;
                }
            }
            [userInfor setUserPerCredentialStyle:credentialCode];
            [userInfor setUserPerCredentialContent:self.userCredentialsContent.text];
            
            
 
            
            [XCAPPHTTPClient requestAddTrainUserDirectoryInforWithUser:userInfor completion:^(WebAPIResponse *response) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    if (response.code == WebAPIResponseCodeSuccess) {
                        if ([self.delegate respondsToSelector:@selector(addFinishUserInfor:)]) {
                            [self.delegate addFinishUserInfor:userInfor];
                        }
                        
                        [self setLeftBarButtonClickeEvent];
                    }
                    
                    NSLog(@"response.responseObject is %@",response.responseObject);
                    
                });
            }];
        }
    }
    else{
        [self.userPersonalInformation setUserNameStr:self.userPerNameTextField.text];
        [self.userPersonalInformation setUserPerCredentialStyle:self.userCredentialStyle.text];
        [self.userPersonalInformation setUserPerCredentialContent:self.userCredentialsContent.text];
        
        if ([self.delegate respondsToSelector:@selector(editFinishUserInfor: withIndex:)]) {
            [self.delegate editFinishUserInfor:self.userPersonalInformation withIndex:self.userInforIndex];
        }
        
        [self setLeftBarButtonClickeEvent];
    }
}

- (void)setupAddTrainTicketUserInforControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 60.0f)];
    
    
    
    CGFloat greyViewHeight = 0.0f;
    if (self.isNewAddUserBool) {
        
        greyViewHeight = KXCUIControlSizeWidth(30.0f);
        UIView *greyColorView = [[UIView alloc]init];
        [greyColorView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
        [greyColorView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,greyViewHeight )];
        [mainView addSubview:greyColorView];
        
        UILabel *addressLabel = [[UILabel alloc]init];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [addressLabel setTextColor:[UIColor whiteColor]];
        [addressLabel setFont:KXCAPPUIContentFontSize(12)];
        [addressLabel setTextAlignment:NSTextAlignmentLeft];
        [addressLabel setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f), 0.0f,
                                          (KProjectScreenWidth - KXCUIControlSizeWidth(40.0f + 10.0f)),
                                          KXCUIControlSizeWidth(30.0f))];
        [greyColorView addSubview:addressLabel];
        [addressLabel setText:@"如为员工预订，请在出行人列表页勾选出行人"];
    }

    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, (KInforLeftIntervalWidth + greyViewHeight),
                                       KProjectScreenWidth, (KFunctionModulButtonHeight*3+2.0f))];
    [mainView addSubview:contentBGView];
    
    UILabel  *titleUserNameLabel = [[UILabel alloc]init];
    [titleUserNameLabel setBackgroundColor:[UIColor clearColor]];
    [titleUserNameLabel setTextAlignment:NSTextAlignmentLeft];
    [titleUserNameLabel setTextColor:KFunctionModuleContentColor];
    [titleUserNameLabel setFont:KFunctionModuleContentFont];
    [titleUserNameLabel setText:@"姓名"];
    [titleUserNameLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 70.0f, KFunctionModulButtonHeight)];
    [contentBGView addSubview:titleUserNameLabel];
    
    UITextField *userNameField = [[UITextField alloc]init];
    [userNameField setTextAlignment:NSTextAlignmentLeft];
    [userNameField setTextColor:KContentTextColor];
    [userNameField setReturnKeyType:UIReturnKeyDone];
    [userNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userNameField setDelegate:self];
    [userNameField setText:self.isNewAddUserBool?@"":self.userPersonalInformation.userNameStr];
    [userNameField setTag:KTextForUserNameStrTag];
    [userNameField setFont:KXCAPPUIContentFontSize(17.0f)];
    [userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [userNameField setPlaceholder:@"请输入名字"];
    userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入名字"
                                                                          attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [userNameField setFrame:CGRectMake(KXCUIControlSizeWidth(110.0f),
                                       0.0,
                                       (KProjectScreenWidth - KXCUIControlSizeWidth(110.0f) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    self.userPerNameTextField = userNameField;
    [contentBGView addSubview:self.userPerNameTextField];
    
    UIView *sepNameView = [[UIView alloc]init];
    [sepNameView setFrame:CGRectMake(0.0f, userNameField.bottom, KProjectScreenWidth, 1.0f)];
    [sepNameView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepNameView];
    
    
    UIButton *cerStyleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cerStyleBtn setBackgroundColor:[UIColor whiteColor]];
    [cerStyleBtn setFrame:CGRectMake(0.0f,sepNameView.bottom,
                                     KProjectScreenWidth, KFunctionModulButtonHeight)];
    [cerStyleBtn setTag:KBtnForUserSelectStyleTag];
    [cerStyleBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    [cerStyleBtn setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
    [cerStyleBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                           forState:UIControlStateHighlighted];
    [contentBGView addSubview:cerStyleBtn];
    
    UILabel  *cerStyleLabel = [[UILabel alloc]init];
    [cerStyleLabel setBackgroundColor:[UIColor clearColor]];
    [cerStyleLabel setTextAlignment:NSTextAlignmentLeft];
    [cerStyleLabel setTextColor:KFunctionModuleContentColor];
    [cerStyleLabel setFont:KFunctionModuleContentFont];
    [cerStyleLabel setText:@"证件类型"];
    [cerStyleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 70.0f, KFunctionModulButtonHeight)];
    [cerStyleBtn addSubview:cerStyleLabel];
    
    UILabel  *cerStyleContentLabel = [[UILabel alloc]init];
    [cerStyleContentLabel setBackgroundColor:[UIColor clearColor]];
    [cerStyleContentLabel setTextAlignment:NSTextAlignmentLeft];
    [cerStyleContentLabel setTextColor:KContentTextColor];
    [cerStyleContentLabel setFont:KXCAPPUIContentFontSize(17)];
    [cerStyleContentLabel setText:KXCShareFMSetting.userCredentialsCompareDictionary.allValues[0]];
    [cerStyleContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(110.0f)),0.0f, KXCUIControlSizeWidth(110.0f), KFunctionModulButtonHeight)];
    self.userCredentialStyle = cerStyleContentLabel;
    [cerStyleBtn addSubview:self.userCredentialStyle];
    
    UILabel *payNextLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                    size:KUserPersonalRightButtonArrowFontSize
                                                   color:KFunNextArrowColor];
    [payNextLabel setFrame:CGRectMake((KProjectScreenWidth - 25.0f), (KFunctionModulButtonHeight - 20.0f)/2, 20.0f, 20.0f)];
    [payNextLabel setBackgroundColor:[UIColor clearColor]];
    [payNextLabel setContentMode:UIViewContentModeCenter];
    [cerStyleBtn addSubview:payNextLabel];
    
    UIView *sepCerView = [[UIView alloc]init];
    [sepCerView setFrame:CGRectMake(0.0f, cerStyleBtn.bottom, KProjectScreenWidth, 1.0f)];
    [sepCerView setBackgroundColor:KSepLineColorSetup];
    [contentBGView addSubview:sepCerView];
    
    UILabel  *usercerCodeLabel = [[UILabel alloc]init];
    [usercerCodeLabel setBackgroundColor:[UIColor clearColor]];
    [usercerCodeLabel setTextAlignment:NSTextAlignmentLeft];
    [usercerCodeLabel setTextColor:KFunctionModuleContentColor];
    [usercerCodeLabel setFont:KFunctionModuleContentFont];
    [usercerCodeLabel setText:@"证件号码"];
    [usercerCodeLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,sepCerView.bottom, 70.0f, KFunctionModulButtonHeight)];
    [contentBGView addSubview:usercerCodeLabel];
    
    UITextField *creContentField = [[UITextField alloc]init];
    [creContentField setTextAlignment:NSTextAlignmentLeft];
    [creContentField setTextColor:KContentTextColor];
    [creContentField setReturnKeyType:UIReturnKeyDone];
    [creContentField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [creContentField setDelegate:self];
    [creContentField setTag:KTextForCerNumberStrTag];
    [creContentField setFont:KXCAPPUIContentFontSize(17.0f)];
    [creContentField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [creContentField setPlaceholder:@"请输入号码"];
    [creContentField setText:self.isNewAddUserBool?@"":self.userPersonalInformation.userPerCredentialContent];
    creContentField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入号码"
                                                                          attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [creContentField setFrame:CGRectMake(KXCUIControlSizeWidth(110.0f),
                                       sepCerView.bottom,
                                       (KProjectScreenWidth - KXCUIControlSizeWidth(110.0f) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    self.userCredentialsContent = creContentField;
    [contentBGView addSubview:self.userCredentialsContent];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    return YES;
}


- (void)userOperationButtonEventClicked:(UIButton *)button{
    
     [self.view endEditing:YES];
    if (KBtnForUserSelectStyleTag == button.tag) {
        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.hotelRecommendSearchLayerView setFrame:layerViewRect];
        }];
    }
}

- (void)userSelectedDefaultotelRecommendSearchStyle:(NSInteger)Searchstyle styleName:(NSString *)styleNameStr{
    [self.userCredentialStyle setText:styleNameStr];
}

@end
