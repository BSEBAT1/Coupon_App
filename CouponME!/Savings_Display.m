//
//  Savings_Display.m
//  CouponME!
//
//  Created by macbook pro on 8/4/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "Savings_Display.h"

@interface Savings_Display ()
@property (strong, nonatomic) IBOutlet UILabel *Current;
@property (strong, nonatomic) IBOutlet UILabel *Historic;

@end

@implementation Savings_Display

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    self.context = myApp.managedObjectContext;
    
    NSError *error = nil;
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Coupon_Data"];
        [request setSortDescriptors:[NSArray arrayWithObject:
                                     [NSSortDescriptor sortDescriptorWithKey:@"upc" ascending:YES]]];
        [request setReturnsObjectsAsFaults:NO];
    
    
    NSFetchRequest *requested = [[NSFetchRequest alloc] initWithEntityName:@"Savings"];
    [requested setSortDescriptors:[NSArray arrayWithObject:
                                 [NSSortDescriptor sortDescriptorWithKey:@"ttsave" ascending:YES]]];
    [requested setReturnsObjectsAsFaults:NO];
    
        NSArray *coupons_active = [[self context] executeFetchRequest:request error:&error];
    
    NSArray *coupons_deleted = [[self context] executeFetchRequest:requested error:&error];
    
        for (Coupon_Data *obj in coupons_active) {
            self.total_savings+=[obj.valuess integerValue];
        }
    
    
    for (Savings *obj in coupons_deleted) {
        self.total_deleted_value+=[obj.ttsave integerValue];
    }
    
        NSLog(@"query records: %@",coupons_active);
    NSLog(@"test amount %d",self.total_savings);
    NSLog(@"query records: %@",coupons_deleted);
    NSLog(@"test amounted %d",self.total_deleted_value);
    NSString *current_value_txt = [@(self.total_savings) stringValue];
    self.Current.text=current_value_txt;
    NSString *past_value_txt = [@(self.total_deleted_value) stringValue];
    
    self.Historic.text=past_value_txt;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
