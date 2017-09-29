//
//  BabyInfo.h
//  XCAPP
//
//  Created by ZhangLiGuang on 17/7/27.
//  Copyright © 2017年 ZhangLiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabyInfo : NSObject


/*!
 * @breif BabyName
 * @See
 */
@property (nonatomic , copy)      NSString          * babyName;

/*!
 * @breif BabyName
 * @See
 */
@property (nonatomic , assign)    BabyGenderStyle   babyGender;

/*!
 * @breif BabyBirthday
 * @See
 */
@property (nonatomic , copy)      NSString          * babyBirthday;

/*!
 * @breif Will BabyBirthday
 * @See
 */
@property (nonatomic , copy)      NSString          * willBabyBirthday;

/*!
 * @breif Will BabyWeight
 * @See
 */
@property (nonatomic , copy)      NSString          * willBabyWeight;

/*!
 * @breif Will BabyLength
 * @See
 */
@property (nonatomic , copy)      NSString          * babyLength;

/*!
 * @breif Will BabyWidth
 * @See
 */
@property (nonatomic , copy)      NSString          * babyWidth;



@end
