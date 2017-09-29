//
//  HotelDetailHeaderView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelDetailHeaderView.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

#define KBtnForDetailButtonTag          (1720111)
#define KBtnForMapInforButtonTag        (1720112)
#define KBtnForStayButtonTag            (1720113)

@interface HotelDetailHeaderView ()

@end

@implementation HotelDetailHeaderView

- (id)initWithFrame:(CGRect)frame withOderInfor:(UserHotelOrderInformation *)hotelInfor{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:KDefaultViewBackGroundColor];
        
        [self setupFrame];
    }
    
    return self;
}


- (void)setupFrame{
    
    
    ///MARK:图片信息
    UIImageView *hotelImgView = [[UIImageView alloc]init];
    [hotelImgView setBackgroundColor:[UIColor clearColor]];
    [hotelImgView setImage:createImageWithColor(HUIRGBColor(190.0f, 190.0f, 190.0f, 0.9))];
    [hotelImgView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KXCUIControlSizeWidth(160.0f))];
    self.hotelImageView = hotelImgView;
    [self addSubview:self.hotelImageView];
    [self.hotelImageView setImage:[UIImage imageNamed:@"u1002.jpg"]];
    
    UIView *addressBlackBGView = [[UIView alloc]init];
    [addressBlackBGView setBackgroundColor:HUIRGBColor(40.0f, 40.0f, 40.0f, 0.9)];
    [addressBlackBGView setFrame:CGRectMake(0.0f,
                                        (hotelImgView.bottom - KXCUIControlSizeWidth(33.0f)),
                                        (KProjectScreenWidth),
                                        KXCUIControlSizeWidth(33.0f))];
    [self.hotelImageView addSubview:addressBlackBGView];

    ///MARK:地址
    UILabel *addressAtImage = [[UILabel alloc]init];
    [addressAtImage setBackgroundColor:[UIColor clearColor]];
    [addressAtImage setFont:KXCAPPUIContentFontSize(18.0f)];
    [addressAtImage setFrame:CGRectMake(KInforLeftIntervalWidth,0.0f,(KProjectScreenWidth - KInforLeftIntervalWidth),
                                        KXCUIControlSizeWidth(33.0f))];
    [addressAtImage setTextAlignment:NSTextAlignmentLeft];
    [addressAtImage setTextColor:[UIColor whiteColor]];
    self.hotelAddressAtImageLabel = addressAtImage;
    [addressBlackBGView addSubview:self.hotelAddressAtImageLabel];
    
    ///MARK:详情信息
    UIView *hotelDetail = [[UIView alloc]init];
    [hotelDetail setBackgroundColor:[UIColor whiteColor]];
    [hotelDetail setFrame:CGRectMake(0.0f, (hotelImgView.bottom + KInforLeftIntervalWidth),
                                     KProjectScreenWidth, KFunctionModulButtonHeight*1.2)];
    self.hotelDetailBGView = hotelDetail;
    [self addSubview:self.hotelDetailBGView];
    
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailBtn setBackgroundColor:[UIColor clearColor]];
    [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [detailBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateNormal];
    [detailBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [detailBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(70.0f) - KInforLeftIntervalWidth),
                                   (KFunctionModulButtonHeight*0.1),
                                   KXCUIControlSizeWidth(70.0f),
                                   KFunctionModulButtonHeight)];
    [detailBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateHighlighted];
    [detailBtn setTag:KBtnForDetailButtonTag];
    [detailBtn addTarget:self action:@selector(userPersonalOperationBtnEventClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [detailBtn simpleButtonWithImageColor:KFunNextArrowColor];
    [detailBtn addAwesomeIcon:FMIconRightReturn beforeTitle:NO ];
    [hotelDetail addSubview:detailBtn];
    
    
    ///MARK:地图地址信息
    UIView *mapAddressView = [[UIView alloc]init];
    [mapAddressView setFrame:CGRectMake(0.0f, (hotelDetail.bottom + KInforLeftIntervalWidth),
                                        KProjectScreenWidth, KFunctionModulButtonHeight)];
    [mapAddressView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:mapAddressView];
    

    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapBtn setBackgroundColor:[UIColor clearColor]];
    [mapBtn setTitle:@"地图" forState:UIControlStateNormal];
    [mapBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [mapBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateNormal];
    [mapBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(70.0f) - KInforLeftIntervalWidth),
                                0.0f,KXCUIControlSizeWidth(70.0f), KFunctionModulButtonHeight)];
    [mapBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                         forState:UIControlStateHighlighted];
    [mapBtn setTag:KBtnForMapInforButtonTag];
    [mapBtn addTarget:self action:@selector(userPersonalOperationBtnEventClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [mapBtn simpleButtonWithImageColor:KFunNextArrowColor];
    [mapBtn addAwesomeIcon:FMIconRightReturn beforeTitle:NO ];
    [mapAddressView addSubview:mapBtn];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    [addressLabel setBackgroundColor:[UIColor clearColor]];
    [addressLabel setFont:KXCAPPUIContentFontSize(18.0f)];
    [addressLabel setFrame:CGRectMake(KInforLeftIntervalWidth,0.0f,
                                      (KProjectScreenWidth - KInforLeftIntervalWidth),
                                      KFunctionModulButtonHeight)];
    [addressLabel setTextAlignment:NSTextAlignmentLeft];
    [addressLabel setText:@"你好"];
    [addressLabel setTextColor:KContentTextColor];
    self.hotelAddressLabel = addressLabel;
    [mapAddressView addSubview:self.hotelAddressLabel];
    
    ///MARK:用户入住信息
    UIView *userStayRoomView = [[UIView alloc]init];
    [userStayRoomView setFrame:CGRectMake(0.0f, (mapAddressView.bottom + KInforLeftIntervalWidth),
                                        KProjectScreenWidth, KFunctionModulButtonHeight)];
    [userStayRoomView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:userStayRoomView];
    
    UILabel *stayDayLabel = [[UILabel alloc]init];
    [stayDayLabel setBackgroundColor:[UIColor clearColor]];
    [stayDayLabel setFont:KXCAPPUIContentFontSize(18.0f)];
    [stayDayLabel setFrame:CGRectMake(KInforLeftIntervalWidth,0.0f,
                                      (KProjectScreenWidth - KInforLeftIntervalWidth),
                                      KFunctionModulButtonHeight)];
    [stayDayLabel setTextAlignment:NSTextAlignmentLeft];
    [stayDayLabel setTextColor:KContentTextColor];
    self.hotelStayDayInforLabel = stayDayLabel;
    [userStayRoomView addSubview:self.hotelStayDayInforLabel];
    
    UIButton *stayRoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stayRoomBtn setBackgroundColor:[UIColor clearColor]];
    [stayRoomBtn setTitle:@"修改" forState:UIControlStateNormal];
    [stayRoomBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [stayRoomBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                      forState:UIControlStateNormal];
    [stayRoomBtn setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(70.0f) - KInforLeftIntervalWidth),
                                0.0f,KXCUIControlSizeWidth(70.0f), KFunctionModulButtonHeight)];
    [stayRoomBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                      forState:UIControlStateHighlighted];
    [stayRoomBtn setTag:KBtnForStayButtonTag];
    [stayRoomBtn addTarget:self action:@selector(userPersonalOperationBtnEventClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [stayRoomBtn simpleButtonWithImageColor:KFunNextArrowColor];
    [stayRoomBtn addAwesomeIcon:FMIconRightReturn beforeTitle:NO ];
    [userStayRoomView addSubview:stayRoomBtn];
}

- (void)userPersonalOperationBtnEventClicked:(UIButton *)button{
    
    if (KBtnForDetailButtonTag == button.tag) {
        
        if ([self.delegate respondsToSelector:@selector(userCheckHotelDetailButtonClickedEvent)]) {
            [self.delegate userCheckHotelDetailButtonClickedEvent];
        }
        
        
    }
    else if (KBtnForMapInforButtonTag == button.tag){
        if ([self.delegate respondsToSelector:@selector(userCheckHotelAtMapButtonClickedEvent)]) {
            [self.delegate userCheckHotelAtMapButtonClickedEvent];
        }
    }
    
    else if (KBtnForStayButtonTag == button.tag){
        if ([self.delegate respondsToSelector:@selector(userUpdateStayDayesInforButtonClickedEvent)]) {
            [self.delegate userUpdateStayDayesInforButtonClickedEvent];
        }
    }
}

@end
