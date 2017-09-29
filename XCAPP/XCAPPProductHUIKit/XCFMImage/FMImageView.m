//
//  FMImageView.m
//  AiShouAPP
//
//  Created by 张利广 on 15/3/23.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import "FMImageView.h"
#import "ImageContentScrollView.h"
#import "ImageBrowse.h"

@interface FMImageView ()

/*!
 *@breif 大图设置
 */
@property (nonatomic , assign)CGRect                imageFrame;

/*!
 *@breif 保存图片按键
 */
@property (nonatomic , weak)UIButton              *saveImageButton;

/*!
 *@breif 大图设置
 */
@property (nonatomic , assign)CGRect                selectedContentImageViewFrame;

/*!
 *@breif 可滑动视图设置
 */
@property (nonatomic , weak)ImageBrowse            *imageBrowseView;

@property (nonatomic,strong)NSMutableArray         *imageList;          //图片数据FMImage
@property (nonatomic,assign)NSInteger              currentImageIndex;   //当前图片索引
@end

@implementation FMImage
@end

@implementation FMImageView

//夜间模式
-(void)createView
{
    self.userInteractionEnabled=YES;
    
    //_backLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor;
    self.alpha=1;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //为内容图片视图添加单击手势
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *contentImageViewTapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCellLargeContentImage:)];
        [self addGestureRecognizer:contentImageViewTapGestureRecognizer];
    }
    return self;
}

#pragma mark -设置图片服务器图片
- (void)setServerImageWithKey:(NSString *)imageKey
                      isThumb:(Boolean)isThumb
                    holdImage:(UIImage* )holdImage
{
    if (IsStringEmptyOrNull(imageKey)) {
        return;
    }
    FMImage* im = [[FMImage alloc]init];
    //    if (isThumb) {
    //        im.url_thumb = [NSString stringWithFormat:@"%@/get.php?id=%@thumb",kMediaServerURL,imageKey];
    //    }
    //    im.url = [NSString stringWithFormat:@"%@/get.php?id=%@",kMediaServerURL,imageKey];
    im.url = [NSString stringWithString:imageKey];
    if (isThumb) {
        [self setImageWithURL:[NSURL URLWithString:im.url_thumb] placeholderImage:holdImage];
    }else{
        [self setImageWithURL:[NSURL URLWithString:im.url] placeholderImage:holdImage];
    }
    self.currentImageIndex = 0;
    im.isShowLarge = NO;
    self.imageList = [NSMutableArray arrayWithObject:im];
}

#pragma mark - 为放大图片设置图片数据内容
- (void)setImageViewWithURL:(NSString* )imageUrl
                   largeUrl:(NSString *)largeUrl
                  holdImage:(UIImage* )holdImage
{
    if (IsStringEmptyOrNull(imageUrl)) {
        return;
    }
    FMImage* im = [[FMImage alloc]init];
    [self setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:holdImage];
    if (largeUrl) {
        im.url_thumb = imageUrl;
        im.url = largeUrl;
    }else{
        im.url = imageUrl;
    }
    
    im.isShowLarge = NO;
    self.currentImageIndex = 0;
    self.imageList = [NSMutableArray arrayWithObject:im];
}


//index 当前显示图片在相册内的索引
- (void)setAlbum:(NSArray* )imageKeyList currentIndex:(NSInteger)index{
    
    
    if (imageKeyList == nil || index >= [imageKeyList count]) {
        return;
    }
    self.imageList = [NSMutableArray array];
    for (NSString* imageKey in imageKeyList) {
        FMImage* im = [[FMImage alloc]init];
        im.url_thumb = [NSString stringWithString:imageKey];
        index ++;
        im.url = [NSString stringWithString:imageKey];
        im.isShowLarge = NO;
        [self.imageList addObject:im];
        
    }
    self.currentImageIndex = index;
    FMImage* im = [self.imageList objectAtIndex:index-1];
    [self setImageWithURL:[NSURL URLWithString:im.url_thumb]];
    
    [self createView];
}
#pragma mark - 显示服务相册
- (void)setAlbum:(NSArray* )imageKeyList bigImageArray:(NSArray *)bigImageArray currentIndex:(NSInteger)index
{
    if (imageKeyList == nil || index >= [imageKeyList count] || bigImageArray == nil) {
        return;
    }
    self.imageList = [NSMutableArray array];
    
    NSInteger indexBig = 0;
    for (NSString* imageKey in imageKeyList) {
        FMImage* im = [[FMImage alloc]init];
//        im.url_thumb = [NSString stringWithString:[NSString stringWithFormat:@"%@@40p",imageKey]];
        im.url_thumb = [NSString stringWithString:[NSString stringWithFormat:@"%@?imageMogr2/thumbnail/!35p",imageKey]];
//        im.url_thumb = [NSString stringWithString:[NSString stringWithFormat:@"%@",imageKey]];

        im.url = [NSString stringWithString: [bigImageArray objectAtIndex:indexBig]];
        
        indexBig ++;
        im.isShowLarge = NO;
        [self.imageList addObject:im];
        
    }
    self.currentImageIndex = index;
    FMImage* im = [self.imageList objectAtIndex:index];
    [self setImageWithURL:[NSURL URLWithString:im.url_thumb]];
    
    [self createView];
}

- (void) showCellLargeContentImage:(UITapGestureRecognizer *) tapGestureRecognizer{
    
    if (self.clickBlock) {
        self.clickBlock();
    }
    else{
        //获取图片信息
        //可缩放大图
        if (self.image == nil || self.image.size.width < 1) {
            return;
        }
        if ([self.imageList count] < 1) {
            return;
        }
        //设置缩放大图动画前frame
        UIView *parentView = [self superview];
        CGRect contentImageViewFrame = [parentView convertRect:self.frame toView:self.window];
        ImageBrowse* imageBrowseView = [[ImageBrowse alloc] init];
        [imageBrowseView showPhotos:self.imageList srcRect:contentImageViewFrame currentIndex:self.currentImageIndex];
    }
}

@end
