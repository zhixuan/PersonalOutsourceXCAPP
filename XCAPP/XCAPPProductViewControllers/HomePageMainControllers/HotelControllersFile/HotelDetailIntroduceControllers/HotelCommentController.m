//
//  HotelCommentController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/13.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelCommentController.h"

@interface HotelCommentController ()
/*!
 * @breif 酒店信息
 * @See
 */
@property (nonatomic , strong)      HotelInformation         *hotelCommentInfor;
@end

@implementation HotelCommentController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
//        self.enableCustomNavbarBackButton = FALSE ;
//        self.dataSource = [DataPage page];
//        <#//MARK:加入其他信息#>
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
//        self.enableCustomNavbarBackButton = FALSE ;
//        self.dataSource = [DataPage page];
//        <#//MARK:加入其他信息#>
        self.hotelCommentInfor = hotelInfor;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNavTitle:@"酒店评价"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
