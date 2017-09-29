//
//  HotelRoomDetailView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/22.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelRoomDetailView.h"


#define KHotelRoomBGViewWidth                   (KXCUIControlSizeWidth(KProjectScreenWidth - KInforLeftIntervalWidth*4))
//#define KHotelRoomTitlCko

@interface HotelRoomDetailView ()

/*!
 * @breif 信息背景图片
 * @See
 */
@property (nonatomic , assign)      UIView                  *hotelRoomBGView;

/*!
 * @breif 标题信息
 * @See
 */
@property (nonatomic , weak)      UILabel                   *hotelRoomTitleLabel;

/*!
 * @breif 房间具体信息内容
 * @See
 */
@property (nonatomic , weak)      UILabel                   *hotelRoomShowContentLabel;
@end

@implementation HotelRoomDetailView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(KLayerViewBackGroundColor)
                        forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(userHiddentViewEvent)
       forControlEvents:UIControlEventTouchUpInside];
        [self setHotelRoomDetailFrame];
    }
    
    return self;
}

- (void)userHiddentViewEvent{
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:layerViewRect];
    }];
}

- (void)setHotelRoomDetailFrame{
    
    
    UIView *whiteBGView = [[UIView alloc]init];
    [whiteBGView setBackgroundColor:[UIColor whiteColor]];
    [whiteBGView setFrame:CGRectMake(KInforLeftIntervalWidth*2, KXCUIControlSizeWidth(100.0f),
                                     KHotelRoomBGViewWidth, KXCUIControlSizeWidth(100.0f))];
    self.hotelRoomBGView = whiteBGView;
    [self addSubview:self.hotelRoomBGView];
    
    UILabel *roomTitle = [[UILabel alloc]init];
    [roomTitle setTextAlignment:NSTextAlignmentLeft];
    [roomTitle setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth*4,
                                   (KHotelRoomBGViewWidth-KInforLeftIntervalWidth*2),
                                   KXCUIControlSizeWidth(20.0f))];
    [roomTitle setTextColor:KContentTextColor];
    [roomTitle setBackgroundColor:[UIColor clearColor]];
    [roomTitle setFont:KXCAPPUIContentDefautFontSize(20.0f)];
    self.hotelRoomTitleLabel = roomTitle;
    [whiteBGView addSubview:self.hotelRoomTitleLabel];
    
    
    NSString *textStr = @"iPhone规定：";
    UIFont *textFont =KXCAPPUIContentFontSize(16.0f);
    CGSize textSize = [textStr sizeWithFont:textFont
                          constrainedToSize:CGSizeMake((KHotelRoomBGViewWidth-KInforLeftIntervalWidth*2), CGFLOAT_MAX)];
    UILabel *openMicPrivilegeTipsLabel = [[UILabel alloc] init];
    [openMicPrivilegeTipsLabel setFrame:CGRectMake(KInforLeftIntervalWidth,(roomTitle.bottom + KInforLeftIntervalWidth*2), textSize.width, textSize.height)];
    openMicPrivilegeTipsLabel.textColor = KContentTextColor;
    openMicPrivilegeTipsLabel.text = textStr;
    openMicPrivilegeTipsLabel.backgroundColor = [UIColor clearColor];
    [openMicPrivilegeTipsLabel setTextAlignment:NSTextAlignmentLeft];
    [openMicPrivilegeTipsLabel setFont:textFont];
    openMicPrivilegeTipsLabel.numberOfLines = 0;
    self.hotelRoomShowContentLabel = openMicPrivilegeTipsLabel;
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0f];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    openMicPrivilegeTipsLabel.attributedText = attributedString;
    
    [whiteBGView addSubview:self.hotelRoomShowContentLabel];
    [openMicPrivilegeTipsLabel sizeToFit];
}

- (void)setRoomTitle:(NSString *)title{
    [self.hotelRoomTitleLabel setText:title];
}
- (void)setRoomDetailContent:(NSString *)content attribute:(NSArray *)array{

    UIFont *textFont =KXCAPPUIContentFontSize(16.0f);
    CGSize textSize = [content sizeWithFont:textFont
                          constrainedToSize:CGSizeMake((KHotelRoomBGViewWidth-KInforLeftIntervalWidth*2), CGFLOAT_MAX)];
    [self.hotelRoomShowContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                        (self.hotelRoomTitleLabel.bottom + KInforLeftIntervalWidth*2),
                                                        textSize.width, textSize.height)];
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KInforLeftIntervalWidth];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    for (NSString *attributeStr in array) {
        NSRange attributeRange=[content rangeOfString:attributeStr];
        [attributedString addAttribute:NSForegroundColorAttributeName value:KSubTitleTextColor range:attributeRange];
    }
    
    self.hotelRoomShowContentLabel.attributedText = attributedString;
    [self.hotelRoomShowContentLabel sizeToFit];
    [self.hotelRoomBGView setFrame:CGRectMake(KInforLeftIntervalWidth*2,
                                              (KProjectScreenHeight - (self.hotelRoomShowContentLabel.bottom +
                                                                      KInforLeftIntervalWidth*12)),
                                              KHotelRoomBGViewWidth,
                                              (self.hotelRoomShowContentLabel.bottom + KInforLeftIntervalWidth*4))];
}
@end
