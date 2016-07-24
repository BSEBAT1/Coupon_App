//
//  Coupon_Data+CoreDataProperties.h
//  CouponME!
//
//  Created by macbook pro on 7/23/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Coupon_Data.h"

NS_ASSUME_NONNULL_BEGIN

@interface Coupon_Data (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *product;
@property (nullable, nonatomic, retain) NSDate *exp_date;
@property (nullable, nonatomic, retain) NSString *disclaimer;
@property (nullable, nonatomic, retain) NSDecimalNumber *value;
@property (nullable, nonatomic, retain) NSNumber *quantity;
@property (nullable, nonatomic, retain) NSString *img_location;
@property (nullable, nonatomic, retain) NSString *stores;

@end

NS_ASSUME_NONNULL_END
