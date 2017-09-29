//
//  CityInforForTrainTicketTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/21.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "CityInforForTrainTicketTableViewCell.h"

@implementation CityInforForTrainTicketTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KCityForTrainTicketCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor whiteColor];
        
        [self.userPersonalNameLabel setFont:KXCAPPUIContentDefautFontSize(17.0f)];
        [self.userPersonalNameLabel setTextColor:KContentTextColor];
        [self.userPersonalNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.userPersonalNameLabel];
        
        [self.separatorView setBackgroundColor:KSepLineColorSetup];
        [self.contentView addSubview:self.separatorView];
    }
    
    return self;
}

- (void)setupDataSourceCityName:(NSString *)cityNameStr indexPath:(NSIndexPath *)indexPath{

    [self.userPersonalNameLabel setText:cityNameStr];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [self.userPersonalNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth *2, 0.0f,
                                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                                   (KCityForTrainTicketCellHeight - 1.0f))];
    [self.separatorView setFrame:CGRectMake(0.0f, (KCityForTrainTicketCellHeight - 1.0f), KProjectScreenWidth, 1.0f)];
}

@end
