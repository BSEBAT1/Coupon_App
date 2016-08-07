//
//  Savings+CoreDataProperties.h
//  CouponME!
//
//  Created by macbook pro on 8/4/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Savings.h"

NS_ASSUME_NONNULL_BEGIN

@interface Savings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDecimalNumber *ttsave;

@end

NS_ASSUME_NONNULL_END
