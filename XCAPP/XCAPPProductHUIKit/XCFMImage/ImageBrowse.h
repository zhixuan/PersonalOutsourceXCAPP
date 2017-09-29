//
//  ImageBrowse.h
//  AiShouAPP
//
//  Created by 张利广 on 15/3/23.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMImageView.h"


@interface ImageBrowse : UIViewController 

//显示相册
//images            FMImage
//rect              原图在window中的位置
//currentIndex      初始显示相片索引
- (void)showPhotos:(NSArray* )images srcRect:(CGRect)rect currentIndex:(NSInteger)currentIndex;
@end
