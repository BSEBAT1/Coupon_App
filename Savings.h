//
//  Savings.h
//  CouponME!
//
//  Created by macbook pro on 8/4/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Savings : NSManagedObject
@property (nullable, nonatomic, retain) NSDecimalNumber *ttsave;


@end

NS_ASSUME_NONNULL_END

#import "Savings+CoreDataProperties.h"
