//
//  Coupon.h
//  CouponME!
//
//  Created by macbook pro on 7/18/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Coupon_Data.h"
#import <UIKit/UIKit.h>


@interface Coupon : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property NSString *barcodes;
@property NSString *exp_dates;
@property NSString *products;
@property NSString *categrories;
@property NSString *values;
@property NSString *disclaimers;
@property NSString *quantity;
@property NSString *img_location;
@property BOOL detail;
@property Coupon_Data *current_detail;
@property NSArray *categories;
@property NSDateFormatter *dateFormat;

@property NSManagedObjectContext *context;

@end
