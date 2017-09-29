//
//  FlightNumberTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightNumberTableViewCell.h"

#define KBtnForCheckShowButtonTag           (1390411)
#define KBtnForReserveButtonTag             (1390412)

@interface FlightNumberTableViewCell ()

/*!
 * @breif 舱位类型
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightCabinModelLabel;

/*!
 * @breif 舱位标签说明
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightLabelTagLabel;

/*!
 * @breif 单价信息
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightMinUnitPrice;

/*!
 * @breif 退款操作按键
 * @See
 */
@property (nonatomic , weak)            UIButton                *flightRefundButton;

/*!
 * @breif 本次航班剩余票量
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightSurplusNumbe;
/*!
 * @breif 预订按键
 * @See
 */
@property (nonatomic , weak)                UIButton            *reserveButton;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      FlightInformation           *selectedTrainTicketInfor;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      NSIndexPath                 *selectedIndexPath;
@end

@implementation FlightNumberTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KFlightNumberTableViewHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  KDefaultViewBackGroundColor;
        
        
        
        ///舱室说明
        UILabel *cabinModelLabel = [[UILabel alloc]init];
        [cabinModelLabel setBackgroundColor:[UIColor clearColor]];
        [cabinModelLabel setTextColor:KContentTextColor];
        [cabinModelLabel setFont:KXCAPPUIContentDefautFontSize(12.0f)];
        [cabinModelLabel setTextAlignment:NSTextAlignmentLeft];
        self.flightCabinModelLabel = cabinModelLabel;
        [self.contentView addSubview:self.flightCabinModelLabel];
        
        ///舱室说明
        UILabel *flightTagLabel = [[UILabel alloc]init];
        [flightTagLabel setBackgroundColor:HUIRGBColor(226.0, 122.0f,113.0f, 1.0f)];
        [flightTagLabel setTextColor:[UIColor whiteColor]];
        [flightTagLabel setFont:KXCAPPUIContentDefautFontSize(12.0f)];
        [flightTagLabel setTextAlignment:NSTextAlignmentCenter];
        self.flightLabelTagLabel = flightTagLabel;
        [self.contentView addSubview:self.flightLabelTagLabel];
        
        
        /**
         [onlyBtn setTitleColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) forState:UIControlStateNormal];
         [onlyBtn setTitleColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f) forState:UIControlStateHighlighted];**/
        
        UIButton *refundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [refundBtn setBackgroundColor:[UIColor clearColor]];
        [refundBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                              forState:UIControlStateNormal];
        [refundBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                              forState:UIControlStateHighlighted];
        [refundBtn.titleLabel setFont:KXCAPPUIContentFontSize(12.0f)];
        [refundBtn setTitleColor:HUIRGBColor(90.0f, 157.0f, 235.0f, 1.0f)
                        forState:UIControlStateNormal];
        [refundBtn setTitleColor:HUIRGBColor(60.0f, 127.0f, 205.0f, 1.0f)
                        forState:UIControlStateHighlighted];
        [refundBtn setTag:KBtnForCheckShowButtonTag];
        [refundBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        self.flightRefundButton = refundBtn;
        [self.contentView addSubview:self.flightRefundButton];
        
        ///价格
        UILabel * minUnitPriceLabel = [[UILabel alloc]init];
        [minUnitPriceLabel setBackgroundColor:[UIColor clearColor]];
        [minUnitPriceLabel setTextColor:KUnitPriceContentColor];
        [minUnitPriceLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
        [minUnitPriceLabel setTextAlignment:NSTextAlignmentRight];
        self.flightMinUnitPrice = minUnitPriceLabel;
        [self.contentView addSubview:self.flightMinUnitPrice];
        
        ///数量
        UILabel * numberLabel = [[UILabel alloc]init];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setTextColor:HUIRGBColor(90, 22, 20, 1.0f)];
        [numberLabel setFont:KXCAPPUIContentDefautFontSize(12.0f)];
        [numberLabel setTextAlignment:NSTextAlignmentRight];
        self.flightSurplusNumbe = numberLabel;
        [self.contentView addSubview:self.flightSurplusNumbe];
        
        
        UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reserveBtn setBackgroundColor:[UIColor clearColor]];
        [reserveBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                             forState:UIControlStateNormal];
        [reserveBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                             forState:UIControlStateHighlighted];
        [reserveBtn.titleLabel setFont:KXCAPPUIContentFontSize(12.0f)];
        [reserveBtn setTag:KBtnForReserveButtonTag];
        [reserveBtn setTitle:@"预订" forState:UIControlStateNormal];
        [reserveBtn.layer setCornerRadius:5.0f];
        [reserveBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [reserveBtn.layer setMasksToBounds:YES];
        self.reserveButton = reserveBtn;
        [self.contentView addSubview:self.reserveButton];
        
        [self.separatorView setBackgroundColor:HUIRGBColor(194.0f, 195.0f, 196.0f, 1.0f)];
        [self.contentView addSubview:self.separatorView];
    }
    
    return self;
}

- (void)setupCellWithDataSource:(FlightInformation *)itemData indexPath:(NSIndexPath *)indexPath{
    
    if (itemData == nil) {
        return;
    }
    
    self.selectedIndexPath = indexPath;
    self.selectedTrainTicketInfor = itemData;
    
    
    NSString *cbinModelLabel = [NSString stringWithFormat:@"%@ %@",itemData.flightCabinModelStr,itemData.flightDiscountStr];
    [self.flightCabinModelLabel setText:cbinModelLabel];
    [self.flightLabelTagLabel setText:itemData.flightLabelNameStr];
    
    [self.flightMinUnitPrice setText:[NSString stringWithFormat: @"￥%.0lf",itemData.flightUnitPrice]];
    ///人民币符号￥
    NSRange yuanRange = [self.flightMinUnitPrice.text rangeOfString:@"￥"];
    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:self.flightMinUnitPrice.text];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(12) range:yuanRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:yuanRange];
    [self.flightMinUnitPrice setAttributedText:minUnitPriceContent];

    if (itemData.flightAllowReturnBool) {
        [self.flightRefundButton setTitle:itemData.flightAllowReturnShowStr forState:UIControlStateNormal];
    }

    [self.flightSurplusNumbe setText:[NSString stringWithFormat:@"%zi张",itemData.flightStockNumber]];
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews{
    
    
    
    CGSize cabinModelSize = [self.flightCabinModelLabel.text sizeWithFont:self.flightCabinModelLabel.font];
    [self.flightCabinModelLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(10.0f), cabinModelSize.width, KXCUIControlSizeWidth(18.0f))];
    
    CGSize tagLabelSize =[self.flightLabelTagLabel.text sizeWithFont:self.flightLabelTagLabel.font];
    [self.flightLabelTagLabel setFrame:CGRectMake((self.flightCabinModelLabel.right+ KXCUIControlSizeWidth(10.0f)),
                                                  KXCUIControlSizeWidth(10.0f), (tagLabelSize.width + 8.0f),
                                                  KXCUIControlSizeWidth(16.0f))];
    
    
    
    [self.flightMinUnitPrice setFrame:CGRectMake((KProjectScreenWidth/2),
                                                 ((KFlightNumberTableViewHeight - 0.50f- KXCUIControlSizeWidth(30.0f))/2 - 2.0f),(KProjectScreenWidth/2 - KInforLeftIntervalWidth - KXCUIControlSizeWidth(65.0f)), KXCUIControlSizeWidth(22.0f))];
    [self.flightSurplusNumbe setFrame:CGRectMake(self.flightMinUnitPrice.left,(self.flightMinUnitPrice.bottom + 3.0f),
                                                 self.flightMinUnitPrice.width, KXCUIControlSizeWidth(18.0f))];
    
    CGSize btnSize =[self.flightRefundButton.titleLabel.text sizeWithFont:self.flightRefundButton.titleLabel.font];
    [self.flightRefundButton setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                 (self.flightCabinModelLabel.bottom + KXCUIControlSizeWidth(3.0f)),
                                                 btnSize.width, KXCUIControlSizeWidth(18.0f))];
    
    [self.reserveButton setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - KXCUIControlSizeWidth(50.0f)),
                                            (KFlightNumberTableViewHeight - 0.50f- KXCUIControlSizeWidth(30.0f))/2,
                                            KXCUIControlSizeWidth(50.0f), (KXCUIControlSizeWidth(30.0f)))];
    
    [self.separatorView setFrame:CGRectMake(0.0f,(KFlightNumberTableViewHeight - 0.5f),
                                            KProjectScreenWidth, 0.5f)];
}



- (void)userOperationButtonEventClicked:(UIButton *)button{
    
    if (self.delegate) {
        
        if (KBtnForCheckShowButtonTag == button.tag) {
            
            if ([self.delegate respondsToSelector:@selector(userCheckReturnCostInfor:)]) {
                [self.delegate userCheckReturnCostInfor:self.selectedIndexPath];
            }
        }else if (KBtnForReserveButtonTag == button.tag){
            
            if ([self.delegate respondsToSelector:@selector(userPersonalReserveFlightWithIndexPath:)]) {
                [self.delegate userPersonalReserveFlightWithIndexPath:self.selectedIndexPath];
            }
        }
    }
}
@end
