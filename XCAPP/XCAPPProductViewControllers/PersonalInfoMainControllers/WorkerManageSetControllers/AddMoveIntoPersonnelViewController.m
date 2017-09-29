//
//  AddMoveIntoPersonnelViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/12.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "AddMoveIntoPersonnelViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"
#import "HTTPClient+HotelsRequest.h"

#define KTextForUserNameStrTag          (1780111)

@interface AddMoveIntoPersonnelViewController ()<UITextFieldDelegate>
/*!
 * @breif 用户名
 * @See
 */
@property (nonatomic , weak)      UITextField           *userPerNameTextField;
@end

@implementation AddMoveIntoPersonnelViewController


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
    
    [self settingNavTitle:@"新增"];
    
    [self setAddMoveIntoPersonnelViewControllerFrame];
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect
                      actionTarget:self action:@selector(leftBarButtonEventClicked)];
    
    [self setRightNavButtonTitleStr:@"完成" withFrame:kNavBarButtonRect
                       actionTarget:self action:@selector(rightBarButtonEventClicked)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonEventClicked{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)rightBarButtonEventClicked{
    
    
    if (IsStringEmptyOrNull(self.userPerNameTextField.text)) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow  , @"用户名不能为空！");
        return;
    }
    
    [self updateRequestAddUserInfor];
}

- (void)setAddMoveIntoPersonnelViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 60.0f)];

    UIView *greyColorView = [[UIView alloc]init];
    [greyColorView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
    [greyColorView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(30.0f))];
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
    
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, (KInforLeftIntervalWidth + greyColorView.bottom ),
                                       KProjectScreenWidth, KFunctionModulButtonHeight)];
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
    [userNameField setTextColor:KFunContentColor];
    [userNameField setReturnKeyType:UIReturnKeyDone];
    [userNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userNameField setDelegate:self];
//    [userNameField setKeyboardType:<#(UIKeyboardType)#>];
    [userNameField setTag:KTextForUserNameStrTag];
    [userNameField setFont:KXCAPPUIContentFontSize(17.0f)];
    [userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [userNameField setPlaceholder:@"请输入名字"];
    userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入名字"
                                                                          attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [userNameField setFrame:CGRectMake((titleUserNameLabel.right + KXCUIControlSizeWidth(10.0f)),
                                       0.0,
                                       (KProjectScreenWidth - (titleUserNameLabel.right + KXCUIControlSizeWidth(10.0f)) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    self.userPerNameTextField = userNameField;
    [contentBGView addSubview:self.userPerNameTextField];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self updateRequestAddUserInfor];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    return YES;
}




- (void)updateRequestAddUserInfor{
    
    NSLog(@"可以添加数据了");
    
    if (IsStringEmptyOrNull(self.userPerNameTextField.text)) {
        ShowAutoHideMBProgressHUD(HUIKeyWindow,@"用户名不能为空！");
        return;
    }
    
    WaittingMBProgressHUD(HUIKeyWindow,@"正在添加...");
    
    [XCAPPHTTPClient userRequestAddReserveTenantUserInforWithUserID:KXCAPPCurrentUserInformation.userPerId userName:self.userPerNameTextField.text completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"开始了呢");
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                
                FinishMBProgressHUD(HUIKeyWindow);
                [self userAddOperationFinish];
                
            }else if (response.code == WebAPIResponseCodeFailed){
                FailedMBProgressHUD(HUIKeyWindow,@"添加失败！");
            }else{
                FailedMBProgressHUD(HUIKeyWindow,@"添加失败！");
            }
        });
    }];
}

- (void)userAddOperationFinish{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userAddFinishUserName:)]) {
            [self.delegate userAddFinishUserName:self.userPerNameTextField.text];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
