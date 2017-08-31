//
//  aFivethViewController.m
//  NavTab6in1
//
//  Created by Alfredo Alba on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "aFivethViewController.h"

@interface aFivethViewController ()

@end

@implementation aFivethViewController

@synthesize myString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([myString isEqualToString:@"Favorite"]) {
        self.view.backgroundColor = [UIColor redColor];
    } else {
        self.view.backgroundColor = [UIColor orangeColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)bFtoS:(UIButton *)sender {
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    UITabBarController *tabBarController = (UITabBarController *) window.rootViewController;
    
    NSMutableArray* viewControllers = [[tabBarController viewControllers] mutableCopy];
    [viewControllers exchangeObjectAtIndex:0 withObjectAtIndex:1];
    [tabBarController setViewControllers:viewControllers];
}

- (IBAction)bStoF:(UIButton *)sender {
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    UITabBarController *tabBarController = (UITabBarController *) window.rootViewController;
    
    NSMutableArray* viewControllers = [[tabBarController viewControllers] mutableCopy];
    [viewControllers exchangeObjectAtIndex:1 withObjectAtIndex:0];
    [tabBarController setViewControllers:viewControllers];
}
@end
