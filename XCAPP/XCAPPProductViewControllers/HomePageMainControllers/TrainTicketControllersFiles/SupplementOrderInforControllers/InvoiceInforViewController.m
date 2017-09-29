//
//  InvoiceInforViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/5.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "InvoiceInforViewController.h"

@interface InvoiceInforViewController ()


/*!
 * @breif 发票说明信息
 * @See
 */
@property (nonatomic , assign)              UILabel                 *showInforLabel;
/*!
 * @breif 发票说明信息
 * @See
 */
@property (nonatomic , assign)              UIView                  *invoiceSupplementBGView;
@end

@implementation InvoiceInforViewController


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
    
    [self settingNavTitle:@"发票"];
    [self setRightNavButtonTitleStr:@"完成" withFrame:kNavBarButtonRect
                       actionTarget:self action:@selector(editInvoiceInforFinishEventClicked)];
    
    [self setupInvoiceInforViewControllerFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editInvoiceInforFinishEventClicked{
    
}


- (void)setupInvoiceInforViewControllerFrame{
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainView];
    [mainView setContentSize:CGSizeMake(KProjectScreenWidth, mainView.height + 30.0f)];
    
    UIView *invoiceInforBGView = [[UIView alloc]init];
    [invoiceInforBGView setBackgroundColor:[UIColor whiteColor]];
    [invoiceInforBGView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth, KProjectScreenWidth,
                                            KFunctionModulButtonHeight*2+1.0f)];
    [mainView addSubview:invoiceInforBGView];
    
    UILabel  *moneyLabel = [[UILabel alloc]init];
    [moneyLabel setBackgroundColor:[UIColor clearColor]];
    [moneyLabel setTextAlignment:NSTextAlignmentLeft];
    [moneyLabel setTextColor:KFunctionModuleContentColor];
    [moneyLabel setFont:KFunctionModuleContentFont];
    [moneyLabel setText:@"发票金额"];
    [moneyLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,0.0f, 90.0f, KFunctionModulButtonHeight)];
    [invoiceInforBGView addSubview:moneyLabel];
    
    UIView *sepInvoiceView = [[UIView alloc]init];
    [sepInvoiceView setFrame:CGRectMake(0.0f, (moneyLabel.bottom),
                                     invoiceInforBGView.width, 1.0f)];
    [sepInvoiceView setBackgroundColor:KSepLineColorSetup];
    [invoiceInforBGView addSubview:sepInvoiceView];
    
    
    UILabel  *mailLabel = [[UILabel alloc]init];
    [mailLabel setBackgroundColor:[UIColor clearColor]];
    [mailLabel setTextAlignment:NSTextAlignmentLeft];
    [mailLabel setTextColor:KFunctionModuleContentColor];
    [mailLabel setFont:KFunctionModuleContentFont];
    [mailLabel setText:@"是否邮寄发票"];
    [mailLabel setFrame:CGRectMake(KFunctionModuleContentLeftWidth,sepInvoiceView.bottom, 160.0f, KFunctionModulButtonHeight)];
    [invoiceInforBGView addSubview:mailLabel];

    
    UILabel *showLabel = [[UILabel alloc]init];
    [showLabel setBackgroundColor:[UIColor clearColor]];
    [showLabel setText:@"服务费（礼品卡支付部分除外）的发票会在您出行后10个工作日内以平信寄出。"];
    [showLabel setTextColor:KContentTextColor];
    [showLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [showLabel setNumberOfLines:0];
    [showLabel setTextAlignment:NSTextAlignmentLeft];
    [showLabel setLineBreakMode:NSLineBreakByWordWrapping];
    CGSize showSize = [showLabel.text sizeWithFont:showLabel.font
                                 constrainedToSize:CGSizeMake(KProjectScreenWidth - KInforLeftIntervalWidth*2,
                                                              CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    [showLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (invoiceInforBGView.bottom+ KInforLeftIntervalWidth*1.5),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2), showSize.height)];
    self.showInforLabel = showLabel;
    [mainView addSubview:self.showInforLabel];

}

@end
