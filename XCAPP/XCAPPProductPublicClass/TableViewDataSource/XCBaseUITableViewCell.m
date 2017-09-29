//
//  XCBaseUITableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "XCBaseUITableViewCell.h"

@implementation XCBaseUITableViewCell

- (id)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = KDefaultViewBackGroundColor;
        
        
        
        ///用户头像图片内容
        UIImageView *userIconImage = [[UIImageView alloc]init];
        userIconImage.backgroundColor = KUIImageViewDefaultColor;
        [userIconImage setClipsToBounds:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userOperationUserPhoto:)];
        [userIconImage addGestureRecognizer:tap];
        [userIconImage setUserInteractionEnabled:YES];
        self.userPhotoImageView = userIconImage;
        [self.contentView addSubview:self.userPhotoImageView ];
        
        ///消息所有者名字
        UILabel *userNameLabel = [[UILabel alloc]init];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameLabel setContentMode:UIViewContentModeCenter];
        [userNameLabel setTextAlignment:NSTextAlignmentCenter];
        [userNameLabel setTextColor:KContentTextColor];
        [userNameLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        self.userPersonalNameLabel= userNameLabel;
        [self.contentView addSubview:self.userPersonalNameLabel];
        
        UIView  *separator = [[UIView alloc]init];
        [separator setBackgroundColor:KSepLineColorSetup];
        self.separatorView = separator;
        [self.contentView addSubview:self.separatorView];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        
        self.backgroundColor = KDefaultViewBackGroundColor;
        
        //[self.backgroundColor setcl]
        
        ///用户头像图片内容
        UIImageView *userIconImage = [[UIImageView alloc]init];
        userIconImage.backgroundColor = KUIImageViewDefaultColor;
        [userIconImage setClipsToBounds:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userOperationUserPhoto:)];
        [userIconImage addGestureRecognizer:tap];
        [userIconImage setUserInteractionEnabled:YES];
        self.userPhotoImageView = userIconImage;
        [self.userPhotoImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:self.userPhotoImageView ];
        
        ///消息所有者名字
        UILabel *userNameLabel = [[UILabel alloc]init];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameLabel setContentMode:UIViewContentModeCenter];
        [userNameLabel setTextAlignment:NSTextAlignmentCenter];
        [userNameLabel setTextColor:KContentTextColor];
        [userNameLabel setFont:KXCAPPUIContentFontSize(16.0f)];
        self.userPersonalNameLabel= userNameLabel;
        [self.contentView addSubview:self.userPersonalNameLabel];
        
        UIView  *separator = [[UIView alloc]init];
        [separator setBackgroundColor:KSepLineColorSetup];
        self.separatorView = separator;
        [self.contentView addSubview:self.separatorView];
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)userOperationUserPhoto:(UIGestureRecognizer *)recognizer{
    
}


@end
