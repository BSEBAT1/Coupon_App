//
//  ListCoupon.h
//  CouponME!
//
//  Created by macbook pro on 7/24/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ListCoupon.h"
#import "Coupon_Data.h"
#import "AppDelegate.h"

@interface ListCoupon : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
