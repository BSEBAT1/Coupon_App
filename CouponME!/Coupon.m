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
@property (strong, nonatomic) IBOutlet UITextView *Notes;
@property (strong, nonatomic) IBOutlet UIImageView *Coupon_Pic;

@property  BOOL newdata;
@property UIDatePicker *pickerDate;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@property (strong, nonatomic) IBOutlet UIButton *Save;



@end

@implementation Coupon
- (IBAction)Save_Coupon:(id)sender {
    NSLog(@"FUCK THIS ");
    if (self.newdata==YES) {
        NSInteger a=[self.quant.text integerValue];
        NSNumber *myNum = @(a);
       
        
       
        for (int i=0; i<a; i++) {
            
            
           
            Coupon_Data *current_Coupon =[NSEntityDescription insertNewObjectForEntityForName:@"Coupon_Data" inManagedObjectContext:self.context];
            NSLog(@"we got here");
            NSLog(@"NUMBER OF COUPONS INSERTED IS %d",i);
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormat dateFromString:self.Exp_date.text];
            
            NSDecimalNumber *cow = [NSDecimalNumber decimalNumberWithString:self.value.text];
            
            NSData *imageData = UIImagePNGRepresentation(self.coupon_image);
            
            
            NSNumber *convert=[NSNumber numberWithInt:i];
            
            [current_Coupon setUpc:self.Barcode.text];
            [current_Coupon setExp_date:date];
            [current_Coupon setValuess:cow];
            [current_Coupon setProduct:self.Product_Name.text];
            [current_Coupon setDisclaimer:self.Notes.text];
            [current_Coupon setQuantity:myNum];
            [current_Coupon setCategory:self.Categrory.text];
            [current_Coupon setDuplicate:convert];
            [current_Coupon setImg_location:imageData];
            
            
            
           
            
          
            
        }
        
   
        NSError *error = nil;
        
        if ([self.context save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
            NSLog(@"reached post part");
        }
        
        
        
        
        
        NSString *noteDataString = [NSString stringWithFormat:@"upc_code=%@&exp_date=%@&product=%@&category=%@&value=%@&quantity=%@&disclaimer=%@",self.Barcode.text,self.Exp_date.text,self.Product_Name.text,self.Categrory.text,self.value.text,self.quant.text,self.Notes.text];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURL *url = [NSURL URLWithString:@"http://www.berkaysebat.com/upload_coupon.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
        }];
        [postDataTask resume];
     
        
        
         [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
        
        
        
    }
    else
    {
        NSInteger a=[self.quant.text integerValue];
        NSNumber *myNum = @(a);
        
        
        for (int i=0; i<a; i++) {
            
            
            
            Coupon_Data *current_Coupon =[NSEntityDescription insertNewObjectForEntityForName:@"Coupon_Data" inManagedObjectContext:self.context];
            NSLog(@"we got here");
            NSLog(@"NUMBER OF COUPONS INSERTED IS %d",i);
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormat dateFromString:self.Exp_date.text];
            
            NSDecimalNumber *cow = [NSDecimalNumber decimalNumberWithString:self.value.text];
            
            
            
            NSNumber *convert=[NSNumber numberWithInt:i];
            NSData *imageData = UIImagePNGRepresentation(self.coupon_image);
            
            [current_Coupon setUpc:self.Barcode.text];
            [current_Coupon setExp_date:date];
            [current_Coupon setValuess:cow];
            [current_Coupon setProduct:self.Product_Name.text];
            [current_Coupon setDisclaimer:self.Notes.text];
            [current_Coupon setQuantity:myNum];
            [current_Coupon setCategory:self.Categrory.text];
            [current_Coupon setDuplicate:convert];
            [current_Coupon setImg_location:imageData];
            
            
            NSLog(@"DID I GET HERE ");
            
            
        }
        
    NSError *error = nil;
    
    if ([self.context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }

     [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    
    }
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:0.94 green:0.30 blue:0.71 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.78 green:0.26 blue:0.99 alpha:1.0].CGColor ];
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
    self.Save.layer.cornerRadius=20;
    
    self.Coupon_Pic.image=self.coupon_image;
    self.Notes.delegate=self;
    
    
    
    self.categories=[[NSArray alloc]initWithObjects:@"Baby",@"Baking",@"Breads",@"Breakfast",@"Canned / Jarred Food",@"Cleaning Supplies",@"Condiments",@"Dairy / Refrigerated",@"Dried Goods",@"Fresh Food", @"Frozen Goods", @"Household Goods", @"Laundry Supplies", @"Medical", @"Paper Goods", @"Personal Care: Dental",@"Personal Care: Cosmetics / Makeup", @"Personal Care: Hair Care", @"Personal Care: Miscellaneous", @"Pets", @"Snacks", @"Miscellaneous",   nil];
    UIPickerView *categories_selection=[[UIPickerView alloc]init];
    categories_selection.delegate=self;
    categories_selection.dataSource=self;
    [categories_selection setShowsSelectionIndicator:YES];
    [self.Categrory setInputView:categories_selection];
    
    UIView *viewDateInput = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 200)];
    [viewDateInput setBackgroundColor:[UIColor whiteColor]];
    self.pickerDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, viewDateInput.frame.size.width, viewDateInput.frame.size.height)];
    self.pickerDate.datePickerMode = UIDatePickerModeDate;
    [viewDateInput addSubview:self.pickerDate];
    [self.pickerDate addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.Exp_date setInputView:viewDateInput];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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
        NSLog(@"product name is %@",self.products);
        if (self.products==NULL) {
            self.newdata=YES;
            NSLog(@"we dont have this product");
            UIAlertController * alert=[UIAlertController
                                       alertControllerWithTitle:@"Coupon Not Found"
                                       message:@"Please Manually Enter Data!"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:^{
            }];

            
        }
        else{
            
            self.newdata=NO;
            
        }
        
    }

    else {
        
        
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

    NSLog(@"the upc is %@",[self.current_detail upc]);
    
    
    NSDate *date_two =[self.current_detail exp_date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormat stringFromDate:date_two];
    NSString *int_to_string = [[self.current_detail quantity]stringValue];
    NSString *double_to_string=[[self.current_detail valuess]stringValue];
    
    UIImage *coupon_image = [UIImage imageWithData:[self.current_detail img_location]];
    
    self.Barcode.text=[self.current_detail upc];
    self.Exp_date.text=stringFromDate;
    self.Product_Name.text=[self.current_detail product];
    self.Categrory.text=[self.current_detail category];
    self.quant.text=int_to_string;
    self.Notes.text=[self.current_detail disclaimer];
    self.value.text=double_to_string;
    
  
    
    
    self.Coupon_Pic.image=coupon_image;
    
   
    self.Barcode.enabled=NO;
    self.Exp_date.enabled=NO;
    self.Product_Name.enabled=NO;
    self.Categrory.enabled=NO;
    self.quant.enabled=NO;
    self.Notes.editable=NO;
    self.value.enabled=NO;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.categories.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.categories objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.Categrory.text=[self.categories objectAtIndex:row];
    [self.Categrory resignFirstResponder];
    
}

- (void)dateChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [dateFormatter stringFromDate:self.pickerDate.date];
    self.Exp_date.text = currentTime;
    
}
-(void)dismissKeyboard {
    [self.Exp_date resignFirstResponder];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.gradientLayer.frame = self.view.bounds;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
- (UIImage*)rotateUIImage:(UIImage*)sourceImage clockwise:(BOOL)clockwise
{
    CGSize size = sourceImage.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    [[UIImage imageWithCGImage:[sourceImage CGImage] scale:1.0 orientation:clockwise ? UIImageOrientationRight : UIImageOrientationLeft] drawInRect:CGRectMake(0,0,size.height ,size.width)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
