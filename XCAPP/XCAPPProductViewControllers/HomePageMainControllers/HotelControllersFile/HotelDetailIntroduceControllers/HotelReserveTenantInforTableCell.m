//
//  HotelReserveTenantInforTableCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelReserveTenantInforTableCell.h"

@interface HotelReserveTenantInforTableCell ()
/*!
 * @breif 用户选择的IndexPath
 * @See
 */
@property (nonatomic , strong)      NSIndexPath         *userSelectedIndexPath;
@end

@implementation HotelReserveTenantInforTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KHotelReserveTenantInforTableCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor whiteColor];
        
        
        UIImageView *selectedShowImage =[[UIImageView alloc]init];
        [selectedShowImage setBackgroundColor:KSepLineColorSetup];
        [selectedShowImage setFrame:CGRectMake(KInforLeftIntervalWidth,
                                               (KHotelReserveTenantInforTableCellHeight - KXCUIControlSizeWidth(25.0f))/2, KXCUIControlSizeWidth(25.0f),
                                               KXCUIControlSizeWidth(25.0f))];
        [selectedShowImage.layer setCornerRadius:KXCUIControlSizeWidth(25.0f)/2];
        [selectedShowImage setImage:createImageWithColor(KSepLineColorSetup)];
        [selectedShowImage.layer setMasksToBounds:YES];
        self.userSelectedImageView = selectedShowImage;
        [self.contentView addSubview:self.userSelectedImageView];
        
        [self.userPersonalNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.userPersonalNameLabel setContentMode:UIViewContentModeCenter];
        [self.userPersonalNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userPersonalNameLabel setTextColor:KContentTextColor];
        [self.userPersonalNameLabel setFont:KXCAPPUIContentDefautFontSize(15.0f)];
        [self.contentView addSubview:self.userPersonalNameLabel];
        
        [self.separatorView setBackgroundColor:KSepLineColorSetup];
        [self.contentView addSubview: self.separatorView];
    }
    
    return self;
}
- (void)setupDataSource:(UserInformationClass *)itemDate indexPaht:(NSIndexPath *)indexPath{
    
    
    if (IsNormalMobileNum(itemDate.userPerId)) {
        return;
    }
    
    self.userSelectedIndexPath = indexPath;

    
    [self.userPersonalNameLabel setText:itemDate.userNameStr];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    
    [self.userSelectedImageView setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                    (KHotelReserveTenantInforTableCellHeight -
                                                     KXCUIControlSizeWidth(25.0f))/2,
                                                    KXCUIControlSizeWidth(25.0f),
                                                    KXCUIControlSizeWidth(25.0f))];
    
    [self.userPersonalNameLabel setFrame:CGRectMake((self.userSelectedImageView.right + KInforLeftIntervalWidth),
                                                    (KHotelReserveTenantInforTableCellHeight -
                                                     KXCUIControlSizeWidth(20.0f))/2,
                                                    KXCUIControlSizeWidth(140.0f),
                                                    KXCUIControlSizeWidth(20.0f))];
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KHotelReserveTenantInforTableCellHeight - 1.0f),
                                            KProjectScreenWidth , 1.0f)];
}

@end
