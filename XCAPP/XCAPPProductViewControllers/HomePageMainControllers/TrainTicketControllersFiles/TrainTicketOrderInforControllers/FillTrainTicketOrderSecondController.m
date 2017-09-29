//
//  FillTrainTicketOrderSecondController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/7.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FillTrainTicketOrderSecondController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "InvoiceInforViewController.h"
#import "CheckTrainOrderController.h"


#define KAlertViewBackTag               (1830111)

#define KTextForPhoneTextTag            (1360111)
#define KTextForEmailTextTag            (1360112)


#define KBtnForAddressBookTag           (1830121)

#define KBtnForPayStyleButtonTag        (1830122)
#define KBtnForInvoiceButtonTag         (1830123)

#define KBtnForDetailButtonTag          (1830124)
#define KBtnForCheckButtonTag           (1830125)



@interface FillTrainTicketOrderSecondController ()<UITextFieldDelegate>

/*!
 * @breif 手机号输入框
 * @See
 */
@property (nonatomic , weak)                UITextField         *phoneContentField;


/*!
 * @breif 邮箱输入框
 * @See
 */
@property (nonatomic , weak)                UITextField         *emailContentField;


/*!
 * @breif 订单信息
 * @See
 */
@property (nonatomic , strong)      TrainticketOrderInformation         *orderTrainTicketInfor;



/*!
 * @breif 总价信息内容
 * @See
 */
@property (nonatomic , weak)            UILabel                         *userOrderTotalConsumption;
@end

@implementation FillTrainTicketOrderSecondController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithOrderInfor:(TrainticketOrderInformation *)orderItem{
    
    self = [super init];
    if (self) {
        self.orderTrainTicketInfor = orderItem;
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
    [self settingNavTitle:@"填写订单"];
    
    [self setLeftNavButtonFA:FMIconLeftReturn withFrame:kNavBarButtonRect actionTarget:self action:@selector(setleftButtonOperationEvent)];
    
    [self setupFillTrainTicketOrderSecondFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setleftButtonOperationEvent{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupFillTrainTicketOrderSecondFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    UIView *userBGView = [[UIView alloc]init];
    [userBGView setBackgroundColor:[UIColor whiteColor]];
    [userBGView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth, KProjectScreenWidth,
                                    (KFunctionModulButtonHeight*2+1.0f))];
    [mainView addSubview:userBGView];
    
    UILabel *countryCode = [[UILabel alloc]init];
    [countryCode setBackgroundColor:[UIColor clearColor]];
    [countryCode setTextColor:KSubTitleTextColor];
    [countryCode setFont:KFunctionModuleContentFont];
    [countryCode setTextAlignment:NSTextAlignmentLeft];
    [countryCode setText:@"+86"];
    [countryCode setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                     KXCUIControlSizeWidth(30.0f), KFunctionModulButtonHeight)];
    [userBGView addSubview:countryCode];
    
    
    UIButton *addressBookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBookBtn setBackgroundColor:[UIColor clearColor]];
    
    [addressBookBtn setTitle:@"通讯录" forState:UIControlStateNormal];
    [addressBookBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [addressBookBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                          forState:UIControlStateNormal];
    [addressBookBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                          forState:UIControlStateHighlighted];
    [addressBookBtn setTitleColor:HUIRGBColor(93.0f, 149.0f, 214, 1.0f) forState:UIControlStateNormal];
    [addressBookBtn setTitleColor:HUIRGBColor(63.0f, 119.0f, 184, 1.0f) forState:UIControlStateHighlighted];
    [addressBookBtn setTag:KBtnForAddressBookTag];
    [addressBookBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [addressBookBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(60.0f) - KInforLeftIntervalWidth),
                                    0.0f, KXCUIControlSizeWidth(60.0f), KFunctionModulButtonHeight)];
    [userBGView addSubview:addressBookBtn];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KContentTextColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForPhoneTextTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"请输入手机号"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f)),
                                        0.0f, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
    self.phoneContentField = phoneTextField;
    [userBGView addSubview:self.phoneContentField];
    
    UIView *sepUserView = [[UIView alloc]init];
    [sepUserView setFrame:CGRectMake(0.0f, (KFunctionModulButtonHeight),
                                     userBGView.width, 1.0f)];
    [sepUserView setBackgroundColor:KSepLineColorSetup];
    [userBGView addSubview:sepUserView];
    

    UILabel  *emailLabel = [[UILabel alloc]init];
    [emailLabel setBackgroundColor:[UIColor clearColor]];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    [emailLabel setTextColor:KFunctionModuleContentColor];
    [emailLabel setFont:KFunctionModuleContentFont];
    [emailLabel setText:@"联系邮箱"];
    [emailLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,sepUserView.bottom, 90.0f, KFunctionModulButtonHeight)];
    [userBGView addSubview:emailLabel];
    
    UITextField *emailTextField = [[UITextField alloc]init];
    [emailTextField setTextAlignment:NSTextAlignmentLeft];
    [emailTextField setTextColor:KContentTextColor];
    [emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [emailTextField setDelegate:self];
    [emailTextField setTag:KTextForPhoneTextTag];
    [emailTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [emailTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [emailTextField setPlaceholder:@"请输入邮箱"];
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邮箱"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [emailTextField setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f)),
                                        sepUserView.bottom,
                                        (KProjectScreenWidth - KXCUIControlSizeWidth(120.0f) - KInforLeftIntervalWidth),
                                        KFunctionModulButtonHeight)];
    self.emailContentField = emailTextField;
    [userBGView addSubview:self.emailContentField];
    
    
    

    
    UIView *visitView = [[UIView alloc]init];
    [visitView setBackgroundColor:[UIColor whiteColor]];
    [visitView setFrame:CGRectMake(0.0f, (userBGView.bottom + KInforLeftIntervalWidth),
                                   KProjectScreenWidth,(KFunctionModulButtonHeight))];
    [mainView addSubview:visitView];
    
    UILabel  *visitLabel = [[UILabel alloc]init];
    [visitLabel setBackgroundColor:[UIColor clearColor]];
    [visitLabel setTextAlignment:NSTextAlignmentLeft];
    [visitLabel setTextColor:KFunctionModuleContentColor];
    [visitLabel setFont:KFunctionModuleContentFont];
    [visitLabel setText:@"送票上门"];
    [visitLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [visitView addSubview:visitLabel];
    

    
    UIView *payStyleBGView = [[UIView alloc]init];
    [payStyleBGView setBackgroundColor:[UIColor whiteColor]];
    [payStyleBGView setFrame:CGRectMake(0.0f, (visitView.bottom + KInforLeftIntervalWidth),
                                        KProjectScreenWidth,(KFunctionModulButtonHeight*2+1.0f))];
    
    UIButton *payStyleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payStyleBtn setBackgroundColor:[UIColor clearColor]];
    [payStyleBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                        forState:UIControlStateNormal];
    [payStyleBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                        forState:UIControlStateHighlighted];
    [payStyleBtn setTag:KBtnForPayStyleButtonTag];
    [payStyleBtn setFrame:CGRectMake(0.0f, 0.0f,KProjectScreenWidth,(KFunctionModulButtonHeight))];
    [payStyleBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
       forControlEvents:UIControlEventTouchUpInside];
    [payStyleBGView addSubview:payStyleBtn];
    
    UILabel  *payTitleLabel = [[UILabel alloc]init];
    [payTitleLabel setBackgroundColor:[UIColor clearColor]];
    [payTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [payTitleLabel setTextColor:KFunctionModuleContentColor];
    [payTitleLabel setFont:KFunctionModuleContentFont];
    [payTitleLabel setText:@"支付方式"];
    [payTitleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [payStyleBtn addSubview:payTitleLabel];
    
    UILabel *payNextLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                    size:KUserPersonalRightButtonArrowFontSize
                                                   color:KFunNextArrowColor];
    [payNextLabel setFrame:CGRectMake((KProjectScreenWidth - 25.0f), (KFunctionModulButtonHeight - 20.0f)/2, 20.0f, 20.0f)];
    [payNextLabel setBackgroundColor:[UIColor clearColor]];
    [payNextLabel setContentMode:UIViewContentModeCenter];
    [payStyleBtn addSubview:payNextLabel];
    
    UIView *sepPayView = [[UIView alloc]init];
    [sepPayView setFrame:CGRectMake(0.0f, (KFunctionModulButtonHeight),
                                     userBGView.width, 1.0f)];
    [sepPayView setBackgroundColor:KSepLineColorSetup];
    [payStyleBGView addSubview:sepPayView];
    
    UIButton *invoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [invoiceBtn setBackgroundColor:[UIColor clearColor]];
    [invoiceBtn setBackgroundImage:createImageWithColor([UIColor whiteColor])
                           forState:UIControlStateNormal];
    [invoiceBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                           forState:UIControlStateHighlighted];
    [invoiceBtn setTag:KBtnForInvoiceButtonTag];
    [invoiceBtn setFrame:CGRectMake(0.0f, sepPayView.bottom,KProjectScreenWidth,(KFunctionModulButtonHeight))];
    [invoiceBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [payStyleBGView addSubview:invoiceBtn];
    
    UILabel  *invoiceTitleLabel = [[UILabel alloc]init];
    [invoiceTitleLabel setBackgroundColor:[UIColor clearColor]];
    [invoiceTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [invoiceTitleLabel setTextColor:KFunctionModuleContentColor];
    [invoiceTitleLabel setFont:KFunctionModuleContentFont];
    [invoiceTitleLabel setText:@"发票"];
    [invoiceTitleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [invoiceBtn addSubview:invoiceTitleLabel];
    
    UILabel *invoiceLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                 size:KUserPersonalRightButtonArrowFontSize
                                                color:KFunNextArrowColor];
    [invoiceLabel setFrame:CGRectMake((KProjectScreenWidth - 25.0f), ((KFunctionModulButtonHeight - 20.0f)/2), 20.0f, 20.0f)];
    [invoiceLabel setBackgroundColor:[UIColor clearColor]];
    [invoiceLabel setContentMode:UIViewContentModeCenter];
    [invoiceBtn addSubview:invoiceLabel];

    
    
    [mainView addSubview:payStyleBGView];
    
    
    UILabel *showLabel = [[UILabel alloc]init];
    [showLabel setBackgroundColor:[UIColor clearColor]];
    [showLabel setText:@"携程不提供火车票发票。纸质火车票作为唯一报销凭证，需自行至火车站办理取票手续。"];
    [showLabel setTextColor:KSubTitleTextColor];
    [showLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [showLabel setNumberOfLines:0];
    [showLabel setTextAlignment:NSTextAlignmentLeft];
    [showLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize showSize = [showLabel.text sizeWithFont:showLabel.font
                                 constrainedToSize:CGSizeMake(KProjectScreenWidth - KInforLeftIntervalWidth*2,
                                                              CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    [showLabel setFrame:CGRectMake(KInforLeftIntervalWidth, (payStyleBGView.bottom + KInforLeftIntervalWidth), (KProjectScreenWidth - KInforLeftIntervalWidth*2),showSize.height)];
    [mainView addSubview:showLabel];
    
    
    ///MARK:初始化底部信息
    CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
    CGRect bottomRect = CGRectMake(0.0f,
                                   (self.view.bounds.size.height - KXCUIControlSizeWidth(50.0f)
                                    - navigationBarHeight)
                                   , KProjectScreenWidth, KXCUIControlSizeWidth(50.0f));
    UIView *bottomView = [[UIView alloc]init];
    [bottomView setFrame:bottomRect];
    [bottomView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
    [self.view addSubview:bottomView];
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:KXCAPPUIContentFontSize(17)];
    [nextButton setBackgroundImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))
                          forState:UIControlStateNormal];
    [nextButton setBackgroundImage:createImageWithColor(HUIRGBColor(185.0f, 121.0f, 38.0f, 1.0))
                          forState:UIControlStateHighlighted];
    [nextButton setTag:KBtnForCheckButtonTag];
    [nextButton addTarget:self action:@selector(userOperationButtonClickedEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [nextButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(80.0f)),
                                    0.0f, KXCUIControlSizeWidth(80.0f),  KXCUIControlSizeWidth(50.0f))];
    [bottomView addSubview:nextButton];
    
    
    UIButton *detailedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailedButton setBackgroundColor:[UIColor clearColor]];
    [detailedButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                              forState:UIControlStateNormal];
    [detailedButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                              forState:UIControlStateHighlighted];
    [detailedButton setTag:KBtnForDetailButtonTag];
    [detailedButton addTarget:self action:@selector(userOperationButtonClickedEvent:)
             forControlEvents:UIControlEventTouchUpInside];
    [detailedButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(80.0f) - 80.0f),
                                        0.0f, 80.0f,  KXCUIControlSizeWidth(50.0f))];
    [bottomView addSubview:detailedButton];
    
    
    UILabel  *titleInforLabel = [[UILabel alloc]init];
    [titleInforLabel setBackgroundColor:[UIColor clearColor]];
    [titleInforLabel setTextAlignment:NSTextAlignmentRight];
    [titleInforLabel setTextColor:HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0)];
    [titleInforLabel setFont:KFunctionModuleContentFont];
    [titleInforLabel setText:@"明细"];
    [titleInforLabel setFrame:CGRectMake(25.0f, 0.0f, 35.0f, KXCUIControlSizeWidth(50.0f))];
    [detailedButton addSubview:titleInforLabel];
    
    UILabel *nextLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                 size:KUserPersonalRightButtonArrowFontSize
                                                color:HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0)];
    [nextLabel setFrame:CGRectMake(titleInforLabel.right, (KXCUIControlSizeWidth(50.0f) - 20.0f)/2, 20.0f, 20.0f)];
    [nextLabel setBackgroundColor:[UIColor clearColor]];
    [nextLabel setContentMode:UIViewContentModeCenter];
    [detailedButton addSubview:nextLabel];
}


- (void)userOperationButtonClickedEvent:(UIButton *)button{
    
    
    ///通讯录
    if (KBtnForAddressBookTag == button.tag) {
        
    }

    ///支付方式
    else if (KBtnForPayStyleButtonTag == button.tag) {
        
    }
    
    //发票信息
    else if (KBtnForInvoiceButtonTag== button.tag) {
        NSLog(@"发票")
        InvoiceInforViewController *viewController = [[InvoiceInforViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    ///详细信息
    else if (KBtnForDetailButtonTag == button.tag) {
        
    }
    
    else if (KBtnForCheckButtonTag == button.tag){
        CheckTrainOrderController *viewController = [[CheckTrainOrderController alloc]initWithOrderInfor:self.orderTrainTicketInfor];
        [self.navigationController pushViewController:viewController animated:YES];
    }
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


@end
