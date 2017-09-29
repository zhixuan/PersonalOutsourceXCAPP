//
//  ImageContentScrollView.h
//  AiShouAPP
//
//  Created by 张利广 on 15/3/23.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadProgressView.h"

@class ImageContentScrollView;

@protocol FMImageViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(ImageContentScrollView *)imageView;
- (void)photoViewSingleTap:(ImageContentScrollView *)imageView;
- (void)photoViewHidden:(ImageContentScrollView *)imageView;
@end

@interface ImageContentScrollView : UIScrollView<UIScrollViewDelegate>
{
    CGRect _srcImageRect;            //缩略图位置
}
@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) LoadProgressView *loadProgressView;
@property (nonatomic,weak)id<FMImageViewDelegate> imageDelegate;

- (void) showInitImage:(NSString*)url srcRect:(CGRect)rect withAnimate:(Boolean)bAnimate;
- (void) startLoadImageWithUrlStr:(NSString *) urlStr;

@end
