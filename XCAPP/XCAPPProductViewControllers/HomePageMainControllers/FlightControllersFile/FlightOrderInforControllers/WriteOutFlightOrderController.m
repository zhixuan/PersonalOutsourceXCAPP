//
//  WriteOutFlightOrderController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/10.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "WriteOutFlightOrderController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "AddTrainTicketUserInforController.h"

#define KTextForPhoneTextTag                        (1360111)
#define KTextForEmailTextTag                        (1360112)


#define KBtnForTicketDetailButtonTag                (1670111)
#define KBtnForTicketFoldDetailButtonTag            (1670112)
#define KBtnForCheckOnlyButtonTag                   (1670113)
#define KBtnForCheckReturnButtonTag                 (1670114)

#define KBtnForAddUserButtonTag                     (1670115)

#define KBtnForOrderDetailedButtonTag               (1570116)
#define KBtnForNextButtonTag                        (1570117)


#define KBtnUserBaseButtonTag                       (1570211)
#define KBtnUserNameInterval                        (1000)
#define KBtnUserCerCodeInterval                     (3000)
#define KBtnUserBaseDeleteTag                       (5000)


//#define KBtnFor

@interface WriteOutFlightOrderController ()<UITextFieldDelegate,AddTrainTicketUserInforDelegate>


/*!
 * @breif 视图内容
 * @See
 */
@property (nonatomic , weak)                UIScrollView            * mainScrollView;
///*!
// * @breif 联系人名字
// * @See
// */
//@property (nonatomic , weak)
/*!
 * @breif 订单信息内容
 * @See
 */
@property (nonatomic , strong)              FlightOrderInformation  *flightOrderInfor;


/*!
 * @breif 机票信息背景图
 * @See
 */
@property (nonatomic , weak)            UIView                      *flightOnlyTicketBGView;

/*!
 * @breif 显示机票详细信息按键
 * @See
 */
@property (nonatomic , weak)            UIButton                    *showTicketDetailBtn;
/*!
 * @breif 机票信息背景图
 * @See
 */
@property (nonatomic , weak)            UIView                      *flightOnlyExpensesBGView;

/*!
 * @breif 用户联系方式视图
 * @See
 */
@property (nonatomic , weak)            UIView                      *flightUserGView;

/*!
 * @breif 手机号输入框
 * @See
 */
@property (nonatomic , weak)            UITextField                 *phoneContentField;


/*!
 * @breif 邮箱输入框
 * @See
 */
@property (nonatomic , weak)            UITextField                 *emailContentField;


/*!
 * @breif 添加乘客信息
 * @See
 */
@property (nonatomic , weak)            UIView                      *addPassengerBGView;

/*!
 * @breif 乘客用户信息内容
 * @See
 */
@property (nonatomic , strong)          NSMutableArray                  *userInforMutableArray;

/*!
 * @breif 保险信息
 * @See
 */
@property (nonatomic , weak)            UIView                      *flightInsuranceBGView;

/*!
 * @breif 支付方式视图
 * @See
 */
@property (nonatomic , weak)            UIView                      *flightPayStyleBGView;

/*!
 * @breif 总价信息内容
 * @See
 */
@property (nonatomic , weak)            UILabel                         *userOrderTotalConsumption;

@end

@implementation WriteOutFlightOrderController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithFlightOrderInfor:(FlightOrderInformation *)orderInfor{
    
    self = [super init];
    if (self) {
        self.flightOrderInfor = orderInfor;
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
    [self setupWriteOutFlightOrderControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupWriteOutFlightOrderControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    self.mainScrollView = mainView;
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 120.0f)];
    
    
    NSLog(@"\n\n=============\n\nKProjectScreenHeight is %lf\nmainView.height is%lf",KProjectScreenHeight,mainView.height);
    
    UILabel *showLabel = [[UILabel alloc]init];
    [showLabel setBackgroundColor:[UIColor clearColor]];
    [showLabel setText:@"您预订的是由供应商提供的旅行套餐产品，不享受里程累积。\n退订和更改规则以产品实际显示为准。"
     @"\n特价产品需在15分钟内完成授权和支付，否则订单将自动取消。"];
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
                                    (showSize.height + KInforLeftIntervalWidth +KInforLeftIntervalWidth*2))];
    [mainView addSubview:headerView];
    [showLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2.5, KInforLeftIntervalWidth,
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*3.5), showSize.height)];
    [headerView addSubview:showLabel];
    
    
    CGRect frame = CGRectMake(KInforLeftIntervalWidth, (KInforLeftIntervalWidth + headerView.bottom),
                              (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                              (KFunctionModulButtonHeight + KFunctionModulButtonHeight*1.3));
    [self setupFirstFlightTicket:frame scrollView:mainView];

   
    ///人员信息
    
    UIView * passengerBGView = [[UIView alloc]init];
    [passengerBGView setFrame:CGRectMake(0.0f, ((self.flightOnlyTicketBGView.bottom + KInforLeftIntervalWidth)),
                                         KProjectScreenWidth, (KFunctionModulButtonHeight))];
    [passengerBGView setBackgroundColor:[UIColor whiteColor]];
    self.addPassengerBGView  = passengerBGView;
    [mainView addSubview:self.addPassengerBGView];
    
    UILabel  *userTitleLabel = [[UILabel alloc]init];
    [userTitleLabel setBackgroundColor:[UIColor clearColor]];
    [userTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [userTitleLabel setTextColor:KFunctionModuleContentColor];
    [userTitleLabel setFont:KFunctionModuleContentFont];
    [userTitleLabel setText:@"乘客"];
    [userTitleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 45.0f, KFunctionModulButtonHeight)];
    [passengerBGView addSubview:userTitleLabel];
    
    UILabel  *userShowLabel = [[UILabel alloc]init];
    [userShowLabel setBackgroundColor:[UIColor clearColor]];
    [userShowLabel setTextAlignment:NSTextAlignmentLeft];
    [userShowLabel setTextColor:KSubTitleTextColor];
    [userShowLabel setFont:KXCAPPUIContentFontSize(12)];
    [userShowLabel setText:@"仅支持成人票预订"];
    [userShowLabel setFrame:CGRectMake((KFunctionModuleContentLeftWidth+userTitleLabel.right),0.0f, 120.0f, KFunctionModulButtonHeight)];
    [passengerBGView addSubview:userShowLabel];
    
    UIButton *addUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addUserBtn setBackgroundColor:[UIColor clearColor]];
    [addUserBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateNormal];
    [addUserBtn setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateHighlighted];
    [addUserBtn setTitle:@"添加\t+" forState:UIControlStateNormal];
    [addUserBtn setTitleColor:HUIRGBColor(93.0f, 149.0f, 214, 1.0f) forState:UIControlStateNormal];
    [addUserBtn setTitleColor:HUIRGBColor(53.0f, 109.0f, 174, 1.0f) forState:UIControlStateHighlighted];
    [addUserBtn setFrame:CGRectMake((passengerBGView.width - KXCUIControlSizeWidth(70.0f) - KInforLeftIntervalWidth), 0.0f,
                                    KXCUIControlSizeWidth(70.0f), KFunctionModulButtonHeight)];
    [addUserBtn setTag:KBtnForAddUserButtonTag];
    [addUserBtn addTarget:self action:@selector(userPersonlOperationButtonEventClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [passengerBGView addSubview:addUserBtn];

    
     ///保险信息
    
    UIView * insuranceView = [[UIView alloc]init];
    [insuranceView setFrame:CGRectMake(0.0f, ((passengerBGView.bottom + KInforLeftIntervalWidth)),
                                       KProjectScreenWidth, (KFunctionModulButtonHeight *3+2.0f))];
    [insuranceView setBackgroundColor:[UIColor whiteColor]];
    self.flightInsuranceBGView = insuranceView;
    [mainView addSubview:self.flightInsuranceBGView];
    
    UILabel *insuranceFirst = [[UILabel alloc]init];
    [insuranceFirst setBackgroundColor:[UIColor clearColor]];
    [insuranceFirst setTextColor:KContentTextColor];
    [insuranceFirst setFont:KFunctionModuleContentFont];
    [insuranceFirst setTextAlignment:NSTextAlignmentLeft];
    [insuranceFirst setText:@"尊享航意险  ¥40/份"];
    [insuranceFirst setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                        KXCUIControlSizeWidth(200.0f), KFunctionModulButtonHeight)];
    [insuranceView addSubview:insuranceFirst];
    
    
    UIView  *separatorFirst = [[UIView alloc]init];
    [separatorFirst setBackgroundColor:KSepLineColorSetup];
    [separatorFirst setFrame:CGRectMake(0.0f,(insuranceFirst.bottom), KProjectScreenWidth, 1.0f)];
    [insuranceView addSubview:separatorFirst];
    
    UILabel *insuranceSecond = [[UILabel alloc]init];
    [insuranceSecond setBackgroundColor:[UIColor clearColor]];
    [insuranceSecond setTextColor:KContentTextColor];
    [insuranceSecond setFont:KFunctionModuleContentFont];
    [insuranceSecond setTextAlignment:NSTextAlignmentLeft];
    [insuranceSecond setText:@"延误取消险  ¥20/份"];
    [insuranceSecond setFrame:CGRectMake(KInforLeftIntervalWidth,separatorFirst.bottom,
                                         KXCUIControlSizeWidth(200.0f), KFunctionModulButtonHeight)];
    [insuranceView addSubview:insuranceSecond];
    
    
    
    UIView  *separatorSecond = [[UIView alloc]init];
    [separatorSecond setBackgroundColor:KSepLineColorSetup];
    [separatorSecond setFrame:CGRectMake(0.0f, insuranceSecond.bottom,
                                         KProjectScreenWidth, 1.0f)];
    [insuranceView addSubview:separatorSecond];
    
    UILabel *insuranceThird= [[UILabel alloc]init];
    [insuranceThird setBackgroundColor:[UIColor clearColor]];
    [insuranceThird setTextColor:KContentTextColor];
    [insuranceThird setFont:KFunctionModuleContentFont];
    [insuranceThird setTextAlignment:NSTextAlignmentLeft];
    [insuranceThird setText:@"航空意外险  ¥30/份"];
    [insuranceThird setFrame:CGRectMake(KInforLeftIntervalWidth,separatorSecond.bottom,
                                        KXCUIControlSizeWidth(200.0f), KFunctionModulButtonHeight)];
    [insuranceView addSubview:insuranceThird];
    
    
    UIView *userBGView = [[UIView alloc]init];
    [userBGView setBackgroundColor:[UIColor whiteColor]];
    [userBGView setFrame:CGRectMake(0.0f, (insuranceView.bottom + KInforLeftIntervalWidth),
                                    KProjectScreenWidth, (KFunctionModulButtonHeight*2+1.0f))];
    self.flightUserGView = userBGView;
    [mainView addSubview:self.flightUserGView];
    
    UILabel *countryCode = [[UILabel alloc]init];
    [countryCode setBackgroundColor:[UIColor clearColor]];
    [countryCode setTextColor:KContentTextColor];
    [countryCode setFont:KFunctionModuleContentFont];
    [countryCode setTextAlignment:NSTextAlignmentLeft];
    [countryCode setText:@"+86"];
    [countryCode setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
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
    
    //MARK:支付方式
    
    UIView *payStyleBGView = [[UIView alloc]init];
    [payStyleBGView setBackgroundColor:[UIColor whiteColor]];
    [payStyleBGView setFrame:CGRectMake(0.0f, (userBGView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                        (KFunctionModulButtonHeight))];
    self.flightPayStyleBGView = payStyleBGView;
    [mainView addSubview:self.flightPayStyleBGView];
    
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
    
    //底部价格总价视图
    [self bottomAllTotalSumView];
}

#pragma mark -
#pragma mark -  单程飞机票视图
///单程飞机票视图
- (void)setupFirstFlightTicket:(CGRect)frame scrollView:(UIScrollView *)mainView{
    UIView *firstOnlyTicketView = [[UIView alloc]init];
    [firstOnlyTicketView setBackgroundColor:[UIColor whiteColor]];
    [firstOnlyTicketView.layer setCornerRadius:5.0f];
    [firstOnlyTicketView.layer setMasksToBounds:YES];
    [firstOnlyTicketView setFrame:frame ];
    self.flightOnlyTicketBGView = firstOnlyTicketView;
    [mainView addSubview:self.flightOnlyTicketBGView ];
    
    
    UILabel *goLabel = [[UILabel alloc]init];
    [goLabel setBackgroundColor:[UIColor clearColor]];
    [goLabel setText:@"去"];
    [goLabel setTextColor:KContentTextColor];
    [goLabel setTextAlignment:NSTextAlignmentCenter];
    [goLabel setFont:KXCAPPUIContentFontSize(17)];
    [goLabel setFrame:CGRectMake(KInforLeftIntervalWidth, (KFunctionModulButtonHeight -
                                                           KXCUIControlSizeWidth(30.0f))/2,
                                 KXCUIControlSizeWidth(30.0f), KXCUIControlSizeWidth(30.0f))];
    [goLabel.layer setCornerRadius:KXCUIControlSizeWidth(30.0f)/2];
    [goLabel.layer setBorderColor:KBorderColorSetup.CGColor];
    [goLabel.layer setBorderWidth:2.0f];
    [goLabel.layer setMasksToBounds:YES];
    [firstOnlyTicketView addSubview:goLabel];
    
    
    NSString *dataSiteStr = [NSString stringWithFormat:@"%@  %@-%@",
                             self.flightOrderInfor.fliOrderTakeOffDate,
                             self.flightOrderInfor.fliOrderTakeOffSite,
                             self.flightOrderInfor.fliOrderArrivedSite];
    
    UILabel *dateSiteLabel = [[UILabel alloc]init];
    [dateSiteLabel setBackgroundColor:[UIColor clearColor]];
    [dateSiteLabel setTextColor:KContentTextColor];
    [dateSiteLabel setTextAlignment:NSTextAlignmentLeft];
    [dateSiteLabel setFont:KXCAPPUIContentFontSize(17)];
    [dateSiteLabel setText:dataSiteStr];
    CGSize dataSiteSize = [dateSiteLabel.text sizeWithAttributes:@{NSFontAttributeName: dateSiteLabel.font}];
    [dateSiteLabel setFrame:CGRectMake((goLabel.right + KXCUIControlSizeWidth(8.0f)),
                                       0.0f, dataSiteSize.width, KFunctionModulButtonHeight)];
    [firstOnlyTicketView addSubview:dateSiteLabel];
    
    UIButton *showTicketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showTicketBtn setBackgroundColor:[UIColor clearColor]];
    [showTicketBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                             forState:UIControlStateNormal];
    [showTicketBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                             forState:UIControlStateHighlighted];
    [showTicketBtn setTag:KBtnForTicketDetailButtonTag];
    [showTicketBtn setFrame:CGRectMake((firstOnlyTicketView.width - KInforLeftIntervalWidth -
                                        KXCUIControlSizeWidth(30.0f)),
                                       (KFunctionModulButtonHeight - KXCUIControlSizeWidth(30.0f))/2,
                                       KXCUIControlSizeWidth(30.0f), KXCUIControlSizeWidth(30.0f))];
    [showTicketBtn.layer setBorderColor:HUIRGBColor(16.0f, 134.0f, 192.0f, 1.0f).CGColor];
    [showTicketBtn.layer setBorderWidth:2.0f];
    [showTicketBtn.layer setCornerRadius:KXCUIControlSizeWidth(30.0f)/2];
    [showTicketBtn.layer setMasksToBounds:YES];
    [showTicketBtn.titleLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [showTicketBtn simpleButtonWithImageColor:HUIRGBColor(16.0f, 134.0f, 192.0f, 1.0f)];
    [showTicketBtn setAwesomeIcon:FMIconLowerArrow];
    [showTicketBtn addTarget:self action:@selector(userPersonlOperationButtonEventClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    self.showTicketDetailBtn = showTicketBtn;
    [firstOnlyTicketView addSubview:self.showTicketDetailBtn ];
    
    UIView  *separator = [[UIView alloc]init];
    [separator setBackgroundColor:KSepLineColorSetup];
    [separator setFrame:CGRectMake(0.0f, KFunctionModulButtonHeight, firstOnlyTicketView.width, 1.0f)];
    [firstOnlyTicketView addSubview:separator];
    
    UIView *expensesBGView = [[UIView alloc]init];
    [expensesBGView setBackgroundColor:[UIColor whiteColor]];
    [expensesBGView setFrame:CGRectMake(0.0f, separator.bottom, firstOnlyTicketView.width, KFunctionModulButtonHeight*1.3)];
    self.flightOnlyExpensesBGView = expensesBGView;
    [firstOnlyTicketView addSubview:self.flightOnlyExpensesBGView];
    
    UILabel *flightPrice = [[UILabel alloc]init];
    [flightPrice setBackgroundColor:[UIColor clearColor]];
    [flightPrice setTextColor:KContentTextColor];
    [flightPrice setFont:KFunctionModuleContentFont];
    [flightPrice setTextAlignment:NSTextAlignmentLeft];
    [flightPrice setText:[NSString stringWithFormat:@"机票价格   ¥%.0lf",
                          self.flightOrderInfor.fliOrderOneWayInfor.flightUnitPrice]];
    [flightPrice setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(10.0f),
                                     KXCUIControlSizeWidth(200.0f), KFunctionModulButtonHeight/3)];
    [expensesBGView addSubview:flightPrice];
    NSRange flightPriceRange = [flightPrice.text rangeOfString:[NSString stringWithFormat:@"%.0lf",
                                                                self.flightOrderInfor.fliOrderOneWayInfor.flightUnitPrice]];
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:flightPrice.text];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(18) range:flightPriceRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:flightPriceRange];
    [flightPrice setAttributedText:minUnitPriceContent];
    
    UILabel *bunkerSurcharge = [[UILabel alloc]init];
    [bunkerSurcharge setBackgroundColor:[UIColor clearColor]];
    [bunkerSurcharge setTextColor:KContentTextColor];
    [bunkerSurcharge setFont:KFunctionModuleContentFont];
    [bunkerSurcharge setTextAlignment:NSTextAlignmentLeft];
    [bunkerSurcharge setText:[NSString stringWithFormat:@"民航基金/燃油   ¥%@",
                              self.flightOrderInfor.fliOrderOneWayInfor.flightBunkerSurcharge]];
    [bunkerSurcharge setFrame:CGRectMake(KInforLeftIntervalWidth, flightPrice.bottom + KXCUIControlSizeWidth(8.0f),
                                         KXCUIControlSizeWidth(200.0f), KFunctionModulButtonHeight/3)];
    [expensesBGView addSubview:bunkerSurcharge];
    
    NSRange surchargeRange = [bunkerSurcharge.text rangeOfString:self.flightOrderInfor.fliOrderOneWayInfor.flightBunkerSurcharge];
    NSMutableAttributedString *surchargeContent=[[NSMutableAttributedString alloc]initWithString:bunkerSurcharge.text];
    
    [surchargeContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(18) range:surchargeRange];
    [surchargeContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:surchargeRange];
    [bunkerSurcharge setAttributedText:surchargeContent];
}

#pragma mark -
#pragma mark -  返程飞机票视图
///返程飞机票视图
- (void)setupSecondFlightTicket:(CGRect)frame scorllView:(UIScrollView *)mainView{

}
///底部价格总价视图
- (void)bottomAllTotalSumView{
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
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:KXCAPPUIContentFontSize(17)];
    [nextButton setBackgroundImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))
                          forState:UIControlStateNormal];
    [nextButton setBackgroundImage:createImageWithColor(HUIRGBColor(185.0f, 121.0f, 38.0f, 1.0))
                          forState:UIControlStateHighlighted];
    [nextButton setTag:KBtnForNextButtonTag];
    [nextButton addTarget:self action:@selector(userPersonlOperationButtonEventClicked:)
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
    [detailedButton addTarget:self action:@selector(userPersonlOperationButtonEventClicked:)
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

- (void)userPersonlOperationButtonEventClicked:(UIButton *)button{
    
    
    ///查看详情
    if (KBtnForTicketDetailButtonTag == button.tag) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [UIView setAnimationDuration:0.4f];
            self.showTicketDetailBtn .transform = CGAffineTransformMakeRotation(M_PI);
            [UIView commitAnimations];
        });
        
        [self.showTicketDetailBtn  setTag:(KBtnForTicketFoldDetailButtonTag)];
    }else if (KBtnForTicketFoldDetailButtonTag == button.tag){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [UIView setAnimationDuration:0.4f];
            self.showTicketDetailBtn .transform = CGAffineTransformMakeRotation(0);
            [UIView commitAnimations];
        });
        [self.showTicketDetailBtn  setTag:(KBtnForTicketDetailButtonTag)];
    }
    
    else if (KBtnForAddUserButtonTag == button.tag){
        UserInformationClass *userinfor = [[UserInformationClass alloc]init];
        AddTrainTicketUserInforController *viewController = [[AddTrainTicketUserInforController alloc]initWithUserInfor:userinfor withIndex:0];
        [viewController setDelegate:self];
        XCAPPNavigationController *navigation = [[XCAPPNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigation animated:YES completion:^{
            
        }];
    }
    
    ///价格明细
    else if (KBtnForOrderDetailedButtonTag == button.tag){
        NSLog(@"明细");
    }
    
    else if (KBtnForNextButtonTag == button.tag){
     
        NSLog(@"下一步内容");
    }
}
- (void)addFinishUserInfor:(UserInformationClass *)userInfor{
    
    if (userInfor) {
        
        [self.userInforMutableArray addObject:userInfor];
//        [self loginConsol];
        NSInteger userCountInt = self.userInforMutableArray.count;
        
        [self.addPassengerBGView setHeight:(KFunctionModulButtonHeight +
                                            (userCountInt*KFunctionModulButtonHeight*1.5))];
        [self.flightInsuranceBGView setTop:(self.addPassengerBGView.bottom + KInforLeftIntervalWidth)];
        
        [self.flightUserGView setTop:(self.flightInsuranceBGView .bottom + KInforLeftIntervalWidth)];
        
        [self.flightPayStyleBGView setTop:(self.flightUserGView.bottom + KInforLeftIntervalWidth)];
        
        [self.mainScrollView setContentSize:CGSizeMake(KProjectScreenWidth,
                                                       (self.flightPayStyleBGView.bottom + KXCUIControlSizeWidth(140.0f)))];
        
        UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [userButton setBackgroundColor:[UIColor whiteColor]];
        [userButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
        [userButton setBackgroundColor:[UIColor whiteColor]];
        [userButton addTarget:self action:@selector(userEditOperationButtonEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        [userButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateHighlighted];
        [userButton setTag:(KBtnUserBaseButtonTag+userCountInt - 1)];
        [userButton setFrame:CGRectMake(0.0f, self.addPassengerBGView.height - KFunctionModulButtonHeight*1.5,
                                        KProjectScreenWidth, KFunctionModulButtonHeight*1.5)];
        [self.addPassengerBGView addSubview:userButton];
        
        
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
        
        ///计算消费信息
        [self calculateAllTotalConsumption];
    }
}



///计算消费信息
- (void)calculateAllTotalConsumption{
    
    /*
    ///火车票数据转换
    CGFloat ticketPriceFloat = [self.ticketOrderInfor.ttOrderTrainticketInfor.traUnitPrice doubleValue];
    
    //每张火车票实际支付金额
    CGFloat oneUserPrice =ticketPriceFloat + [self.ticketOrderInfor.ttOrderTrainticketInfor.traServiceCostStr doubleValue];
    
    ///计算总数
    CGFloat totalConsumption = oneUserPrice*self.userInforMutableArray.count;
    
    [self.userOrderTotalConsumption setText:[NSString stringWithFormat:@"%.0lf",totalConsumption]];
    NSLog(@"消费清单信息：\n\n票务单价 %.2lf\n消费单价 %.2lf\n消费总价%.2lf",ticketPriceFloat,oneUserPrice,totalConsumption);
    */
}

- (void)editFinishUserInfor:(UserInformationClass *)userInfor withIndex:(NSInteger)index{
    
    ///替换数组
    [self.userInforMutableArray replaceObjectAtIndex:index withObject:userInfor];
    
    NSInteger btnTag = (KBtnUserBaseButtonTag+index);
    UIButton *button = (UIButton *)[self.addPassengerBGView viewWithTag:btnTag];
    
    UILabel *nameLabel = (UILabel *)[button viewWithTag:(btnTag + KBtnUserNameInterval)];
    [nameLabel setText:userInfor.userNameStr];
    
    UILabel *cerCodeLabel = (UILabel *)[button viewWithTag:(btnTag + KBtnUserCerCodeInterval)];
    [cerCodeLabel setText:[NSString stringWithFormat:@"%@ %@",userInfor.userPerCredentialStyle,
                           userInfor.userPerCredentialContent]];
    
//    [self loginConsol];
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



- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag == KTextForPhoneTextTag) {
        [self.mainScrollView setContentOffset:CGPointMake(0.0f, KXCUIControlSizeWidth(260.0f)) animated:YES];
    }else if (textField.tag == KTextForEmailTextTag){
        [self.mainScrollView setContentOffset:CGPointMake(0.0f,(KXCUIControlSizeWidth(300.0f) + KFunctionModulButtonHeight)) animated:YES];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    return YES;
}
@end
