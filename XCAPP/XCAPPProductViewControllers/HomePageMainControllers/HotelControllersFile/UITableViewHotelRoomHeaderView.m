//
//  UITableViewHotelRoomHeaderView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/10/18.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UITableViewHotelRoomHeaderView.h"

#define KMarkRecordColor                    [UIColor colorWithRed:093.0f/255.0f green:149.0f/255.0f blue:214.0f/255.0f alpha:1.0f]


@interface UITableViewHotelRoomHeaderView ()

/*!
 * @breif 用户操作按键
 * @See
 */
@property (nonatomic , weak)            UIButton                *operationButton;

/*!
 * @breif 房型信息
 * @See
 */
@property (nonatomic , weak)            UILabel                 *roomStyleContentLabel;

/*!
 * @breif 单价信息
 * @See
 */
@property (nonatomic , weak)            UILabel                 *roomMinUnitPrice;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , assign)          NSInteger               selectedIndexPath;

///分割线
@property (nonatomic , weak)        UIView                      *separatorView;
@end
@implementation UITableViewHotelRoomHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KUITableViewHotelRoomHeaderCellHeight)];
        [self.contentView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KUITableViewHotelRoomHeaderCellHeight)];
        
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setBackgroundImage:createImageWithColor([UIColor whiteColor])
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(KTableViewCellSelectedColor)
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KUITableViewHotelRoomHeaderCellHeight)];
        [button addTarget:self action:@selector(userOperationButtonEventClicked)
         forControlEvents:UIControlEventTouchUpInside];
        self.operationButton = button;
        [self.contentView addSubview:self.operationButton];
        
        
        ///房间类型
        UILabel *roomLabel = [[UILabel alloc]init];
        [roomLabel setBackgroundColor:[UIColor clearColor]];
        [roomLabel setTextColor:KSubTitleTextColor];
        [roomLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
        [roomLabel setTextAlignment:NSTextAlignmentLeft];
        self.roomStyleContentLabel = roomLabel;
        [self.operationButton addSubview:self.roomStyleContentLabel];
        
        ///价格
        UILabel * minUnitPriceLabel = [[UILabel alloc]init];
        [minUnitPriceLabel setBackgroundColor:[UIColor clearColor]];
        [minUnitPriceLabel setTextColor:KUnitPriceContentColor];
        [minUnitPriceLabel setFont:KXCAPPUIContentDefautFontSize(20.0f)];
        [minUnitPriceLabel setTextAlignment:NSTextAlignmentRight];
        self.roomMinUnitPrice = minUnitPriceLabel;
        [self.operationButton addSubview:self.roomMinUnitPrice];
        
        UIView  *separator = [[UIView alloc]init];
        [separator setBackgroundColor:KSepLineColorSetup];
        self.separatorView = separator;
        [self.operationButton addSubview:self.separatorView];
    }
    
    return self;
}

- (void)setupDataSouceForHeaerCell:(HotelInformation *)itemData indexPath:(NSInteger)indexPath{
    
    self.selectedIndexPath = indexPath;
    
    [self.roomStyleContentLabel setText:itemData.hotelRoomClassNameContentStr];
    [self.roomMinUnitPrice setText:[NSString stringWithFormat: @"￥%.1lf起",itemData.hotelMinUnitPriceFloat]];
    ///人民币符号￥
    NSRange yuanRange = [self.roomMinUnitPrice.text rangeOfString:@"￥"];
    ///@“起”
    NSRange beginRange=[self.roomMinUnitPrice.text rangeOfString:@"起"];
    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:self.roomMinUnitPrice.text];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(13) range:yuanRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KMarkRecordColor range:yuanRange];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(14) range:beginRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:beginRange];
    [self.roomMinUnitPrice setAttributedText:minUnitPriceContent];
    
    [self layoutIfNeeded];
}
- (void)layoutSubviews{

    [self.roomStyleContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                                    KXCUIControlSizeWidth(200.0f),
                                                    (KUITableViewHotelRoomHeaderCellHeight - KInforLeftIntervalWidth*2))];
    
    [self.roomMinUnitPrice setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - KXCUIControlSizeWidth(100.0f)),
                                               (KUITableViewHotelRoomHeaderCellHeight - KXCUIControlSizeWidth(20.0f))/2,
                                               KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    
    [self.separatorView setFrame:CGRectMake(0.0f,(KUITableViewHotelRoomHeaderCellHeight - 1.0f) , KProjectScreenWidth, 1.0f)];
}


- (void)userOperationButtonEventClicked{
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectedHeaerViewWithPathIndex:)]) {
            [self.delegate didSelectedHeaerViewWithPathIndex:self.selectedIndexPath];
        }
    }

}
@end
