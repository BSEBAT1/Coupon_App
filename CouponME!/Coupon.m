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
@property (strong, nonatomic) IBOutlet UITextField *Product;
@property (strong, nonatomic) IBOutlet UITextField *Categrory;
@property (strong, nonatomic) IBOutlet UIButton *Save;



@end

@implementation Coupon
- (IBAction)Save_Coupon:(id)sender {
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.Barcode.text=self.barcodes;
    self.Exp_date.text=self.exp_dates;
    self.Product.text=self.products;
    self.Categrory.text=self.categrories;
    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    self.context = myApp.managedObjectContext;
    
    
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

@end
