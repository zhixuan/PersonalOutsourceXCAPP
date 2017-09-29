//
//  HotelDetailTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelDetailTableViewCell.h"

#define KHotelNameLabelFontSize             KXCAPPUIContentDefautFontSize(16.0f)
#define KRankContentFontSize                KXCAPPUIContentDefautFontSize(12.0f)
#define KMarkRecordFontSize                 KXCAPPUIContentDefautFontSize(16.0f)
#define KMinUnitPriceFontSize               KXCAPPUIContentDefautFontSize(24.0f)
#define KAddressFontSize                    KXCAPPUIContentDefautFontSize(12.0f)

#define KBtnForReserveButtonTag             (1730123)



@interface HotelDetailTableViewCell ()

/*!
 * @breif 酒店Cell背景色信息
 * @See
 */
@property (nonatomic , weak)      UIView                            *hotelBackGroundView;
/*!
 * @breif 酒店房间名字类型
 * @See
 */
@property (nonatomic , weak)        UILabel                         *hotelRoomNameLabel;

/*!
 * @breif 酒店房间附属信息
 * @See
 */
@property (nonatomic , weak)        UILabel                         *hotelRoomSubContentLabel;

/*!
 * @breif 酒店房间附属信息
 * @See
 */
@property (nonatomic , weak)        UILabel                         *hotelRoomAllowCancelLabel;


/*!
 * @breif 酒店最低单价
 * @See
 */
@property (nonatomic , weak)      UILabel                           *hotelRealityUnitPriceLabel;

/*!
 * @breif 无法预订显示
 * @See
 */
@property (nonatomic , weak)      UILabel                          *reserveEndOperatLabel;

/*!
 * @breif 预订按键
 * @See
 */
@property (nonatomic , weak)      UIButton                          *reserveButton;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      HotelInformation                *selectedHotelInfor;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      NSIndexPath                     *selectedIndexPath;
@end

@implementation HotelDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KHotelDetailTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
//        [selectedView setBackgroundColor:[UIColor redColor]];

        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  KDefaultViewBackGroundColor;
        
        UIView *hotelBGView = [[UIView alloc]init];
        [hotelBGView setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f), 0.0f, (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)), KHotelDetailTableViewCellHeight)];
        [hotelBGView setBackgroundColor:[UIColor whiteColor]];
        self.hotelBackGroundView = hotelBGView;
        [self.contentView addSubview:self.hotelBackGroundView];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:KContentTextColor];
        [nameLabel setFont:KHotelNameLabelFontSize];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        self.hotelRoomNameLabel = nameLabel;
        [self.hotelBackGroundView addSubview:self.hotelRoomNameLabel];
        
        UILabel *subInforLabel = [[UILabel alloc]init];
        [subInforLabel setBackgroundColor:[UIColor clearColor]];
        [subInforLabel setTextColor:KContentTextColor];
        [subInforLabel setFont:KXCAPPUIContentFontSize(14.0f)];
        [subInforLabel setTextAlignment:NSTextAlignmentLeft];
        self.hotelRoomSubContentLabel = subInforLabel;
        [self.hotelBackGroundView addSubview:self.hotelRoomSubContentLabel];
        
        UILabel *allowCancelLabel = [[UILabel alloc]init];
        [allowCancelLabel setBackgroundColor:[UIColor clearColor]];
        [allowCancelLabel setTextColor:HUIRGBColor(226.0, 122.0f,113.0f, 1.0f)];
        [allowCancelLabel setFont:KXCAPPUIContentFontSize(14.0f)];
        [allowCancelLabel setTextAlignment:NSTextAlignmentLeft];
        self.hotelRoomAllowCancelLabel = allowCancelLabel;
        [self.hotelBackGroundView addSubview:self.hotelRoomAllowCancelLabel];
        
        ///价格
        UILabel * minUnitPriceLabel = [[UILabel alloc]init];
        [minUnitPriceLabel setBackgroundColor:[UIColor clearColor]];
        [minUnitPriceLabel setTextColor:KUnitPriceContentColor];
        [minUnitPriceLabel setFont:KMinUnitPriceFontSize];
        [minUnitPriceLabel setTextAlignment:NSTextAlignmentRight];
        self.hotelRealityUnitPriceLabel = minUnitPriceLabel;
        [self.hotelBackGroundView addSubview:self.hotelRealityUnitPriceLabel];
        
        UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reserveBtn setBackgroundColor:[UIColor clearColor]];
        [reserveBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
        [reserveBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                              forState:UIControlStateHighlighted];
        [reserveBtn.titleLabel setFont:KXCAPPUIContentFontSize(12.0f)];
        [reserveBtn setTag:KBtnForReserveButtonTag];
        [reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reserveBtn setTitle:@"预订" forState:UIControlStateNormal];
        [reserveBtn.layer setCornerRadius:5.0f];
        [reserveBtn addTarget:self action:@selector(userOperationButtonEventClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        [reserveBtn.layer setMasksToBounds:YES];
        self.reserveButton = reserveBtn;
        [self.hotelBackGroundView addSubview:self.reserveButton];
        
//        [self.separatorView setBackgroundColor:HUIRGBColor(194.0f, 195.0f, 196.0f, 1.0f)];
//        [self.hotelBackGroundView addSubview:self.separatorView];

        
        [self.separatorView setBackgroundColor:KSepLineColorSetup];
        [self.hotelBackGroundView addSubview: self.separatorView];
    }
    
    return self;
}

- (void)setupDataSourceForIndexCell:(HotelInformation *)itemData indexPath:(NSIndexPath *)indexPath{
    
    if (itemData == nil) {
        return;
    }
    
    self.selectedIndexPath = indexPath;
    self.selectedHotelInfor = itemData;
    
    [self.hotelRoomNameLabel setText:itemData.hotelRoomStyleExplanationContent];
    NSString *subContent = [NSString stringWithFormat:@"%@\t%@",itemData.hotelMorningMealContent,itemData.hotelRoomBerthContent];
    [ self.hotelRoomSubContentLabel setText:subContent];
    
    if(itemData.hotelAllowCancelBool){
        [self.hotelRoomAllowCancelLabel setText:@"可取消"];
    }else{
        [self.hotelRoomAllowCancelLabel setText:@"不可取消"];
    }
    
    [self.hotelRealityUnitPriceLabel setText:[NSString stringWithFormat:@"￥%.0lf",itemData.hotelRealityUnitPriceFloat]];
    
    ///人民币符号￥
    NSRange yuanRange = [self.hotelRealityUnitPriceLabel.text rangeOfString:@"￥"];
    NSMutableAttributedString *priceContent=[[NSMutableAttributedString alloc]initWithString:self.hotelRealityUnitPriceLabel.text];
    [priceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(12) range:yuanRange];
    [priceContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:yuanRange];
    [self.hotelRealityUnitPriceLabel setAttributedText:priceContent];

    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{

    [self.hotelRoomNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                                 (self.hotelBackGroundView.width - KInforLeftIntervalWidth -
                                                  KXCUIControlSizeWidth(90.0f)),
                                                 KXCUIControlSizeWidth(20.0f))];
    CGSize subContentSize = [self.hotelRoomSubContentLabel.text sizeWithFont:self.hotelRoomSubContentLabel.font];
    [self.hotelRoomSubContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                       self.hotelRoomNameLabel.bottom + KXCUIControlSizeWidth(5.0f),
                                                       (subContentSize.width+ 4.0f), KXCUIControlSizeWidth(20.0f))];
    
    [self.hotelRoomAllowCancelLabel setFrame:CGRectMake((self.hotelRoomSubContentLabel.right +
                                                         KXCUIControlSizeWidth(20.0f)),
                                                        self.hotelRoomNameLabel.bottom + KXCUIControlSizeWidth(5.0f), KXCUIControlSizeWidth(60.0f),
                                                        KXCUIControlSizeWidth(20.0f))];
    
    [self.hotelRealityUnitPriceLabel setFrame:CGRectMake((self.hotelBackGroundView.width - KInforLeftIntervalWidth -
                                                           KXCUIControlSizeWidth(80.0f)), KInforLeftIntervalWidth, KXCUIControlSizeWidth(80.0f), KXCUIControlSizeWidth(25.0f))];
    
    if (self.selectedHotelInfor.hotelRoomResidueCountInteger > 1) {
        [self.reserveButton setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
        [self.reserveButton setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                              forState:UIControlStateHighlighted];
        [self.reserveButton.layer setCornerRadius:5.0f];
        [self.reserveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.reserveButton setTitle:@"预订" forState:UIControlStateNormal];
        [self.reserveButton setFrame:CGRectMake((self.hotelBackGroundView.width - KInforLeftIntervalWidth -
                                                 KXCUIControlSizeWidth(50.0f)),
                                                (KHotelDetailTableViewCellHeight - 1.0f - KXCUIControlSizeWidth(30.0f)
                                                 - KInforLeftIntervalWidth),
                                                KXCUIControlSizeWidth(50.0f), (KXCUIControlSizeWidth(30.0f)))];
    }else{
        [self.reserveButton setBackgroundImage:createImageWithColor(KDefaultViewBackGroundColor)
                                      forState:UIControlStateNormal];
        [self.reserveButton setBackgroundImage:createImageWithColor(KDefaultViewBackGroundColor)
                                      forState:UIControlStateHighlighted];
        [self.reserveButton.layer setCornerRadius:1.0f];
        [self.reserveButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [self.reserveButton setTitle:@"满房" forState:UIControlStateNormal];
        [self.reserveButton setFrame:CGRectMake((self.hotelBackGroundView.width - KInforLeftIntervalWidth -
                                                 KXCUIControlSizeWidth(40.0f)),
                                                (KHotelDetailTableViewCellHeight - 1.0f - KXCUIControlSizeWidth(30.0f)
                                                 - KInforLeftIntervalWidth),
                                                KXCUIControlSizeWidth(40.0f), (KXCUIControlSizeWidth(30.0f)))];

    }
    
    [self.reserveButton setFrame:CGRectMake((self.hotelBackGroundView.width - KInforLeftIntervalWidth -
                                             KXCUIControlSizeWidth(50.0f)),
                                            (KHotelDetailTableViewCellHeight - 1.0f - KXCUIControlSizeWidth(30.0f)
                                             - KInforLeftIntervalWidth),
                                            KXCUIControlSizeWidth(50.0f), (KXCUIControlSizeWidth(30.0f)))];
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KHotelDetailTableViewCellHeight - 1.0f),
                                            (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)), 1.0f)];
}

- (void)userOperationButtonEventClicked:(UIButton *)button{
    if (self.selectedHotelInfor.hotelRoomResidueCountInteger <1)return;
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userPersonalReserveRoomOperationWithIndexPath:)]) {
            [self.delegate userPersonalReserveRoomOperationWithIndexPath:self.selectedIndexPath];
        }
    }
}


- (void)setupDataSouceForHeaerCell:(HotelInformation *)itemData indexPath:(NSIndexPath *)indexPath{

}
@end
