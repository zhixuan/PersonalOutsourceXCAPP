//
//  HotelReserveOrderDetailView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/26.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelReserveOrderDetailView.h"

#define KOrderContentFontSize       KXCAPPUIContentFontSize(15.0f)

@interface HotelReserveOrderDetailView ()
/*!
 * @breif 订单信息背景视图
 * @See
 */
@property (nonatomic , weak)      UIView                *orderWhiteColorContentGBView;

/*!
 * @breif 房间单价信息
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderRoomUnitPriceLabel;

/*!
 * @breif 入住时间
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderRoomRemoveIntoDataLabel;

/*!
 * @breif 房间入住信息内容（单价，入住几晚，入住几间）
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderRoomPriceCalculateLabel;

/*!
 * @breif 房间总价信息
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderRoomTotleSumPriceLabel;

/*!
 * @breif 视图大小Fram
 * @See
 */
@property (nonatomic , assign)      CGRect              contentGBViewRect;
@end

@implementation HotelReserveOrderDetailView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentGBViewRect = frame;
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        
//        [self addTarget:self action:@selector(buttonHiddenClicked) forControlEvents:UIControlEventAllEvents];
        
        [self setupHotelReserveOrderDetailViewFrame];
        
    }
    
    return self;
}


- (void)setupHotelReserveOrderDetailViewFrame{
    
    UIView *contentGBView = [[UIView alloc]init];
    [contentGBView setFrame:CGRectMake(0.0f, (self.height - KXCUIControlSizeWidth(230.0f) - KInforLeftIntervalWidth), (KProjectScreenWidth), KXCUIControlSizeWidth(230.0f))];
    [contentGBView setBackgroundColor:[UIColor whiteColor]];
    [contentGBView.layer setCornerRadius:2.0f];
    [contentGBView.layer setMasksToBounds:YES];
    self.orderWhiteColorContentGBView = contentGBView;
    [self addSubview:self.orderWhiteColorContentGBView];
    
    UIButton *rightCloseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightCloseBtn setBackgroundColor:[UIColor clearColor]];
    [rightCloseBtn setBackgroundImage:[UIImage imageNamed:@"userRightCloseImageView.png"]
                             forState:UIControlStateNormal];
    [rightCloseBtn addTarget:self action:@selector(userPersonalCloseOperationButtonEvent)
            forControlEvents:UIControlEventTouchUpInside];
    [rightCloseBtn setFrame:CGRectMake((contentGBView.width - KInforLeftIntervalWidth - KXCUIControlSizeWidth(36.0f)),
                                       KInforLeftIntervalWidth, KXCUIControlSizeWidth(28.0f),
                                       KXCUIControlSizeWidth(28.0f))];
    [rightCloseBtn.layer setCornerRadius:KXCUIControlSizeWidth(28.0f)/2];
    [rightCloseBtn.layer setMasksToBounds:YES];
    [contentGBView addSubview:rightCloseBtn];
    
    
    
    UILabel *titelLabel = [[UILabel alloc]init];
    [titelLabel setBackgroundColor:[UIColor clearColor]];
    [titelLabel setText:@"费用明细"];
    [titelLabel setTextColor:KContentTextColor];
    [titelLabel setTextAlignment:NSTextAlignmentLeft];
    [titelLabel setFont:KXCAPPUIContentFontSize(20.0f)];
    [titelLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, KInforLeftIntervalWidth, KXCUIControlSizeWidth(140.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:titelLabel];
    
    
    UILabel *roomLabel = [[UILabel alloc]init];
    [roomLabel setBackgroundColor:[UIColor clearColor]];
    [roomLabel setText:@"房费"];
    [roomLabel setTextAlignment:NSTextAlignmentLeft];
    [roomLabel setFont:KOrderContentFontSize];
    [roomLabel setTextColor:KContentTextColor];
    [roomLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, titelLabel.bottom + KXCUIControlSizeWidth(8.0f), KXCUIControlSizeWidth(60.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:roomLabel];
    
    UILabel *roomPriceLabel = [[UILabel alloc]init];
    [roomPriceLabel setBackgroundColor:[UIColor clearColor]];
    [roomPriceLabel setTextAlignment:NSTextAlignmentRight];
    [roomPriceLabel setFont:KOrderContentFontSize];
    [roomPriceLabel setTextColor:KContentTextColor];
    [roomPriceLabel setFrame:CGRectMake((contentGBView.width - KXCUIControlSizeWidth(150.0f) - KInforLeftIntervalWidth*2),
                                        titelLabel.bottom + KXCUIControlSizeWidth(8.0f),
                                        KXCUIControlSizeWidth(150.0f), KXCUIControlSizeWidth(30.0f))];
    self.orderRoomUnitPriceLabel = roomPriceLabel;
    [contentGBView addSubview:self.orderRoomUnitPriceLabel];
    
    
    UILabel *removeIntoLabel = [[UILabel alloc]init];
    [removeIntoLabel setBackgroundColor:[UIColor clearColor]];
    [removeIntoLabel setTextAlignment:NSTextAlignmentLeft];
    [removeIntoLabel setFont:KOrderContentFontSize];
    [removeIntoLabel setTextColor:KContentTextColor];
    [removeIntoLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, roomLabel.bottom + KXCUIControlSizeWidth(8.0f), KXCUIControlSizeWidth(150.0f), KXCUIControlSizeWidth(30.0f))];
    self.orderRoomRemoveIntoDataLabel = removeIntoLabel;
    [contentGBView addSubview:self.orderRoomRemoveIntoDataLabel];
    
    
    UILabel *roomPriceCalculate = [[UILabel alloc]init];
    [roomPriceCalculate setBackgroundColor:[UIColor clearColor]];
    [roomPriceCalculate setTextAlignment:NSTextAlignmentRight];
    [roomPriceCalculate setFont:KOrderContentFontSize];
    [roomPriceCalculate setTextColor:KContentTextColor];
    [roomPriceCalculate setFrame:CGRectMake((contentGBView.width -KXCUIControlSizeWidth(200.0f) - KInforLeftIntervalWidth*2),
                                            roomLabel.bottom + KXCUIControlSizeWidth(8.0f),
                                            KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(30.0f))];
    self.orderRoomPriceCalculateLabel = roomPriceCalculate;
    [contentGBView addSubview:roomPriceCalculate];
    
    UIView *sepStarView = [[UIView alloc]init];
    [sepStarView setBackgroundColor:KSepLineColorSetup];
    [sepStarView setFrame:CGRectMake(0.0f, (roomPriceCalculate.bottom + KXCUIControlSizeWidth(18.0f)),
                                     contentGBView.width, 1.0f)];
    [contentGBView addSubview:sepStarView];
    
    
    UILabel *totleSumLabel = [[UILabel alloc]init];
    [totleSumLabel setBackgroundColor:[UIColor clearColor]];
    [totleSumLabel setTextAlignment:NSTextAlignmentRight];
    [totleSumLabel setFont:KXCAPPUIContentFontSize(19.0)];
    [totleSumLabel setTextColor:KContentTextColor];
    [totleSumLabel setFrame:CGRectMake((contentGBView.width -KXCUIControlSizeWidth(200.0f) - KInforLeftIntervalWidth*2),
                                       sepStarView.bottom + KXCUIControlSizeWidth(17.0f),
                                       KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(30.0f))];
    self.orderRoomTotleSumPriceLabel = totleSumLabel;
    [contentGBView addSubview:self.orderRoomTotleSumPriceLabel];

}
- (void)detailForHotelReserveOrderDataInfor:(UserHotelOrderInformation *) willOrderInfor{

    [self.orderRoomUnitPriceLabel setText:[NSString stringWithFormat:@"￥%.1f",willOrderInfor.orderHotelRoomInforation.hotelRealityUnitPriceFloat]];

    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:self.orderRoomUnitPriceLabel.text];
    ///价格信息
    NSRange priceRange = [self.orderRoomUnitPriceLabel.text rangeOfString:[NSString stringWithFormat:@"%.1f",willOrderInfor.orderHotelRoomInforation.hotelRealityUnitPriceFloat]];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:priceRange];
    [self.orderRoomUnitPriceLabel setAttributedText:minUnitPriceContent];
    
    [self.orderRoomRemoveIntoDataLabel setTextAlignment:NSTextAlignmentLeft];
    [self.orderRoomRemoveIntoDataLabel setFont:KOrderContentFontSize];
    [self.orderRoomRemoveIntoDataLabel setTextColor:KContentTextColor];
    [self.orderRoomRemoveIntoDataLabel setText:willOrderInfor.orderUserMoveIntoDate];

    
    [self.orderRoomPriceCalculateLabel setTextAlignment:NSTextAlignmentRight];
    [self.orderRoomPriceCalculateLabel setFont:KOrderContentFontSize];
    [self.orderRoomPriceCalculateLabel setTextColor:KUnitPriceContentColor];
    [self.orderRoomPriceCalculateLabel setText:[NSString stringWithFormat:@"￥%.1f(%zi间夜) × %zi",willOrderInfor.orderHotelRoomInforation.hotelRealityUnitPriceFloat,willOrderInfor.orderRoomQuantityInteger,willOrderInfor.orderStayDayesQuantityInteger]];

    
    NSMutableAttributedString *roomPriceCalculateContent=[[NSMutableAttributedString alloc]initWithString:self.orderRoomPriceCalculateLabel.text];
    ///价格信息
    
    NSRange calculateRange = [self.orderRoomPriceCalculateLabel.text rangeOfString:@"￥"];
    [roomPriceCalculateContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:calculateRange];
    [self.orderRoomPriceCalculateLabel setAttributedText:roomPriceCalculateContent];
    
   
    [self.orderRoomTotleSumPriceLabel setTextAlignment:NSTextAlignmentRight];
    [self.orderRoomTotleSumPriceLabel setFont:KXCAPPUIContentFontSize(19.0)];
    [self.orderRoomTotleSumPriceLabel setTextColor:KUnitPriceContentColor];
    [self.orderRoomTotleSumPriceLabel setText:[NSString stringWithFormat:@"总额￥%.1f",(willOrderInfor.orderHotelRoomInforation.hotelRealityUnitPriceFloat*willOrderInfor.orderStayDayesQuantityInteger*willOrderInfor.orderRoomQuantityInteger)]];

    
    NSMutableAttributedString *totleSumContent=[[NSMutableAttributedString alloc]initWithString:self.orderRoomTotleSumPriceLabel.text];
    ///价格信息
    NSRange totleSumRange = [self.orderRoomTotleSumPriceLabel.text rangeOfString:@"总额￥"];
    [totleSumContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:totleSumRange];
    [self.orderRoomTotleSumPriceLabel setAttributedText:totleSumContent];

    
}

- (void)userPersonalCloseOperationButtonEvent{
    [self buttonHiddenClicked];
}

- (void)buttonHiddenClicked{
    [UIView animateWithDuration:0.25 animations:^{
        
        [self setFrame:self.contentGBViewRect];
    }];
}

@end
