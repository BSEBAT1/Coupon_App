//
//  Savings_Display.h
//  CouponME!
//
//  Created by macbook pro on 8/4/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coupon.h"
#import "Coupon_Data.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Savings.h"

@interface Savings_Display : UIViewController
@property NSInteger total_savings;
@property NSInteger total_deleted_value;

@property NSManagedObjectContext *context;

@end
