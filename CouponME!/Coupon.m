//
//  Coupon.m
//  CouponME!
//
//  Created by macbook pro on 7/18/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "Coupon.h"
#import "Coupon_Data.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface Coupon ()
@property (strong, nonatomic) IBOutlet UITextField *Barcode;
@property (strong, nonatomic) IBOutlet UITextField *Exp_date;
@property (strong, nonatomic) IBOutlet UITextField *Product_Name;
@property (strong, nonatomic) IBOutlet UITextField *Categrory;
@property (strong, nonatomic) IBOutlet UITextField *value;
@property (strong, nonatomic) IBOutlet UITextField *quant;

@property (strong, nonatomic) IBOutlet UITextField *Notes;
@property (strong, nonatomic) IBOutlet UIImageView *Coupon_Pic;

@property (strong, nonatomic) IBOutlet UIButton *Save;



@end

@implementation Coupon
- (IBAction)Save_Coupon:(id)sender {
  
    
    Coupon_Data *current_Coupon =[NSEntityDescription insertNewObjectForEntityForName:@"Coupon_Data" inManagedObjectContext:self.context];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:self.Exp_date.text];
    
    NSDecimalNumber *cow = [NSDecimalNumber decimalNumberWithString:self.value.text];

    NSInteger a=[self.quant.text integerValue];
    NSNumber *myNum = @(a);
    
    
    
//    [current_Coupon setUpc:self.Barcode.text];
//    [current_Coupon setExp_date:date];
//    [current_Coupon setValue:cow];
    [current_Coupon setProduct:@"jerry seinfeld"];
//    [current_Coupon setDisclaimer:self.Notes.text];
//    [current_Coupon setQuantity:myNum];
//    [current_Coupon setCategory:self.Categrory.text];
    
    
    
    NSError *error = nil;
    
    if ([self.context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }

    
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.Barcode.text=self.barcodes;
    self.Exp_date.text=self.exp_dates;
    self.Product_Name.text=self.products;
    self.Categrory.text=self.categrories;
    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    self.context = myApp.managedObjectContext;
    self.Notes.delegate=self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.Notes) {
        [theTextField resignFirstResponder];
    }
    return YES;
}


@end
