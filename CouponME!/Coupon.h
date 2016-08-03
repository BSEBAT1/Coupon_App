//
//  Coupon.h
//  CouponME!
//
//  Created by macbook pro on 7/18/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "ViewController.h"

@interface Coupon : ViewController <UITextFieldDelegate>
@property NSString *barcodes;
@property NSString *exp_dates;
@property NSString *products;
@property NSString *categrories;
@property NSString *values;
@property NSString *disclaimers;
@property NSString *quantity;
@property NSString *img_location;
@property BOOL detail;
@property NSString *UPC_SEGWAY;

@property NSManagedObjectContext *context;

@end
