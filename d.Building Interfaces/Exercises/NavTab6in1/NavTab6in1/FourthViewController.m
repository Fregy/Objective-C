//
//  FourthViewController.m
//  NavTab6in1
//
//  Created by Alfredo Alba on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "FourthViewController.h"
#import "ThirdViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

@synthesize lbText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    ThirdViewController *vc = [self.tabBarController.viewControllers objectAtIndex:2];
    
    if (vc.tfText.text == nil || [vc.tfText.text isEqualToString:@""]) {
        lbText.text = @"There is no badge value on third screen.";
    } else {
        lbText.text = [NSString stringWithFormat:@"The badge value on third screen is %@.",vc.tabBarItem.badgeValue];
    }
}

@end
