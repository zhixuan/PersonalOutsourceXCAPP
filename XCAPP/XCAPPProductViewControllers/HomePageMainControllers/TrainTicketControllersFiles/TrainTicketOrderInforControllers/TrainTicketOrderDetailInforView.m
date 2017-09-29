//
//  TrainTicketOrderDetailInforView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/25.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketOrderDetailInforView.h"

#define KOrderContentFontSize       KXCAPPUIContentFontSize(15.0f)

@interface TrainTicketOrderDetailInforView ()

/*!
 * @breif 订单信息背景视图
 * @See
 */
@property (nonatomic , weak)      UIView                *orderWhiteColorContentGBView;

/*!
 * @breif 火车票单价信息
 * @See
 */
@property (nonatomic , weak)      UILabel               *orderTrainticketUnitPriceLabel;

/*!
 * @breif 视图大小Fram
 * @See
 */
@property (nonatomic , assign)      CGRect              contentGBViewRect;
@end

@implementation TrainTicketOrderDetailInforView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentGBViewRect = frame;
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        [self setupTrainTicketOrderDetailInforViewFrame];
    }
    
    return self;
}


- (void)setupTrainTicketOrderDetailInforViewFrame{
    
    UIView *contentGBView = [[UIView alloc]init];
    [contentGBView setFrame:CGRectMake((KInforLeftIntervalWidth*2),(self.height - KXCUIControlSizeWidth(160.0f)), (KProjectScreenWidth - KInforLeftIntervalWidth *4), KXCUIControlSizeWidth(130.0f))];
    [contentGBView setBackgroundColor:[UIColor whiteColor]];
    [contentGBView.layer setCornerRadius:6.0f];
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
    [roomLabel setText:@"票价"];
    [roomLabel setTextAlignment:NSTextAlignmentLeft];
    [roomLabel setFont:KOrderContentFontSize];
    [roomLabel setTextColor:KContentTextColor];
    [roomLabel setFrame:CGRectMake(KInforLeftIntervalWidth*2, titelLabel.bottom + KXCUIControlSizeWidth(8.0f), KXCUIControlSizeWidth(60.0f), KXCUIControlSizeWidth(30.0f))];
    [contentGBView addSubview:roomLabel];
    
    UILabel *roomPriceLabel = [[UILabel alloc]init];
    [roomPriceLabel setBackgroundColor:[UIColor clearColor]];
    [roomPriceLabel setTextAlignment:NSTextAlignmentRight];
    [roomPriceLabel setFont:KOrderContentFontSize];
    [roomPriceLabel setTextColor:KUnitPriceContentColor];
    [roomPriceLabel setFrame:CGRectMake((contentGBView.width - KXCUIControlSizeWidth(150.0f) - KInforLeftIntervalWidth*2),
                                        titelLabel.bottom + KXCUIControlSizeWidth(8.0f),
                                        KXCUIControlSizeWidth(150.0f), KXCUIControlSizeWidth(30.0f))];
    self.orderTrainticketUnitPriceLabel = roomPriceLabel;
    [contentGBView addSubview:self.orderTrainticketUnitPriceLabel];
}
- (void)detailForTrainTicketOrderInfor:(TrainticketOrderInformation *)orderItem{
    
    [self.orderTrainticketUnitPriceLabel setTextAlignment:NSTextAlignmentRight];
    [self.orderTrainticketUnitPriceLabel setFont:KOrderContentFontSize];
    [self.orderTrainticketUnitPriceLabel setTextColor:KContentTextColor];
    [self.orderTrainticketUnitPriceLabel setText:[NSString stringWithFormat:@"￥%@ × %zi",orderItem.ttOrderTrainticketInfor.traUnitPrice,orderItem.ttTicketCountInteger]];
    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:self.orderTrainticketUnitPriceLabel.text];
    ///价格信息
    NSRange priceRange = [self.orderTrainticketUnitPriceLabel.text rangeOfString:[NSString stringWithFormat:@"%@",orderItem.ttOrderTrainticketInfor.traUnitPrice]];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:priceRange];
    [self.orderTrainticketUnitPriceLabel setAttributedText:minUnitPriceContent];
    
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
