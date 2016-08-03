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
    
    
    
    [current_Coupon setUpc:self.Barcode.text];
    [current_Coupon setExp_date:date];
    [current_Coupon setValuess:cow];
    [current_Coupon setProduct:self.Product_Name.text];
    [current_Coupon setDisclaimer:self.Notes.text];
    [current_Coupon setQuantity:myNum];
    [current_Coupon setCategory:self.Categrory.text];
    
    
    
    
    
    NSError *error = nil;
    
    if ([self.context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }

    
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.detail==NO) {
        self.Barcode.text=self.barcodes;
        self.Exp_date.text=self.exp_dates;
        self.Product_Name.text=self.products;
        self.Categrory.text=self.categrories;
        self.quant.text=self.quantity;
        self.Notes.text=self.disclaimers;
        self.value.text=self.values;
        
        AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
        self.context = myApp.managedObjectContext;
        self.Notes.delegate=self;
        self.Exp_date.delegate=self;
        self.Product_Name.delegate=self;
        self.Categrory.delegate=self;
        self.value.delegate=self;
        self.quant.delegate=self;
        self.Barcode.delegate=self;
    }
//    self.Barcode.text=self.barcodes;
//    self.Exp_date.text=self.exp_dates;
//    self.Product_Name.text=self.products;
//    self.Categrory.text=self.categrories;
//    self.quant.text=self.quantity;
//    self.Notes.text=self.disclaimers;
//    self.value.text=self.values;
//    
//    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
//    self.context = myApp.managedObjectContext;
//    self.Notes.delegate=self;
//    self.Exp_date.delegate=self;
//    self.Product_Name.delegate=self;
//    self.Categrory.delegate=self;
//    self.value.delegate=self;
//    self.quant.delegate=self;
//    self.Barcode.delegate=self;
    else {
        
        AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
        self.context = myApp.managedObjectContext;
        [self detailview];
        
        
        
    }
    
    
    
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
//    if (theTextField == self.Notes) {
        [theTextField resignFirstResponder];
//    }
//    else if (theTextField==self.Barcode){
//        [theTextField resignFirstResponder];
//        
//    }
//    else if (theTextField==self.quant){
//        [theTextField resignFirstResponder];
//        
//    }
//    else if (theTextField==self.Exp_date){
//        [theTextField resignFirstResponder];
//        
//    }
//    else if (theTextField==self.Product_Name){
//        [theTextField resignFirstResponder];
//        
//    }
//    else if (theTextField==self.value){
//        [theTextField resignFirstResponder];
//        
//    }
    
    return YES;
}

-(void)detailview{
    
    self.Save.hidden=YES;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Coupon_Data" inManagedObjectContext:[self context]];
    NSString *UPC = self.UPC_SEGWAY;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"upc== %@", UPC]];
    fetchRequest.fetchLimit=1;
    [fetchRequest setEntity:entity];
    
    
    NSError *error = nil;
    NSArray *saglam = [[self context] executeFetchRequest:fetchRequest error:&error];
    Coupon_Data *current_coupon=[saglam objectAtIndex:0];
    NSLog(@"the upc is %@",[current_coupon upc]);
    
    
    
    
    
    
}


@end
