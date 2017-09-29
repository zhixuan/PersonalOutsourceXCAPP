//
//  OrderExpenseDetailView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/7/11.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "OrderExpenseDetailView.h"

#define KOrderContentFontSize       KXCAPPUIContentFontSize(15.0f)
@interface OrderExpenseDetailView ()
/*!
 * @breif 订单信息
 * @See
 */
@property (nonatomic , strong)      UserHotelOrderInformation *userOrderInfor;
@end

@implementation OrderExpenseDetailView

- (id)initWithFrame:(CGRect)frame order:(UserHotelOrderInformation *)orderInfor{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        
        self.userOrderInfor = orderInfor;
        [self addTarget:self action:@selector(buttonHiddenClicked)
       forControlEvents:UIControlEventAllEvents];
        
        [self setupOrderExpenseDetailViewFrame];
    }
    
    return self;
}


- (void)setupOrderExpenseDetailViewFrame{
    
    
    
    UIView *contentGBView = [[UIView alloc]init];
    [contentGBView setFrame:CGRectMake((KInforLeftIntervalWidth*2), KXCUIControlSizeWidth(150.0f), (KProjectScreenWidth - KInforLeftIntervalWidth *4), KXCUIControlSizeWidth(200.0f))];
    [contentGBView setBackgroundColor:[UIColor whiteColor]];
    [contentGBView.layer setCornerRadius:6.0f];
    [contentGBView.layer setMasksToBounds:YES];
    [self addSubview:contentGBView];
    
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
    [roomPriceLabel setText:[NSString stringWithFormat:@"￥%.1f",self.userOrderInfor.orderHotelInforation.hotelRealityUnitPriceFloat]];
    [roomPriceLabel setTextAlignment:NSTextAlignmentRight];
    [roomPriceLabel setFont:KOrderContentFontSize];
    [roomPriceLabel setTextColor:KUnitPriceContentColor];
    [roomPriceLabel setFrame:CGRectMake((contentGBView.width - KXCUIControlSizeWidth(150.0f) - KInforLeftIntervalWidth*2),
                                        titelLabel.bottom + KXCUIControlSizeWidth(8.0f),
                                        KXCUIControlSizeWidth(150.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:roomPriceLabel];
    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:roomPriceLabel.text];
    ///价格信息
    NSRange priceRange = [roomPriceLabel.text rangeOfString:@"￥"];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:priceRange];
    [roomPriceLabel setAttributedText:minUnitPriceContent];
    
    
    UILabel *removeIntoLabel = [[UILabel alloc]init];
    [removeIntoLabel setBackgroundColor:[UIColor clearColor]];
    [removeIntoLabel setText:self.userOrderInfor.orderUserMoveIntoDate];
    [removeIntoLabel setTextAlignment:NSTextAlignmentLeft];
    [removeIntoLabel setFont:KOrderContentFontSize];
    [removeIntoLabel setTextColor:KContentTextColor];
    [removeIntoLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, roomLabel.bottom + KXCUIControlSizeWidth(8.0f), KXCUIControlSizeWidth(150.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:removeIntoLabel];
    
    
    UILabel *roomPriceCalculate = [[UILabel alloc]init];
    [roomPriceCalculate setBackgroundColor:[UIColor clearColor]];
    [roomPriceCalculate setText:[NSString stringWithFormat:@"￥%.1f(%zi间夜) × %zi",self.userOrderInfor.orderHotelInforation.hotelRealityUnitPriceFloat,self.userOrderInfor.orderRoomQuantityInteger,self.userOrderInfor.orderStayDayesQuantityInteger]];
    [roomPriceCalculate setTextAlignment:NSTextAlignmentRight];
    [roomPriceCalculate setFont:KOrderContentFontSize];
    [roomPriceCalculate setTextColor:KUnitPriceContentColor];
    [roomPriceCalculate setFrame:CGRectMake((contentGBView.width -KXCUIControlSizeWidth(200.0f) - KInforLeftIntervalWidth*2),
                                        roomLabel.bottom + KXCUIControlSizeWidth(8.0f),
                                        KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:roomPriceCalculate];
    
    NSMutableAttributedString *roomPriceCalculateContent=[[NSMutableAttributedString alloc]initWithString:roomPriceCalculate.text];
    ///价格信息
    NSRange calculateRange = [roomPriceCalculate.text rangeOfString:@"￥"];
    [roomPriceCalculateContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:calculateRange];
    [roomPriceCalculate setAttributedText:roomPriceCalculateContent];
    
    
    UILabel *totleSumLabel = [[UILabel alloc]init];
    [totleSumLabel setBackgroundColor:[UIColor clearColor]];
    [totleSumLabel setText:[NSString stringWithFormat:@"总额￥%.1f",(self.userOrderInfor.orderHotelInforation.hotelRealityUnitPriceFloat*self.userOrderInfor.orderStayDayesQuantityInteger*self.userOrderInfor.orderRoomQuantityInteger)]];
    [totleSumLabel setTextAlignment:NSTextAlignmentRight];
    [totleSumLabel setFont:KXCAPPUIContentFontSize(19.0)];
    [totleSumLabel setTextColor:KUnitPriceContentColor];
    [totleSumLabel setFrame:CGRectMake((contentGBView.width -KXCUIControlSizeWidth(200.0f) - KInforLeftIntervalWidth*2),
                                            roomPriceCalculate.bottom + KXCUIControlSizeWidth(8.0f),
                                            KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:totleSumLabel];
    
    NSMutableAttributedString *totleSumContent=[[NSMutableAttributedString alloc]initWithString:totleSumLabel.text];
    ///价格信息
    NSRange totleSumRange = [totleSumLabel.text rangeOfString:@"总额￥"];
    [totleSumContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:totleSumRange];
    [totleSumLabel setAttributedText:totleSumContent];

}

- (void)userPersonalCloseOperationButtonEvent{
    [self buttonHiddenClicked];
}

- (void)buttonHiddenClicked{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect detailRect = CGRectMake(KProjectScreenWidth, 0.0f,
                                       KProjectScreenWidth, KProjectScreenHeight);
        [self setFrame:detailRect];
    }];
}
@end
