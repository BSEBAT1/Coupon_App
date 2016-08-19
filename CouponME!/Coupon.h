//
//  Coupon.h
//  CouponME!
//
//  Created by macbook pro on 7/18/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "ViewController.h"
#import "Coupon_Data.h"
#import <UIKit/UIKit.h>


@interface Coupon : ViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>
@property NSString *barcodes;
@property NSString *exp_dates;
@property NSString *products;
@property NSString *categrories;
@property NSString *values;
@property NSString *disclaimers;
@property NSString *quantity;

@property BOOL detail;
@property Coupon_Data *current_detail;
@property NSArray *categories;
@property NSDateFormatter *dateFormat;
@property UIImage *coupon_image;
@property NSManagedObjectContext *context;




@end
