//
//  FillTrainTicketOrderViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FillTrainTicketOrderViewController.h"
#import "RelatedCNTViewController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "HTTPClient.h"
#import "HTTPClient+TrainTickeRequest.h"

#import "TrainPassStationController.h"
#import "ReturnedMoneyInstructionsController.h"
#import "SelectedUserInforViewController.h"
#import "AddTrainTicketUserInforController.h"
#import "FillTrainTicketOrderSecondController.h"

#import "PaySuccessfulViewController.h"
#import "TrainTicketSeatSelectedLayerView.h"
#import "OrderImmediatePayViewController.h"

#import "TrainTicketOrderDetailInforView.h"



#define KBtnForRelatedButtonTag             (1570111)

#define KBtnForPassStationButtonTag         (1570112)
#define KBtnForRefundButtonTag              (1570113)

#define KBtnForSelectSeatButtonTag          (1570114)
#define KBtnForAddUserButtonTag             (1570115)

#define KBtnForOrderDetailedButtonTag       (1570116)
#define KBtnForPayButtonTag                 (1570117)

#define KBtnUserBaseButtonTag               (1570211)
#define KBtnUserDeleteBaseButtonTag         (1570411)

#define KBtnUserNameInterval                (1000)
#define KBtnUserCerCodeInterval             (3000)
#define KBtnUserBaseDeleteTag               (5000)

#define KTextForUserNameTextTag             (1620111)
#define KTextForPhoneTextTag                (1620112)
#define KTextForEmailTextTag                (1620113)

#define KAlertViewForDeleteTag              (1740111)
#define KAlertViewForRelatedTag             (1740311)

@interface FillTrainTicketOrderViewController ()<AddTrainTicketUserInforDelegate,UITextFieldDelegate,SelectedUsersDelegate,TrainTicketSeatSelectedDelegate,UIAlertViewDelegate>

/*!
 * @breif 界面移动视图
 * @See
 */
@property (nonatomic , weak)      UIScrollView                          *mainScrollView;
/*!
 * @breif 订单信息
 * @See
 */
@property (nonatomic , strong)      TrainticketOrderInformation         *ticketOrderInfor;


/*!
 * @breif 坐席信息
 * @See
 */
@property (nonatomic , weak)              UILabel                       *ticketSeatContentLabel;
/*!
 * @breif 坐席选择按键
 * @See
 */
@property (nonatomic , weak)      UIButton                              *selectedSeatButton;


/*!
 * @breif 用户信息视图
 * @See
 */
@property (nonatomic , weak)            UIView                          *usersInforBGView;


/*!
 * @breif 用户信息按键视图
 * @See
 */
@property (nonatomic , weak)            UIView                          *usersInforBtnsView;

///*!
// * @breif 服务费信息说明
// * @See
// */
//@property (nonatomic , weak)          UIView                            *ticketServeCostBGView;

/*!
 * @breif 乘客用户信息内容
 * @See
 */
@property (nonatomic , strong)          NSMutableArray                  *userInforMutableArray;

/*!
 * @breif 将要删除的乘客信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass                *willDeleteUserInfor;


/*!
 * @breif 总价信息内容
 * @See
 */
@property (nonatomic , weak)            UILabel                         *userOrderTotalConsumption;


/*!
 * @breif 订票者联系人信息
 * @See
 */
@property (nonatomic , weak)        UIView                              *relatedReporterView;

/*!
 * @breif 用户联系人名字
 * @See
 */
@property (nonatomic , weak)      UITextField                           *userNameContentField;

/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UITextField                           *phoneContentField;

/*!
 * @breif 用户邮箱
 * @See
 */
@property (nonatomic , weak)      UITextField                           *emailContentField;

/*!
 * @breif 火车票支付方式
 * @See
 */
@property (nonatomic , weak)      UIView                                *trainTicketPayStyleBGView;

/*!
 * @breif 选择火车票座位信息
 * @See
 */
@property (nonatomic , weak)      TrainTicketSeatSelectedLayerView      *trainTicketSeatSelectedLayerView;

/*!
 * @breif 用户订单明细信息
 * @See
 */
@property (nonatomic , weak)      TrainTicketOrderDetailInforView       *userOrderDetailedView;


@end

@implementation FillTrainTicketOrderViewController


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
        self.ticketOrderInfor = orderItem;
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
    
    [self settingNavTitle:@"填写订单"];
    
    self.userInforMutableArray = [[NSMutableArray alloc]init];
    [self setupFillTrainTicketOrderViewControllerFrame];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!KXCShareFMSetting.userPersonalIsRelatedAccountBool) {
        
        [XCAPPHTTPClient requestCheckUserIsRelatedAccountWithUserId:KXCAPPCurrentUserInformation.userPerId completion:^(WebAPIResponse *response) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                NSLog(@"response.responseObject is %@",response.responseObject);
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    NSLog(@"已经保存过数据信息");
                    if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *accountDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                        if (accountDic.count ==2) {
                            
                            NSString *nameStr = StringForKeyInUnserializedJSONDic(accountDic, @"username_train");
                            NSString *passwordStr = StringForKeyInUnserializedJSONDic(accountDic, @"passowrd_train");
                            
                            if ((!IsStringEmptyOrNull(nameStr)) && (!IsStringEmptyOrNull(passwordStr))) {
                                [KXCShareFMSetting setUserPersonalIsRelatedAccountBool:YES];
                                [KXCShareFMSetting setUserPersonalRelatedAccountNameStr:nameStr];
                            }else{
                                [KXCShareFMSetting setUserPersonalIsRelatedAccountBool:NO];
                            }
                        }
                    }
                }
            });
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFillTrainTicketOrderViewControllerFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    self.mainScrollView = mainView;
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    UILabel *showLabel = [[UILabel alloc]init];
    [showLabel setBackgroundColor:[UIColor clearColor]];
    [showLabel setText:@"近期由于铁路局核验体系升级,因身份核验问题导致购票失败的用户比较多。建议您关联出行人的12306账号，关联后，购票更快，成功率更高。"];
    [showLabel setTextColor:[UIColor whiteColor]];
    [showLabel setFont:KXCAPPUIContentFontSize(12.0f)];
    [showLabel setNumberOfLines:0];
    [showLabel setTextAlignment:NSTextAlignmentLeft];
    [showLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize showSize = [showLabel.text sizeWithFont:showLabel.font
                                 constrainedToSize:CGSizeMake(KProjectScreenWidth - KInforLeftIntervalWidth*3.5,
                                                              CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
    [headerView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                    (showSize.height + KInforLeftIntervalWidth +KXCUIControlSizeWidth(40.0f)))];
    [mainView addSubview:headerView];
    [showLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2.5, KInforLeftIntervalWidth,
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*3.5), showSize.height)];
    [headerView addSubview:showLabel];
    
    UIButton *relatedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [relatedBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(50.0f) - KInforLeftIntervalWidth),
                                    showLabel.bottom, KXCUIControlSizeWidth(50.0f),
                                    KXCUIControlSizeWidth(40.0f))];
    [relatedBtn setTag:KBtnForRelatedButtonTag];
    [relatedBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [relatedBtn setBackgroundColor:[UIColor clearColor]];
    [relatedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [relatedBtn setTitle:@"关联 >" forState:UIControlStateNormal];
    [relatedBtn.titleLabel setFont:KXCAPPUIContentFontSize(13.0f)];
    [relatedBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [relatedBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateNormal];
    [relatedBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateHighlighted];
    [headerView addSubview:relatedBtn];
    NSMutableAttributedString *relatedContent=[[NSMutableAttributedString alloc]initWithString:@"关联 >"];
    NSRange relatedRange = [@"关联 >" rangeOfString:@"关联"];
    [relatedContent addAttribute:NSForegroundColorAttributeName value:HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0) range:relatedRange];
    [relatedBtn setAttributedTitle:relatedContent forState:UIControlStateNormal];
    CGRect trainBGRect = CGRectMake(KInforLeftIntervalWidth, headerView.bottom + KInforLeftIntervalWidth,
                                    (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                    KXCUIControlSizeWidth(158.0f));
    [self setupTrainTicketInformation:mainView rect:trainBGRect];
    
    
    //MARK:火车票信息
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedBtn setFrame:CGRectMake(0.0f,
                                     trainBGRect.size.height + KInforLeftIntervalWidth*2 + headerView.bottom,
                                     KProjectScreenWidth,
                                     KFunctionModulButtonHeight)];
    [selectedBtn setTag:KBtnForSelectSeatButtonTag];
    [selectedBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [selectedBtn setBackgroundColor:[UIColor clearColor]];
    [selectedBtn setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
    [selectedBtn setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                           forState:UIControlStateHighlighted];
    self.selectedSeatButton = selectedBtn;
    [mainView addSubview:self.selectedSeatButton ];
    
    UILabel  *seatStyleLabel = [[UILabel alloc]init];
    [seatStyleLabel setBackgroundColor:[UIColor clearColor]];
    [seatStyleLabel setTextAlignment:NSTextAlignmentLeft];
    [seatStyleLabel setTextColor:KFunctionModuleContentColor];
    [seatStyleLabel setFont:KFunctionModuleContentFont];
    [seatStyleLabel setText:@"坐席"];
    [seatStyleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [selectedBtn addSubview:seatStyleLabel];
    
    UILabel *seatLabel = [[UILabel alloc]init];
    [seatLabel setTextAlignment:NSTextAlignmentCenter];
    [seatLabel setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(150.0f))/2,
                                   0.0f, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
    [seatLabel setTextColor:KContentTextColor];
    self.ticketSeatContentLabel = seatLabel;
    [selectedBtn addSubview:self.ticketSeatContentLabel];
    NSString *seatContentStr =[NSString stringWithFormat:@"%@ ￥%@",self.ticketOrderInfor.ttOrderTrainticketInfor.traCabinModelStr,self.ticketOrderInfor.ttOrderTrainticketInfor.traUnitPrice];
    NSRange contentRange=[seatContentStr rangeOfString:self.ticketOrderInfor.ttOrderTrainticketInfor.traUnitPrice];
    NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:seatContentStr];
    [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(18.0f) range:contentRange];
    [dynamicContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:contentRange];
    [self.ticketSeatContentLabel setAttributedText:dynamicContent];
    
    UILabel *nextSeatLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                     size:KUserPersonalRightButtonArrowFontSize
                                                    color:KFunNextArrowColor];
    [nextSeatLabel setFrame:CGRectMake((KProjectScreenWidth - 20.0f - KInforLeftIntervalWidth) ,
                                       (KXCUIControlSizeWidth(50.0f) - 20.0f)/2, 20.0f, 20.0f)];
    [nextSeatLabel setBackgroundColor:[UIColor clearColor]];
    [nextSeatLabel setContentMode:UIViewContentModeCenter];
    [selectedBtn addSubview:nextSeatLabel];
    
    NSInteger userCountInt = self.userInforMutableArray.count;
    //MARK:人员信息
    UIView *userInforBGView = [[UIView alloc]init];
    [userInforBGView setFrame:CGRectMake(0.0f, (selectedBtn.bottom + KInforLeftIntervalWidth),
                                         KProjectScreenWidth, (KFunctionModulButtonHeight + (userCountInt*KFunctionModulButtonHeight*1.5 + userCountInt)))];
    [userInforBGView setBackgroundColor:[UIColor whiteColor]];
    self.usersInforBGView = userInforBGView;
    [mainView addSubview:self.usersInforBGView];
    
    UILabel  *userTitleLabel = [[UILabel alloc]init];
    [userTitleLabel setBackgroundColor:[UIColor clearColor]];
    [userTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [userTitleLabel setTextColor:KFunctionModuleContentColor];
    [userTitleLabel setFont:KFunctionModuleContentFont];
    [userTitleLabel setText:@"乘客"];
    [userTitleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 45.0f, KFunctionModulButtonHeight)];
    [userInforBGView addSubview:userTitleLabel];
    
    UILabel  *userShowLabel = [[UILabel alloc]init];
    [userShowLabel setBackgroundColor:[UIColor clearColor]];
    [userShowLabel setTextAlignment:NSTextAlignmentLeft];
    [userShowLabel setTextColor:KSubTitleTextColor];
    [userShowLabel setFont:KXCAPPUIContentFontSize(12)];
    [userShowLabel setText:@"仅支持成人票预订"];
    [userShowLabel setFrame:CGRectMake((KFunctionModuleContentLeftWidth+userTitleLabel.right),0.0f, 120.0f, KFunctionModulButtonHeight)];
    [userInforBGView addSubview:userShowLabel];
    
    UIButton *addUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addUserBtn setBackgroundColor:[UIColor clearColor]];
    [addUserBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateNormal];
    [addUserBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateHighlighted];
    [addUserBtn setTitle:@"添加\t+" forState:UIControlStateNormal];
    [addUserBtn setTitleColor:HUIRGBColor(93.0f, 149.0f, 214, 1.0f) forState:UIControlStateNormal];
    [addUserBtn setTitleColor:HUIRGBColor(53.0f, 109.0f, 174, 1.0f) forState:UIControlStateHighlighted];
    [addUserBtn setFrame:CGRectMake((userInforBGView.width - KXCUIControlSizeWidth(70.0f) - KInforLeftIntervalWidth), 0.0f,
                                    KXCUIControlSizeWidth(70.0f), KFunctionModulButtonHeight)];
    [addUserBtn setTag:KBtnForAddUserButtonTag];
    [addUserBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [userInforBGView addSubview:addUserBtn];
    
    
    
    UIView *userBGView = [[UIView alloc]init];
    [userBGView setBackgroundColor:[UIColor whiteColor]];
    [userBGView setFrame:CGRectMake(0.0f, (self.usersInforBGView.bottom + KInforLeftIntervalWidth),
                                    KProjectScreenWidth, (KFunctionModulButtonHeight*3+2.0f))];
    self.relatedReporterView = userBGView;
    [mainView addSubview:self.relatedReporterView];
    
    UILabel  *userNameLabel = [[UILabel alloc]init];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setTextColor:KFunctionModuleContentColor];
    [userNameLabel setFont:KFunctionModuleContentFont];
    [userNameLabel setText:@"联系人名字"];
    [userNameLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [userBGView addSubview:userNameLabel];
    
    UITextField *nameTextField = [[UITextField alloc]init];
    [nameTextField setTextAlignment:NSTextAlignmentLeft];
    [nameTextField setTextColor:KContentTextColor];
    [nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [nameTextField setDelegate:self];
    [nameTextField setReturnKeyType:UIReturnKeyDone];
    [nameTextField setTag:KTextForUserNameTextTag];
    [nameTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [nameTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [nameTextField setPlaceholder:@"请输入联系人名字"];
    nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入联系人名字"
                                                                          attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [nameTextField setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f)),
                                       0.0f,
                                       (KProjectScreenWidth - KXCUIControlSizeWidth(120.0f) - KInforLeftIntervalWidth),
                                       KFunctionModulButtonHeight)];
    self.userNameContentField = nameTextField;
    [userBGView addSubview:self.userNameContentField];
    
    UIView *sepUserNameView = [[UIView alloc]init];
    [sepUserNameView setFrame:CGRectMake(0.0f, (nameTextField.bottom),
                                         userBGView.width, 1.0f)];
    [sepUserNameView setBackgroundColor:KSepLineColorSetup];
    [userBGView addSubview:sepUserNameView];
    
    
    UILabel *countryCode = [[UILabel alloc]init];
    [countryCode setBackgroundColor:[UIColor clearColor]];
    [countryCode setTextColor:KContentTextColor];
    [countryCode setFont:KFunctionModuleContentFont];
    [countryCode setTextAlignment:NSTextAlignmentLeft];
    [countryCode setText:@"+86"];
    [countryCode setFrame:CGRectMake(KInforLeftIntervalWidth, sepUserNameView.bottom,
                                     KXCUIControlSizeWidth(30.0f), KFunctionModulButtonHeight)];
    [userBGView addSubview:countryCode];
    
    
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
                                        sepUserNameView.bottom, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
    self.phoneContentField = phoneTextField;
    [userBGView addSubview:self.phoneContentField];
    
    UIView *sepUserView = [[UIView alloc]init];
    [sepUserView setFrame:CGRectMake(0.0f, (phoneTextField.bottom),
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
    [emailTextField setReturnKeyType:UIReturnKeyDone];
    [emailTextField setTag:KTextForEmailTextTag];
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
    
    //MARK:支付方式
    UIView *payStyleBGView = [[UIView alloc]init];
    [payStyleBGView setBackgroundColor:[UIColor whiteColor]];
    [payStyleBGView setFrame:CGRectMake(0.0f, (userBGView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                        (KFunctionModulButtonHeight))];
    self.trainTicketPayStyleBGView = payStyleBGView;
    [mainView addSubview:self.trainTicketPayStyleBGView];
    
    UILabel  *payStyleLabel = [[UILabel alloc]init];
    [payStyleLabel setBackgroundColor:[UIColor clearColor]];
    [payStyleLabel setTextAlignment:NSTextAlignmentLeft];
    [payStyleLabel setTextColor:KFunctionModuleContentColor];
    [payStyleLabel setFont:KFunctionModuleContentFont];
    [payStyleLabel setText:@"支付方式"];
    [payStyleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [payStyleBGView addSubview:payStyleLabel];
    
    UILabel  *payContentLabel = [[UILabel alloc]init];
    [payContentLabel setBackgroundColor:[UIColor clearColor]];
    [payContentLabel setTextAlignment:NSTextAlignmentLeft];
    [payContentLabel setTextColor:KFunctionModuleContentColor];
    [payContentLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [payContentLabel setText:@"担保"];
    [payContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth),0.0f, 90.0f, KFunctionModulButtonHeight)];
    [payStyleBGView addSubview:payContentLabel];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(KProjectScreenWidth, self.trainTicketPayStyleBGView.bottom + KXCUIControlSizeWidth(120.0f))];
    
    ///MARK:初始化底部信息
    CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
    
    CGRect orderDetailRect = CGRectMake(0.0f, (self.view.bounds.size.height
                                               - navigationBarHeight),
                                        KProjectScreenWidth,
                                        (self.view.bounds.size.height
                                         - navigationBarHeight));
    
    TrainTicketOrderDetailInforView *orderDetail = [[TrainTicketOrderDetailInforView alloc]initWithFrame:orderDetailRect];
    self.userOrderDetailedView = orderDetail;
    [self.view addSubview:self.userOrderDetailedView];
    
    CGRect bottomRect = CGRectMake(0.0f,
                                   (self.view.bounds.size.height - KXCUIControlSizeWidth(50.0f)
                                    - navigationBarHeight)
                                   , KProjectScreenWidth, KXCUIControlSizeWidth(50.0f));
    UIView *bottomView = [[UIView alloc]init];
    [bottomView setFrame:bottomRect];
    [bottomView setBackgroundColor:HUIRGBColor(61.0f, 75.0f, 87.0f, 1.0f)];
    [self.view addSubview:bottomView];
    
    
    UILabel *RMBLabel = [[UILabel alloc]init];
    [RMBLabel setBackgroundColor:[UIColor clearColor]];
    [RMBLabel setTextColor:[UIColor whiteColor]];
    [RMBLabel setText:@"￥"];
    [RMBLabel setFont:KXCAPPUIContentDefautFontSize(12.5)];
    [RMBLabel setFrame:CGRectMake(10.0f, 0.0f, 15.0f,  KXCUIControlSizeWidth(50.0f))];
    [bottomView addSubview:RMBLabel];
    
    UILabel *totalConsumption = [[UILabel alloc]init];
    [totalConsumption setBackgroundColor:[UIColor clearColor]];
    [totalConsumption setTextColor:KUnitPriceContentColor];
    [totalConsumption setFont: [UIFont boldSystemFontOfSize:((19)*KXCAdapterSizeWidth)]];
    [totalConsumption setTextAlignment:NSTextAlignmentLeft];
    [totalConsumption setFrame:CGRectMake(RMBLabel.right, 0.0f, KXCUIControlSizeWidth(160.0f),
                                          KXCUIControlSizeWidth(50.0f))];
    self.userOrderTotalConsumption = totalConsumption;
    [self.userOrderTotalConsumption setText:@"0"];
    [bottomView addSubview:self.userOrderTotalConsumption ];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setTitle:@"支付" forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:KXCAPPUIContentFontSize(17)];
    [nextButton setBackgroundImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))
                          forState:UIControlStateNormal];
    [nextButton setBackgroundImage:createImageWithColor(HUIRGBColor(185.0f, 121.0f, 38.0f, 1.0))
                          forState:UIControlStateHighlighted];
    [nextButton setTag:KBtnForPayButtonTag];
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
    [detailedButton setTag:KBtnForOrderDetailedButtonTag];
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
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    TrainTicketSeatSelectedLayerView *hotelRecommendView = [[TrainTicketSeatSelectedLayerView alloc]initWithFrame:layerViewRect withSearchContent:self.ticketOrderInfor.ttOrderTrainticketInfor.traServiceAtAllLevelsArray];
    [hotelRecommendView setDelegate:self];
    self.trainTicketSeatSelectedLayerView = hotelRecommendView;
    [self.navigationController.view addSubview:self.trainTicketSeatSelectedLayerView];
    
    [self requestVerifyTrainTickeValidAndReserve:self.ticketOrderInfor.ttOrderTrainticketInfor.traCabinModelStr price:@""];
    
    
    if (!IsStringEmptyOrNull(KXCAPPCurrentUserInformation.userNameStr)) {
        [self.userNameContentField setText:KXCAPPCurrentUserInformation.userNameStr];
    }else if (!IsStringEmptyOrNull(KXCAPPCurrentUserInformation.userNickNameStr)){
        [self.userNameContentField setText:KXCAPPCurrentUserInformation.userNickNameStr];
    }
    
    if (!IsStringEmptyOrNull(KXCAPPCurrentUserInformation.userPerPhoneNumberStr)) {
        [self.phoneContentField setText:KXCAPPCurrentUserInformation.userPerPhoneNumberStr];
    }
    
    if (!IsStringEmptyOrNull(KXCAPPCurrentUserInformation.userPerEmailStr)) {
        [self.emailContentField setText:KXCAPPCurrentUserInformation.userPerEmailStr];
    }
    
    
}

- (void)setupTrainTicketInformation:(UIScrollView *)mainView rect:(CGRect)frame{
    
    UIView *trainBGView =[[UIView alloc]init];
    [trainBGView setFrame:frame];
    [trainBGView.layer setBorderWidth:1.0];
    [trainBGView.layer setBorderColor:KSepLineColorSetup.CGColor];
    [trainBGView.layer setCornerRadius:5.0f];
    [trainBGView.layer setMasksToBounds:YES];
    [trainBGView setBackgroundColor:[UIColor whiteColor]];
    [mainView addSubview:trainBGView];
    
    UIView *trainTicketView = [[UIView alloc]init];
    [trainTicketView setBackgroundColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f)];
    [trainTicketView setFrame:CGRectMake(0.0f, 0.0f, frame.size.width,
                                         frame.size.height - KFunctionModulButtonHeight)];
    [trainBGView addSubview:trainTicketView];
    
    
    NSString *dataNumberStr = [NSString stringWithFormat:@"%@ %@ %@",self.ticketOrderInfor.ttOrderDepartDate,self.ticketOrderInfor.ttOrderTrainticketInfor.traCodeNameStr,self.ticketOrderInfor.ttOrderTrainticketInfor.traTypeStr];
    UILabel *dateNumber = [[UILabel alloc]init];
    [dateNumber setTextAlignment:NSTextAlignmentLeft];
    [dateNumber setTextColor:[UIColor whiteColor]];
    [dateNumber setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                    (trainTicketView.width - KInforLeftIntervalWidth*2),
                                    KXCUIControlSizeWidth(20.0f))];
    [dateNumber setFont:KXCAPPUIContentDefautFontSize(12.0f)];
    [dateNumber setBackgroundColor:[UIColor clearColor]];
    [dateNumber setText:dataNumberStr];
    [trainTicketView addSubview:dateNumber];
    
    UILabel *beginDate = [[UILabel alloc]init];
    [beginDate setTextAlignment:NSTextAlignmentLeft];
    [beginDate setTextColor:[UIColor whiteColor]];
    [beginDate setFrame:CGRectMake(KInforLeftIntervalWidth, (dateNumber.bottom + KXCUIControlSizeWidth(5.0f)),
                                   (trainTicketView.width/3),
                                   KXCUIControlSizeWidth(40.0f))];
    [beginDate setFont:KXCAPPUIContentDefautFontSize(30.0f)];
    [beginDate setBackgroundColor:[UIColor clearColor]];
    [beginDate setText:self.ticketOrderInfor.ttOrderTrainticketInfor.traTakeOffTime];
    [trainTicketView addSubview:beginDate];
    
    UILabel *endDate = [[UILabel alloc]init];
    [endDate setTextAlignment:NSTextAlignmentLeft];
    [endDate setTextColor:[UIColor whiteColor]];
    [endDate setFrame:CGRectMake((trainTicketView.width -  KInforLeftIntervalWidth - (trainTicketView.width/3)),
                                 (dateNumber.bottom + KXCUIControlSizeWidth(5.0f)),
                                 (trainTicketView.width/3),
                                 KXCUIControlSizeWidth(40.0f))];
    [endDate setFont:KXCAPPUIContentDefautFontSize(30.0f)];
    [endDate setBackgroundColor:[UIColor clearColor]];
    [endDate setTextAlignment:NSTextAlignmentRight];
    [endDate setText:[self.ticketOrderInfor.ttOrderTrainticketInfor.traArrivedTime substringToIndex:5]];
    [trainTicketView addSubview:endDate];
    
    UILabel *beginSite = [[UILabel alloc]init];
    [beginSite setTextAlignment:NSTextAlignmentLeft];
    [beginSite setTextColor:[UIColor whiteColor]];
    [beginSite setFrame:CGRectMake(KInforLeftIntervalWidth, (endDate.bottom + KXCUIControlSizeWidth(5.0f)),
                                   (trainTicketView.width/3),
                                   KXCUIControlSizeWidth(20.0f))];
    [beginSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginSite setBackgroundColor:[UIColor clearColor]];
    [beginSite setText:self.ticketOrderInfor.ttOrderTrainticketInfor.traTakeOffSite];
    [trainTicketView addSubview:beginSite];
    
    UILabel *arrivedSite = [[UILabel alloc]init];
    [arrivedSite setTextAlignment:NSTextAlignmentLeft];
    [arrivedSite setTextColor:[UIColor whiteColor]];
    [arrivedSite setFrame:CGRectMake((trainTicketView.width -  KInforLeftIntervalWidth - (trainTicketView.width/3)),
                                     (endDate.bottom + KXCUIControlSizeWidth(5.0f)),
                                     (trainTicketView.width/3),
                                     KXCUIControlSizeWidth(20.0f))];
    [arrivedSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedSite setBackgroundColor:[UIColor clearColor]];
    [arrivedSite setTextAlignment:NSTextAlignmentRight];
    [arrivedSite setText:self.ticketOrderInfor.ttOrderTrainticketInfor.traArrivedSite];
    [trainTicketView addSubview:arrivedSite];
    
    
    UIButton *refundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refundBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(240.0f) - KInforLeftIntervalWidth),
                                   trainTicketView.bottom, KXCUIControlSizeWidth(240.0f),
                                   KFunctionModulButtonHeight)];
    [refundBtn setTag:KBtnForRefundButtonTag];
    [refundBtn addTarget:self action:@selector(userOperationButtonClickedEvent:)
        forControlEvents:UIControlEventTouchUpInside];
    [refundBtn setBackgroundColor:[UIColor clearColor]];
    [refundBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [refundBtn setTitleColor:KSubTitleTextColor forState:UIControlStateHighlighted];
    [refundBtn setTitle:@"取票、退改签说明和预定须知>" forState:UIControlStateNormal];
    [refundBtn.titleLabel setFont:KXCAPPUIContentFontSize(13.0f)];
    [refundBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateNormal];
    [refundBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateHighlighted];
    [trainBGView addSubview:refundBtn];
    
    
    UITapGestureRecognizer *tapOwner = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.mainScrollView addGestureRecognizer:tapOwner];
}

#pragma mark -
#pragma mark - 设置界面点击效果
- (void)didTapOnTableView:(UIGestureRecognizer*) recognizer {
    
    if ([self.emailContentField isFirstResponder] || [self.phoneContentField isFirstResponder]) {
        recognizer.cancelsTouchesInView = YES;
        [self.view endEditing:YES];
    }else{
        recognizer.cancelsTouchesInView = NO;
    }
}

- (void)userOperationButtonClickedEvent:(UIButton *)button{
    
    ///关联12306账户
    if (KBtnForRelatedButtonTag == button.tag) {
        
        if (KXCShareFMSetting.userPersonalIsRelatedAccountBool) {
            
            NSString *errorStr = [NSString stringWithFormat:@"您已绑定用户名为“%@”的12306账号，是否要更改？",KXCShareFMSetting.userPersonalRelatedAccountNameStr];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:errorStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更改", nil];
            [alertView setTag:KAlertViewForRelatedTag];
            [alertView show];
            return;
        }
        RelatedCNTViewController *viewController = [[RelatedCNTViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    ///经停站
    else if (KBtnForPassStationButtonTag == button.tag){
        TrainPassStationController *viewController = [[TrainPassStationController alloc]initWith:self.ticketOrderInfor.ttOrderTrainticketInfor];
        XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigation animated:YES completion:^{
            
        }];
    }
    
    ///退款须知
    else if (KBtnForRefundButtonTag == button.tag){
        ReturnedMoneyInstructionsController*viewController = [[ReturnedMoneyInstructionsController alloc]init];
        XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigation animated:YES completion:^{
            
        }];
    }
    
    ///选择座席
    else if (KBtnForSelectSeatButtonTag == button.tag){
        
        [self.view endEditing:YES];
        CGRect layerViewRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.trainTicketSeatSelectedLayerView setFrame:layerViewRect];
        }];
    }
    
    ///添加乘客
    else if (KBtnForAddUserButtonTag == button.tag){
        
        SelectedUserInforViewController  *viewController = [[SelectedUserInforViewController alloc]initWithTitleStr:@"出行人" withSelected:self.userInforMutableArray];
        [viewController setDelegate:self];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    ///价格明细
    else if (KBtnForOrderDetailedButtonTag == button.tag){
        
        if (self.ticketOrderInfor.ttTicketTotalVolume ==0.0f ||
            self.ticketOrderInfor.ttTicketCountInteger == 0) {
            ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"未添加乘客，无法查看明细");
            return;
        }
        
        CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect orderDetailRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                (self.view.bounds.size.height
                                                 - navigationBarHeight));
            
            [self.userOrderDetailedView setFrame:orderDetailRect];
        }];
        
        [self.userOrderDetailedView detailForTrainTicketOrderInfor:self.ticketOrderInfor];
    }
    
    else if (KBtnForPayButtonTag == button.tag){
        
        [self userUploadOrderInforRequestOperation];
    }
}

- (void)addFinishUserInfor:(UserInformationClass *)userInfor{
    
    if (userInfor) {
        
        [self.userInforMutableArray addObject:userInfor];
        [self replaceAllPassengerUserInfor];
    }
}


- (void)replaceAllPassengerUserInfor{
    NSInteger userCountInt = self.userInforMutableArray.count;
    
    [self.usersInforBGView setHeight:(KFunctionModulButtonHeight + (userCountInt*KFunctionModulButtonHeight*1.5))];
    [self.usersInforBGView setTop:(self.selectedSeatButton.bottom + KInforLeftIntervalWidth)];
    
    [self.relatedReporterView setFrame:CGRectMake(0.0f, (self.usersInforBGView.bottom + KInforLeftIntervalWidth),
                                                  KProjectScreenWidth, (KFunctionModulButtonHeight*3+2.0f))];
    
    [self.trainTicketPayStyleBGView  setFrame:CGRectMake(0.0f, (self.relatedReporterView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                                         (KFunctionModulButtonHeight))];
    
    [self.mainScrollView setContentSize:CGSizeMake(KProjectScreenWidth, self.trainTicketPayStyleBGView.bottom + KXCUIControlSizeWidth(120.0f))];
    
    for (UIButton *operationBtn in self.usersInforBGView.subviews) {
        
        if ([operationBtn isKindOfClass:[UIButton class]]) {
            
            if (operationBtn.tag != KBtnForAddUserButtonTag) {
                [operationBtn removeFromSuperview];
            }
        }
    }
    
    
    CGFloat beginYPointFloat = KFunctionModulButtonHeight;
    //    for (UserInformationClass *userInfor in self.userInforMutableArray) {
    
    for (int userCountIndex = 0; userCountIndex < userCountInt; userCountIndex++) {
        
        UserInformationClass *userInfor = (UserInformationClass *)[self.userInforMutableArray objectAtIndex:userCountIndex];
        UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [userButton setBackgroundColor:[UIColor whiteColor]];
        [userButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
        [userButton setBackgroundColor:[UIColor whiteColor]];
        [userButton addTarget:self action:@selector(userEditOperationButtonEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        [userButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateHighlighted];
        [userButton setTag:(KBtnUserBaseButtonTag+userCountIndex)];
        [userButton setFrame:CGRectMake(0.0f, beginYPointFloat, KProjectScreenWidth, KFunctionModulButtonHeight*1.5)];
        [self.usersInforBGView addSubview:userButton];
        beginYPointFloat += KFunctionModulButtonHeight*1.5;
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"userDeleteImage.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(userDeleteOperationButtonEventClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setTag:(KBtnUserDeleteBaseButtonTag+userCountIndex)];
        [deleteBtn setFrame:CGRectMake(KInforLeftIntervalWidth*1.5, (KFunctionModulButtonHeight*1.5 - KXCUIControlSizeWidth(20.0f))/2, KXCUIControlSizeWidth(20.0f), KXCUIControlSizeWidth(20.0f))];
        [deleteBtn.layer setCornerRadius:KXCUIControlSizeWidth(20.0f)/2];
        [deleteBtn.layer setMasksToBounds:YES];
        [userButton addSubview:deleteBtn];
        
        
        UIView *sepPayView = [[UIView alloc]init];
        [sepPayView setFrame:CGRectMake(0.0f,0.0f,
                                        userButton.width, 1.0f)];
        [sepPayView setBackgroundColor:KSepLineColorSetup];
        [userButton addSubview:sepPayView];
        
        UILabel *userNameInfor = [[UILabel alloc]init];
        [userNameInfor setBackgroundColor:[UIColor clearColor]];
        [userNameInfor setTextColor:KContentTextColor];
        [userNameInfor setText:userInfor.userNameStr];
        
        [userNameInfor setTag:(userButton.tag + KBtnUserNameInterval)];
        [userNameInfor setTextAlignment:NSTextAlignmentLeft];
        [userNameInfor setFont:KXCAPPUIContentFontSize(15.0f)];
        [userNameInfor setFrame:CGRectMake((45.0f+KFunctionModuleContentLeftWidth*2),KXCUIControlSizeWidth(10.0f),
                                           ( KXCUIControlSizeWidth(200.0f)), ((KFunctionModulButtonHeight*1.5 - KXCUIControlSizeWidth(20.0f))/2))];
        [userButton addSubview:userNameInfor];
        
        
        UILabel *userCardIdInfor = [[UILabel alloc]init];
        [userCardIdInfor setBackgroundColor:[UIColor clearColor]];
        [userCardIdInfor setTextColor:KContentTextColor];
        [userCardIdInfor setText:[NSString stringWithFormat:@"%@ %@",userInfor.userPerCredentialStyle,
                                  userInfor.userPerCredentialContent]];
        [userCardIdInfor setTag:(userButton.tag + KBtnUserCerCodeInterval)];
        [userCardIdInfor setTextAlignment:NSTextAlignmentLeft];
        [userCardIdInfor setFont:KXCAPPUIContentFontSize(15.0f)];
        [userCardIdInfor setFrame:CGRectMake((45.0f+KFunctionModuleContentLeftWidth*2),(userNameInfor.bottom),
                                             ( KXCUIControlSizeWidth(200.0f)), ((KFunctionModulButtonHeight*1.5 - KXCUIControlSizeWidth(20.0f))/2))];
        [userButton addSubview:userCardIdInfor];
        
        UILabel *nextSeatLabel = [FontAwesome labelWithFAIcon:FMIconRightReturn
                                                         size:KUserPersonalRightButtonArrowFontSize
                                                        color:KFunNextArrowColor];
        [nextSeatLabel setFrame:CGRectMake((KProjectScreenWidth - 20.0f - KInforLeftIntervalWidth) ,
                                           (KFunctionModulButtonHeight*1.5 - 20.0f)/2, 20.0f, 20.0f)];
        [nextSeatLabel setBackgroundColor:[UIColor clearColor]];
        [nextSeatLabel setContentMode:UIViewContentModeCenter];
        [userButton addSubview:nextSeatLabel];
    }
    
    
    ///计算消费信息
    [self calculateAllTotalConsumption];
}
///计算消费信息
- (void)calculateAllTotalConsumption{
    
    ///火车票数据转换 票面价格 tp
    CGFloat ticketPriceFloat = [self.ticketOrderInfor.ttOrderTrainticketInfor.traUnitPrice doubleValue];
    
    //每张火车票实际支付金额 票务单价计算公式 sum = (无付费 + 票面价格)
    //    CGFloat oneUserPrice =ticketPriceFloat + [self.ticketOrderInfor.ttOrderTrainticketInfor.traServiceCostStr doubleValue];
    ///目前没有服务费
    CGFloat oneUserPrice =ticketPriceFloat + 0;
    
    
    ///数量计算（即：成人人数）n
    NSInteger userCountInteger = self.userInforMutableArray.count;
    
    ///计算总数 支付金额总数 totalMoney = (票务价格sum × n)
    CGFloat totalConsumption = oneUserPrice*userCountInteger;
    
    [self.userOrderTotalConsumption setText:[NSString stringWithFormat:@"%.1lf",totalConsumption]];
    [self.ticketOrderInfor setTtTicketCountInteger:userCountInteger];
    [self.ticketOrderInfor setTtTicketTotalVolume:totalConsumption];
    NSLog(@"消费清单信息：\n\n票务单价 %.2lf\n消费单价 %.2lf\n消费总价%.2lf",ticketPriceFloat,oneUserPrice,totalConsumption);
}

- (void)editFinishUserInfor:(UserInformationClass *)userInfor withIndex:(NSInteger)index{
    
    ///替换数组
    [self.userInforMutableArray replaceObjectAtIndex:index withObject:userInfor];
    
    NSInteger btnTag = (KBtnUserBaseButtonTag+index);
    UIButton *button = (UIButton *)[self.usersInforBGView viewWithTag:btnTag];
    
    UILabel *nameLabel = (UILabel *)[button viewWithTag:(btnTag + KBtnUserNameInterval)];
    [nameLabel setText:userInfor.userNameStr];
    
    UILabel *cerCodeLabel = (UILabel *)[button viewWithTag:(btnTag + KBtnUserCerCodeInterval)];
    [cerCodeLabel setText:[NSString stringWithFormat:@"%@ %@",userInfor.userPerCredentialStyle,
                           userInfor.userPerCredentialContent]];
    
    //    [self loginConsol];
}

- (void)loginConsol{
    
    NSLog(@"******************************************");
    for (UserInformationClass *userInfor in self.userInforMutableArray) {
        
        
        NSLog(@"-----------------\n 姓名\t\t%@\n类型\t\t%@\n编号\t\t%@",userInfor.userNameStr,
              userInfor.userPerCredentialStyle,
              userInfor.userPerCredentialContent);
    }
}

- (void)userEditOperationButtonEventClicked:(UIButton *)button{
    
    NSLog(@"userButton.tag is %zi",button.tag);
    
    NSInteger index = button.tag - KBtnUserBaseButtonTag;
    if (index >= 0) {
        
        UserInformationClass *userInfor = (UserInformationClass *)[self.userInforMutableArray objectAtIndex:index];
        AddTrainTicketUserInforController *viewController = [[AddTrainTicketUserInforController alloc]initWithUserInfor:userInfor withIndex:index];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigation animated:YES completion:^{
            
        }];
    }
    
}

- (void)userDeleteOperationButtonEventClicked:(UIButton *)button{
    
    
    NSInteger index = button.tag - KBtnUserDeleteBaseButtonTag;
    
    NSLog(@"userButton.tag is %zi",index);
    
    
    if (index >= 0) {
        
        UserInformationClass *userInfor = (UserInformationClass *)[self.userInforMutableArray objectAtIndex:index];
        self.willDeleteUserInfor = userInfor;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要移除当前联系人吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"移除", nil];
        [alertView setTag:KAlertViewForDeleteTag];
        [alertView show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag == KAlertViewForDeleteTag) {
        if (buttonIndex != 0) {
            
//            NSLog(@"可以移除当前联系人");
            [self.userInforMutableArray removeObject:self.willDeleteUserInfor];
            [self replaceAllPassengerUserInfor];
//            NSLog(@"-----------------\n 姓名\t\t%@\n类型\t\t%@\n编号\t\t%@",self.willDeleteUserInfor.userNameStr,
//                  self.willDeleteUserInfor.userPerCredentialStyle,
//                  self.willDeleteUserInfor.userPerCredentialContent);
        }
    }
    
    else if (alertView.tag == KAlertViewForRelatedTag){
        
        if (buttonIndex != 0) {
            RelatedCNTViewController *viewController = [[RelatedCNTViewController alloc]init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    
}

- (void)userSelectedUserArray:(NSArray *)userArray isDeleteSelectedBool:(BOOL)deleteBool{
    //    if (userArray.count > 0) {
    
    ///移除以前的
    if (self.userInforMutableArray.count > 0) {
        [self.userInforMutableArray removeAllObjects];
        
        for (UIButton *button in [self.usersInforBGView subviews]) {
            if (button) {
                if(KBtnForAddUserButtonTag != button.tag){
                    [button removeFromSuperview];
                }
            }
        }
    }
    
    ///加入当前的
    for (UserInformationClass *userInfor in userArray) {
        [self addFinishUserInfor:userInfor];
    }
}

- (void)userUploadOrderInforRequestOperation{
    
    
    if (IsStringEmptyOrNull(self.userNameContentField.text)) {
        
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"联系人名字不能为空！");
        return;
    }
    
    
    if (IsStringEmptyOrNull(self.emailContentField.text)) {
        
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"联系人邮箱不能为空！");
        return;
    }
    
    if (IsStringEmptyOrNull(self.phoneContentField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"联系人电话不能为空！");
        return;
    }
    
    
    if (self.userInforMutableArray.count < 1) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"至少添加 1 位乘客");
        return;
    }
    
    [self.ticketOrderInfor.ttOrderReserveUserInfor setUserNickNameStr:self.userNameContentField.text];
    [self.ticketOrderInfor.ttOrderReserveUserInfor setUserPerEmailStr:self.emailContentField.text];
    [self.ticketOrderInfor.ttOrderReserveUserInfor setUserPerPhoneNumberStr:self.phoneContentField.text];
    [self.ticketOrderInfor setTtOrderBuyTicketUserMutArray:self.userInforMutableArray];
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    WaittingMBProgressHUD(HUIKeyWindow,@"提交订单");
    [XCAPPHTTPClient requestUserCreateTrainTickeOrderWithOrderParam:self.ticketOrderInfor completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"response.responseObject is %@",response.responseObject);
            
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                
                FinishMBProgressHUD(HUIKeyWindow);
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    NSString *orderNoStr = @"";
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"orderNo") isKindOfClass:[NSString class]]) {
                        orderNoStr = StringForKeyInUnserializedJSONDic(dataDictionary, @"orderNo") ;
                    }
                    
                    NSString *qunarOrderNoStr = @"";
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"qunarOrderNo") isKindOfClass:[NSString class]]) {
                        qunarOrderNoStr = StringForKeyInUnserializedJSONDic(dataDictionary, @"qunarOrderNo") ;
                    }
                    ////进行界面跳转
                    if ((!IsStringEmptyOrNull(orderNoStr))&&(!IsStringEmptyOrNull(qunarOrderNoStr))) {
                        
                        UserPersonalOrderInformation *orderInfor = [[UserPersonalOrderInformation alloc]init];
                        
                        [orderInfor setUserOrderStyle:XCAPPOrderForTrainTicketStyle];
                        [orderInfor setTrainticketOrderInfor:self.ticketOrderInfor];
                        [orderInfor.trainticketOrderInfor setTtOrderTradeNumber:orderNoStr];
                        [orderInfor.trainticketOrderInfor setTtOrderTradeNumberCodeForQuNaErStr:qunarOrderNoStr];
                        OrderImmediatePayViewController *viewController = [[OrderImmediatePayViewController alloc]initWithOderInfor:orderInfor];
                        [weakSelf.navigationController pushViewController:viewController animated:YES];
                    }
                }
            }else{
                NSString *errorStr = [NSString stringWithFormat:@"【错误内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                FailedMBProgressHUD(HUIKeyWindow,errorStr);
                NSLog(@"response.responseObject【错误内容】 is %@\nerrorStr is %@",response.responseObject,errorStr);
            }
        });
        
    }];
    return;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    CGFloat scrollContentY =(self.userInforMutableArray.count *1.5*KFunctionModulButtonHeight) + KXCUIControlSizeWidth(350.0f);
    [self.mainScrollView setContentOffset:CGPointMake(0.0f, scrollContentY) animated:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == KTextForEmailTextTag) {
        [self.mainScrollView setContentOffset:CGPointMake(0.0f, KXCUIControlSizeWidth(20.0f)) animated:YES];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    
    if (textField.tag == KTextForPhoneTextTag) {
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

///用户选座操作协议处理事件
- (void)userSelectedSearchStyle:(NSInteger)Searchstyle{
    
    
    if (self.ticketOrderInfor.ttOrderTrainticketInfor.traServiceAtAllLevelsArray.count > Searchstyle) {
        
        NSDictionary *seatDictionary = (NSDictionary *)[self.ticketOrderInfor.ttOrderTrainticketInfor.traServiceAtAllLevelsArray objectAtIndex:Searchstyle];
        
        NSString *seatPrice = StringForKeyInUnserializedJSONDic(seatDictionary, @"seatPrice");
        NSString *seatTypeStr = StringForKeyInUnserializedJSONDic(seatDictionary, @"seatType");
        
        [self requestVerifyTrainTickeValidAndReserve:seatTypeStr price:seatPrice];
        
        
        for (NSString *key in seatDictionary) {
            NSString *valuesStr = StringForKeyInUnserializedJSONDic(seatDictionary, key);
            NSLog(@"key \t %@\nvaluesStr\t %@",key,valuesStr);
        }
    }
}

- (void)requestVerifyTrainTickeValidAndReserve:(NSString *)traCabinModelStr price:(NSString *)priceStr{
    
    __weak __typeof(&*self)weakSelf = self;
    
    [XCAPPHTTPClient requestVerifyTrainTickeValidAndReserveWithTrainNo:self.ticketOrderInfor.ttOrderTrainticketInfor.traCodeNameStr from:self.ticketOrderInfor.ttOrderTrainticketInfor.traTakeOffSite to:self.ticketOrderInfor.ttOrderTrainticketInfor.traArrivedSite date:self.ticketOrderInfor.ttOrderDepartDate seatType:traCabinModelStr
                                                            completion:^(WebAPIResponse *response) {
                                                                dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                    
                                                                    NSLog(@"response.responseObject is %@",response.responseObject);
                                                                    if (response.code == WebAPIResponseCodeSuccess) {
                                                                        
                                                                        if (![weakSelf.ticketOrderInfor.ttOrderTrainticketInfor.traCabinModelStr isEqualToString:traCabinModelStr]) {
                                                                            
                                                                            [weakSelf.ticketOrderInfor.ttOrderTrainticketInfor setTraCabinModelStr:traCabinModelStr];
                                                                            [weakSelf.ticketOrderInfor.ttOrderTrainticketInfor setTraUnitPrice:priceStr];
                                                                            
                                                                            /*
                                                                             trainEndTime = 201609151753;
                                                                             trainStartTime = 201609150740;
                                                                             **/
                                                                            
                                                                            if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                                                                                NSDictionary *dataDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                                                                                
                                                                                
                                                                                [weakSelf.ticketOrderInfor.ttOrderTrainticketInfor setTraArrivedTimeSealStr:StringForKeyInUnserializedJSONDic(dataDictionary, @"trainEndTime")];
                                                                                [weakSelf.ticketOrderInfor.ttOrderTrainticketInfor setTraTakeOffTimeSealStr:StringForKeyInUnserializedJSONDic(dataDictionary, @"trainStartTime")];
                                                                                
                                                                                NSString *seatContentStr =[NSString stringWithFormat:@"%@ ￥%@",weakSelf.ticketOrderInfor.ttOrderTrainticketInfor.traCabinModelStr,weakSelf.ticketOrderInfor.ttOrderTrainticketInfor.traUnitPrice];
                                                                                NSRange contentRange=[seatContentStr rangeOfString:weakSelf.ticketOrderInfor.ttOrderTrainticketInfor.traUnitPrice];
                                                                                NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:seatContentStr];
                                                                                [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(18.0f) range:contentRange];
                                                                                [dynamicContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:contentRange];
                                                                                [weakSelf.ticketSeatContentLabel setAttributedText:dynamicContent];
                                                                                
                                                                            }
                                                                        }
                                                                        
                                                                    }else {
                                                                        if ([ObjForKeyInUnserializedJSONDic(response.responseObject,@"desc") isKindOfClass:[NSString class]]) {
                                                                            
                                                                            NSString *errorStr = [NSString stringWithFormat:@"%@ %@",weakSelf.ticketOrderInfor.ttOrderTrainticketInfor.traCabinModelStr, StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                                                                            ShowAutoHideMBProgressHUDWithOneSec(HUIKeyWindow,errorStr);
                                                                        }else{
                                                                            ShowAutoHideMBProgressHUDWithOneSec(HUIKeyWindow,@"选座失败，请稍后重试...");
                                                                        }
                                                                    }
                                                                    
                                                                });
                                                            }];
}


@end
