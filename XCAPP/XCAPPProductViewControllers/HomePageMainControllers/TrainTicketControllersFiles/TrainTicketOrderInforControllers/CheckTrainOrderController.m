//
//  CheckTrainOrderController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "CheckTrainOrderController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

#define KBtnForOrderDetailButtonTag     (1430111)
#define KBtnForPayButtonTag             (1430112)


@interface CheckTrainOrderController ()

/*!
 * @breif 核对信息原始数据
 * @See
 */
@property (nonatomic , strong)              TrainticketOrderInformation         *checkTrainOrderInfor;

@end

@implementation CheckTrainOrderController


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
        self.checkTrainOrderInfor = orderItem;
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
    [self settingNavTitle:@"核对订单"];
    [self setupCheckTrainOrderControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCheckTrainOrderControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    
    
    //MARK:车票信息信息
    UIView *ticketBGView = [[UIView alloc]init];
    [ticketBGView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                      (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                      (KFunctionModulButtonHeight + KXCUIControlSizeWidth(65.0f)))];
    [ticketBGView setBackgroundColor:[UIColor whiteColor]];
    [ticketBGView.layer setBorderWidth:1.0];
    [ticketBGView.layer setBorderColor:KSepLineColorSetup.CGColor];
    [ticketBGView.layer setCornerRadius:5.0f];
    [ticketBGView.layer setMasksToBounds:YES];
    [ticketBGView setBackgroundColor:[UIColor whiteColor]];
    [mainView addSubview:ticketBGView];
    
    
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f)];
    [headerView setFrame:CGRectMake(0.0f, 0.0f, ticketBGView.width,
                                         KFunctionModulButtonHeight)];
    [ticketBGView addSubview:headerView];

    UILabel *dateInfor = [[UILabel alloc]init];
    [dateInfor setBackgroundColor:[UIColor clearColor]];
    [dateInfor setTextColor:[UIColor whiteColor]];
    [dateInfor setText:@"2016-08-20/2016-08-29"];
    [dateInfor setTextAlignment:NSTextAlignmentLeft];
    [dateInfor setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [dateInfor setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, (headerView.width - KXCUIControlSizeWidth(80.0f) - KInforLeftIntervalWidth), KFunctionModulButtonHeight)];
    [headerView addSubview:dateInfor];
    

    UILabel *ticketNameInfor = [[UILabel alloc]init];
    [ticketNameInfor setBackgroundColor:[UIColor clearColor]];
    [ticketNameInfor setTextColor:[UIColor whiteColor]];
    [ticketNameInfor setText:self.checkTrainOrderInfor.ttOrderTrainticketInfor.traCodeNameStr];
    [ticketNameInfor setTextAlignment:NSTextAlignmentRight];
    [ticketNameInfor setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [ticketNameInfor setFrame:CGRectMake((headerView.width - KXCUIControlSizeWidth(80.0f) - KInforLeftIntervalWidth),
                                         0.0f, KXCUIControlSizeWidth(80.0f), KFunctionModulButtonHeight)];
    [headerView addSubview:ticketNameInfor];
    
    
    UILabel *startTimeInfor = [[UILabel alloc]init];
    [startTimeInfor setBackgroundColor:[UIColor clearColor]];
    [startTimeInfor setTextColor:KContentTextColor];
    [startTimeInfor setText:[NSString stringWithFormat:@"%@",
                         self.checkTrainOrderInfor.ttOrderTrainticketInfor.traTakeOffTime]];
    [startTimeInfor setTextAlignment:NSTextAlignmentLeft];
    [startTimeInfor setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [startTimeInfor setFrame:CGRectMake(KInforLeftIntervalWidth, (headerView.bottom + KXCUIControlSizeWidth(3.0f)),
                                    ( KXCUIControlSizeWidth(80.0f)), KXCUIControlSizeWidth(24.0f))];
    [ticketBGView addSubview:startTimeInfor];
    
    UILabel *arrivedTimeInfor = [[UILabel alloc]init];
    [arrivedTimeInfor setBackgroundColor:[UIColor clearColor]];
    [arrivedTimeInfor setTextColor:KContentTextColor];
    [arrivedTimeInfor setText:[NSString stringWithFormat:@"%@",
                         self.checkTrainOrderInfor.ttOrderTrainticketInfor.traArrivedTime]];
    [arrivedTimeInfor setTextAlignment:NSTextAlignmentLeft];
    [arrivedTimeInfor setFont:KXCAPPUIContentDefautFontSize(14.0f)];
    [arrivedTimeInfor setFrame:CGRectMake(KInforLeftIntervalWidth, startTimeInfor.bottom,
                                     KXCUIControlSizeWidth(80.0f), KXCUIControlSizeWidth(24.0f))];
    [ticketBGView addSubview:arrivedTimeInfor];
    
    UILabel *startSiteInfor = [[UILabel alloc]init];
    [startSiteInfor setBackgroundColor:[UIColor clearColor]];
    [startSiteInfor setTextColor:KContentTextColor];
    [startSiteInfor setText:self.checkTrainOrderInfor.ttOrderTrainticketInfor.traTakeOffSite];
    [startSiteInfor setTextAlignment:NSTextAlignmentLeft];
    [startSiteInfor setFont:KXCAPPUIContentFontSize(14.0f)];
    [startSiteInfor setFrame:CGRectMake((startTimeInfor.right + KInforLeftIntervalWidth), (headerView.bottom + KXCUIControlSizeWidth(3.0f)),
                                        ( KXCUIControlSizeWidth(80.0f)), KXCUIControlSizeWidth(24.0f))];
    [ticketBGView addSubview:startSiteInfor];
    
    UILabel *arrivedSiteInfor = [[UILabel alloc]init];
    [arrivedSiteInfor setBackgroundColor:[UIColor clearColor]];
    [arrivedSiteInfor setTextColor:KContentTextColor];
    [arrivedSiteInfor setText:self.checkTrainOrderInfor.ttOrderTrainticketInfor.traArrivedSite];
    [arrivedSiteInfor setTextAlignment:NSTextAlignmentLeft];
    [arrivedSiteInfor setFont:KXCAPPUIContentFontSize(14.0f)];
    [arrivedSiteInfor setFrame:CGRectMake((startTimeInfor.right + KInforLeftIntervalWidth), startTimeInfor.bottom,
                                          KXCUIControlSizeWidth(80.0f), KXCUIControlSizeWidth(24.0f))];
    [ticketBGView addSubview:arrivedSiteInfor];
    
    
    UILabel *unPriceInfor = [[UILabel alloc]init];
    [unPriceInfor setBackgroundColor:[UIColor clearColor]];
    [unPriceInfor setTextColor:KContentTextColor];
    [unPriceInfor setText:[NSString stringWithFormat:@"￥%@",
                           self.checkTrainOrderInfor.ttOrderTrainticketInfor.traUnitPrice]];
    [unPriceInfor setTextAlignment:NSTextAlignmentLeft];
    [unPriceInfor setFont:KXCAPPUIContentFontSize(15.0f)];
    [unPriceInfor setFrame:CGRectMake((ticketBGView.width - KInforLeftIntervalWidth -  KXCUIControlSizeWidth(60.0f))
                                      , (headerView.bottom + KXCUIControlSizeWidth(3.0f)),
                                        ( KXCUIControlSizeWidth(80.0f)), KXCUIControlSizeWidth(24.0f))];
    [ticketBGView addSubview:unPriceInfor];
    NSRange priceRange=[unPriceInfor.text rangeOfString:self.checkTrainOrderInfor.ttOrderTrainticketInfor.traUnitPrice];
    NSMutableAttributedString *unPriceContent=[[NSMutableAttributedString alloc]initWithString:unPriceInfor.text];
    [unPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(18.0f) range:priceRange];
    [unPriceContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:priceRange];
    [unPriceInfor setAttributedText:unPriceContent];
    
    UILabel *ticketClassInfor = [[UILabel alloc]init];
    [ticketClassInfor setBackgroundColor:[UIColor clearColor]];
    [ticketClassInfor setTextColor:KContentTextColor];
    [ticketClassInfor setText:self.checkTrainOrderInfor.ttOrderTrainticketInfor.traCabinModelStr];
    [ticketClassInfor setTextAlignment:NSTextAlignmentLeft];
    [ticketClassInfor setFont:KXCAPPUIContentFontSize(15.0f)];
    [ticketClassInfor setFrame:CGRectMake((ticketBGView.width - KInforLeftIntervalWidth -  KXCUIControlSizeWidth(60.0f)),
                                          startTimeInfor.bottom,
                                          KXCUIControlSizeWidth(60.0f), KXCUIControlSizeWidth(24.0f))];
    [ticketBGView addSubview:ticketClassInfor];
    
    
    
    //MARK:人员信息
    
    UIView *userBGView = [[UIView alloc]init];
    [userBGView setBackgroundColor:[UIColor whiteColor]];
    [userBGView setFrame:CGRectMake(0.0f, (ticketBGView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                    (KFunctionModulButtonHeight*1.4+1.0f))];
    [mainView addSubview:userBGView];
    
    
    UILabel *userNameInfor = [[UILabel alloc]init];
    [userNameInfor setBackgroundColor:[UIColor clearColor]];
    [userNameInfor setTextColor:KContentTextColor];
    [userNameInfor setText:@"张利广"];
    [userNameInfor setTextAlignment:NSTextAlignmentLeft];
    [userNameInfor setFont:KXCAPPUIContentFontSize(14.0f)];
    [userNameInfor setFrame:CGRectMake((KInforLeftIntervalWidth),8.0f,
                                        ( KXCUIControlSizeWidth(120.0f)), KXCUIControlSizeWidth(24.0f))];
    [userBGView addSubview:userNameInfor];
    
    UILabel *userCardIdInfor = [[UILabel alloc]init];
    [userCardIdInfor setBackgroundColor:[UIColor clearColor]];
    [userCardIdInfor setTextColor:KContentTextColor];
    [userCardIdInfor setText:@"身份证"];
    [userCardIdInfor setTextAlignment:NSTextAlignmentLeft];
    [userCardIdInfor setFont:KXCAPPUIContentFontSize(14.0f)];
    [userCardIdInfor setFrame:CGRectMake((userNameInfor.right),8.0f,
                                       ( KXCUIControlSizeWidth(160.0f)), KXCUIControlSizeWidth(18.0f))];
    [userBGView addSubview:userCardIdInfor];
    
    UILabel *userCardIdNumberInfor = [[UILabel alloc]init];
    [userCardIdNumberInfor setBackgroundColor:[UIColor clearColor]];
    [userCardIdNumberInfor setTextColor:KContentTextColor];
    [userCardIdNumberInfor setText:@"130426199409274915"];
    [userCardIdNumberInfor setTextAlignment:NSTextAlignmentLeft];
    [userCardIdNumberInfor setFont:KXCAPPUIContentDefautFontSize(15.0f)];
    [userCardIdNumberInfor setFrame:CGRectMake((userNameInfor.right),
                                               (5.0f + userCardIdInfor.bottom),
                                               (KXCUIControlSizeWidth(160.0f)),
                                               KXCUIControlSizeWidth(18.0f))];
    [userBGView addSubview:userCardIdNumberInfor];
    
    
    //MARK:服务费信息
    UIView *serveCostBGView = [[UIView alloc]init];
    [serveCostBGView setFrame:CGRectMake(0.0f, (userBGView.bottom + KInforLeftIntervalWidth),
                                         KProjectScreenWidth, (KFunctionModulButtonHeight))];
    [serveCostBGView setBackgroundColor:[UIColor whiteColor]];
    [mainView addSubview:serveCostBGView];
    
    UILabel  *serveCostLabel = [[UILabel alloc]init];
    [serveCostLabel setBackgroundColor:[UIColor clearColor]];
    [serveCostLabel setTextAlignment:NSTextAlignmentLeft];
    [serveCostLabel setTextColor:KFunctionModuleContentColor];
    [serveCostLabel setFont:KFunctionModuleContentFont];
    [serveCostLabel setText:@"服务费"];
    [serveCostLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [serveCostBGView addSubview:serveCostLabel];
    
    UILabel  *serveCostContentLabel = [[UILabel alloc]init];
    [serveCostContentLabel setBackgroundColor:[UIColor clearColor]];
    [serveCostContentLabel setTextAlignment:NSTextAlignmentLeft];
    [serveCostContentLabel setTextColor:KContentTextColor];
    [serveCostContentLabel setFont:KFunctionModuleContentFont];
    [serveCostContentLabel setText:@"￥20 × 1"];
    [serveCostContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth),0.0f, KXCUIControlSizeWidth(150.0f), KFunctionModulButtonHeight)];
    [serveCostBGView addSubview:serveCostContentLabel];
    
    NSRange serveCostContentRange=[serveCostContentLabel.text rangeOfString:@"20"];
    NSMutableAttributedString *serveCostContent=[[NSMutableAttributedString alloc]initWithString:serveCostContentLabel.text];
    [serveCostContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(18.0f) range:serveCostContentRange];
    [serveCostContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:serveCostContentRange];
    [serveCostContentLabel setAttributedText:serveCostContent];
    
    //MARK:用户联系信息
    UIView *addressBookBGView = [[UIView alloc]init];
    [addressBookBGView setBackgroundColor:[UIColor whiteColor]];
    [addressBookBGView setFrame:CGRectMake(0.0f, (serveCostBGView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                    (KFunctionModulButtonHeight*2+1.0f))];
    [mainView addSubview:addressBookBGView];
    
    UILabel  *phoneLabel = [[UILabel alloc]init];
    [phoneLabel setBackgroundColor:[UIColor clearColor]];
    [phoneLabel setTextAlignment:NSTextAlignmentLeft];
    [phoneLabel setTextColor:KFunctionModuleContentColor];
    [phoneLabel setFont:KFunctionModuleContentFont];
    [phoneLabel setText:@"联系手机"];
    [phoneLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [addressBookBGView addSubview:phoneLabel];
    
    UILabel  *phoneContentLabel = [[UILabel alloc]init];
    [phoneContentLabel setBackgroundColor:[UIColor clearColor]];
    [phoneContentLabel setTextAlignment:NSTextAlignmentLeft];
    [phoneContentLabel setTextColor:KFunctionModuleContentColor];
    [phoneContentLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [phoneContentLabel setText:@"18615459060"];
    [phoneContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth),0.0f,
                                            (addressBookBGView.width -(KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth) ), KFunctionModulButtonHeight)];
    [addressBookBGView addSubview:phoneContentLabel];
    
    UIView *sepUserView = [[UIView alloc]init];
    [sepUserView setFrame:CGRectMake(0.0f, (KFunctionModulButtonHeight),
                                     addressBookBGView.width, 1.0f)];
    [sepUserView setBackgroundColor:KSepLineColorSetup];
    [addressBookBGView addSubview:sepUserView];
    
    UILabel  *emailLabel = [[UILabel alloc]init];
    [emailLabel setBackgroundColor:[UIColor clearColor]];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    [emailLabel setTextColor:KFunctionModuleContentColor];
    [emailLabel setFont:KFunctionModuleContentFont];
    [emailLabel setText:@"邮箱"];
    [emailLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,sepUserView.bottom, 90.0f, KFunctionModulButtonHeight)];
    [addressBookBGView addSubview:emailLabel];
    
    UILabel  *emailContentLabel = [[UILabel alloc]init];
    [emailContentLabel setBackgroundColor:[UIColor clearColor]];
    [emailContentLabel setTextAlignment:NSTextAlignmentLeft];
    [emailContentLabel setTextColor:KFunctionModuleContentColor];
    [emailContentLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [emailContentLabel setText:@"zhangliguang1@hotmail.com"];
    [emailContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth),
                                           sepUserView.bottom, (addressBookBGView.width -(KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth) ), KFunctionModulButtonHeight)];
    [addressBookBGView addSubview:emailContentLabel];
    
    //MARK:支付方式
    
    UIView *payStyleBGView = [[UIView alloc]init];
    [payStyleBGView setBackgroundColor:[UIColor whiteColor]];
    [payStyleBGView setFrame:CGRectMake(0.0f, (addressBookBGView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                           (KFunctionModulButtonHeight))];
    [mainView addSubview:payStyleBGView];
    
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
    [payContentLabel setText:@"支付宝支付"];
    [payContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth),0.0f, 90.0f, KFunctionModulButtonHeight)];
    [payStyleBGView addSubview:payContentLabel];
    //MARK:用户发票是否需要
    
    UIView *invoiceBGView = [[UIView alloc]init];
    [invoiceBGView setBackgroundColor:[UIColor whiteColor]];
    [invoiceBGView setFrame:CGRectMake(0.0f, (payStyleBGView.bottom + KInforLeftIntervalWidth), KProjectScreenWidth,
                                        (KFunctionModulButtonHeight))];
    [mainView addSubview:invoiceBGView];
    
    UILabel  *invoiceleLabel = [[UILabel alloc]init];
    [invoiceleLabel setBackgroundColor:[UIColor clearColor]];
    [invoiceleLabel setTextAlignment:NSTextAlignmentLeft];
    [invoiceleLabel setTextColor:KFunctionModuleContentColor];
    [invoiceleLabel setFont:KFunctionModuleContentFont];
    [invoiceleLabel setText:@"发票"];
    [invoiceleLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [invoiceBGView addSubview:invoiceleLabel];
    
    UILabel  *invoiceContentLabel = [[UILabel alloc]init];
    [invoiceContentLabel setBackgroundColor:[UIColor clearColor]];
    [invoiceContentLabel setTextAlignment:NSTextAlignmentLeft];
    [invoiceContentLabel setTextColor:KFunctionModuleContentColor];
    [invoiceContentLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [invoiceContentLabel setText:@"不需要"];
    [invoiceContentLabel setFrame:CGRectMake((KXCUIControlSizeWidth(120.0f) + KInforLeftIntervalWidth),0.0f, 90.0f, KFunctionModulButtonHeight)];
    [invoiceBGView addSubview:invoiceContentLabel];
    
    
    [self bottomTrainOrderDetailView];
}

- (void)bottomTrainOrderDetailView{
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
    [detailedButton setTag:KBtnForOrderDetailButtonTag];
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
    
    ///查看详情
    if (KBtnForOrderDetailButtonTag == button.tag) {
        

    }
    
    ///支付操作
    else if (KBtnForPayButtonTag == button.tag){
        
    }
}



@end
