//
//  HotelMapAddressController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/29.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelMapAddressController.h"

#import <CoreLocation/CoreLocation.h>
#import "FontAwesome.h"



@implementation HotelMKAnnotation

- (id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
@end


#define KBtnForCloseButtonTag           (1880111)
#define KBtnForMapNavButtonTag          (1880112)
#define KBtnForMapEnlargeButtonTag      (1880113)
#define KBtnForMapReduceButtonTag       (1880114)




@interface HotelMapAddressController ()<MKMapViewDelegate>


/*!
 * @breif 酒店数据信息
 * @See
 */
@property (nonatomic , strong)      HotelInformation                *hotelMapInformation;

/*!
 * @breif 地图信息
 * @See
 */
@property (nonatomic , weak)      MKMapView                         *hotelMapView;


/*!
 * @breif 方法缩小比率
 * @See
 */
@property (nonatomic , assign)      CGFloat                         hotelMapDispayRatio;
@end

@implementation HotelMapAddressController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE;
    }
    return self;
}

- (id)initWithHotelInfor:(HotelInformation *)hotelInfor{
    self = [super init];
    if (self) {
        self.hotelMapInformation = hotelInfor;
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
    self.hotelMapDispayRatio = 0.01;
    [self setupHotelMapAddressControllerFrame];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)setupHotelMapAddressControllerFrame{
    
    
    MKMapView *map = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [map setBackgroundColor:[UIColor clearColor]];
    [map setDelegate:self];
    [map setHeight:KProjectScreenHeight];
    [map setMapType:MKMapTypeStandard];
//    [map setShowsScale:YES];
    self.hotelMapView = map;
    [self.view addSubview:self.hotelMapView];
    
    [self setLeftRightBarButtonFrame];
    
    
    HotelMKAnnotation *annotation = [[HotelMKAnnotation alloc]init];
    [annotation setTitle:self.hotelMapInformation.hotelNameContentStr];
    [annotation setCoordinate:self.hotelMapInformation.hotelCoordinate];
    [self.hotelMapView addAnnotation:annotation];
    
    
    //设置地图级别和位置
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = self.hotelMapDispayRatio;
    theSpan.longitudeDelta = self.hotelMapDispayRatio;
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(annotation.coordinate, theSpan);
    [self.hotelMapView setRegion:coordinateRegion animated:YES];
}

- (void)setLeftRightBarButtonFrame{

    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    [leftBtn setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth*2, 30.0f, 30.0f)];
    [leftBtn setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.8f))
                       forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.9f))
                       forState:UIControlStateHighlighted];
    [leftBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [leftBtn simpleButtonWithImageColor:[UIColor whiteColor] withHighlightedColor:[UIColor whiteColor]];
    [leftBtn setAwesomeIcon:FMIconCloseEdit];
    [leftBtn setTag:KBtnForCloseButtonTag];
    [leftBtn.layer setCornerRadius:4.0f];
    [leftBtn.layer setMasksToBounds:YES];
    [leftBtn addTarget:self action:@selector(buttonOperationClickedEvent:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setBackgroundColor:[UIColor clearColor]];
    [navButton setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - 80.0f), KInforLeftIntervalWidth*2, 80.0f, 30.0f)];
    [navButton setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.8f))
                       forState:UIControlStateNormal];
    [navButton setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.9f))
                       forState:UIControlStateHighlighted];
    [navButton setTitle:@"导航" forState:UIControlStateNormal];
    [navButton.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [navButton simpleButtonWithImageColor:[UIColor whiteColor] withHighlightedColor:[UIColor whiteColor]];
    [navButton addAwesomeIcon:FMIconVoice beforeTitle:YES];
    [navButton setTag:KBtnForMapNavButtonTag];
    [navButton.layer setCornerRadius:4.0f];
    [navButton.layer setMasksToBounds:YES];
    [navButton addTarget:self action:@selector(buttonOperationClickedEvent:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navButton];
    
    
    UIView *mapRatioView = [[UIView alloc]init];
    [mapRatioView setBackgroundColor:HUIRGBColor(240.0f, 240.0f,240.0f, 0.8f)];
    [mapRatioView setFrame:CGRectMake(KInforLeftIntervalWidth,
                                      (KProjectScreenHeight - KXCUIControlSizeWidth(50.0f) - 61.0f),
                                      30.0f, 61.0f)];
    [mapRatioView.layer setCornerRadius:4.f];
    [mapRatioView.layer setMasksToBounds:YES];
    [self.view addSubview:mapRatioView];
    
    UIButton *enlargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enlargeBtn setBackgroundColor:[UIColor clearColor]];
    [enlargeBtn setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [enlargeBtn setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.8f))
                       forState:UIControlStateNormal];
    [enlargeBtn setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.9f))
                       forState:UIControlStateHighlighted];
    [enlargeBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [enlargeBtn simpleButtonWithImageColor:[UIColor whiteColor] withHighlightedColor:[UIColor whiteColor]];
    [enlargeBtn setAwesomeIcon:FMIconAdd];
    [enlargeBtn setTag:KBtnForMapEnlargeButtonTag];
    [enlargeBtn addTarget:self action:@selector(buttonOperationClickedEvent:)
      forControlEvents:UIControlEventTouchUpInside];
    [mapRatioView addSubview:enlargeBtn];
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceBtn setBackgroundColor:[UIColor clearColor]];
    [reduceBtn setFrame:CGRectMake(0.0f, (enlargeBtn.bottom + 1.0f), 30.0f, 30.0f)];
    [reduceBtn setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.8f))
                          forState:UIControlStateNormal];
    [reduceBtn setBackgroundImage:createImageWithColor(HUIRGBColor(0.0f, 0.0f,0.0f, 0.9f))
                          forState:UIControlStateHighlighted];
    [reduceBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
    [reduceBtn simpleButtonWithImageColor:[UIColor whiteColor] withHighlightedColor:[UIColor whiteColor]];
    [reduceBtn setAwesomeIcon:FMIconUpDownSelected];
    [reduceBtn setTag:KBtnForMapReduceButtonTag];
    [reduceBtn addTarget:self action:@selector(buttonOperationClickedEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [mapRatioView addSubview:reduceBtn];
    
    
    
    
}

- (void)leftButtonOperationEvent{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.hotelMapView setDelegate: nil];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *annotationView = nil;
    
    if ([annotation isKindOfClass:[MKAnnotationView class]]) {
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MKAnnotationView"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKAnnotationView"];
        }
        
//        BreakRulesAnnotationInfor *breakRulesAnnotation = (BreakRulesAnnotationInfor *)annotation;
//        
//        //判断是否为长按点内容，若不是则将标注图片设置违章多发点默认图片
//        if (breakRulesAnnotation.breakRulesAnnotationTypeStyle < 100) {
//            annotationView.image = [UIImage imageNamed:@"QuickDealWithAccidentAnnotation_Normal.png"];
//        }
//        //若是长按内容，则将标注图片设置为长按默认图片，并设置为可点查看标题内容
//        else{
            MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"LongPressAnnotation"];
            
            if (!pinAnnotationView) {
                pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"LongPressAnnotation"] ;
                pinAnnotationView.animatesDrop = YES;
                pinAnnotationView.canShowCallout = NO;
                [pinAnnotationView setSelected:YES];
            }
            return  pinAnnotationView;
        }
//    }
    
    return annotationView;

}


- (void)buttonOperationClickedEvent:(id)sender{
 
    UIButton *button = (UIButton *)sender;
    
    ///关闭界面
    if (KBtnForCloseButtonTag == button.tag) {
        [self leftButtonOperationEvent];
    }
    
    ///导航操作
    else if (KBtnForMapNavButtonTag == button.tag) {
        
        
        //latitude = 36.600000000000001, longitude = 114.466666666667)
        
        CLLocationCoordinate2D startCoor =  CLLocationCoordinate2DMake(36.600000000000001, 114.466666666667);
        CLLocationCoordinate2D endCoor = self.hotelMapInformation.hotelCoordinate;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=BeiJIngXCAPP&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",
                                   @"BeiJIngXCAPP", endCoor.latitude, endCoor.longitude];
            
            NSURL *url = [NSURL URLWithString:urlString];
//            DEBUG_LOG(@"\n%@\n%@\n%@", mapDic[@"name"], mapDic[@"url"], urlString);
            [[UIApplication sharedApplication] openURL:url];
        }else{
            if (HUISystemVersionBelowOrIs(kHUISystemVersion_6_0)) { // ios6以下，调用google map
                
                NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude];
                //        @"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude
                urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *aURL = [NSURL URLWithString:urlString];
                [[UIApplication sharedApplication] openURL:aURL];
            } else { // 直接调用ios自己带的apple map
                
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
                toLocation.name = @"to name";
                
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                
            }

        }
    }
    
    ///放大地图操作
    else if (KBtnForMapEnlargeButtonTag == button.tag) {
        self.hotelMapDispayRatio = self.hotelMapDispayRatio/2;
        //设置地图级别和位置
        MKCoordinateSpan theSpan;
        theSpan.latitudeDelta = self.hotelMapDispayRatio;
        theSpan.longitudeDelta = self.hotelMapDispayRatio;
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(self.hotelMapInformation.hotelCoordinate, theSpan);
        [self.hotelMapView setRegion:coordinateRegion animated:YES];
    }
    
    ///缩小地图操作
    else if (KBtnForMapReduceButtonTag == button.tag) {
        
        self.hotelMapDispayRatio = self.hotelMapDispayRatio*2;
        //设置地图级别和位置
        MKCoordinateSpan theSpan;
        theSpan.latitudeDelta = self.hotelMapDispayRatio;
        theSpan.longitudeDelta = self.hotelMapDispayRatio;
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(self.hotelMapInformation.hotelCoordinate, theSpan);
        [self.hotelMapView setRegion:coordinateRegion animated:YES];
    }
}
@end
