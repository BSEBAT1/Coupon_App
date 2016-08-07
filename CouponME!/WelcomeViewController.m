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

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:0.94 green:0.30 blue:0.71 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.78 green:0.26 blue:0.99 alpha:1.0].CGColor ];
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
