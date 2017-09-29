//
//  HotelInforTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/6/28.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "HotelInforTableViewCell.h"

#define KDistanceLabelFontSize              KXCAPPUIContentDefautFontSize(10.0f)
#define KHotelNameLabelFontSize             KXCAPPUIContentDefautFontSize(16.0f)
#define KRankContentFontSize                KXCAPPUIContentDefautFontSize(12.0f)
#define KMarkRecordFontSize                 KXCAPPUIContentDefautFontSize(16.0f)
#define KMinUnitPriceFontSize               KXCAPPUIContentDefautFontSize(18.0f)
#define KAddressFontSize                    KXCAPPUIContentDefautFontSize(12.0f)


#define KMarkRecordColor                    [UIColor colorWithRed:093.0f/255.0f green:149.0f/255.0f blue:214.0f/255.0f alpha:1.0f]
#define KAddressColor                       [UIColor colorWithRed:143.0f/255.0f green:150.0f/255.0f blue:163.0f/255.0f alpha:1.0f]


#define KHotelServiceImageTag               (1790111)

#define KImgForServiceWidhtFloat            (KXCUIControlSizeWidth(15.0f))


@interface HotelInforTableViewCell ()

/*!
 * @breif 酒店Cell背景色信息
 * @See
 */
@property (nonatomic , weak)      UIView                            *hotelBackGroundView;
//[uif]
/*!
 * @breif 酒店
 * @See
 */
@property (nonatomic , weak)      UIImageView                       *hotelImageView;

/*!
 * @breif 酒店距离
 * @See
 */
@property (nonatomic , weak)      UILabel                           *hotelDistanceLabel;

/*!
 * @breif 酒店名字
 * @See
 */
@property (nonatomic , weak)      UILabel                           *hotelNameLabel;
//
////rank
///*!
// * @breif 酒店评分
// * @See
// */
//@property (nonatomic , weak)      UILabel                           *hotelMarkRecordLabel;

/*!
 * @breif 酒店级别
 * @See 四星级/五星级/
 */
@property (nonatomic , weak)      UILabel                           *hotelRankContentLabel;

/*!
 * @breif 酒店地址
 * @See
 */
@property (nonatomic , weak)      UILabel                           *hotelAddressLabel;

/*!
 * @breif 酒店最低单价
 * @See
 */
@property (nonatomic , weak)      UILabel                           *hotelMinUnitPriceLabel;

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


/*!
 * @breif 服务图片数据
 * @See
 */
@property (nonatomic , strong)      NSMutableArray                  *hotelServiceItemArray;
@end

@implementation HotelInforTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KHotelInforTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor clearColor];
        
        UIView *hotelBGView = [[UIView alloc]init];
        [hotelBGView setFrame:CGRectMake(KXCUIControlSizeWidth(10.0f), 0.0f, (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)), KHotelInforTableViewCellHeight)];
        [hotelBGView setBackgroundColor:[UIColor whiteColor]];
        self.hotelBackGroundView = hotelBGView;
        [self.contentView addSubview:self.hotelBackGroundView];
        
        
        ///背景图片内容
        UIImageView *displayImageView = [[UIImageView alloc]init];
        [displayImageView setBackgroundColor:[UIColor clearColor]];
        [displayImageView setImage:KUIImageViewDefaultImage];
        [displayImageView setClipsToBounds:YES];
        [displayImageView setContentMode:UIViewContentModeScaleAspectFill];
        [displayImageView setUserInteractionEnabled:YES];
        self.hotelImageView = displayImageView;
        [self.hotelBackGroundView addSubview:self.hotelImageView];
        
        
        UILabel *distanceLabel = [[UILabel alloc]init];
        [distanceLabel setBackgroundColor:HUIRGBColor(20.0f, 20.0f, 20.0f, 0.75)];
        [distanceLabel setTextColor:[UIColor whiteColor]];
        [distanceLabel setFont:KDistanceLabelFontSize];
        [distanceLabel setTextAlignment:NSTextAlignmentCenter];
        self.hotelDistanceLabel = distanceLabel;
        [self.hotelImageView addSubview:self.hotelDistanceLabel];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:KContentTextColor];
        [nameLabel setFont:KHotelNameLabelFontSize];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        self.hotelNameLabel = nameLabel;
        [self.hotelBackGroundView addSubview:self.hotelNameLabel];
        
//        UILabel *markRecordLabel = [[UILabel alloc]init];
//        [markRecordLabel setBackgroundColor:[UIColor clearColor]];
//        [markRecordLabel setTextColor:KMarkRecordColor];
//        [markRecordLabel setFont:KMarkRecordFontSize];
//        [markRecordLabel setTextAlignment:NSTextAlignmentLeft];
//        self.hotelMarkRecordLabel = markRecordLabel;
//        [self.hotelBackGroundView addSubview:self.hotelMarkRecordLabel];
        
        
        ///价格
        UILabel * minUnitPriceLabel = [[UILabel alloc]init];
        [minUnitPriceLabel setBackgroundColor:[UIColor clearColor]];
        [minUnitPriceLabel setTextColor:KUnitPriceContentColor];
        [minUnitPriceLabel setFont:KMinUnitPriceFontSize];
        [minUnitPriceLabel setTextAlignment:NSTextAlignmentRight];
        self.hotelMinUnitPriceLabel = minUnitPriceLabel;
        [self.hotelBackGroundView addSubview:self.hotelMinUnitPriceLabel];
        
        UILabel *rankContentLabel = [[UILabel alloc]init];
        [rankContentLabel setBackgroundColor:[UIColor clearColor]];
        [rankContentLabel setTextColor:KContentTextColor];
        [rankContentLabel setFont:KRankContentFontSize];
        [rankContentLabel setTextAlignment:NSTextAlignmentLeft];
        self.hotelRankContentLabel = rankContentLabel;
        [self.hotelBackGroundView addSubview:self.hotelRankContentLabel];
        
        
        UILabel *addressLabel = [[UILabel alloc]init];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [addressLabel setTextColor:KAddressColor];
        [addressLabel setFont:KAddressFontSize];
        [addressLabel setTextAlignment:NSTextAlignmentLeft];
        self.hotelAddressLabel = addressLabel;
        [self.hotelBackGroundView addSubview:self.hotelAddressLabel];
        
        
        [self.separatorView setBackgroundColor:KSepLineColorSetup];
        [self.hotelBackGroundView addSubview: self.separatorView];
    }
    
    return self;
}


- (void)setupHotelInforTableViewCellDataSource:(HotelInformation *)itemData indexPath:(NSIndexPath *)indexPath{
    
    
    
    if (itemData == nil) {
        return;
    }
    /*
    NSURL *imageURL = [NSURL URLWithString:itemData.hotelImageDisplayURLStr];
    [self.hotelImageView setImageWithURL:imageURL placeholderImage:KUIImageViewDefaultImage];
     */
    NSString *imageNameStr = [NSString stringWithFormat:@"hotelIcon%zi.png",((indexPath.row%6)+1)];
    [self.hotelImageView setImage:[UIImage imageNamed:imageNameStr]];

    [self.hotelDistanceLabel setText:itemData.hotelDistanceStr];
    
    [self.hotelNameLabel setText:itemData.hotelNameContentStr];
    [self.hotelRankContentLabel setText:itemData.hotelRankContentStr];
    
    
//    [self.hotelMarkRecordLabel setText:itemData.hotelMarkRecordContentStr];
//    NSRange contentRange=[self.hotelMarkRecordLabel.text rangeOfString:@"分"];
//    NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:self.hotelMarkRecordLabel.text];
//    [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(11) range:contentRange];
//    [self.hotelMarkRecordLabel setAttributedText:dynamicContent];
    
    [self.hotelMinUnitPriceLabel setText:[NSString stringWithFormat: @"￥%.0lf起",itemData.hotelMinUnitPriceFloat]];
    ///人民币符号￥
    NSRange yuanRange = [self.hotelMinUnitPriceLabel.text rangeOfString:@"￥"];
    ///@“起”
    NSRange beginRange=[self.hotelMinUnitPriceLabel.text rangeOfString:@"起"];
    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:self.hotelMinUnitPriceLabel.text];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(12) range:yuanRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KMarkRecordColor range:yuanRange];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(13) range:beginRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:beginRange];
    [self.hotelMinUnitPriceLabel setAttributedText:minUnitPriceContent];
    
    [self.hotelAddressLabel setText:itemData.hotelAddressRoughStr];
    
    if (!self.hotelServiceItemArray) {
        self.hotelServiceItemArray = [[NSMutableArray alloc]init];
    }
    
    for (UIImageView *serviceImage in self.hotelServiceItemArray) {
        [serviceImage removeFromSuperview];
    }
    
    [self.hotelServiceItemArray removeAllObjects];
    
    for (NSString *imagePathName in itemData.hotelServiceContentArray) {
        
        if (!IsStringEmptyOrNull(imagePathName)) {
            
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setBackgroundColor:[UIColor clearColor]];
            [imageView setImage:[UIImage imageNamed:imagePathName]];
            [self.hotelServiceItemArray addObject:imageView];
        }
    }
    
    [self layoutIfNeeded];

}

- (void)layoutSubviews{
    
    [self.hotelImageView setFrame:CGRectMake(0.0f, 0.0f, (KHotelInforTableViewCellHeight-1.0f),
                                             (KHotelInforTableViewCellHeight-1.0f))];
    
    [self.hotelDistanceLabel setFrame:CGRectMake(0.0f, (self.hotelImageView.height - 20.0f),
                                                 self.hotelImageView.width, 20.0f)];
    
    CGFloat  contentRight = (self.hotelImageView.right + KInforLeftIntervalWidth);
    
    [self.hotelNameLabel setFrame:CGRectMake(contentRight, KXCUIControlSizeWidth(5.0f),
                                              (self.hotelBackGroundView.width - 20.0f -contentRight),
                                             KXCUIControlSizeWidth(70/3))];
    
    [self.hotelMinUnitPriceLabel setFrame:CGRectMake((self.hotelBackGroundView.width - 20.0f -100.0f),
                                                     (self.hotelNameLabel.bottom),
                                             100.0f,
                                             KXCUIControlSizeWidth(20))];

    CGSize rankContentLabelSize = [self.hotelRankContentLabel.text sizeWithFont:self.hotelRankContentLabel.font];
    [self.hotelRankContentLabel setFrame:CGRectMake(contentRight, (self.hotelNameLabel.bottom),
                                                (rankContentLabelSize.width), KXCUIControlSizeWidth(70/3))];
    
    
    CGFloat serviceImageLeftFloat = self.hotelRankContentLabel.right + KInforLeftIntervalWidth;
    
    CGFloat serviceYFloat = (self.hotelNameLabel.bottom + KXCUIControlSizeWidth(4.0f));
    
    for (int index = 0; index < self.hotelServiceItemArray.count; index++) {
        
        UIImageView *imageView = (UIImageView *)[self.hotelServiceItemArray objectAtIndex:index];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView.layer setCornerRadius:KImgForServiceWidhtFloat/2];
        [imageView.layer setMasksToBounds:YES];
        [imageView setFrame:CGRectMake((serviceImageLeftFloat + (KImgForServiceWidhtFloat +KXCUIControlSizeWidth(8.0f))*index),
                                       serviceYFloat, KImgForServiceWidhtFloat, KImgForServiceWidhtFloat)];
        
        [self.hotelBackGroundView addSubview:imageView];
    }
   
    [self.hotelAddressLabel setFrame:CGRectMake(contentRight, (self.hotelRankContentLabel.bottom),
                                                (self.hotelBackGroundView.width - 20.0f -contentRight), KXCUIControlSizeWidth(70/3))];
    
    [self.separatorView setFrame:CGRectMake(0.0f, self.hotelImageView.bottom,
                                            (KProjectScreenWidth - KXCUIControlSizeWidth(20.0f)), 1.0f)];
}

@end
