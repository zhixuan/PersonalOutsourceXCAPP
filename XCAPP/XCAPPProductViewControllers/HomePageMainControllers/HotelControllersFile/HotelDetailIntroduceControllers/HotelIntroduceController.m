//
//  HotelIntroduceController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelIntroduceController.h"
#import "HTTPClient.h"
#import "HTTPClient+HotelsRequest.h"

@interface HotelIntroduceController ()
/*!
 * @breif 酒店信息
 * @See
 */
@property (nonatomic , strong)      HotelInformation         *hotelIntroductionInfor;
@end

@implementation HotelIntroduceController

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

- (id)initWithHotelInfor:(HotelInformation *)hotelInfor{
    self = [super init];
    if (self) {
        self.hotelIntroductionInfor = hotelInfor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNavTitle:@"酒店介绍"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestHotelInformation{
    
    WaittingMBProgressHUD(HUIKeyWindow, @"正在加载...");
    [XCAPPHTTPClient hotelIntroductionWithHotelId:self.hotelIntroductionInfor.hotelIdStr completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                FinishMBProgressHUD(HUIKeyWindow);
                
                NSLog(@"response.responseObject is %@",response.responseObject);
            }
            else if (response.code == WebAPIResponseCodeFailed) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg) isKindOfClass:[NSString class]]) {
                    NSString *msg = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg);
                    FailedMBProgressHUD(HUIKeyWindow,msg);
                }
            }
            else{
                FailedMBProgressHUD(HUIKeyWindow,WebAPIResponseCodeFailedErrorMark);
            }
        });
    }];
}

@end
