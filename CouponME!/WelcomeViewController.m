//
//  WelcomeViewController.m
//  CouponME!
//
//  Created by macbook pro on 8/7/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) IBOutlet UIButton *Savings;
@property (strong, nonatomic) IBOutlet UIButton *Scan;
@property (strong, nonatomic) IBOutlet UIButton *List_Coupons;


@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:0.94 green:0.30 blue:0.71 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.78 green:0.26 blue:0.99 alpha:1.0].CGColor ];
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
    self.Scan.layer.cornerRadius=20;
    self.Savings.layer.cornerRadius=20;
    self.List_Coupons.layer.cornerRadius=20;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.gradientLayer.frame = self.view.bounds;
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
