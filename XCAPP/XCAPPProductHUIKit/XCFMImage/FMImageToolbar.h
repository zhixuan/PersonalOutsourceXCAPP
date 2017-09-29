//
//  MJPhotoToolbar.h
//  AiShouAPP
//
//  Created by 张利广 on 15/3/23.
//  Copyright (c) 2015年 aishou.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMImageToolbarDelegate <NSObject>
- (void)clickImageSave;
@end

@interface FMImageToolbar : UIView
@property (nonatomic, assign) NSInteger photoCount;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, weak) id<FMImageToolbarDelegate> delegate;
@end
