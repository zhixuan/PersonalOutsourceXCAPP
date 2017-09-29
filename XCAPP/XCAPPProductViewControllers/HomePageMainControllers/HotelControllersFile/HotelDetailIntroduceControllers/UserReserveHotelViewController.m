//
//  UserReserveHotelViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UserReserveHotelViewController.h"
#import "AddMoveIntoPersonnelViewController.h"
#import "SelectedUserInforViewController.h"
#import "HotelReserveOrderDetailView.h"

#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"

#import "HotelReserveTenantInforController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"
#import "OrderImmediatePayViewController.h"

#define KBtnForUserButtonTag                (1780111)

#define KBtnForAddUserButtonTag             (1780111)



///添加/减少房间
#define KBtnForAddOneRoomButtonTag      (1470211)
#define KBtnForSubtractRoomButtonTag    (1470212)


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

@interface UserReserveHotelViewController ()<AddMoveIntoPersonnelFinishDelegate,UITextFieldDelegate,HotelReserveTenantOperationDelegate>

/*!
 * @breif 将要产生的订单信息
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation           *willMakeOrderInfor;

/*!
 * @breif 界面移动视图
 * @See
 */
@property (nonatomic , weak)      UIScrollView                          *mainScrollView;


/*!
 * @breif 用户信息视图
 * @See
 */
@property (nonatomic , weak)            UIView                          *usersInforBGView;

/*!
 * @breif 用户订购的房间个数
 * @See
 */
@property (nonatomic , weak)      UILabel                               *userOrderRoomInteger;

/*!
 * @breif 乘客用户信息内容
 * @See
 */
@property (nonatomic , strong)          NSMutableArray                  *userInforMutableArray;




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
@property (nonatomic , weak)      UIView                                *hotelPayStyleBGView;

/*!
 * @breif 将要被移除的用户信息
 * @See
 */
@property (nonatomic , strong)      UserInformationClass                *willDeleteUserInformation;

/*!
 * @breif 用户订单明细信息
 * @See
 */
@property (nonatomic , weak)      HotelReserveOrderDetailView           *userOrderDetailedView;
@end

@implementation UserReserveHotelViewController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (id)initWithUserOrderInfor:(UserHotelOrderInformation *)willOrderInfor{
    self = [super init];
    if (self) {
        self.willMakeOrderInfor = willOrderInfor;
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
    [self setupUserReserveHotelViewControllerFrame];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUserReserveHotelViewControllerFrame{

    self.userInforMutableArray = [[NSMutableArray alloc]init];

    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    self.mainScrollView = mainView;
    [self.view addSubview:self.mainScrollView ];
    
    [self.mainScrollView  setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    UIView *hotelInforBGView = [[UIView alloc]init];
    [hotelInforBGView setBackgroundColor:[UIColor whiteColor]];
    [hotelInforBGView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                          KProjectScreenWidth,
                                          (KXCUIControlSizeWidth(90.0f) + KInforLeftIntervalWidth +
                                           KFunctionModulButtonHeight))];
    [mainView addSubview:hotelInforBGView];
    
    
    UILabel *hotelNameLabel = [[UILabel alloc]init];
    [hotelNameLabel setBackgroundColor:[UIColor clearColor]];
    [hotelNameLabel setTextAlignment:NSTextAlignmentLeft];
    [hotelNameLabel setTextColor:KFunctionModuleContentColor];
    [hotelNameLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
    [hotelNameLabel setText:[NSString stringWithFormat:@"%@(%@)",self.willMakeOrderInfor.orderHotelInforation.hotelNameContentStr,self.willMakeOrderInfor.orderHotelInforation.hotelAddressRoughStr]];
    [hotelNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth,KXCUIControlSizeWidth(8.0f), (KProjectScreenWidth - KInforLeftIntervalWidth*2), KXCUIControlSizeWidth(23.0f))];
    [hotelInforBGView addSubview:hotelNameLabel];
    
    UILabel *hotelRoomLabel = [[UILabel alloc]init];
    [hotelRoomLabel setBackgroundColor:[UIColor clearColor]];
    [hotelRoomLabel setTextAlignment:NSTextAlignmentLeft];
    [hotelRoomLabel setTextColor:KSubTitleTextColor];
    [hotelRoomLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
    
     NSString *subContent = [NSString stringWithFormat:@"%@\t%@",self.willMakeOrderInfor.orderHotelRoomInforation.hotelMorningMealContent,self.willMakeOrderInfor.orderHotelRoomInforation.hotelRoomBerthContent];
    [hotelRoomLabel setText:subContent];
    [hotelRoomLabel setFrame:CGRectMake(KInforLeftIntervalWidth,(KXCUIControlSizeWidth(4.0f) + hotelNameLabel.bottom), (KProjectScreenWidth - KInforLeftIntervalWidth*2), KXCUIControlSizeWidth(23.0f))];
    [hotelInforBGView addSubview:hotelRoomLabel];
    
    UILabel *roomStayLabel =   [[UILabel alloc]init];
    [roomStayLabel setBackgroundColor:[UIColor clearColor]];
    [roomStayLabel setTextAlignment:NSTextAlignmentLeft];
    [roomStayLabel setTextColor:KSubTitleTextColor];
    [roomStayLabel setFont:KXCAPPUIContentDefautFontSize(15.0f)];
    NSString *dateInforStr = [NSString stringWithFormat:@"%@ 到 %@\t%zi晚",self.willMakeOrderInfor.orderForHotelBeginDate,self.willMakeOrderInfor.orderForHotelEndDate,self.willMakeOrderInfor.orderStayDayesQuantityInteger];
    [roomStayLabel setText:dateInforStr];
    [roomStayLabel setFrame:CGRectMake(KInforLeftIntervalWidth, (KXCUIControlSizeWidth(4.0f) + hotelRoomLabel.bottom),
                                       (KProjectScreenWidth - KInforLeftIntervalWidth*2), KXCUIControlSizeWidth(18.0f))];
    [hotelInforBGView addSubview:roomStayLabel];
    
    ///人民币符号￥
    NSRange benginDate = [roomStayLabel.text rangeOfString:self.willMakeOrderInfor.orderForHotelBeginDate];
    NSRange endDate = [roomStayLabel.text rangeOfString:self.willMakeOrderInfor.orderForHotelEndDate];
    NSRange stayDayes = [roomStayLabel.text rangeOfString:[NSString stringWithFormat:@"\t%zi",self.willMakeOrderInfor.orderStayDayesQuantityInteger]];

    NSMutableAttributedString *roomStayContent=[[NSMutableAttributedString alloc]initWithString:roomStayLabel.text];
    [roomStayContent addAttribute:NSForegroundColorAttributeName value:KFunNextArrowColor range:benginDate];
    [roomStayContent addAttribute:NSForegroundColorAttributeName value:KFunNextArrowColor range:endDate];
    [roomStayContent addAttribute:NSForegroundColorAttributeName value:KFunNextArrowColor range:stayDayes];
    
    [roomStayLabel setAttributedText:roomStayContent];
    
    
    
    ///酒店基本信息分割视图，该视图下面是预订房间数
    UIView *hotelRoomIntervalView = [[UIView alloc]init];
    [hotelRoomIntervalView setBackgroundColor:KDefaultViewBackGroundColor];
    [hotelRoomIntervalView setFrame:CGRectMake(0.0f, KXCUIControlSizeWidth(90.0f),
                                               KProjectScreenWidth, KInforLeftIntervalWidth)];
    [hotelInforBGView addSubview:hotelRoomIntervalView];
    
    
    UIButton *subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractButton setTag:KBtnForSubtractRoomButtonTag];
    [subtractButton setBackgroundColor:[UIColor clearColor]];
    [subtractButton.titleLabel setFont:KXCAPPUIContentFontSize(23.0f)];
    [subtractButton setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [subtractButton simpleButtonWithImageColor:KStateNormalContentColor];
    [subtractButton.titleLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [subtractButton setAwesomeIcon:FMIconSubtract];
    [subtractButton setFrame:CGRectMake(KInforLeftIntervalWidth*2 ,
                                        (hotelRoomIntervalView.bottom),
                                        KFunctionModulButtonHeight,KFunctionModulButtonHeight)];
    [subtractButton addTarget:self action:@selector(userAddSubtractStayDaysOperationEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
    [subtractButton setBackgroundColor:[UIColor clearColor]];
    [hotelInforBGView addSubview:subtractButton];
    
    
    UILabel *movestayLabel = [[UILabel alloc]init];
    [movestayLabel setBackgroundColor:[UIColor clearColor]];
    [movestayLabel setTextColor:KContentTextColor];
    [movestayLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [movestayLabel setTextAlignment:NSTextAlignmentCenter];
    [movestayLabel setFrame:CGRectMake(KXCUIControlSizeWidth(100.0f), (hotelRoomIntervalView.bottom + (KFunctionModulButtonHeight -  KXCUIControlSizeWidth(23.0f))/2), (hotelInforBGView.width - KXCUIControlSizeWidth(100.0f)*2), KXCUIControlSizeWidth(23.0f))];
    self.userOrderRoomInteger = movestayLabel;
    [hotelInforBGView addSubview:self.userOrderRoomInteger];
    
    [self.userOrderRoomInteger setText:[NSString stringWithFormat:@"住 %zi 间",self.willMakeOrderInfor.orderRoomQuantityInteger]];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTag:KBtnForAddOneRoomButtonTag];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton.titleLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [addButton setTitleColor:KStateNormalContentColor forState:UIControlStateNormal];
    [addButton simpleButtonWithImageColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f)];
    [addButton.titleLabel setFont:KXCAPPUIContentFontSize(22.0f)];
    [addButton setAwesomeIcon:FMIconAdd];
    [addButton setFrame:CGRectMake((hotelInforBGView.width - KInforLeftIntervalWidth*2 -
                                    KFunctionModulButtonHeight),
                                   (hotelRoomIntervalView.bottom),
                                   KFunctionModulButtonHeight,KFunctionModulButtonHeight)];
    [addButton addTarget:self action:@selector(userAddSubtractStayDaysOperationEventClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [hotelInforBGView addSubview:addButton];
    
    
    
    NSInteger userCountInt = self.userInforMutableArray.count;
    
    //MARK:人员信息
    UIView *userInforBGView = [[UIView alloc]init];
    [userInforBGView setFrame:CGRectMake(0.0f, (hotelInforBGView.bottom + KInforLeftIntervalWidth),
                                         KProjectScreenWidth, (KFunctionModulButtonHeight + (userCountInt*KFunctionModulButtonHeight*1.2 + userCountInt)))];
    [userInforBGView setBackgroundColor:[UIColor whiteColor]];
    self.usersInforBGView = userInforBGView;
    [mainView addSubview:self.usersInforBGView];
    
    UILabel  *userTitleLabel = [[UILabel alloc]init];
    [userTitleLabel setBackgroundColor:[UIColor clearColor]];
    [userTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [userTitleLabel setTextColor:KFunctionModuleContentColor];
    [userTitleLabel setFont:KFunctionModuleContentFont];
    [userTitleLabel setText:@"选择入住人"];
    [userTitleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 80.0f, KFunctionModulButtonHeight)];
    [userInforBGView addSubview:userTitleLabel];
    
    UILabel  *userShowLabel = [[UILabel alloc]init];
    [userShowLabel setBackgroundColor:[UIColor clearColor]];
    [userShowLabel setTextAlignment:NSTextAlignmentLeft];
    [userShowLabel setTextColor:KSubTitleTextColor];
    [userShowLabel setFont:KXCAPPUIContentFontSize(12)];
    [userShowLabel setText:@"每间可只填1位入住人"];
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
    [addUserBtn addTarget:self action:@selector(buttonClickedOperation:)
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
    [phoneTextField setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f)),sepUserNameView.bottom,
                                        KXCUIControlSizeWidth(150.0f),
                                        KFunctionModulButtonHeight)];
    self.phoneContentField = phoneTextField;
    [userBGView addSubview:self.phoneContentField];

    UIView *sepUserView = [[UIView alloc]init];
    [sepUserView setFrame:CGRectMake(0.0f, phoneTextField.bottom,
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
    self.hotelPayStyleBGView = payStyleBGView;
    [mainView addSubview:self.hotelPayStyleBGView];
    
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
    
    
    [self.mainScrollView setContentSize:CGSizeMake(KProjectScreenWidth, self.hotelPayStyleBGView.bottom + KXCUIControlSizeWidth(120.0f))];
    
    
    
    
    ///MARK:初始化底部信息
    CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
    
    CGRect orderDetailRect = CGRectMake(0.0f, (self.view.bounds.size.height
                                               - navigationBarHeight),
                                        KProjectScreenWidth,
                                        (self.view.bounds.size.height
                                         - navigationBarHeight));
    
    HotelReserveOrderDetailView *orderDetail = [[HotelReserveOrderDetailView alloc]initWithFrame:orderDetailRect];
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
    
    UITapGestureRecognizer *tapOwner = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.mainScrollView addGestureRecognizer:tapOwner];
    
    
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
    
    [self calculateAllTotalConsumption];
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

- (void)buttonClickedOperation:(UIButton *)button{
    
    if (KBtnForAddUserButtonTag == button.tag){
        HotelReserveTenantInforController  *viewController = [[HotelReserveTenantInforController alloc]initWithTitleStr:@"出行人" withSelected:self.userInforMutableArray];
        [viewController setDelegate:self];
        [self.navigationController pushViewController:viewController animated:YES];
    }

}

- (void)userSelectedTenantUserArray:(NSArray *)userArray isDeleteSelectedBool:(BOOL)deleteBool{
    
    NSLog(@"");
    
    for (UserInformationClass *user in userArray) {
        
        NSLog(@"\n\nuser.userNameStr is %@\n\n",user.userNameStr);
    }
    
    
    ///移除以前的
    if (self.userInforMutableArray.count > 0) {
        [self.userInforMutableArray removeAllObjects];
        
        for (UIButton *button in [self.usersInforBGView subviews]) {
            if (button) {
                if ([button isKindOfClass:[UIButton class]]) {
                    if(KBtnForAddUserButtonTag != button.tag){
                        [button removeFromSuperview];
                    }
                }
                
            }
        }
    }
    
//    ///加入当前的
    for (UserInformationClass *userInfor in userArray) {
        if (userInfor) {
            
            [self.userInforMutableArray addObject:userInfor];
            
            [self replaceAllPassengerUserInfor];
        }
    }


}

#pragma mark -  METHOD For AddMoveIntoPersonnelFinishDelegate
#pragma mark -  新增入住人员信息内容
- (void)userAddFinishUserName:(NSString *)userNameStr{
    
    NSLog(@"userNameStr is %@",userNameStr);
    
    if (userNameStr) {
        
        [self.userInforMutableArray addObject:userNameStr];
        
        [self replaceAllPassengerUserInfor];
    }

}

- (void)replaceAllPassengerUserInfor{
    NSInteger userCountInt = self.userInforMutableArray.count;
    
    [self.usersInforBGView setHeight:(KFunctionModulButtonHeight + (userCountInt*KFunctionModulButtonHeight*1.2))];
    [self.usersInforBGView setTop:((KXCUIControlSizeWidth(90.0f) + KInforLeftIntervalWidth +
                                    KFunctionModulButtonHeight) + KInforLeftIntervalWidth*2)];
    
    [self.relatedReporterView setFrame:CGRectMake(0.0f, (self.usersInforBGView.bottom + KInforLeftIntervalWidth),
                                                  KProjectScreenWidth, (KFunctionModulButtonHeight*3+2.0f))];
    
    [self.hotelPayStyleBGView  setFrame:CGRectMake(0.0f, (self.relatedReporterView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                                         (KFunctionModulButtonHeight))];
    
    [self.mainScrollView setContentSize:CGSizeMake(KProjectScreenWidth,self.hotelPayStyleBGView .bottom + KXCUIControlSizeWidth(120.0f))];
    
    
    
    for (UIButton *operationBtn in self.usersInforBGView.subviews) {
        
        if ([operationBtn isKindOfClass:[UIButton class]]) {
            
            if (operationBtn.tag != KBtnForAddUserButtonTag) {
                [operationBtn removeFromSuperview];
            }
        }
    }
    
    CGFloat beginYPointFloat = KFunctionModulButtonHeight;
    
    for (int userCountIndex = 0; userCountIndex < userCountInt; userCountIndex++) {
        
        UserInformationClass  *userInfor = (UserInformationClass *)[self.userInforMutableArray objectAtIndex:userCountIndex];
        UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [userButton setBackgroundColor:[UIColor whiteColor]];
        [userButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
        [userButton setBackgroundColor:[UIColor whiteColor]];
        [userButton addTarget:self action:@selector(userEditOperationButtonEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        [userButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateHighlighted];
        [userButton setTag:(KBtnUserBaseButtonTag+userCountIndex)];
        [userButton setFrame:CGRectMake(0.0f, beginYPointFloat, KProjectScreenWidth, KFunctionModulButtonHeight*1.2)];
        [self.usersInforBGView addSubview:userButton];
        beginYPointFloat += KFunctionModulButtonHeight*1.2;
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"userDeleteImage.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(userDeleteOperationButtonEventClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setTag:(KBtnUserDeleteBaseButtonTag+userCountIndex)];
        [deleteBtn setFrame:CGRectMake(KInforLeftIntervalWidth*1.5, (KFunctionModulButtonHeight*1.2 - KXCUIControlSizeWidth(20.0f))/2, KXCUIControlSizeWidth(20.0f), KXCUIControlSizeWidth(20.0f))];
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
        [userNameInfor setFrame:CGRectMake((45.0f+KFunctionModuleContentLeftWidth*2),0.0f,
                                           ( KXCUIControlSizeWidth(200.0f)), (KFunctionModulButtonHeight*1.2))];
        [userButton addSubview:userNameInfor];
    }
  
}



- (void)userOperationButtonClickedEvent:(UIButton *)button{
    if (KBtnForPayButtonTag == button.tag){
        
        
        [self userUploadOrderInforRequestOperation];
    }
    
    else if (KBtnForOrderDetailedButtonTag == button.tag){
        
        CGFloat navigationBarHeight = self.navigationController.navigationBar.height;
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect orderDetailRect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                (self.view.bounds.size.height
                                                 - navigationBarHeight));
            
            [self.userOrderDetailedView setFrame:orderDetailRect];
        }];
        
        [self.userOrderDetailedView detailForHotelReserveOrderDataInfor:self.willMakeOrderInfor];

    }
}


- (void)userAddSubtractStayDaysOperationEventClicked:(UIButton *)button{

    ///增加一间
    if (KBtnForAddOneRoomButtonTag == button.tag) {
        self.willMakeOrderInfor.orderRoomQuantityInteger +=1;
    }
    ///减去一间
    else if (KBtnForSubtractRoomButtonTag == button.tag){
        if ((self.willMakeOrderInfor.orderRoomQuantityInteger-1) == 0) {
            ShowAutoHideMBProgressHUD(HUIKeyWindow,@"至少住 1 间!");
            return;
        }
        self.willMakeOrderInfor.orderRoomQuantityInteger -=1;
    }
    [self.userOrderRoomInteger setText:[NSString stringWithFormat:@"住 %zi 间",self.willMakeOrderInfor.orderRoomQuantityInteger]];
    
    NSRange contentRange=[self.userOrderRoomInteger.text rangeOfString:[NSString stringWithFormat:@"%zi",self.willMakeOrderInfor.orderRoomQuantityInteger]];
    NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:self.userOrderRoomInteger.text];
    [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(24) range:contentRange];
    [dynamicContent addAttribute:NSForegroundColorAttributeName value:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) range:contentRange];
    [self.userOrderRoomInteger setAttributedText:dynamicContent];
    
    //计算消费信息
    [self calculateAllTotalConsumption];
}

///计算消费信息
- (void)calculateAllTotalConsumption{
    ///每间房间的单价
    CGFloat ticketPriceFloat = self.willMakeOrderInfor.orderHotelRoomInforation.hotelRealityUnitPriceFloat;
    ///目前没有服务费
    CGFloat oneUserPrice =ticketPriceFloat + 0;
    
    ///计算总数 支付金额总数 totalMoney = (房间单价sum × 房间数 ×入住天数)
    CGFloat totalConsumption = oneUserPrice*self.willMakeOrderInfor.orderRoomQuantityInteger*self.willMakeOrderInfor.orderStayDayesQuantityInteger;
    
    [self.userOrderTotalConsumption setText:[NSString stringWithFormat:@"%.1lf",totalConsumption]];
    //    [self.willMakeOrderInfor seth];
    //    [self.ticketOrderInfor setTtTicketTotalVolume:totalConsumption];
    //    NSLog(@"消费清单信息：\n\n票务单价 %.2lf\n消费单价 %.2lf\n消费总价%.2lf",ticketPriceFloat,oneUserPrice,totalConsumption);
    
    [self.willMakeOrderInfor setOrderPaySumTotal:[NSString stringWithFormat:@"%.1lf",totalConsumption]];
    
}

- (void)userEditOperationButtonEventClicked:(UIButton *)button{
    
}

- (void)userDeleteOperationButtonEventClicked:(UIButton *)button{
    NSInteger index = button.tag - KBtnUserDeleteBaseButtonTag;
    
    NSLog(@"userButton.tag is %zi",index);

    if (index >= 0) {
        
        UserInformationClass *userInfor = (UserInformationClass *)[self.userInforMutableArray objectAtIndex:index];
        self.willDeleteUserInformation = userInfor;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"确定要移除当前入住人“%@”吗？",userInfor.userNameStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"移除", nil];
        [alertView setTag:KAlertViewForDeleteTag];
        [alertView show];
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0) {
        
        NSLog(@"可以移除当前联系人");
        [self.userInforMutableArray removeObject:self.willDeleteUserInformation];
        [self replaceAllPassengerUserInfor];
        NSLog(@"-----------------\n 姓名\t\t%@",self.willDeleteUserInformation.userNameStr);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    if (self.userInforMutableArray.count > 0) {
        CGFloat scrollContentY =(self.userInforMutableArray.count *1.2*KFunctionModulButtonHeight) + KXCUIControlSizeWidth(300.0f);
        [self.mainScrollView setContentOffset:CGPointMake(0.0f, scrollContentY) animated:YES];
    }
   
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == KTextForEmailTextTag) {
        [self.mainScrollView setContentOffset:CGPointMake(0.0f, KXCUIControlSizeWidth(20.0f)) animated:YES];
    }
    
    [self.view endEditing:YES];
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
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"至少添加 1 房客");
        return;
    }
    
    
    NSString *errorStr = [NSString stringWithFormat:@"您选择的%zi间客房，无法满足%zi人入住,请添加客房!",self.willMakeOrderInfor.orderRoomQuantityInteger,self.userInforMutableArray.count];
    NSLog(@"errorStr is %@",errorStr);
    if (self.willMakeOrderInfor.orderRoomQuantityInteger*2<self.userInforMutableArray.count) {
        
        NSString *errorStr = [NSString stringWithFormat:@"您选择的%zi间客房，无法满足%zi人入住,请添加客房!",self.willMakeOrderInfor.orderRoomQuantityInteger,self.userInforMutableArray.count];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:errorStr delegate:nil cancelButtonTitle:nil
                                                 otherButtonTitles:@"确定", nil];
        [alertView show];
//        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,errorStr);
        return;
    }
    
    
    [self.willMakeOrderInfor.orderContactUserInfor setUserNameStr:self.userNameContentField.text];
    [self.willMakeOrderInfor.orderContactUserInfor setUserPerEmailStr:self.emailContentField.text];
    [self.willMakeOrderInfor.orderContactUserInfor setUserPerPhoneNumberStr:self.phoneContentField.text];
    [self.willMakeOrderInfor setOrderMoveIntoUsersArray:self.userInforMutableArray];


    [self userCreateHotelReserveOderRequestion];

}

- (void)userCreateHotelReserveOderRequestion{
    
    __weak __typeof(&*self)weakSelf = self;
    WaittingMBProgressHUD(HUIKeyWindow,@"提交订单");
    [XCAPPHTTPClient userRequestCreateHotelReserveOrderWithOrderInfor:self.willMakeOrderInfor completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"response.responseObject is %@",response.responseObject);

            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                FinishMBProgressHUD(HUIKeyWindow);
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *dataDic = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    if (dataDic.count > 0) {
                        if ([ObjForKeyInUnserializedJSONDic(dataDic, @"oid") isKindOfClass:[NSString class]]) {
                            
                            NSString *orderIdStr = [NSString stringWithFormat:@"%@",StringForKeyInUnserializedJSONDic(dataDic, @"oid")];
                            
                            ////进行界面跳转
                            if ((!IsStringEmptyOrNull(orderIdStr))&&(!IsStringEmptyOrNull(orderIdStr))) {
                                
                                [weakSelf.willMakeOrderInfor setOrderId:orderIdStr];
                                UserPersonalOrderInformation *orderInfor = [[UserPersonalOrderInformation alloc]init];
                                [orderInfor setUserOrderStyle:XCAPPOrderHotelForStyle];
                                 [orderInfor setHotelOrderInfor:self.willMakeOrderInfor];
                                
                                OrderImmediatePayViewController *viewController = [[OrderImmediatePayViewController alloc]initWithOderInfor:orderInfor];
                                [weakSelf.navigationController pushViewController:viewController animated:YES];
                            }
                        }

                    }
                }
            }else{
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    
                    NSString *errorStr = [NSString stringWithFormat:@"【错误内容】%@",StringForKeyInUnserializedJSONDic(response.responseObject,@"desc")];
                    NSLog(@"response.responseObject【错误内容】 is %@\nerrorStr is %@",response.responseObject,errorStr);

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
