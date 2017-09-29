//
//  TrainTicketTableViewCell.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/6.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketTableViewCell.h"

@interface TrainTicketTableViewCell ()

/*!
 * @breif 名字
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainName;

/*!
 * @breif 火车出发时间
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainOffTime;

/*!
 * @breif 火车到达时间
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainArrivedTime;

/*!
 * @breif 火车出发地点
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainOffSite;

/*!
 * @breif 火车两地行驶市场
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainTimeInterval;
/*!
 * @breif 火车到达地点
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainArrivedSite;

/*!
 * @breif 火车票其他说明信息
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainOtherInfor;

/*!
 * @breif 火车票单价
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainUnitPrice;

/*!
 * @breif 火车票等级及数量
 * @See
 */
@property (nonatomic , weak)            UILabel                     *trainScaleNumber;


/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      TrainticketInformation          *selectedTrainTicketInfor;

/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , strong)      NSIndexPath                     *selectedIndexPath;
@end

@implementation TrainTicketTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth,
                                                                        KTrainTicketTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        self.backgroundColor =  [UIColor whiteColor];
        
        
        ///名字
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:KSubTitleTextColor];
        [nameLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        self.trainName = nameLabel;
        [self.contentView addSubview:self.trainName];
        
        ///出发时间
        UILabel *beginDateLabel = [[UILabel alloc]init];
        [beginDateLabel setBackgroundColor:[UIColor clearColor]];
        [beginDateLabel setTextColor:KContentTextColor];
        [beginDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [beginDateLabel setTextAlignment:NSTextAlignmentLeft];
        self.trainOffTime = beginDateLabel;
        [self.contentView addSubview:self.trainOffTime];
        
        ///到达时间
        UILabel *endDateLabel = [[UILabel alloc]init];
        [endDateLabel setBackgroundColor:[UIColor clearColor]];
        [endDateLabel setTextColor:KContentTextColor];
        [endDateLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [endDateLabel setTextAlignment:NSTextAlignmentLeft];
        self.trainArrivedTime = endDateLabel;
        [self.contentView addSubview:self.trainArrivedTime];
        
        ///到达时间
        UILabel *dateIntervalLabel = [[UILabel alloc]init];
        [dateIntervalLabel setBackgroundColor:[UIColor clearColor]];
        [dateIntervalLabel setTextColor:[UIColor lightGrayColor]];
        [dateIntervalLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [dateIntervalLabel setTextAlignment:NSTextAlignmentCenter];
        self.trainTimeInterval = dateIntervalLabel;
        [self.contentView addSubview:self.trainTimeInterval];
        
        ///出发地点
        UILabel *takeOffLabel = [[UILabel alloc]init];
        [takeOffLabel setBackgroundColor:[UIColor clearColor]];
        [takeOffLabel setTextColor:KContentTextColor];
        [takeOffLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [takeOffLabel setTextAlignment:NSTextAlignmentCenter];
        self.trainOffSite = takeOffLabel;
        [self.contentView addSubview:self.trainOffSite];
        
        ///出发地点
        UILabel * arrivedLabel= [[UILabel alloc]init];
        [arrivedLabel setBackgroundColor:[UIColor clearColor]];
        [arrivedLabel setTextColor:KContentTextColor];
        [arrivedLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [arrivedLabel setTextAlignment:NSTextAlignmentCenter];
        self.trainArrivedSite = arrivedLabel;
        [self.contentView addSubview:self.trainArrivedSite];
        
        
        ///说明信息
        UILabel *otherLabel = [[UILabel alloc]init];
        [otherLabel setBackgroundColor:[UIColor clearColor]];
        [otherLabel setTextColor:KSubTitleTextColor];
        [otherLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [otherLabel setTextAlignment:NSTextAlignmentRight];
        self.trainOtherInfor = otherLabel;
        [self.contentView addSubview:self.trainOtherInfor];
        
        ///价格信息
        UILabel *priceLabel  = [[UILabel alloc]init];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setTextColor:KFunContentColor];
        [priceLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
        self.trainUnitPrice = priceLabel;
        [self.contentView addSubview:self.trainUnitPrice];
        
        
        ///数量信息
        UILabel *numberLabel  = [[UILabel alloc]init];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setTextColor:KContentTextColor];
        [numberLabel setFont:KXCAPPUIContentDefautFontSize(14.0f)];
        [numberLabel setTextAlignment:NSTextAlignmentRight];
        self.trainScaleNumber = numberLabel;
        [self.contentView addSubview:self.trainScaleNumber];
        
        
        [self.separatorView setBackgroundColor:KSepLineColorSetup];
        [self.contentView addSubview: self.separatorView];
    }
    
    return self;
}

- (void)setuprainTicketTableViewCellDataSource:(TrainticketInformation *)itemDate indexPath:(NSIndexPath *)indexPath{
    
    
    [self.trainName setText:itemDate.traCodeNameStr];
    [self.trainOffTime setText:itemDate.traTakeOffTime];
    [self.trainArrivedTime setText:itemDate.traArrivedTime];
    
    [self.trainTimeInterval setText:itemDate.traTimeInterval];
    [self.trainOffSite setText:itemDate.traTakeOffSite];
    [self.trainArrivedSite setText:itemDate.traArrivedSite];
    
    
    [self.trainOtherInfor setText:@"其他座次有票"];
    
    [self.trainUnitPrice setText:[NSString stringWithFormat:@"￥%@",itemDate.traUnitPrice]];
    NSRange contentRange=[self.trainUnitPrice.text rangeOfString:itemDate.traUnitPrice];
    NSMutableAttributedString *dynamicContent=[[NSMutableAttributedString alloc]initWithString:self.trainUnitPrice.text];
    [dynamicContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(20) range:contentRange];
    [dynamicContent addAttribute:NSForegroundColorAttributeName value:KUnitPriceContentColor range:contentRange];
    [self.trainUnitPrice setAttributedText:dynamicContent];
    
    [self.trainScaleNumber setText:[NSString stringWithFormat:@"%@ %@",itemDate.traCabinModelStr,itemDate.traScaleNumber]];
    
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews{
    
    [self.trainName setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, KProjectScreenWidth/3,KXCUIControlSizeWidth(25.0f))];
    [self.trainOffTime setFrame:CGRectMake(KInforLeftIntervalWidth, self.trainName.bottom, KProjectScreenWidth/3,KXCUIControlSizeWidth(25.0f))];
    [self.trainArrivedTime setFrame:CGRectMake(KInforLeftIntervalWidth, self.trainOffTime.bottom, KProjectScreenWidth/3,KXCUIControlSizeWidth(25.0f))];
    
    [self.trainTimeInterval setFrame:CGRectMake(KProjectScreenWidth/3, KInforLeftIntervalWidth, KProjectScreenWidth/3,KXCUIControlSizeWidth(25.0f))];
    [self.trainOffSite setFrame:CGRectMake(KProjectScreenWidth/3, self.trainName.bottom, KProjectScreenWidth/3,KXCUIControlSizeWidth(25.0f))];
    [self.trainArrivedSite setFrame:CGRectMake(KProjectScreenWidth/3, self.trainOffTime.bottom, KProjectScreenWidth/3,KXCUIControlSizeWidth(25.0f))];
    
    
    [self.trainOtherInfor setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - KXCUIControlSizeWidth(120.0f)),
                                              (KInforLeftIntervalWidth +  KXCUIControlSizeWidth(4.0f)),
                                              KXCUIControlSizeWidth(120.0f), KXCUIControlSizeWidth(17.0f))];
    [self.trainUnitPrice setFrame:CGRectMake(self.trainOtherInfor.left, self.trainOtherInfor.bottom,
                                             KXCUIControlSizeWidth(120.0f), KXCUIControlSizeWidth(33.0f))];
    [self.trainScaleNumber setFrame:CGRectMake(self.trainUnitPrice.left, self.trainUnitPrice.bottom,
                                               KXCUIControlSizeWidth(120.0f), KXCUIControlSizeWidth(25.0f))];
    
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KTrainTicketTableViewCellHeight - 1.0f),KProjectScreenWidth , 1.0f)];
}
@end
