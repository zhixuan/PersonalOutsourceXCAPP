//
//  ViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "ViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+PersonalInfor.h"
#import "OpenUDID.h"

@interface ViewController ()

@end

@implementation ViewController
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
    [self settingNavTitle:@"你好"];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [XCAPPHTTPClient userPersonalCheckTravelRountListInforWithPageNumber:1 pageSize:15 completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"response.responseObject is %@",response.responseObject);
            }
        });
    }];
     
    
    NSString *openUDIDStr = [OpenUDID value];
    NSLog(@"openUDIDStr is %@",openUDIDStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
