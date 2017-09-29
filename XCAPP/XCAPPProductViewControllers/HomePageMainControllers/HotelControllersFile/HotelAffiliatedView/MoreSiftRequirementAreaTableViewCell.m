//
//  MoreSiftRequirementAreaTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/20.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "MoreSiftRequirementAreaTableViewCell.h"

@implementation MoreSiftRequirementAreaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KAreaTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor whiteColor];
        
        
        UIImageView *selectedShowImage =[[UIImageView alloc]init];
        [selectedShowImage setBackgroundColor:KSepLineColorSetup];
        [selectedShowImage setFrame:CGRectMake(KInforLeftIntervalWidth,
                                               (KAreaTableViewCellHeight - KXCUIControlSizeWidth(25.0f))/2, KXCUIControlSizeWidth(25.0f),
                                               KXCUIControlSizeWidth(25.0f))];
        [selectedShowImage.layer setCornerRadius:KXCUIControlSizeWidth(25.0f)/2];
        [selectedShowImage setImage:createImageWithColor([UIColor clearColor])];
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

- (void)setupTableViewDataSource:(NSString *)areaNameStr indexPath:(NSIndexPath *)indexPath{
    if (IsNormalMobileNum(areaNameStr)) {
        return;
    }
    
    [self.userPersonalNameLabel setText:areaNameStr];
    
    if (indexPath.row == 0) {
//        [self.userSelectedImageView setImage:createImageWithColor(HUIRGBColor(215.0f, 151.0f, 68.0f, 1.0))];
        
        [self.userSelectedImageView setImage:[UIImage imageNamed:@"nr_selected.png"]];
    }else{
        [self.userSelectedImageView setImage:createImageWithColor([UIColor clearColor])];
    }
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews{
    [self.userSelectedImageView setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(120.0f + 25.0f) - KInforLeftIntervalWidth),
                                                    (KAreaTableViewCellHeight -
                                                     KXCUIControlSizeWidth(25.0f))/2,
                                                    KXCUIControlSizeWidth(25.0f),
                                                    KXCUIControlSizeWidth(25.0f))];
    
    [self.userPersonalNameLabel setFrame:CGRectMake((KInforLeftIntervalWidth),
                                                    (KAreaTableViewCellHeight -
                                                     KXCUIControlSizeWidth(20.0f))/2,
                                                    KXCUIControlSizeWidth(140.0f),
                                                    KXCUIControlSizeWidth(20.0f))];
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KAreaTableViewCellHeight - 1.0f),
                                            KProjectScreenWidth , 1.0f)];
}

@end
