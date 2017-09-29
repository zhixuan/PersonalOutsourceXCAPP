//
//  TrainTicketReturnController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/27.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketReturnController.h"
#import "UIUserOperationButton.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "JSONKit.h"
#import "HTTPClient+TrainTickeRequest.h"


#define KTextForPhoneTextTag                (1330112)
#define KTextForUserNameTextTag             (1330111)

#define KBtnForPassengerButtonTag           (1330511)

#define KBtnForSubmitButtonTag              (1330677)

#define KAlertForSubmitAlertViewTag         (1330678)

@interface TrainTicketReturnController ()<UITextFieldDelegate,UIAlertViewDelegate>

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
 * @breif 用户火车票订单信息
 * @See
 */
@property (nonatomic , strong)      TrainticketOrderInformation         *userOrderForTrainticket;


/*!
 * @breif 用户选择的需要退票的用户信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                      *selectedWillReturnUserArray;

@end

@implementation TrainTicketReturnController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
//        self.enableCustomNavbarBackButton = FALSE ;
    }
    return self;
}

- (id)initWithTrainTicketOrder:(TrainticketOrderInformation *)trainTicketOrder{
    self = [super init];
    if (self) {
//        self.enableCustomNavbarBackButton = FALSE ;
        self.userOrderForTrainticket = trainTicketOrder;
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
    [self settingNavTitle:@"火车票退票"];
    
    [self setRightNavButtonTitleStr:@"退票说明"
                          withFrame:CGRectMake(0, 0.0f, 80, 44.0f)
                       actionTarget:self
                             action:@selector(userOperationRightButtonEvent)
     ];
    
    ///初始化数组
    self.selectedWillReturnUserArray = [[NSMutableArray alloc]init];
    [self setupTrainTicketReturnControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userOperationRightButtonEvent{
    
    NSLog(@"退票说明按键信息操作成功");
}

- (void)setupTrainTicketReturnControllerFrame{
    
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 80.0f)];
    
    UIView *trainTicketInforBGView = [[UIView alloc]init];
    [trainTicketInforBGView setBackgroundColor:[UIColor whiteColor]];
    [trainTicketInforBGView setFrame:CGRectMake(0.0f,KInforLeftIntervalWidth,
                                                KProjectScreenWidth,
                                                (KFunctionModulButtonHeight + KXCUIControlSizeWidth(121.0f)))];
    [mainView addSubview:trainTicketInforBGView];
    
    UILabel *beginSite = [[UILabel alloc]init];
    [beginSite setTextAlignment:NSTextAlignmentLeft];
    [beginSite setTextColor:KSubTitleTextColor];
    [beginSite setFrame:CGRectMake(KInforLeftIntervalWidth*2, KXCUIControlSizeWidth(20.0f),
                                   (trainTicketInforBGView.width/3),
                                   KXCUIControlSizeWidth(15.0f))];
    [beginSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginSite setBackgroundColor:[UIColor clearColor]];
    [beginSite setText:self.userOrderForTrainticket.ttOrderTrainticketInfor.traTakeOffSite];
    [trainTicketInforBGView addSubview:beginSite];
    
    UILabel *arrivedSite = [[UILabel alloc]init];
    [arrivedSite setTextColor:KSubTitleTextColor];
    [arrivedSite setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                     (KXCUIControlSizeWidth(20.0f)),
                                     (trainTicketInforBGView.width/3),
                                     KXCUIControlSizeWidth(15.0f))];
    [arrivedSite setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedSite setBackgroundColor:[UIColor clearColor]];
    [arrivedSite setTextAlignment:NSTextAlignmentRight];
    [arrivedSite setText:self.userOrderForTrainticket.ttOrderTrainticketInfor.traArrivedSite];
    [trainTicketInforBGView addSubview:arrivedSite];
    
    UILabel *beginDateTime = [[UILabel alloc]init];
    [beginDateTime setTextAlignment:NSTextAlignmentLeft];
    [beginDateTime setTextColor:KContentTextColor];
    [beginDateTime setFrame:CGRectMake(KInforLeftIntervalWidth*2, (beginSite.bottom + KXCUIControlSizeWidth(5.0f)),
                                       (trainTicketInforBGView.width/3),
                                       KXCUIControlSizeWidth(40.0f))];
    [beginDateTime setFont:KXCAPPUIContentDefautFontSize(27.0f)];
    [beginDateTime setBackgroundColor:[UIColor clearColor]];
    [beginDateTime setText:self.userOrderForTrainticket.ttOrderTrainticketInfor.traTakeOffTime];
    [trainTicketInforBGView addSubview:beginDateTime];
    
    UILabel *endDateTime = [[UILabel alloc]init];
    [endDateTime setTextColor:KContentTextColor];
    [endDateTime setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                     (beginSite.bottom + KXCUIControlSizeWidth(5.0f)),
                                     (trainTicketInforBGView.width/3),
                                     KXCUIControlSizeWidth(40.0f))];
    [endDateTime setFont:KXCAPPUIContentDefautFontSize(27.0f)];
    [endDateTime setBackgroundColor:[UIColor clearColor]];
    [endDateTime setTextAlignment:NSTextAlignmentRight];
    [endDateTime setText:self.userOrderForTrainticket.ttOrderTrainticketInfor.traArrivedTime];
    [trainTicketInforBGView addSubview:endDateTime];
    
    UILabel *beginDateLabel = [[UILabel alloc]init];
    [beginDateLabel setTextAlignment:NSTextAlignmentLeft];
    [beginDateLabel setTextColor:KSubTitleTextColor];
    [beginDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, (KXCUIControlSizeWidth(5.0f) + beginDateTime.bottom),
                                        (trainTicketInforBGView.width/3),
                                        KXCUIControlSizeWidth(15.0f))];
    [beginDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [beginDateLabel setBackgroundColor:[UIColor clearColor]];
    
    
    NSDictionary *beginDateDictionary = dateYearMonthDayWeekWithDateStr(self.userOrderForTrainticket.ttOrderTrainticketInfor.traTakeOffTimeSealStr);
    [beginDateLabel setText:StringForKeyInUnserializedJSONDic(beginDateDictionary, @"date")];
    [trainTicketInforBGView addSubview:beginDateLabel];
    
    UILabel *arrivedDateLabel = [[UILabel alloc]init];
    [arrivedDateLabel setTextColor:KSubTitleTextColor];
    [arrivedDateLabel setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                          (KXCUIControlSizeWidth(5.0f) + endDateTime.bottom),
                                          (trainTicketInforBGView.width/3),
                                          KXCUIControlSizeWidth(15.0f))];
    [arrivedDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedDateLabel setBackgroundColor:[UIColor clearColor]];
    [arrivedDateLabel setTextAlignment:NSTextAlignmentRight];
    NSDictionary *arrivedDateDictionary = dateYearMonthDayWeekWithDateStr(self.userOrderForTrainticket.ttOrderTrainticketInfor.traArrivedTimeSealStr);
    [arrivedDateLabel setText:StringForKeyInUnserializedJSONDic(arrivedDateDictionary, @"date")];
    [trainTicketInforBGView addSubview:arrivedDateLabel];
    
    UIView *separatorView = [[UIView alloc]init] ;
    [separatorView setBackgroundColor:KSepLineColorSetup];
    [separatorView setFrame:CGRectMake(KInforLeftIntervalWidth,
                                       (arrivedDateLabel.bottom + KXCUIControlSizeWidth(20.0f)),
                                       (trainTicketInforBGView.width - KInforLeftIntervalWidth*2), 1.0f)];
    [trainTicketInforBGView addSubview:separatorView];
    
    
    UILabel *traintNameLabel = [[UILabel alloc]init];
    [traintNameLabel setBackgroundColor:[UIColor clearColor]];
    [traintNameLabel setFrame:CGRectMake((KInforLeftIntervalWidth ),
                                         ((arrivedDateLabel.bottom/2-KXCUIControlSizeWidth(8.0f))),
                                         (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                         KXCUIControlSizeWidth(14.0f))];
    [traintNameLabel setFont:KXCAPPUIContentDefautFontSize(13.0f)];
    [traintNameLabel setTextColor:KSubTitleTextColor];
    [traintNameLabel setTextAlignment:NSTextAlignmentCenter];
    [trainTicketInforBGView addSubview:traintNameLabel];
    [traintNameLabel setText:self.userOrderForTrainticket.ttOrderTrainticketInfor.traCodeNameStr];
    
    
    UIImageView *fromToImageView = [[UIImageView alloc]init];
    [fromToImageView setBackgroundColor:[UIColor clearColor]];
    [fromToImageView setImage:[UIImage imageNamed:@"FromToImage.png"]];
    [fromToImageView setFrame:CGRectMake(beginDateLabel.right - KXCUIControlSizeWidth(40.0f),
                                         (arrivedDateLabel.bottom/2+12),
                                         (KProjectScreenWidth - beginDateLabel.right*2 +
                                          KXCUIControlSizeWidth(80.0f)),
                                         KXCUIControlSizeWidth(10.0f))];
    [trainTicketInforBGView addSubview:fromToImageView];
    
    UILabel *traintIntervalLabel = [[UILabel alloc]init];
    [traintIntervalLabel setBackgroundColor:[UIColor clearColor]];
    [traintIntervalLabel setFrame:CGRectMake((KInforLeftIntervalWidth),(fromToImageView.bottom),
                                             (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                             KXCUIControlSizeWidth(18.0f))];
    [traintIntervalLabel setFont:KXCAPPUIContentDefautFontSize(13.0f)];
    [traintIntervalLabel setTextColor:KSubTitleTextColor];
    [traintIntervalLabel setTextAlignment:NSTextAlignmentCenter];
    [trainTicketInforBGView addSubview:traintIntervalLabel];
    [traintIntervalLabel setText:@"约4小时48分"];
    
    
    UILabel *seatTypeLabel = [[UILabel alloc]init];
    [seatTypeLabel setTextAlignment:NSTextAlignmentLeft];
    [seatTypeLabel setTextColor:KContentTextColor];
    [seatTypeLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, separatorView.bottom,
                                       (trainTicketInforBGView.width/3),
                                       KFunctionModulButtonHeight)];
    [seatTypeLabel setFont:KFunctionModuleContentFont];
    [seatTypeLabel setBackgroundColor:[UIColor clearColor]];
    [seatTypeLabel setText:self.userOrderForTrainticket.ttOrderTrainticketInfor.traCabinModelStr];
    [trainTicketInforBGView addSubview:seatTypeLabel];
    
    UILabel *seatPriceLabel = [[UILabel alloc]init];
    [seatPriceLabel setTextColor:KSubTitleTextColor];
    [seatPriceLabel setFrame:CGRectMake((trainTicketInforBGView.width -  KInforLeftIntervalWidth*2 - (trainTicketInforBGView.width/3)),
                                        (separatorView.bottom),
                                        (trainTicketInforBGView.width/3),
                                        KFunctionModulButtonHeight)];
    [seatPriceLabel setFont:KFunctionModuleContentFont];
    [seatPriceLabel setBackgroundColor:[UIColor clearColor]];
    [seatPriceLabel setTextAlignment:NSTextAlignmentRight];
    [seatPriceLabel setText:[NSString stringWithFormat: @"￥%@",self.userOrderForTrainticket.ttOrderTrainticketInfor.traUnitPrice]];
    [trainTicketInforBGView addSubview:seatPriceLabel];
    

    UILabel *passengerLabel = [[UILabel alloc]init];
    [passengerLabel setBackgroundColor:[UIColor clearColor]];
    [passengerLabel setTextColor:KSubTitleTextColor];
    [passengerLabel setText:@"选择乘客"];
    [passengerLabel setTextAlignment:NSTextAlignmentLeft];
    [passengerLabel setFont:KFunctionModuleContentFont];
    [passengerLabel setFrame:CGRectMake(KInforLeftIntervalWidth,(trainTicketInforBGView.bottom + KInforLeftIntervalWidth),
                                           KXCUIControlSizeWidth(75.0f), KXCUIControlSizeWidth(30.0f))];
    [mainView addSubview:passengerLabel];
    
    
    
    
    NSLog(@"乘客信息内容：\n %@", self.userOrderForTrainticket.ttOrderBuyTicketUserMutArray);


    NSMutableArray *passengerUserArray = self.userOrderForTrainticket.ttOrderBuyTicketUserMutArray;
    
    
    
    NSInteger passengerCountInteger = passengerUserArray.count;
    
    NSInteger rowCount = 2;
    CGFloat passengerWidthFloat = (KProjectScreenWidth - (KInforLeftIntervalWidth + KXCUIControlSizeWidth(75.0f) +KInforLeftIntervalWidth))/2;
    
    CGFloat passengerHightFloat = KXCUIControlSizeWidth(32.0f);
    
    CGFloat beginYFloat = passengerLabel.top;
    
    CGFloat beginXFloat = (KInforLeftIntervalWidth + KXCUIControlSizeWidth(75.0f) +KInforLeftIntervalWidth);
    
    for (int index=0; index<passengerCountInteger; index++) {
        
        int row=index/rowCount;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=index%rowCount;//列号
        
        UserInformationClass *userInfor = (UserInformationClass *)[passengerUserArray objectAtIndex:index];
        
        CGFloat appviewx=beginXFloat+(passengerWidthFloat)*loc;
        CGFloat appviewy=(beginYFloat)+(passengerHightFloat)*row;
        UIUserOperationButton *button = [[UIUserOperationButton alloc]init];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setUserOperation:userInfor];
        
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor([UIColor clearColor])
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(243, 244, 245, 1.0))
                          forState:UIControlStateHighlighted];
        [button.layer setCornerRadius:3.0f];
        [button.layer setBorderColor:KSubTitleTextColor.CGColor];
        [button.layer setBorderWidth:1.0];
        [button.layer setMasksToBounds:YES];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(13.0f)];
        [button setFrame:CGRectMake(appviewx,appviewy + KXCUIControlSizeWidth(6.0f),
                                    KXCUIControlSizeWidth(20.0f),
                                    KXCUIControlSizeWidth(20.0f))];
        [button addTarget:self action:@selector(userOperationTrainUserInforButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:button];
        
        UILabel * userNameLabel = [[UILabel alloc]init];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameLabel setTextColor:KContentTextColor];
        [userNameLabel setText:userInfor.userNameStr];
        [userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [userNameLabel setFont:KFunctionModuleContentFont];
        [userNameLabel setFrame:CGRectMake((button.right + KXCUIControlSizeWidth(6.0f)),button.top,
                                           (passengerWidthFloat - KXCUIControlSizeWidth(26.0f)),
                                           KXCUIControlSizeWidth(20.0f))];
        [mainView addSubview:userNameLabel];

    }
    
    ///当前行数
    NSInteger rowInteger = passengerCountInteger/rowCount;
    ///最后一行的数据个数
    NSInteger columnMin = passengerCountInteger%rowCount;
    
    if (columnMin != 0) {
        rowInteger+=1;
    }
    CGFloat heightForHeader= (passengerLabel.top+passengerHightFloat*rowInteger);
    
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + heightForHeader)];

    UILabel *linkNameLabel = [[UILabel alloc]init];
    [linkNameLabel setBackgroundColor:[UIColor clearColor]];
    [linkNameLabel setTextColor:KSubTitleTextColor];
    [linkNameLabel setText:@"联系人姓名"];
    [linkNameLabel setTextAlignment:NSTextAlignmentLeft];
    [linkNameLabel setFont:KFunctionModuleContentFont];
    [linkNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth,(heightForHeader + KXCUIControlSizeWidth(20.0f)),
                                           KXCUIControlSizeWidth(75.0f), KFunctionModulButtonHeight)];
    [mainView addSubview:linkNameLabel];

    
    UILabel *linkPhoneLabel = [[UILabel alloc]init];
    [linkPhoneLabel setBackgroundColor:[UIColor clearColor]];
    [linkPhoneLabel setTextColor:KSubTitleTextColor];
    [linkPhoneLabel setText:@"联系人信息"];
    [linkPhoneLabel setTextAlignment:NSTextAlignmentLeft];
    [linkPhoneLabel setFont:KFunctionModuleContentFont];
    [linkPhoneLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                        (linkNameLabel.bottom + KXCUIControlSizeWidth(20.0f)),
                                        KXCUIControlSizeWidth(75.0f),KFunctionModulButtonHeight)];
    [mainView addSubview:linkPhoneLabel];
    
    
    
    UIView *nameTextBGView = [[UIView alloc]init];
    [nameTextBGView setBackgroundColor:[UIColor whiteColor]];
    [nameTextBGView setFrame:CGRectMake((linkPhoneLabel.right + KInforLeftIntervalWidth),
                                        (linkNameLabel.top + KXCUIControlSizeWidth(5.0f)),
                                        (KProjectScreenWidth - KXCUIControlSizeWidth(100.0f) - KInforLeftIntervalWidth),
                                        (KFunctionModulButtonHeight - KXCUIControlSizeWidth(10.0f)))];
    
    [mainView addSubview:nameTextBGView];
    
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
    [nameTextField setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)), 0.0f,
                                       (nameTextBGView.width - KXCUIControlSizeWidth(20.0f)),
                                       (KFunctionModulButtonHeight - KXCUIControlSizeWidth(10.0f)))];
    self.userNameContentField = nameTextField;
    [nameTextBGView addSubview:self.userNameContentField];
    

    UIView *emailOrPhoneTextBGView = [[UIView alloc]init];
    [emailOrPhoneTextBGView setBackgroundColor:[UIColor whiteColor]];
    [emailOrPhoneTextBGView setFrame:CGRectMake((linkPhoneLabel.right + KInforLeftIntervalWidth),
                                                (linkPhoneLabel.top + KXCUIControlSizeWidth(5.0f)),
                                                (KProjectScreenWidth - KXCUIControlSizeWidth(100.0f) - KInforLeftIntervalWidth),
                                                (KFunctionModulButtonHeight - KXCUIControlSizeWidth(10.0f)))];
    
    [mainView addSubview:emailOrPhoneTextBGView];
    
    UITextField *phoneTextField = [[UITextField alloc]init];
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    [phoneTextField setTextColor:KContentTextColor];
    [phoneTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setDelegate:self];
    [phoneTextField setTag:KTextForPhoneTextTag];
    [phoneTextField setFont:KXCAPPUIContentFontSize(18.0f)];
    [phoneTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneTextField setPlaceholder:@"请输入手机号或邮箱"];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号或邮箱"
                                                                           attributes:@{NSForegroundColorAttributeName: KFunContentColor}];
    [phoneTextField setFrame:CGRectMake((KXCUIControlSizeWidth(10.0f)), 0.0f,
                                        (emailOrPhoneTextBGView.width - KXCUIControlSizeWidth(20.0f)),
                                        (KFunctionModulButtonHeight - KXCUIControlSizeWidth(10.0f)))];
    self.phoneContentField = phoneTextField;
    [emailOrPhoneTextBGView addSubview:self.phoneContentField];

    if (!IsStringEmptyOrNull(self.userOrderForTrainticket.ttOrderBookUserInfor.userNameStr)) {
        [self.userNameContentField setText:self.userOrderForTrainticket.ttOrderBookUserInfor.userNameStr];
    }else if (!IsStringEmptyOrNull(self.userOrderForTrainticket.ttOrderBookUserInfor.userNickNameStr)){
        [self.userNameContentField setText:self.userOrderForTrainticket.ttOrderBookUserInfor.userNickNameStr];
    }
    
    
    if (!IsStringEmptyOrNull(self.userOrderForTrainticket.ttOrderBookUserInfor.userPerPhoneNumberStr)) {
        [self.phoneContentField setText:self.userOrderForTrainticket.ttOrderBookUserInfor.userPerPhoneNumberStr];
    }
    else if (!IsStringEmptyOrNull(self.userOrderForTrainticket.ttOrderBookUserInfor.userPerEmailStr)) {
        [self.phoneContentField setText:self.userOrderForTrainticket.ttOrderBookUserInfor.userPerEmailStr];
    }
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [searchBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [searchBtn setTag:KBtnForSubmitButtonTag];
    [searchBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [searchBtn.layer setCornerRadius:5.0f];
    [searchBtn addTarget:self action:@selector(userPersonalSubmitReturnButtonClickedEvent)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (emailOrPhoneTextBGView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [mainView addSubview:searchBtn];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == KTextForUserNameTextTag) {
        [self.phoneContentField becomeFirstResponder];
    }
    
    else if (textField.tag == KTextForPhoneTextTag){
        [self userPersonalSubmitReturnButtonClickedEvent];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    
    return YES;
}


- (void)userPersonalSubmitReturnButtonClickedEvent{
    
    ///联系人姓名不能为空！
    if (IsStringEmptyOrNull(self.userNameContentField.text)) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"联系人姓名不能为空！");
        [self.userNameContentField becomeFirstResponder];
        return;
    }
    
    ///联系人信息不能为空！
    if (IsStringEmptyOrNull(self.phoneContentField.text)) {
        [self.phoneContentField becomeFirstResponder];
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"联系人信息不能为空！");
        return;
    }
    
    
    if (self.selectedWillReturnUserArray.count < 1) {
        ShowIMAutoHideMBProgressHUD(HUIKeyWindow,@"请选择需要退票的乘客信息");
        return;
    }
    
    [self.view endEditing:YES];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"提交后该订单或乘客预订将被取消，是否继续操作？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView setTag:KAlertForSubmitAlertViewTag];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == KAlertForSubmitAlertViewTag) {
        
        if (buttonIndex != 0) {
            [self userPersonalSubmitReturnOrderRequestion];
        }
    }
}


- (void)userOperationTrainUserInforButtonEvent:(UIUserOperationButton *)button{
    
    ///判断里面是否有这个人
    ///若存在这个人，将该人移除，设置界面
    if ([self.selectedWillReturnUserArray containsObject:button.userOperation]) {
        
        
        [self.selectedWillReturnUserArray removeObject:button.userOperation];
        
        [button setAwesomeIcon:FMIconNULL];
        [button simpleButtonWithImageColor:[UIColor clearColor]];
        [button.layer setBorderColor:KSubTitleTextColor.CGColor];
        
    }else{
        [self.selectedWillReturnUserArray addObject:button.userOperation];
        
        [button.layer setBorderColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f).CGColor];
        [button setAwesomeIcon:FMIconSelected];
        [button simpleButtonWithImageColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)];
    }
}


- (void)userPersonalSubmitReturnOrderRequestion{
    

    if (self.selectedWillReturnUserArray.count > 0) {
        
        ///将每个人员拿出来
        NSMutableArray *travellerArray = [NSMutableArray array];
        
        for (UserInformationClass *itemUser in self.selectedWillReturnUserArray) {
            ///格式化
            NSDictionary *userDic = [itemUser setupUserPersonalForTrainUserRefundParameter];
            [travellerArray addObject:userDic];
        }
        ///JSON数据
        NSString *jsonUserStr = [travellerArray JSONString];
        
        WaittingMBProgressHUD(HUIKeyWindow,@"验证退票信息...");
        [XCAPPHTTPClient requestUserApplyForRefundOrderTrainTicketWithUserId:KXCAPPCurrentUserInformation.userPerId orderNo:self.userOrderForTrainticket.ttOrderTradeNumber qunarOrderNo:self.userOrderForTrainticket.ttOrderTradeNumberCodeForQuNaErStr comment:@"客户端退票" passengers:jsonUserStr completion:^(WebAPIResponse *response) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                NSLog(@"客户端退票 %@",response.responseObject);
                
                if (response.code == WebAPIResponseCodeSuccess) {
                    NSLog(@"客户端退票 成功了！");
                    
                    SuccessMBProgressHUD(HUIKeyWindow  , @"退票申请操作成功，48小时将退还您的购票资金！");
                }
                else{
                    
                    if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                        NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                        
                        NSLog(@"msg！is %@",msg);
                        FailedMBProgressHUD(HUIKeyWindow,msg);
                    }
                    else{
                        FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
                    }
                }
                
            });
        }];

    }

    
    NSLog(@"提交退款申请网络请求操作处理");
}
@end
