//
//  UITableViewFlightHeaderView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/9.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "UITableViewFlightHeaderView.h"
#define KMarkRecordColor                    [UIColor colorWithRed:093.0f/255.0f green:149.0f/255.0f blue:214.0f/255.0f alpha:1.0f]

@interface UITableViewFlightHeaderView ()


/*!
 * @breif 用户操作按键
 * @See
 */
@property (nonatomic , weak)            UIButton                *operationButton;
/*!
 * @breif 航班起飞时间
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightTakeOffTime;

/*!
 * @breif 航班起飞地点
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightTakeOffAirport;


/*!
 * @breif 单价信息
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightMinUnitPrice;
/*!
 * @breif 航班到达时间
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightArrivedTime;

/*!
 * @breif 航班到达机场
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightArrivedAirport;

/*!
 * @breif 航班所属公司ICON
 * @See
 */
@property (nonatomic , weak)            UIImageView             *flightIconImageView;

/*!
 * @breif 航班其他信息（所属公司、航号、机型、是否提供餐食）
 * @See
 */
@property (nonatomic , weak)            UILabel                 *flightOtherContentInfor;


/*!
 * @breif 选中的数据信息
 * @See
 */
@property (nonatomic , assign)          NSInteger               selectedIndexPath;

///分割线
@property (nonatomic , weak)        UIView                      *separatorView;
@end
@implementation UITableViewFlightHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor =  [UIColor whiteColor];
        
        [self setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KUITableViewFlightHeaderHeight)];
        [self.contentView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KUITableViewFlightHeaderHeight)];
        
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setBackgroundImage:createImageWithColor([UIColor whiteColor])
                          forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(KTableViewCellSelectedColor)
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KUITableViewFlightHeaderHeight)];
        [button addTarget:self action:@selector(userOperationButtonEventClicked)
         forControlEvents:UIControlEventTouchUpInside];
        self.operationButton = button;
        [self.contentView addSubview:self.operationButton];
//        [self.contentView setClipsToBounds:YES];
//        [self.contentView setUserInteractionEnabled:YES];
//        [self.contentView.layer setMasksToBounds:YES];
        
       
        ///出发时间
        UILabel *beginDateLabel = [[UILabel alloc]init];
        [beginDateLabel setBackgroundColor:[UIColor clearColor]];
        [beginDateLabel setTextColor:KContentTextColor];
        [beginDateLabel setFont:KXCAPPUIContentDefautFontSize(21.0f)];
        [beginDateLabel setTextAlignment:NSTextAlignmentLeft];
        self.flightTakeOffTime = beginDateLabel;
        [self.operationButton addSubview:self.flightTakeOffTime];
        
        ///到达时间
        UILabel *endDateLabel = [[UILabel alloc]init];
        [endDateLabel setBackgroundColor:[UIColor clearColor]];
        [endDateLabel setTextColor:KContentTextColor];
        [endDateLabel setFont:KXCAPPUIContentDefautFontSize(22.0f)];
        [endDateLabel setTextAlignment:NSTextAlignmentRight];
        self.flightArrivedTime = endDateLabel;
        [self.operationButton addSubview:self.flightArrivedTime];
        
        
        ///价格
        UILabel * minUnitPriceLabel = [[UILabel alloc]init];
        [minUnitPriceLabel setBackgroundColor:[UIColor clearColor]];
        [minUnitPriceLabel setTextColor:KUnitPriceContentColor];
        [minUnitPriceLabel setFont:KXCAPPUIContentDefautFontSize(18.0f)];
        [minUnitPriceLabel setTextAlignment:NSTextAlignmentRight];
        self.flightMinUnitPrice = minUnitPriceLabel;
        [self.operationButton addSubview:self.flightMinUnitPrice];
        
        ///出发地点
        UILabel *takeOffLabel = [[UILabel alloc]init];
        [takeOffLabel setBackgroundColor:[UIColor clearColor]];
        [takeOffLabel setTextColor:KSubTitleTextColor];
        [takeOffLabel setFont:KXCAPPUIContentDefautFontSize(12.0f)];
        [takeOffLabel setTextAlignment:NSTextAlignmentLeft];
        self.flightTakeOffAirport = takeOffLabel;
        [self.operationButton addSubview:self.flightTakeOffAirport];
        
        ///到达地点
        UILabel * arrivedLabel= [[UILabel alloc]init];
        [arrivedLabel setBackgroundColor:[UIColor clearColor]];
        [arrivedLabel setTextColor:KSubTitleTextColor];
        [arrivedLabel setFont:KXCAPPUIContentDefautFontSize(12.0f)];
        [arrivedLabel setTextAlignment:NSTextAlignmentRight];
        self.flightArrivedAirport = arrivedLabel;
        [self.operationButton addSubview:self.flightArrivedAirport];
        
        ///说明信息
        UILabel *otherLabel = [[UILabel alloc]init];
        [otherLabel setBackgroundColor:[UIColor clearColor]];
        [otherLabel setTextColor:KFunContentColor];
        [otherLabel setFont:KXCAPPUIContentDefautFontSize(12.0f)];
        [otherLabel setTextAlignment:NSTextAlignmentLeft];
        self.flightOtherContentInfor = otherLabel;
        [self.operationButton addSubview:self.flightOtherContentInfor];
        
        
//        KUnitPriceContentColor
        
        UIView  *separator = [[UIView alloc]init];
        [separator setBackgroundColor:KSepLineColorSetup];
        self.separatorView = separator;
        [self.operationButton addSubview:self.separatorView];
         
    }
    
    return self;
}

- (void)setupFlightHeaderViewDataSource:(FlightInformation *)itemData indexPath:(NSInteger)indexPath{
    
    if (itemData == nil) {
        return;
    }
    
    self.selectedIndexPath = indexPath;
    
    [self.flightTakeOffTime setText:itemData.flightTakeOffTime];
    [self.flightArrivedTime setText:itemData.flightArrivedTime];
    
    [self.flightTakeOffAirport setText:itemData.flightTakeOffAirport];
    [self.flightArrivedAirport setText:itemData.flightArrivedAirport];
    
    
    
    [self.flightMinUnitPrice setText:[NSString stringWithFormat: @"￥%.0lf起",itemData.flightUnitPrice]];
    ///人民币符号￥
    NSRange yuanRange = [self.flightMinUnitPrice.text rangeOfString:@"￥"];
    ///@“起”
    NSRange beginRange=[self.flightMinUnitPrice.text rangeOfString:@"起"];
    
    NSMutableAttributedString *minUnitPriceContent=[[NSMutableAttributedString alloc]initWithString:self.flightMinUnitPrice.text];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(12) range:yuanRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KMarkRecordColor range:yuanRange];
    
    [minUnitPriceContent addAttribute:NSFontAttributeName value:KXCAPPUIContentDefautFontSize(13) range:beginRange];
    [minUnitPriceContent addAttribute:NSForegroundColorAttributeName value:KContentTextColor range:beginRange];
    [self.flightMinUnitPrice setAttributedText:minUnitPriceContent];

    
    NSString *hasBoar = @"无餐食";
    if (itemData.flightProvideBoardBool) {
        hasBoar = @"有餐食";
    }
    NSString *otherContentStr = [NSString stringWithFormat:@"%@|%@|%@",itemData.flightName,itemData.flightModelName,hasBoar];
    [self.flightOtherContentInfor setText:otherContentStr];
    
    
    
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews{
    
    [self.flightTakeOffTime setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                                KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    [self.flightTakeOffAirport setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                   (self.flightTakeOffTime.bottom + KXCUIControlSizeWidth(3.0f)) ,
                                                   KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    
    
    [self.flightArrivedTime setFrame:CGRectMake(KXCUIControlSizeWidth(130.0f),
                                                KInforLeftIntervalWidth, KXCUIControlSizeWidth(100.0f),
                                                KXCUIControlSizeWidth(22.0f))];
    
    [self.flightMinUnitPrice setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - KXCUIControlSizeWidth(100.0f)), KXCUIControlSizeWidth(20.0f), KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(20.0f))];
    
    
    [self.flightArrivedAirport setFrame:CGRectMake((KXCUIControlSizeWidth(130.0f)),
                                                   (self.flightArrivedTime.bottom + KXCUIControlSizeWidth(3.0f)),
                                                   KXCUIControlSizeWidth(100.0f),
                                                   KXCUIControlSizeWidth(20.0f))];
    
    [self.flightOtherContentInfor setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                      (self.flightArrivedAirport.bottom + KXCUIControlSizeWidth(3.0f)),
                                                      (KProjectScreenWidth - KInforLeftIntervalWidth*2), KXCUIControlSizeWidth(20.0f))];
   
    
    [self.separatorView setFrame:CGRectMake(0.0f, (KUITableViewFlightHeaderHeight - 1.0f),
                                            KProjectScreenWidth, 1.0f)];
    
}


- (void)userOperationButtonEventClicked{

    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userSelectedIndexPath:)]) {
            [self.delegate userSelectedIndexPath:self.selectedIndexPath];
        }
    }
    NSLog(@"self.selectedIndexPath is %zi",self.selectedIndexPath);
}

@end
