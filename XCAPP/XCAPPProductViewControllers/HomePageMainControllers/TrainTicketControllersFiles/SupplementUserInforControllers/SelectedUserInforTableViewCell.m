//
//  SelectedUserInforTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "SelectedUserInforTableViewCell.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

@interface SelectedUserInforTableViewCell ()

/*!
 * @breif 用户身份证信息
 * @See
 */
@property (nonatomic , weak)      UILabel               *userCredentialContentLabel;

/*!
 * @breif 编辑按键
 * @See
 */
@property (nonatomic , weak)      UIButton              *userEditButton;

/*!
 * @breif 用户选择的IndexPath
 * @See
 */
@property (nonatomic , strong)      NSIndexPath         *userSelectedIndexPath;
@end

@implementation SelectedUserInforTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KSelectedUserInforTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor whiteColor];
        
        
        UIImageView *selectedShowImage =[[UIImageView alloc]init];
        [selectedShowImage setBackgroundColor:KSepLineColorSetup];
        [selectedShowImage setFrame:CGRectMake(KInforLeftIntervalWidth,
                                               (KSelectedUserInforTableViewCellHeight - KXCUIControlSizeWidth(25.0f))/2, KXCUIControlSizeWidth(25.0f),
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
        
        UILabel *credentialLabel = [[UILabel alloc]init];
        [credentialLabel setBackgroundColor:[UIColor clearColor]];
        [credentialLabel setContentMode:UIViewContentModeCenter];
        [credentialLabel setTextAlignment:NSTextAlignmentLeft];
        [credentialLabel setTextColor:KContentTextColor];
        [credentialLabel setFont:KXCAPPUIContentDefautFontSize(15.0f)];
        self.userCredentialContentLabel = credentialLabel;
        [self.contentView addSubview:self.userCredentialContentLabel];
        
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                           forState:UIControlStateNormal];
        [editBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                           forState:UIControlStateHighlighted];
        [editBtn.titleLabel setFont:KXCAPPUIContentFontSize(20.0f)];
        [editBtn simpleButtonWithImageColor:KSubTitleTextColor];
        [editBtn addTarget:self action:@selector(userEditButtonEventClicked)
          forControlEvents:UIControlEventTouchUpInside];
        [editBtn setAwesomeIcon:FMIconEidt];
        self.userEditButton = editBtn;
        [self.contentView addSubview:self.userEditButton];
        
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
    
    NSString *userCredentialContent = [NSString stringWithFormat:@"%@ %@",itemDate.userPerCredentialStyle,itemDate.userPerCredentialContent];
    [self.userCredentialContentLabel setText:userCredentialContent];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    
    [self.userSelectedImageView setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                    (KSelectedUserInforTableViewCellHeight -
                                                     KXCUIControlSizeWidth(25.0f))/2,
                                                    KXCUIControlSizeWidth(25.0f),
                                                    KXCUIControlSizeWidth(25.0f))];
    
    [self.userPersonalNameLabel setFrame:CGRectMake((self.userSelectedImageView.right + KInforLeftIntervalWidth),
                                                    KInforLeftIntervalWidth,
                                                    KXCUIControlSizeWidth(140.0f),
                                                    KXCUIControlSizeWidth(20.0f))];

    [self.userCredentialContentLabel setFrame:CGRectMake((self.userSelectedImageView.right + KInforLeftIntervalWidth),
                                                         (self.userPersonalNameLabel.bottom +
                                                          KXCUIControlSizeWidth(5.0f)),
                                                         KXCUIControlSizeWidth(260.0f),
                                                         KXCUIControlSizeWidth(20.0f))];
    
    [self.userEditButton setFrame:CGRectMake((KProjectScreenWidth - KXCUIControlSizeWidth(40.0f) -
                                              KInforLeftIntervalWidth*1.2),
                                             (KSelectedUserInforTableViewCellHeight - KXCUIControlSizeWidth(40.0f))/2,
                                             KXCUIControlSizeWidth(40.0f),
                                             KXCUIControlSizeWidth(40.0f))];
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KSelectedUserInforTableViewCellHeight - 1.0f),
                                            KProjectScreenWidth , 1.0f)];
}


- (void)userEditButtonEventClicked{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userSelectedUserToEditWithIndexPath:)]) {
            [self.delegate userSelectedUserToEditWithIndexPath:self.userSelectedIndexPath];
        }
    }
}
@end
