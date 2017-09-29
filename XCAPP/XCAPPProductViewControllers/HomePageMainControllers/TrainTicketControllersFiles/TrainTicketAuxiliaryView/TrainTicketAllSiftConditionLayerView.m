//
//  TrainTicketAllSiftConditionLayerView.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/9/26.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "TrainTicketAllSiftConditionLayerView.h"


#define KBtnForSeatButtonBaseTag        (1350211)
#define KBtnForTrainNumberBaseTag       (1350411)
#define KBtnForBeginStationBaseTag      (1350611)
#define KBtnForEndStationBaseTag        (1350811)


#define KBtnForReplaceButtonTag         (1820111)
#define KBtnForDoneButtonTag            (1820112)
//#define KBtnFor

@interface TrainTicketAllSiftConditionLayerView ()

/*!
 * @breif 坐席信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray      *selectedSeatArray;

/*!
 * @breif 车次信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray      *selectedTrainNumberArray;

/*!
 * @breif 出发站信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray      *selectedBeginStationArray;

/*!
 * @breif 到达站信息
 * @See
 */
@property (nonatomic , strong)      NSMutableArray      *selectedEndStationArray;


/*!
 * @breif 坐席信息选中标志信息
 * @See
 */
@property (nonatomic , assign)      NSInteger           userSelectedSeatButtonTag;

/*!
 * @breif 车次信息选中标志信息
 * @See
 */
@property (nonatomic , assign)      NSInteger           userSelectedTrainNumberButtonTag;

/*!
 * @breif 出发站信息选中标志信息
 * @See
 */
@property (nonatomic , assign)      NSInteger           userSelectedBeginStationButtonTag;

/*!
 * @breif 到达站信息选中标志信息
 * @See
 */
@property (nonatomic , assign)      NSInteger           userSelectedEndStationButtonTag;

/*!
 * @breif 界面中可变化的数据信息
 * @See
 */
@property (nonatomic , weak)      UIView                *userBackGroundWhiteView;

/*!
 * @breif 坐席类型
 * @See
 */
@property (nonatomic , strong)      NSString            *seatTypeStr;

/*!
 * @breif 火车票类型
 * @See
 */
@property (nonatomic , strong)      NSString            *trainTypeStr;
/*!
 * @breif 出发站站筛选
 * @See
 */
@property (nonatomic , strong)      NSString            *filterFromStr;
/*!
 * @breif 终点站筛选
 * @See
 */
@property (nonatomic , strong)      NSString            *filterToStr;

/*!
 * @breif 界面是否被初始化一次
 * @See
 */
@property (nonatomic , assign)      BOOL                isRloadBool;

@end

@implementation TrainTicketAllSiftConditionLayerView

- (id)initWithFrame:(CGRect)frame withSeatArray:(NSArray *)seatArray trainNumber:(NSArray *)trainNumberArray beginArray:(NSArray *)beginArray endArray:(NSArray *)endArray{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:KLayerViewBackGroundColor];

        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:KLayerViewBackGroundColor];
        
        self.seatTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
        self.trainTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
        self.filterFromStr = [[NSString alloc]initWithFormat:@"%@",@""];
        self.filterToStr = [[NSString alloc]initWithFormat:@"%@",@""];
        
        self.userSelectedSeatButtonTag = KBtnForSeatButtonBaseTag;
        self.userSelectedEndStationButtonTag = KBtnForEndStationBaseTag;
        self.userSelectedTrainNumberButtonTag = KBtnForTrainNumberBaseTag;
        self.userSelectedBeginStationButtonTag = KBtnForBeginStationBaseTag;
        
        UIView *whiteBackGroudView = [[UIView alloc]init];
        [whiteBackGroudView setBackgroundColor:[UIColor whiteColor]];
        [whiteBackGroudView setFrame:CGRectMake(0.0f, KXCUIControlSizeWidth(50.0f), KProjectScreenWidth, KXCUIControlSizeWidth(260.0f))];
        self.userBackGroundWhiteView = whiteBackGroudView;
        [self addSubview:self.userBackGroundWhiteView ];
        
        self.isRloadBool = YES;

    }
    return self;
}


//- (void)setupTrainTicketAllSiftConditionLayerViewFrame{
//    
//}

- (void)setupFrameWithSeatArray:(NSArray *)seatArray trainNumber:(NSArray *)trainNumberArray beginArray:(NSArray *)beginArray endArray:(NSArray *)endArray{
    self.selectedSeatArray = [[NSMutableArray alloc]initWithObjects:@{@"display":@"不限",
                                                                      @"key":@"不限"},nil];
    [self.selectedSeatArray addObjectsFromArray:seatArray];
    
    self.selectedEndStationArray = [[NSMutableArray alloc]initWithObjects:@{@"display":@"不限",
                                                                            @"key":@"不限"},nil];
    [self.selectedEndStationArray addObjectsFromArray:endArray];
    
    self.selectedTrainNumberArray = [[NSMutableArray alloc]initWithObjects:@{@"display":@"不限",
                                                                             @"key":@"不限"},nil];
    [self.selectedTrainNumberArray addObjectsFromArray:trainNumberArray];
    
    
    self.selectedBeginStationArray = [[NSMutableArray alloc]initWithObjects:@{@"display":@"不限",
                                                                              @"key":@"不限"},nil];
    [self.selectedBeginStationArray addObjectsFromArray:beginArray];
    
    if (self.isRloadBool) {
         [self setupTrainTicketAllSiftConditionLayerViewFrame];
    }
   
}


- (void)userReplaceBtnOperationClickedEvent{
    
    CGRect layerViewRect = CGRectMake(0.0f, KProjectScreenHeight, KProjectScreenWidth, KProjectScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:layerViewRect];
    }];
}

- (void)setupTrainTicketAllSiftConditionLayerViewFrame{
    
    self.isRloadBool = NO;

    ///重置按键
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetButton setBackgroundColor:[UIColor clearColor]];
    [resetButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [resetButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [resetButton setTitleColor:HUIRGBColor(93.0f, 93.0f, 93.0f, 1.0f) forState:UIControlStateHighlighted];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                      forState:UIControlStateNormal];
    [resetButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                           forState:UIControlStateHighlighted];
    [resetButton setTag:KBtnForReplaceButtonTag];
    [resetButton addTarget:self action:@selector(userOperationButtonForLeftRightButtonEvent:)
     forControlEvents:UIControlEventTouchUpInside];
    [resetButton setFrame:CGRectMake(KInforLeftIntervalWidth, KXCUIControlSizeWidth(5.0f),
                                     KXCUIControlSizeWidth(40.0), KXCUIControlSizeWidth(40.0))];
    [self.userBackGroundWhiteView addSubview:resetButton];

    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:[UIColor clearColor]];
    [doneButton.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [doneButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [doneButton setTitleColor:HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f)
                         forState:UIControlStateNormal];
    [doneButton setTitleColor:HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f)
                         forState:UIControlStateHighlighted];
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                           forState:UIControlStateNormal];
    [doneButton setBackgroundImage:createImageWithColor([UIColor clearColor])
                           forState:UIControlStateHighlighted];
    [doneButton setTag:KBtnForDoneButtonTag];
    [doneButton addTarget:self action:@selector(userOperationButtonForLeftRightButtonEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [doneButton setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - KXCUIControlSizeWidth(40.0f)),
                                    KXCUIControlSizeWidth(5.0f), KXCUIControlSizeWidth(40.0),
                                    KXCUIControlSizeWidth(40.0))];
    [self.userBackGroundWhiteView addSubview:doneButton];
    
    UIView *separatorForBtnView = [[UIView alloc]init];
    [separatorForBtnView setBackgroundColor:KSepLineColorSetup];
    [separatorForBtnView setFrame:CGRectMake(0.0f, (doneButton.bottom + KXCUIControlSizeWidth(5.0f)),
                                             KProjectScreenWidth, 1.0f)];
    [self.userBackGroundWhiteView addSubview:separatorForBtnView];
    
    
    UILabel *seatTitleLabel = [[UILabel alloc]init];
    [seatTitleLabel setBackgroundColor:[UIColor clearColor]];
    [seatTitleLabel setTextColor:KContentTextColor];
    [seatTitleLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [seatTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [seatTitleLabel setText:@"坐席"];
    [seatTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth*1.5,
                                        (separatorForBtnView.bottom+ KInforLeftIntervalWidth),
                                        KXCUIControlSizeWidth(80.0f), KXCUIControlSizeWidth(18.0f))];
    [self.userBackGroundWhiteView addSubview:seatTitleLabel];

    
    

    CGFloat beginY = seatTitleLabel.bottom + KXCUIControlSizeWidth(10.0f);
    CGFloat beginX = KInforLeftIntervalWidth*2;
    CGFloat btnIntervalWidth = KXCUIControlSizeWidth(20.0f);
    CGFloat btnWidth = (KProjectScreenWidth - KInforLeftIntervalWidth*4 - 2*btnIntervalWidth)/3;
    CGFloat btnHeight = KXCUIControlSizeWidth(32.0f);
    int totalloc=3;
    NSInteger dataCount = self.selectedSeatArray.count;
    for (int index=0; index<dataCount; index++) {
        int row=index/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=index%totalloc;//列号
        CGFloat appviewx=beginX+(btnWidth + btnIntervalWidth)*loc;
        CGFloat appviewy=(beginY)+(btnHeight + KXCUIControlSizeWidth(10.0f))*row;
        
        
        NSDictionary *dataDic = (NSDictionary *)[self.selectedSeatArray objectAtIndex:index];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(15.0f)];
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setTitle:StringForKeyInUnserializedJSONDic(dataDic, @"display") forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setTag:(KBtnForSeatButtonBaseTag + index)];
        [button addTarget:self action:@selector(userOperationSelectedSeatButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(appviewx,appviewy, btnWidth,btnHeight)];
        [button.layer setBorderColor:KTableViewCellSelectedColor.CGColor];
        [button.layer setBorderWidth:1.0f];
        [button.layer setCornerRadius:4.0f];
        [button.layer setMasksToBounds:YES];
        [self.userBackGroundWhiteView addSubview:button];
        
        if (index == 0 ) {
            [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
    }
    
    
    NSInteger remainderInteger =(dataCount%totalloc==0)? 0:1;
    
    beginY = (beginY)+ (((btnHeight + KXCUIControlSizeWidth(10.0f)))*(remainderInteger+dataCount/totalloc)) + KInforLeftIntervalWidth - KXCUIControlSizeWidth(10.0f);
    
    
    UIView *separatorForNumberView = [[UIView alloc]init];
    [separatorForNumberView setBackgroundColor:KSepLineColorSetup];
    [separatorForNumberView setFrame:CGRectMake(0.0f, (beginY +  KInforLeftIntervalWidth),
                                                KProjectScreenWidth, 1.0f)];
    [self.userBackGroundWhiteView addSubview:separatorForNumberView];
    
    UILabel *numberlTitleLabel = [[UILabel alloc]init];
    [numberlTitleLabel setBackgroundColor:[UIColor clearColor]];
    [numberlTitleLabel setTextColor:KContentTextColor];
    [numberlTitleLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [numberlTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [numberlTitleLabel setText:@"车次"];
    [numberlTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth*1.5,
                                        (separatorForNumberView.bottom +KInforLeftIntervalWidth),
                                        KXCUIControlSizeWidth(80.0f), KXCUIControlSizeWidth(18.0f))];
    [self.userBackGroundWhiteView addSubview:numberlTitleLabel];

    beginY = numberlTitleLabel.bottom + KXCUIControlSizeWidth(10.0f);
    
    dataCount = self.selectedTrainNumberArray.count;
    for (int index=0; index<dataCount; index++) {
        int row=index/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=index%totalloc;//列号
        CGFloat appviewx=beginX+(btnWidth + btnIntervalWidth)*loc;
        CGFloat appviewy=(beginY)+(btnHeight + KXCUIControlSizeWidth(10.0f))*row;
        
        NSDictionary *dataDic = (NSDictionary *)[self.selectedTrainNumberArray objectAtIndex:index];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(15.0f)];
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setTitle:StringForKeyInUnserializedJSONDic(dataDic, @"display") forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setTag:(KBtnForTrainNumberBaseTag + index)];
        [button addTarget:self action:@selector(userOperationSelectedTrainNumberButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(appviewx,appviewy, btnWidth,btnHeight)];
        [button.layer setBorderColor:KTableViewCellSelectedColor.CGColor];
        [button.layer setBorderWidth:1.0f];
        [button.layer setCornerRadius:4.0f];
        [button.layer setMasksToBounds:YES];
        [self.userBackGroundWhiteView addSubview:button];
        
        if (index == 0 ) {
            [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
    }
    
    remainderInteger =(dataCount%totalloc==0)? 0:1;
    
    beginY = (beginY)+ (((btnHeight + KXCUIControlSizeWidth(10.0f)))*(remainderInteger+dataCount/totalloc)) + KInforLeftIntervalWidth - KXCUIControlSizeWidth(10.0f);
    
    
    UIView *separatorForBeginView = [[UIView alloc]init];
    [separatorForBeginView setBackgroundColor:KSepLineColorSetup];
    [separatorForBeginView setFrame:CGRectMake(0.0f, (beginY +  KInforLeftIntervalWidth ),
                                               KProjectScreenWidth, 1.0f)];
    [self.userBackGroundWhiteView addSubview:separatorForBeginView];
    
    UILabel *beginTitleLabel = [[UILabel alloc]init];
    [beginTitleLabel setBackgroundColor:[UIColor clearColor]];
    [beginTitleLabel setTextColor:KContentTextColor];
    [beginTitleLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [beginTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [beginTitleLabel setText:@"出发车站"];
    [beginTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth*1.5,
                                           separatorForBeginView.bottom + KInforLeftIntervalWidth,
                                           KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(18.0f))];
    [self.userBackGroundWhiteView addSubview:beginTitleLabel];

    beginY = beginTitleLabel.bottom + KXCUIControlSizeWidth(10.0f);
    dataCount = self.selectedBeginStationArray.count;
    for (int index=0; index<dataCount; index++) {
        int row=index/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=index%totalloc;//列号
        CGFloat appviewx=beginX+(btnWidth + btnIntervalWidth)*loc;
        CGFloat appviewy=(beginY)+(btnHeight + KXCUIControlSizeWidth(10.0f))*row;
        
        
        NSDictionary *dataDic = (NSDictionary *)[self.selectedBeginStationArray objectAtIndex:index];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(15.0f)];
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setTitle:StringForKeyInUnserializedJSONDic(dataDic, @"display") forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setTag:(KBtnForBeginStationBaseTag + index)];
        [button addTarget:self action:@selector(userOperationSelectedBeginStationButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(appviewx,appviewy, btnWidth,btnHeight)];
        [button.layer setBorderColor:KTableViewCellSelectedColor.CGColor];
        [button.layer setBorderWidth:1.0f];
        [button.layer setCornerRadius:4.0f];
        [button.layer setMasksToBounds:YES];
        [self.userBackGroundWhiteView addSubview:button];
        
        if (index == 0 ) {
            [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
    }
    remainderInteger =(dataCount%totalloc==0)? 0:1;
    
    beginY = (beginY)+ (((btnHeight + KXCUIControlSizeWidth(10.0f)))*(remainderInteger+dataCount/totalloc)) + KInforLeftIntervalWidth - KXCUIControlSizeWidth(10.0f);
    
    
    UIView *separatorForEndView = [[UIView alloc]init];
    [separatorForEndView setBackgroundColor:KSepLineColorSetup];
    [separatorForEndView setFrame:CGRectMake(0.0f, (beginY +  KInforLeftIntervalWidth),
                                               KProjectScreenWidth, 1.0f)];
    [self.userBackGroundWhiteView addSubview:separatorForEndView];
    
    UILabel *endTitleLabel = [[UILabel alloc]init];
    [endTitleLabel setBackgroundColor:[UIColor clearColor]];
    [endTitleLabel setTextColor:KContentTextColor];
    [endTitleLabel setFont:KXCAPPUIContentDefautFontSize(16.0f)];
    [endTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [endTitleLabel setText:@"到达车站"];
    [endTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth*1.5,
                                         separatorForEndView.bottom + KInforLeftIntervalWidth,
                                         KXCUIControlSizeWidth(100.0f), KXCUIControlSizeWidth(18.0f))];
    [self.userBackGroundWhiteView addSubview:endTitleLabel];
    
    
    beginY = endTitleLabel.bottom + KXCUIControlSizeWidth(10.0f);
    dataCount = self.selectedEndStationArray.count;
    for (int index=0; index<dataCount; index++) {
        int row=index/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=index%totalloc;//列号
        CGFloat appviewx=beginX+(btnWidth + btnIntervalWidth)*loc;
        CGFloat appviewy=(beginY)+(btnHeight + KXCUIControlSizeWidth(10.0f))*row;
        
        
        NSDictionary *dataDic = (NSDictionary *)[self.selectedEndStationArray objectAtIndex:index];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:KXCAPPUIContentFontSize(15.0f)];
        [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
        [button setTitle:StringForKeyInUnserializedJSONDic(dataDic, @"display") forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                          forState:UIControlStateNormal];
        [button setTag:(KBtnForEndStationBaseTag + index)];
        [button addTarget:self action:@selector(userOperationSelectedEndStationButtonEvent:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                          forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(appviewx,appviewy, btnWidth,btnHeight)];
        [button.layer setBorderColor:KTableViewCellSelectedColor.CGColor];
        [button.layer setBorderWidth:1.0f];
        [button.layer setCornerRadius:4.0f];
        [button.layer setMasksToBounds:YES];
        [self.userBackGroundWhiteView addSubview:button];
        
        if (index == 0 ) {
            [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                              forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
    }

    beginY = (beginY)+(dataCount%3 ==0 ? 0:btnHeight + KXCUIControlSizeWidth(10.0f))*(dataCount/3) + KInforLeftIntervalWidth;
    
    
    CGFloat contentAllHeightFloat = beginY + btnHeight;
    
    [self.userBackGroundWhiteView setFrame:CGRectMake(0.0f, (self.height - contentAllHeightFloat), KProjectScreenWidth, contentAllHeightFloat)];
//    [self.userBackGroundWhiteView setHeight:beginY + btnHeight];
//    [self.userBackGroundWhiteView setTop:(self.height - self.userBackGroundWhiteView.top)];

    
}



- (void)userOperationSelectedSeatButtonEvent:(UIButton *)button{
    
    if (button.tag == self.userSelectedSeatButtonTag) {
        return;
    }
    
    ///将现在的更改为选中状态
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    ///将原先的设置为未选中状态
    UIButton *beforBtn = (UIButton *)[self viewWithTag:self.userSelectedSeatButtonTag];
    
    [beforBtn setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                      forState:UIControlStateNormal];
    [beforBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    
    ///取出数据
    NSDictionary *dataDic = (NSDictionary *)[self.selectedSeatArray objectAtIndex:(button.tag - KBtnForSeatButtonBaseTag)];
    
    NSString *titleStr = StringForKeyInUnserializedJSONDic(dataDic, @"key");
    self.seatTypeStr = titleStr;
    if ([titleStr isEqualToString:@"不限"]) {
        self.seatTypeStr = @"";
    }
    
    self.userSelectedSeatButtonTag = button.tag;
    
    NSLog(@"seatTypeStr is %@",self.seatTypeStr);
}


/**
 #define KBtnForSeatButtonBaseTag        (1350211)
 #define KBtnForTrainNumberBaseTag       (1350411)
 #define KBtnForBeginStationBaseTag      (1350611)
 #define KBtnForEndStationBaseTag        (1350811)
 **/
- (void)userOperationSelectedTrainNumberButtonEvent:(UIButton *)button{
    
    if (button.tag == self.userSelectedTrainNumberButtonTag) {
        return;
    }
    
    ///将现在的更改为选中状态
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    ///将原先的设置为未选中状态
    UIButton *beforBtn = (UIButton *)[self viewWithTag:self.userSelectedTrainNumberButtonTag];
    
    [beforBtn setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                        forState:UIControlStateNormal];
    [beforBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    
    ///取出数据
    NSDictionary *dataDic = (NSDictionary *)[self.selectedTrainNumberArray objectAtIndex:(button.tag - KBtnForTrainNumberBaseTag)];
    
    NSString *titleStr = StringForKeyInUnserializedJSONDic(dataDic, @"key");
    self.trainTypeStr = titleStr;
    if ([titleStr isEqualToString:@"不限"]) {
        self.trainTypeStr = @"";
    }
    
    self.userSelectedTrainNumberButtonTag = button.tag ;
    
    
    NSLog(@"trainTypeStr is %@",self.trainTypeStr);
}

- (void)userOperationSelectedBeginStationButtonEvent:(UIButton *)button{
    
    if (button.tag == self.userSelectedBeginStationButtonTag) {
        return;
    }
    
    ///将现在的更改为选中状态
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    ///将原先的设置为未选中状态
    UIButton *beforBtn = (UIButton *)[self viewWithTag:self.userSelectedBeginStationButtonTag];
    [beforBtn setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                        forState:UIControlStateNormal];
    [beforBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    
    ///取出数据
    NSDictionary *dataDic = (NSDictionary *)[self.selectedBeginStationArray objectAtIndex:(button.tag - KBtnForBeginStationBaseTag)];
    
    NSString *titleStr = StringForKeyInUnserializedJSONDic(dataDic, @"key");
    self.filterFromStr = titleStr;
    if ([titleStr isEqualToString:@"不限"]) {
        self.filterFromStr = @"";
    }
    
    self.userSelectedBeginStationButtonTag = button.tag ;
    
    
    NSLog(@"filterFromStr is %@",self.filterFromStr);
}

- (void)userOperationSelectedEndStationButtonEvent:(UIButton *)button{
    
    if (button.tag == self.userSelectedEndStationButtonTag) {
        return;
    }
    
    ///将现在的更改为选中状态
    [button setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                      forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    ///将原先的设置为未选中状态
    UIButton *beforBtn = (UIButton *)[self viewWithTag:self.userSelectedEndStationButtonTag];
    [beforBtn setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                        forState:UIControlStateNormal];
    [beforBtn setTitleColor:KContentTextColor forState:UIControlStateNormal];
    
    ///取出数据
    NSDictionary *dataDic = (NSDictionary *)[self.selectedEndStationArray objectAtIndex:(button.tag - KBtnForEndStationBaseTag)];
    
    NSString *titleStr = StringForKeyInUnserializedJSONDic(dataDic, @"key");
    self.filterToStr = titleStr;
    if ([titleStr isEqualToString:@"不限"]) {
        self.filterToStr = @"";
    }
    
    
    self.userSelectedEndStationButtonTag = button.tag ;
    
    
    NSLog(@"filterToStr is %@",self.filterToStr);
}



- (void)userOperationButtonForLeftRightButtonEvent:(UIButton *)button{
    
    
    if (button.tag == KBtnForReplaceButtonTag) {
        
        
        ////----坐席
        if (self.userSelectedSeatButtonTag != KBtnForSeatButtonBaseTag) {
            
            ///将现在的更改为选中状态
            UIButton *defautbuttonSeat = (UIButton *)[self viewWithTag:KBtnForSeatButtonBaseTag];
            [defautbuttonSeat setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                                        forState:UIControlStateNormal];
            [defautbuttonSeat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            ///将原先的设置为未选中状态
            UIButton *beforBtnSeat = (UIButton *)[self viewWithTag:self.userSelectedSeatButtonTag];
            [beforBtnSeat setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                                    forState:UIControlStateNormal];
            [beforBtnSeat setTitleColor:KContentTextColor forState:UIControlStateNormal];
        }
       
        
        ////----车次
        if (self.userSelectedTrainNumberButtonTag != KBtnForTrainNumberBaseTag) {
            ///将现在的更改为选中状态
            UIButton *defautbuttonNumber = (UIButton *)[self viewWithTag:KBtnForTrainNumberBaseTag];
            [defautbuttonNumber setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                                          forState:UIControlStateNormal];
            [defautbuttonNumber setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            ///将原先的设置为未选中状态
            UIButton *beforBtnNumber = (UIButton *)[self viewWithTag:self.userSelectedTrainNumberButtonTag];
            [beforBtnNumber setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                                      forState:UIControlStateNormal];
            [beforBtnNumber setTitleColor:KContentTextColor forState:UIControlStateNormal];
        }
        
        
        
        
        
        ////----出发位置
        if (self.userSelectedBeginStationButtonTag != KBtnForBeginStationBaseTag) {
            ///将现在的更改为选中状态
            UIButton *defautbuttonBegin = (UIButton *)[self viewWithTag:KBtnForBeginStationBaseTag];
            [defautbuttonBegin setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                                         forState:UIControlStateNormal];
            [defautbuttonBegin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            ///将原先的设置为未选中状态
            UIButton *beforBtnBegin = (UIButton *)[self viewWithTag:self.userSelectedBeginStationButtonTag];
            [beforBtnBegin setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                                     forState:UIControlStateNormal];
            [beforBtnBegin setTitleColor:KContentTextColor forState:UIControlStateNormal];
        }
       
        
        ///----到达位置
        if (KBtnForEndStationBaseTag != self.userSelectedEndStationButtonTag) {
            ///将现在的更改为选中状态
            UIButton *defautbuttonEnd = (UIButton *)[self viewWithTag:KBtnForEndStationBaseTag];
            [defautbuttonEnd setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                                       forState:UIControlStateNormal];
            [defautbuttonEnd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            ///将原先的设置为未选中状态
            UIButton *beforBtnEnd = (UIButton *)[self viewWithTag:self.userSelectedEndStationButtonTag];
            [beforBtnEnd setBackgroundImage:createImageWithColor(HUIRGBColor(248.0f, 248.0f, 248.0f, 1.0f))
                                   forState:UIControlStateNormal];
            [beforBtnEnd setTitleColor:KContentTextColor forState:UIControlStateNormal];
        }
        
        
        self.seatTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
        self.trainTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
        self.filterFromStr = [[NSString alloc]initWithFormat:@"%@",@""];
        self.filterToStr = [[NSString alloc]initWithFormat:@"%@",@""];
        

        self.userSelectedSeatButtonTag = KBtnForSeatButtonBaseTag;
        self.userSelectedEndStationButtonTag = KBtnForEndStationBaseTag;
        self.userSelectedTrainNumberButtonTag = KBtnForTrainNumberBaseTag;
        self.userSelectedBeginStationButtonTag = KBtnForBeginStationBaseTag;
    }
    
    else if (KBtnForDoneButtonTag ==button.tag){
        if (self.delegate ) {
            if ([self.delegate respondsToSelector:@selector(userSelectedConditionWithSeat:trainNumber:beginStatuse:endStatuse:)]) {
                [self.delegate userSelectedConditionWithSeat:self.seatTypeStr trainNumber:self.trainTypeStr beginStatuse:self.filterFromStr endStatuse:self.filterToStr ];
                
                [self userReplaceBtnOperationClickedEvent];
            }
        }
    }
}
@end
