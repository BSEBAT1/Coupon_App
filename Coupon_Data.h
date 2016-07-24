//
//  Coupon_Data.h
//  CouponME!
//
//  Created by macbook pro on 7/23/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Coupon_Data : NSManagedObject
@property (nullable, nonatomic, retain) NSString *product;
@property (nullable, nonatomic, retain) NSDate *exp_date;
@property (nullable, nonatomic, retain) NSString *disclaimer;
@property (nullable, nonatomic, retain) NSDecimalNumber *value;
@property (nullable, nonatomic, retain) NSNumber *quantity;
@property (nullable, nonatomic, retain) NSString *img_location;
@property (nullable, nonatomic, retain) NSString *stores;
@end

NS_ASSUME_NONNULL_END

#import "Coupon_Data+CoreDataProperties.h"
