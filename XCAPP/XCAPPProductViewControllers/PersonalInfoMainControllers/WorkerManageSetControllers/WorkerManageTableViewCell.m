//
//  WorkerManageTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/19.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "WorkerManageTableViewCell.h"

@interface WorkerManageTableViewCell (){
    
}
/*!
 * @breif 用户手机号
 * @See
 */
@property (nonatomic , weak)      UILabel           *userPhoneNumberLabel;

/*!
 * @breif 删除按键
 * @See
 */
@property (nonatomic , weak)      UIButton          *userDeleteBtn;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      NSIndexPath                     *selectedIndexPath;


@end

@implementation WorkerManageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KWorkerManageTableViewCellHeight)];
        [selectedView setBackgroundColor:[UIColor whiteColor]];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor whiteColor];
        
        [self.userPersonalNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.userPersonalNameLabel setContentMode:UIViewContentModeCenter];
        [self.userPersonalNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userPersonalNameLabel setTextColor:KContentTextColor];
        [self.userPersonalNameLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
        [self.contentView addSubview:self.userPersonalNameLabel];
        
        UILabel *phoneLabel = [[UILabel alloc]init];
        [phoneLabel setBackgroundColor:[UIColor clearColor]];
        [phoneLabel setContentMode:UIViewContentModeCenter];
        [phoneLabel setTextAlignment:NSTextAlignmentLeft];
        [phoneLabel setTextColor:KSubTitleTextColor];
        [phoneLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        self.userPhoneNumberLabel = phoneLabel;
        [self.contentView addSubview:self.userPhoneNumberLabel];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundColor:[UIColor clearColor]];
        [deleteBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                              forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:createImageWithColor([UIColor clearColor])
                              forState:UIControlStateHighlighted];
        [deleteBtn.titleLabel setFont:KXCAPPUIContentFontSize(14.0f)];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:KUnitPriceContentColor forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(userOperationButtonEventClicked)
             forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn.layer setMasksToBounds:YES];
        self.userDeleteBtn = deleteBtn;
        [self.contentView addSubview:self.userDeleteBtn];

        
        
        [self.separatorView setBackgroundColor:KSepLineColorSetup];
        [self.contentView addSubview: self.separatorView];
    }
    
    return self;
}


- (void)setupUserInforDataSource:(UserInformationClass *)itemDate indexPath:(NSIndexPath *)indexPath{

    
    self.selectedIndexPath = indexPath;
    
    if (itemDate == nil) {
        return;
    }
    
    [self.userPersonalNameLabel setText:itemDate.userNickNameStr];
    [self.userPhoneNumberLabel setText:[NSString stringWithFormat:@"%@ %@",itemDate.userNameStr,
                                        itemDate.userPerPhoneNumberStr]];
    
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews{
    
    [self.userPersonalNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(6.0f),
                                                    KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(25.0f))];
    
     [self.userPhoneNumberLabel setFrame:CGRectMake(KInforLeftIntervalWidth, (self.userPersonalNameLabel.bottom + KXCUIControlSizeWidth(3.0f)), KXCUIControlSizeWidth(200.0f), KXCUIControlSizeWidth(20.0f))];
   
    if (KXCAPPCurrentUserInformation.userOptionRoleStyle == OptionRoleStyleForAdministration) {
        [self.userDeleteBtn setHidden:NO];
         [self.userDeleteBtn setFrame:CGRectMake((KProjectScreenWidth - KWorkerManageTableViewCellHeight - KInforLeftIntervalWidth) , 0.0f, KWorkerManageTableViewCellHeight, (KWorkerManageTableViewCellHeight - 1.0f))];
    }else{
        [self.userDeleteBtn setHidden:YES];
        [self.userDeleteBtn setFrame:CGRectMake((KProjectScreenWidth - KWorkerManageTableViewCellHeight - KInforLeftIntervalWidth) , 0.0f, 0.0f, (0.0f))];
    }
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KWorkerManageTableViewCellHeight - 1.0f),
                                            KProjectScreenWidth , 1.0f)];
}

- (void)userOperationButtonEventClicked{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(deleteUserWithIndexPath:)]) {
            [self.delegate deleteUserWithIndexPath:self.selectedIndexPath];
        }
    }
}
@end
