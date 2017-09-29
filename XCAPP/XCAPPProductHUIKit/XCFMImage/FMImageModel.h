//
//  FMImageModel.h
//  AiShouAPP
//
//  Created by 张利广 on 15/3/23.
//  Copyright (c) 2015年 aishou.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface FMImageModel : NSObject
@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,copy)   NSString *imageType;

@end
