//
//  XCTabBarController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCTabBarController.h"
#import "FontAwesome.h"
#import "HomeMainViewController.h"
#import "AuthorizeMainViewController.h"
#import "ItineraryMainViewController.h"
#import "PerOrderListViewController.h"
#import "PersonalInforViewController.h"


#define kFontThinName                           @"STHeitiSC-Light"              //细字体
#define kTableBarFontSize                       [UIFont fontWithName:kFontThinName size:10.0]

#define KRedUnReadMsgImageWidth                 (KXCUIControlSizeWidth(10.0f))


#define KTabBarBackGroundColor                  HUIRGBColor(35.0f, 47.0f, 61.0f, 1.0f)

#define KTabBarItemTitleNormalColor             HUIRGBColor(88.0f, 141.0f, 219.0f, 1.0f)

#define KTabBarItemTitleSelectedColor           [UIColor whiteColor]



@interface XCTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic , strong)  UINavigationController *baseNavigationController;

/*!
 * @breif 选中的模块名字
 * @See
 */
@property (nonatomic , strong)      NSString            *itemBarTitleStr;

@end

@implementation XCTabBarController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (id)initWithNavigationController:(UINavigationController *)navigationController{
    
    self = [super init];
    if (self) {
        self.baseNavigationController = navigationController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉当前选择button上的阴影
    if ([self.tabBar respondsToSelector:@selector(setSelectionIndicatorImage:)]) {
        self.tabBar.selectionIndicatorImage = createImageWithColor(KTabBarBackGroundColor);//设置选中时图片
    }
//
    //去掉顶部阴影条
    if ([UITabBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
        [self.tabBar setShadowImage: createImageWithColor(KTabBarBackGroundColor)];
    }

    //设置背景
    UIImage* img = createImageWithColor(KTabBarBackGroundColor);
    if(img){
        [self.tabBar setBackgroundImage:img];
        
    }else{
        UIColor* color = KTabBarBackGroundColor;
        if (color) {
            
            if(HUISystemVersionBelow(kHUISystemVersion_7_0)){
                self.tabBar.tintColor = color;
            }else{
                
                self.tabBar.barTintColor = color;
            }
        }
    }

//    nstext
    //title颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{ NSFontAttributeName: kTableBarFontSize,
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
        NSForegroundColorAttributeName: KTabBarItemTitleNormalColor}
                                             forState:UIControlStateNormal];

    [[UITabBarItem appearance] setTitleTextAttributes:
     @{ NSFontAttributeName: kTableBarFontSize,
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
        NSForegroundColorAttributeName: KTabBarItemTitleSelectedColor}
                                             forState:UIControlStateSelected];
//
    [self setupTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabBarController{
    
    ///首页
    HomeMainViewController *homeController = [[HomeMainViewController alloc]init];
    XCAPPNavigationController *homeNav = [[XCAPPNavigationController alloc]initWithRootViewController:homeController];
    
    ////订单
    PerOrderListViewController *authorizeController = [[PerOrderListViewController alloc]init];
    XCAPPNavigationController *authorizeNav = [[XCAPPNavigationController alloc]initWithRootViewController:authorizeController];
    
//    ///行程
//    ItineraryMainViewController *itineraryController = [[ItineraryMainViewController alloc]init];
//    XCAPPNavigationController *itineraryNav = [[XCAPPNavigationController alloc]initWithRootViewController:itineraryController];
    
    ////我的
    PersonalInforViewController *personalController = [[PersonalInforViewController alloc]init];
    XCAPPNavigationController *personalNav = [[XCAPPNavigationController alloc]initWithRootViewController:personalController];
    
    //设置tabbar，并默认选中首页
    self.viewControllers = [NSArray arrayWithObjects:homeNav,authorizeNav, personalNav, nil];
    
    [self setTabRootControlItem];
}

- (void)setTabRootControlItem{
    
    if ([self.viewControllers count] < 3) {
        return;
    }
    /**
     **/
    ///大厅
    XCAPPNavigationController *homePageNC = [self.viewControllers objectAtIndex:0];
    homePageNC.tabBarItem = [self addButtonWithNormalImage:[FontAwesome imageWithIcon:FMNewHomeIcon
                                                                            iconColor:KTabBarItemTitleNormalColor
                                                                             iconSize:KTabBarItemBtnSize]
                                             selectedImage:[FontAwesome imageWithIcon:FMNewHomeIcon
                                                                            iconColor:KTabBarItemTitleSelectedColor
                                                                             iconSize:KTabBarItemBtnSize]
                                                     title:@"酒店"];
    self.itemBarTitleStr = @"酒店";
    
    ///信息
    XCAPPNavigationController *messageNC = [self.viewControllers objectAtIndex:1];
    messageNC.tabBarItem = [self addButtonWithNormalImage:[FontAwesome imageWithIcon:FMNewMessageIcon
                                                                           iconColor:KTabBarItemTitleNormalColor
                                                                            iconSize:KTabBarItemBtnSize]
                                            selectedImage:[FontAwesome imageWithIcon:FMNewMessageIcon
                                                                           iconColor:KTabBarItemTitleSelectedColor
                                                                            iconSize:KTabBarItemBtnSize]
                                                    title:@"订单"];
    
    ///我的
    XCAPPNavigationController *personalNC = [self.viewControllers objectAtIndex:2];
    personalNC.tabBarItem = [self addButtonWithNormalImage:[FontAwesome imageWithIcon:FMNewPeopleIcon
                                                                            iconColor:KTabBarItemTitleNormalColor
                                                                             iconSize:KTabBarItemBtnSize]
                                             selectedImage:[FontAwesome imageWithIcon:FMNewPeopleIcon
                                                                            iconColor:KTabBarItemTitleSelectedColor
                                                                             iconSize:KTabBarItemBtnSize]
                                                     title:@"我的"];
    
}

- (UITabBarItem* )addButtonWithNormalImage:(UIImage *)normalImage
                             selectedImage:(UIImage*)selectedImage
                                     title:(NSString* )title
{
    UITabBarItem *tabBarItem = nil;
    if(HUISystemVersionBelow(kHUISystemVersion_7_0)){
        tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        //        tabBarItem
        
    } else {
        tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    //    tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0,-6, 0);
    //    tabBarItem.titlePositionAdjustment=UIEdgeInsetsMake(6, 0,-6, 0);
    return tabBarItem;
    
}
- (void)clickTabbarIndex:(int)index
{
    
//    NSLog(@"---------enenne ");
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
//    NSUUID *userUuId = [[NSUUID alloc]init];
//    
//    NSString *userUUIDStr = [NSString stringWithFormat:@"%@",userUuId];
//    
//    NSLog(@"\nuserUuId.UUIDString is %@\nuserUUIDStr is %@",userUuId.UUIDString,userUUIDStr);
//    
    
    if ([item.title isEqualToString:self.itemBarTitleStr]) {
        if ([self.itemBarTitleStr isEqualToString:@"订单"]) {
            
            
            
            
            /////在订单界面中多次点击，起到刷新效果
            [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserRefreshUserOrderDataNotification
                                                                object:nil];
        }
    }
    
    if (![self.itemBarTitleStr isEqualToString:@"我的"]) {
        
        

        if ([item.title isEqualToString:@"我的"]){
//            NSLog(@"刷新请求数据信息");
            
            ///MARK:用户从其他模块进入“我的”模块时，刷新界面数据内容
            [[NSNotificationCenter defaultCenter] postNotificationName:KXCAPPUserIntoPersonalFromOtherRefreshDataNotification
                                                                object:nil];
        }
    }
    self.itemBarTitleStr = item.title;
    
    
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"zhende");
}

@end
