//
//  XCAPPUIViewController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/23.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCAPPUIViewController.h"

///副标题颜色
#define KSubTitleTextColor              [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1]

@interface XCAPPUIViewController ()

@end

@implementation XCAPPUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.enableCustomNavbarBackButton = YES;
        self.navButtonSize = KNavSize;
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        self.enableCustomNavbarBackButton = YES;
        self.navButtonSize = KNavSize;
    }
    return self;
}
- (void)loadView
{
    
    
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = KDefaultViewBackGroundColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.enableCustomNavbarBackButton)
    {
        self.navButtonSize = KNavSize;
        [self setLeftNavButtonFA:FMIconLeftReturn
                       withFrame:kNavBarButtonRect
                    actionTarget:self
                          action:@selector(_backToPrevController)];
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) settingNavTitle:(NSString *)title
{
    
    CGRect rcTileView = CGRectMake(110, 0, (KProjectScreenWidth - 110.0*2), 44);
    
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame: rcTileView];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    [titleTextLabel setTextAlignment:NSTextAlignmentCenter];
    titleTextLabel.textColor = KDefineUIButtonTitleNormalColor;
    [titleTextLabel setFont:KXCAPPUIContentDefautFontSize(20.0f)];
    [titleTextLabel setText:title];
    self.navigationItem.titleView = titleTextLabel;
    
}

- (void) settingNavTitleWithTitle:(NSString *)title colour:(UIColor *)titleColor{
    CGRect rcTileView = CGRectMake(90, 0, (KProjectScreenWidth - 90.0*2), 44);
    
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame: rcTileView];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    [titleTextLabel setTextAlignment:NSTextAlignmentCenter];
    titleTextLabel.textColor = titleColor;
    [titleTextLabel setFont:KXCAPPUIContentDefautFontSize(22.0f)];
    [titleTextLabel setText:title];
    self.navigationItem.titleView = titleTextLabel;
}
- (void) setLeftNavButtonFA:(NSInteger)buttonType withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = [UIFont systemFontOfSize:self.navButtonSize];
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [navButton simpleButtonWithImageColor:[UIColor whiteColor]];
    [navButton addAwesomeIcon:buttonType beforeTitle:YES];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    self.navigationItem.leftBarButtonItem = navItem;
}
- (void) setLeftNavButton:(UIImage* )btImage withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    [navButton setImage:btImage forState:UIControlStateNormal];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, navItem, nil] animated:NO];
    }else{
        self.navigationItem.leftBarButtonItem = navItem;
    }
    
}

- (void)setLeftNavButtonTitleStr:(NSString *)titleStr withFrame:(CGRect)frame actionTarget:(id)target action:(SEL)action{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = KXCAPPUIContentFontSize(15.0f);
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [navButton setTitle:titleStr forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor colorWithRed:205.0f/255.0f green:205.0f/255.0f
                                              blue:205.0f/255.0f alpha:0.7f]
                    forState:UIControlStateHighlighted];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    self.navigationItem.leftBarButtonItem = navItem;
    
}

- (void) setRightNavButton:(UIImage* )btImage withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    [navButton setImage:btImage forState:UIControlStateNormal];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    [navItem.customView setFrame:frame];
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, navItem, nil] animated:NO];
    }else{
        self.navigationItem.rightBarButtonItem = navItem;
    }
}

- (void)setRightNavButtonFA:(NSInteger)buttonType withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = [UIFont systemFontOfSize:self.navButtonSize];
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [navButton simpleButtonWithImageColor:[UIColor whiteColor] ];
    [navButton addAwesomeIcon:buttonType beforeTitle:YES];
    
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    }
    self.navigationItem.rightBarButtonItem = navItem;
}

- (void)setRightNavButtonTitleStr:(NSString *)titleStr withFrame:(CGRect)frame actionTarget:(id)target action:(SEL)action{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = KXCAPPUIContentFontSize(15.0f);
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [navButton setTitle:titleStr forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor colorWithRed:205.0f/255.0f green:205.0f/255.0f
                                              blue:205.0f/255.0f alpha:0.7f]
                    forState:UIControlStateHighlighted];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_7_0)){//iOS 7以上
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    }else{
        navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    }
    self.navigationItem.rightBarButtonItem = navItem;
    
}


- (void)setEnableCustomNavbarBackButton:(BOOL)enableCustomNavbarBackButton
{
    _enableCustomNavbarBackButton = enableCustomNavbarBackButton;
    if (!_enableCustomNavbarBackButton)
        self.navigationItem.leftBarButtonItems = nil;
}

- (void)setRightNavButtonFA:(NSArray <NSNumber *> *)buttonTypeArray
                  buttonTag:(NSArray <NSNumber *> *)tagArray
        buttonSelectedColor:(NSArray <UIColor *> *)colorArray
          buttonDefautColor:(NSArray <UIColor *> *)colorDefaultArray
               actionTarget:(id)target
                     action:(SEL)action{
    
    
    NSInteger buttonTypeInt = buttonTypeArray.count;
    if (buttonTypeInt != tagArray.count) {
        return;
    }
    
    //    CGRectMake(0, 0.0f, 55, 44.0f)    //左右侧导航栏按钮大小
    UIView *buttonBGView = [[UIView alloc]init];
    for (int index = 0; index <buttonTypeInt; index ++) {
        UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [navButton setFrame:CGRectMake(index*38, 0.0f, 38.0f, 44.0f)];
        navButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [navButton simpleButtonWithImageColor:(UIColor *)[colorArray objectAtIndex:index]];
        [navButton addAwesomeIcon:[buttonTypeArray[index] integerValue] beforeTitle:YES];
        [navButton setTag:[tagArray[index] integerValue]];
        [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [buttonBGView addSubview:navButton];
    }
    [buttonBGView setFrame:CGRectMake(0.0f, 0.0f, buttonTypeInt*38, 44.0f)];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBGView];
    
    self.navigationItem.rightBarButtonItem = navItem;
    
}

- (void)_backToPrevController
{
    if (self.navBackButtonRespondBlock)
    {
        self.navBackButtonRespondBlock();
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
