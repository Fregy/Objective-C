//
//  ThirdViewController.m
//  NavTab6in1
//
//  Created by Alfredo Alba on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (IBAction)bDone:(UIButton *)sender {
    
    if (self.tfText.text.length > 0)
    {
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:(long)2] setBadgeValue:self.tfText.text];
        //[self.tabBarItem setBadgeValue:self.tfText.text];
    }
    else {
        [self.tabBarItem setBadgeValue:nil];
    }
}
@end
