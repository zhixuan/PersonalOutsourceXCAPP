//
//  FlightAccurateSiftController.m
//  XCAPP
//
//  Created by ZhangLiGuang on 16/8/16.
//  Copyright © 2016年 ZhangLiGuang. All rights reserved.
//

#import "FlightAccurateSiftController.h"
#import "RTArealocationView.h"

#define KBtnForDoneButtonTag            (1860113)
@interface FlightAccurateSiftController ()<ArealocationViewDelegate>

/*!
 * @breif 数据视图
 * @See
 */
@property (nonatomic , strong) RTArealocationView *arealocationView;
/*!
 * @breif 数据视图
 * @See
 */
@property (nonatomic, strong) NSArray *allDataSource;

/*!
 * @breif 起飞时间
 * @See
 */
@property (nonatomic , strong)      NSString            *flightTakeOffDateStr;

/*!
 * @breif 机型信息
 * @See
 */
@property (nonatomic , strong)      NSString            *flightTypeStr;

/*!
 * @breif 舱位信息
 * @See
 */
@property (nonatomic , strong)      NSString            *flightCabinStr;

/*!
 * @breif 公司信息
 * @See
 */
@property (nonatomic , strong)      NSString            *flightCompanyStr;
@end

@implementation FlightAccurateSiftController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNavTitle:@"筛选"];
    [self setLeftNavButtonTitleStr:@"取消" withFrame:kNavBarButtonRect actionTarget:self action:@selector(setleftBarButtonEvent)];
    NSString *titleStr = @"恢复默认";
    CGSize titleSize = [titleStr sizeWithFont:KXCAPPUIContentFontSize(16.0f) ];
    [self setRightNavButtonTitleStr:titleStr withFrame:CGRectMake(0, 0.0f, titleSize.width, 44.0f)
                       actionTarget:self action:@selector(rightButtonOperationEvent)];
    
    self.flightTakeOffDateStr = [[NSString alloc]initWithFormat:@"%@",@""];
    self.flightTypeStr = [[NSString alloc]initWithFormat:@"%@",@""];
    self.flightCabinStr= [[NSString alloc]initWithFormat:@"%@",@""];
    self.flightCompanyStr = [[NSString alloc]initWithFormat:@"%@",@""];
    [self setupFlightAccurateSiftControllerFrame];
    
    
    
    
    
    NSArray *meunContent1Array = @[@"不限",
                                  @"凌晨 00:00 - 06:00",
                                  @"上午 06:00 - 12:00",
                                  @"下午 12:00 - 18:00",
                                  @"夜间 18:00 - 24:00",];
    
    NSArray *meunContent2Array = @[@"不限",
                                   @"中",
                                   @"大",];
    
    NSArray *meunContent3Array = @[@"不限",
                                   @"经济舱",
                                   @"公务/头等舱",];
    
    NSArray *meunContent4Array = @[@"不限",
                                   @"联行",
                                   @"吉祥",
                                   @"南航",
                                   @"海航",
                                   @"国航",
                                   @"东航",
                                   @"上航",
                                   @"厦航",];
    
    NSDictionary *meunTitle1Dic = @{@"title":@"起飞时间",@"content":meunContent1Array};
    NSDictionary *meunTitle2Dic = @{@"title":@"机型",@"content":meunContent2Array};
    NSDictionary *meunTitle3Dic = @{@"title":@"舱位",@"content":meunContent3Array};
    NSDictionary *meunTitle4Dic = @{@"title":@"航空公司",@"content":meunContent4Array};
    

    self.allDataSource = @[meunTitle1Dic,meunTitle2Dic,meunTitle3Dic,meunTitle4Dic];
    
    self.arealocationView = [[RTArealocationView alloc] initWithFrame:self.view.bounds withMenuIntger:2];
    [self.arealocationView setHeight:48*9];
    self.arealocationView.delegate = self;
    
    // 初始化选择的cell
    NSInteger select[2] = {0,0,};
    [self.arealocationView selectRowWithSelectedIndex:select];
    
    // 显示 menu
    [self.arealocationView showArealocationInView:self.view];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(250.0f, 145.0f, 30.0f, 1.0f))
                         forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:createImageWithColor(HUIRGBColor(220.0f, 115.0f, 00.0f, 1.0f))
                         forState:UIControlStateHighlighted];
    [searchBtn.titleLabel setFont:KXCAPPUIContentFontSize(16.0f)];
    [searchBtn setTag:KBtnForDoneButtonTag];
    [searchBtn setTitle:@"确定" forState:UIControlStateNormal];
    [searchBtn.layer setCornerRadius:5.0f];
    [searchBtn addTarget:self action:@selector(userDoneButtonClickedEvent)
        forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setMasksToBounds:YES];
    [searchBtn setFrame:CGRectMake(KInforLeftIntervalWidth,
                                   (self.arealocationView.bottom + KXCUIControlSizeWidth(28.0f)),
                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                   KFunctionModulButtonHeight)];
    [self.view addSubview:searchBtn];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setleftBarButtonEvent{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)rightButtonOperationEvent{
    
    
    NSInteger select[2] = {0,0,};
    [self.arealocationView selectRowWithSelectedIndex:select];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userSelectedSiftInforStartDate:type:cabin:company:)]) {
            [self.delegate userSelectedSiftInforStartDate:@"" type:@"" cabin:@"" company:@""];
        }
    }
    
    [self setleftBarButtonEvent];
}


- (void)userDoneButtonClickedEvent{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userSelectedSiftInforStartDate:type:cabin:company:)]) {
            [self.delegate userSelectedSiftInforStartDate:self.flightTakeOffDateStr
                                                     type:self.flightTypeStr
                                                    cabin:self.flightCabinStr
                                                  company:self.flightCompanyStr];
        }
    }
    
    [self setleftBarButtonEvent];
}
- (void)setupFlightAccurateSiftControllerFrame{
    
}
/**
 *  每一级要展示的数量
 *
 *  @param arealocationView arealocationView
 *  @param level            层级
 *  @param index            cell索引
 *  @param selectedIndex    所有选中的索引数组
 *
 *  @return 展示的数量
 */
- (NSInteger)arealocationView:(RTArealocationView *)arealocationView countForClassAtLevel:(NSInteger)level index:(NSInteger)index selectedIndex:(NSInteger *)selectedIndex {
    
    
    NSInteger countFor= 0;
    
    if (level==0) {
        
        return 4;
        
    }
    else if (level==1) {
        
        NSDictionary *dict = self.allDataSource[index];
        
        NSArray *comArr = dict[@"content"];
        
        countFor =  comArr.count;
        
    }else if (level==2) {
        
        NSDictionary *dict = self.allDataSource[index];
        
        NSArray *comArr = dict[@"content"];
        
        countFor =  comArr.count;
        
    }
    
    return countFor;
}



/**
 *  cell的标题
 *
 *  @param arealocationView arealocationView
 *  @param level            层级
 *  @param index            cell索引
 *  @param selectedIndex    所有选中的索引数组
 *
 *  @return cell的标题
 */
- (NSString *)arealocationView:(RTArealocationView *)arealocationView titleForClass:(NSInteger)level index:(NSInteger)index selectedIndex:(NSInteger *)selectedIndex {
    
    if (level==0) {
        
        NSDictionary *dict = self.allDataSource[index];
        
        return dict[@"title"];
    }
    
    else if (level==1) {
        
        NSDictionary *dict = self.allDataSource[selectedIndex[0]];
        
        NSArray *comArr = dict[@"content"];
        
        return comArr[index];

    }else if (level==2) {
        
        NSDictionary *dict = self.allDataSource[selectedIndex[1]];
        
        NSArray *comArr = dict[@"content"];
        
        return comArr[index];
        
    }else {
        
       return @"m";
    }
    
}


/**
 *  选取完毕执行的方法
 *
 *  @param arealocationView arealocationView
 *  @param selectedIndex           每一层选取结果的数组
 */
- (void)arealocationView:(RTArealocationView *)arealocationView finishChooseLocationAtIndexs:(NSInteger *)selectedIndex{
    
    NSDictionary *dict = self.allDataSource[selectedIndex[0]];
    NSArray *content = dict[@"content"];
    
//    NSLog(@"第一列 第%ld个，第二列 第%ld个",selectedIndex[0],selectedIndex[1]);
//    NSLog(@"\n%@ :%@",dict[@"title"],content[selectedIndex[1]]);
    
    if (selectedIndex[0] == 0) {
        
        self.flightTakeOffDateStr = [NSString stringWithFormat:@"%@",content[selectedIndex[1]]];
    }
    
    else if(selectedIndex[0] == 1){
        self.flightTypeStr = [NSString stringWithFormat:@"%@",content[selectedIndex[1]]];
    }
    
    else if(selectedIndex[0] == 2){
        self.flightCabinStr= [NSString stringWithFormat:@"%@",content[selectedIndex[1]]];
    }
    
    else if(selectedIndex[0] == 3){
        self.flightCompanyStr = [NSString stringWithFormat:@"%@",content[selectedIndex[1]]];
    }

}

@end
